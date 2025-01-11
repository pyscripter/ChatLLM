unit LLMSupport;

interface

uses
  System.Classes,
  System.JSON,
  System.JSON.Serializers,
  System.Net.HttpClient,
  System.Net.HttpClientComponent;

type
  TLLMProvider = (
    llmProviderOpenAI,
    llmProviderGemini,
    llmProviderOllama);

  TEndpointType = (
    etUnsupported,
    etOllamaGenerate,
    etOllamaChat,
    etOpenAICompletion,
    etOpenAIChatCompletion,
    etGemini);

  TLLMSettingsValidation = (
    svValid,
    svModelEmpty,
    svInvalidEndpoint,
    svInvalidModel,
    svAPIKeyMissing);

  TLLMSettings = record
    EndPoint: string;
    ApiKey: string;
    Model: string;
    TimeOut: Integer;
    MaxTokens: Integer;
    SystemPrompt: string;
    function Validate: TLLMSettingsValidation;
    function IsLocal: Boolean;
    function EndpointType: TEndpointType;
  end;

  TLLMProviders = record
    Provider: TLLMProvider;
    OpenAI: TLLMSettings;
    Gemini: TLLMSettings;
    Ollama: TLLMSettings;
  end;

  TQAItem = record
    Prompt: string;
    Answer: string;
    constructor Create(const AQuestion, AnAnswer: string);
  end;

  TChatTopic = record
    Title: string;
    QAItems: TArray<TQAItem>;
  end;
  TChatTopics = TArray<TChatTopic>;

  TOnLLMResponseEvent = procedure(Sender: TObject; const Prompt, Answer: string) of object;
  TOnLLMErrorEvent = procedure(Sender: TObject; const Error: string) of object;

  TLLMBase = class
  private
    FHttpClient: TNetHTTPClient;
    FHttpResponse: IHTTPResponse;
    FSourceStream: TStringStream;
    FOnLLMResponse: TOnLLMResponseEvent;
    FOnLLMError: TOnLLMErrorEvent;
    FLastPrompt: string;
    FContext: TJSONValue;
    FEndPointType: TEndpointType;
    procedure OnRequestError(const Sender: TObject; const AError: string);
    procedure OnRequestCompleted(const Sender: TObject; const AResponse: IHTTPResponse);
    function GetIsBusy: Boolean;
    function GetLLMSettings: TLLMSettings;
  protected
    FSerializer: TJsonSerializer;
    procedure DoResponseCompleted(const AResponse: IHTTPResponse); virtual;
    procedure DoResponseCreated(const AResponse: IHTTPResponse); virtual;
    procedure DoResponseOK(const Msg: string); virtual;
    function RequestParams(const Prompt: string; const Suffix: string = ''): string; virtual; abstract;
    // Gemini support
    procedure AddGeminiSystemPrompt(Params: TJSONObject);
    function GeminiMessage(const Role, Content: string): TJSONObject;
  public
    Providers: TLLMProviders;
    ActiveTopicIndex: Integer;
    ChatTopics: TArray<TChatTopic>;
    procedure ClearContext;
    function ValidateSettings: TLLMSettingsValidation; virtual;
    function ValidationErrMsg(Validation: TLLMSettingsValidation): string;
    constructor Create;
    destructor Destroy; override;

    procedure Ask(const Prompt: string; const Suffix: string = '');
    procedure CancelRequest;
    procedure SaveSettings(const FName: string);
    procedure LoadSettrings(const FName: string);

    property Settings: TLLMSettings read GetLLMSettings;
    property IsBusy: Boolean read GetIsBusy;
    property OnLLMResponse: TOnLLMResponseEvent read FOnLLMResponse write FOnLLMResponse;
    property OnLLMError: TOnLLMErrorEvent read FOnLLMError write FOnLLMError;
  end;

  TLLMChat = class(TLLMBase)
  protected
    procedure DoResponseOK(const Msg: string); override;
    function RequestParams(const Prompt: string; const Suffix: string = ''): string; override;
  public
    ActiveTopicIndex: Integer;
    ChatTopics: TArray<TChatTopic>;
    function ValidateSettings: TLLMSettingsValidation; override;
    constructor Create;

    function ActiveTopic: TChatTopic;
    procedure NextTopic;
    procedure PreviousTopic;
    procedure ClearTopic;
    procedure RemoveTopic;
    procedure NewTopic;

    procedure SaveChat(const FName: string);
    procedure LoadChat(const FName: string);
  end;

const
  DefaultSystemPrompt = 'You are my expert Pascal/Delphi coding assistant.';

  OpenaiChatSettings: TLLMSettings = (
    EndPoint: 'https://api.openai.com/v1/chat/completions';
    ApiKey: '';
    Model: 'gpt-4o';
    //Model: 'gpt-3.5-turbo';
    TimeOut: 20000;
    MaxTokens: 1000;
    SystemPrompt: DefaultSystemPrompt);

  GeminiSettings: TLLMSettings = (
    EndPoint: 'https://generativelanguage.googleapis.com/v1beta';
    ApiKey: '';
    Model: 'gemini-1.5-flash';
    TimeOut: 20000;
    MaxTokens: 1000;
    SystemPrompt: DefaultSystemPrompt);

  OllamaChatSettings: TLLMSettings = (
    EndPoint: 'http://localhost:11434/api/chat';
    ApiKey: '';
    Model: 'codellama';
    //Model: 'codegema';
    //Model: 'starcoder2';
    //Model: 'stable-code';
    TimeOut: 60000;
    MaxTokens: 1000;
    SystemPrompt: DefaultSystemPrompt);

implementation

uses
  System.SysUtils,
  System.IOUtils;

resourcestring
  sLLMBusy = 'The LLM client is busy';
  sNoResponse = 'No response from the LLM Server';
  sNoAPIKey = 'The LLM API key is missing';
  sNoModel = 'The LLM model has not been set';
  sUnsupportedEndpoint = 'The LLM endpoint is missing or not supported';
  sUnsupportedModel = 'The LLM model is not supported';
  sUnexpectedResponse = 'Unexpected response from the LLM Server';

function Obfuscate(const S: string): string;
// Reversible string obfuscation using the ROT13 algorithm
begin
  Result := S;
  for var I := 1 to Length(S) do
    case Ord(S[I]) of
    Ord('A')..Ord('M'), Ord('a')..Ord('m'): Result[I] := Chr(Ord(S[I]) + 13);
    Ord('N')..Ord('Z'), Ord('n')..Ord('z'): Result[I] := Chr(Ord(S[I]) - 13);
    Ord('0')..Ord('4'): Result[I] := Chr(Ord(S[I]) + 5);
    Ord('5')..Ord('9'): Result[I] := Chr(Ord(S[I]) - 5);
    end;
end;


{ TLLMBase }

procedure TLLMBase.AddGeminiSystemPrompt(Params: TJSONObject);
begin
  if Settings.SystemPrompt <> '' then
  begin
    var JsonText := TJSONObject.Create;
    JsonText.AddPair('text', Settings.SystemPrompt);

    var JsonParts := TJSONObject.Create;
    JsonParts.AddPair('parts', JsonText);

    Params.AddPair('system_instruction', JsonParts);
  end;
end;

procedure TLLMBase.Ask(const Prompt: string; const Suffix: string = '');
var
  ErrMsg: string;
  Params: string;
begin
  if Prompt = '' then Exit;

  if Assigned(FHttpResponse) then
    ErrMsg := sLLMBusy
  else
  begin
    var Validation := ValidateSettings;
    ErrMsg := ValidationErrMsg(Validation);
  end;

  if ErrMsg <> '' then
  begin
    if Assigned(FOnLLMError) then
      FOnLLMError(Self, ErrMsg);
    Exit;
  end;

  FEndPointType := Settings.EndpointType;
  FHttpClient.ConnectionTimeout := Settings.TimeOut;
  FHttpClient.ResponseTimeout := Settings.TimeOut * 2;

  FLastPrompt := Prompt;
  Params := RequestParams(Prompt, Suffix);

  FSourceStream.Clear;
  FSourceStream.WriteString(Params);
  FSourceStream.Position := 0;

  FHttpClient.CustHeaders.Clear;
  var EndPoint := Settings.EndPoint;
  case FEndPointType of
    etOpenAICompletion, etOpenAIChatCompletion:
      FHttpClient.CustomHeaders['Authorization'] := 'Bearer ' + Settings.ApiKey;
    etGemini:
      EndPoint := Format('%s/models/%s:generateContent?key=%s',
        [Settings.EndPoint, Settings.Model, Settings.ApiKey]);
  end;

  FHttpClient.CustomHeaders['Content-Type'] := 'application/json';
  FHttpClient.CustomHeaders['AcceptEncoding'] := 'deflate, gzip;q=1.0, *;q=0.5';
  FHttpResponse := FHttpClient.Post(EndPoint , FSourceStream);
  DoResponseCreated(FHttpResponse);
end;

procedure TLLMBase.CancelRequest;
begin
  if Assigned(FHttpResponse) then
    FHttpResponse.AsyncResult.Cancel;
end;

procedure TLLMBase.ClearContext;
begin
  FreeAndNil(FContext);
end;

constructor TLLMBase.Create;
begin
  inherited;
  FHttpClient := TNetHTTPClient.Create(nil);
  FHttpClient.OnRequestCompleted := OnRequestCompleted;
  FHttpClient.OnRequestError := OnRequestError;
  FHttpClient.Asynchronous := True;

  FSourceStream := TStringStream.Create('', TEncoding.UTF8);

  FSerializer := TJsonSerializer.Create;
end;

destructor TLLMBase.Destroy;
begin
  FSerializer.Free;
  FSourceStream.Free;
  FHttpClient.Free;
  FContext.Free;
  inherited;
end;

procedure TLLMBase.DoResponseCompleted(const AResponse: IHTTPResponse);
begin
  // Do nothing
end;

procedure TLLMBase.DoResponseCreated(const AResponse: IHTTPResponse);
begin
  // Do Nothing
end;

procedure TLLMBase.DoResponseOK(const Msg: string);
begin
  // Do nothing
end;

function TLLMBase.GeminiMessage(const Role, Content: string): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('role', Role);
  var Parts := TJSONObject.Create;
  Parts.AddPair('text', Content);
  Result.AddPair('parts', Parts);
end;

function TLLMBase.GetIsBusy: Boolean;
begin
  Result := Assigned(FHttpResponse);
end;

function TLLMBase.GetLLMSettings: TLLMSettings;
begin
  case Providers.Provider of
    llmProviderOpenAI: Result := Providers.OpenAI;
    llmProviderOllama: Result := Providers.Ollama;
    llmProviderGemini: Result := Providers.Gemini;
  end;
end;

procedure TLLMBase.LoadSettrings(const FName: string);
begin
  if FileExists(FName) then
  begin
    Providers := FSerializer.Deserialize<TLLMProviders>(TFile.ReadAllText(FName));
    Providers.OpenAI.ApiKey := Obfuscate(Providers.OpenAI.ApiKey);
    Providers.Gemini.ApiKey := Obfuscate(Providers.Gemini.ApiKey);
    // backward compatibility
    if (Providers.Gemini.EndPoint = '') and (Providers.Gemini.Model = '') then
      Providers.Gemini := GeminiSettings;
  end;
end;

procedure TLLMBase.OnRequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
var
  ResponseData: TBytes;
  ResponseOK: Boolean;
  ErrMsg, Msg: string;
begin
  FHttpResponse := nil;
  DoResponseCompleted(AResponse);
  if AResponse.AsyncResult.IsCancelled then
    Exit;
  ResponseOK := False;
  if AResponse.ContentStream.Size > 0 then
  begin
    SetLength(ResponseData, AResponse.ContentStream.Size);
    AResponse.ContentStream.Read(ResponseData, AResponse.ContentStream.Size);
    var JsonResponse := TJSONValue.ParseJSONValue(ResponseData, 0);
    try
      if not (JsonResponse.TryGetValue('error.message', ErrMsg)
        or JsonResponse.TryGetValue('error', ErrMsg))
      then
        case FEndPointType of
          etOpenAIChatCompletion:
            ResponseOK := JsonResponse.TryGetValue('choices[0].message.content', Msg);
          etOpenAICompletion:
            ResponseOK := JsonResponse.TryGetValue('choices[0].text', Msg);
          etOllamaGenerate:
            ResponseOK := JsonResponse.TryGetValue('response', Msg);
          etOllamaChat:
            ResponseOK := JsonResponse.TryGetValue('message.content', Msg);
          etGemini:
            ResponseOK := JsonResponse.TryGetValue('candidates[0].content.parts[0].text', Msg);
        end;

      if FEndPointType = etOllamaGenerate then
      begin
        ClearContext;
        FContext := JsonResponse.FindValue('context');
        if Assigned(FContext) then
          FContext.Owned := False;
      end;
    finally
      JsonResponse.Free;
    end;
  end else
    ErrMsg := sNoResponse;

  if ResponseOK then
  begin
    DoResponseOK(Msg);
    if Assigned(FOnLLMResponse)  then
      FOnLLMResponse(Self, FLastPrompt, Msg);
  end
  else
  begin
    if ErrMsg = '' then
      ErrMsg := sUnexpectedResponse;
    if Assigned(FOnLLMError) then
      FOnLLMError(Self, ErrMsg);
  end;
end;

procedure TLLMBase.OnRequestError(const Sender: TObject; const AError: string);
begin
  FHttpResponse := nil;
  if Assigned(FOnLLMError) then
    FOnLLMError(Self, AError);
end;

procedure TLLMBase.SaveSettings(const FName: string);
begin
  Providers.OpenAI.ApiKey := Obfuscate(Providers.OpenAI.ApiKey);
  Providers.Gemini.ApiKey := Obfuscate(Providers.Gemini.ApiKey);
  try
    TFile.WriteAllText(FName, FSerializer.Serialize<TLLMProviders>(Providers));
  finally
    Providers.OpenAI.ApiKey := Obfuscate(Providers.OpenAI.ApiKey);
    Providers.Gemini.ApiKey := Obfuscate(Providers.Gemini.ApiKey);
  end;
end;

function TLLMBase.ValidateSettings: TLLMSettingsValidation;
begin
  Result := Settings.Validate;
end;

function TLLMBase.ValidationErrMsg(Validation: TLLMSettingsValidation): string;
begin
  case Validation of
    svValid: Result := '';
    svModelEmpty: Result := sNoModel;
    svInvalidEndpoint: Result := sUnsupportedEndpoint;
    svInvalidModel: Result := sUnsupportedModel;
    svAPIKeyMissing: Result := sNoAPIKey;
  end;
end;

{ TLLMChat }

function TLLMChat.ActiveTopic: TChatTopic;
begin
  Result := ChatTopics[ActiveTopicIndex];
end;

procedure TLLMChat.ClearTopic;
begin
  ChatTopics[ActiveTopicIndex] := Default(TChatTopic);
  ClearContext;
end;

constructor TLLMChat.Create;
begin
  inherited;
  Providers.Provider := llmProviderOpenAI;
  Providers.OpenAI := OpenaiChatSettings;
  Providers.Ollama := OllamaChatSettings;
  Providers.Gemini := GeminiSettings;

  ChatTopics := [Default(TChatTopic)];
  ActiveTopicIndex := 0;
end;

procedure TLLMChat.DoResponseOK(const Msg: string);
begin
  ChatTopics[ActiveTopicIndex].QAItems := ActiveTopic.QAItems + [TQAItem.Create(FLastPrompt, Msg)];
end;

procedure TLLMChat.LoadChat(const FName: string);
begin
  if FileExists(FName) then
  begin
    ChatTopics :=
      FSerializer.Deserialize<TArray<TChatTopic>>(
      TFile.ReadAllText(FName, TEncoding.UTF8));
    ActiveTopicIndex := High(ChatTopics);
  end;
end;

procedure TLLMChat.NewTopic;
begin
  if Length(ActiveTopic.QAItems) = 0 then
    Exit;
  if Length(ChatTopics[High(ChatTopics)].QAItems) > 0 then
    ChatTopics := ChatTopics + [Default(TChatTopic)];
  ActiveTopicIndex := High(ChatTopics);
end;

procedure TLLMChat.NextTopic;
begin
  if ActiveTopicIndex < Length(ChatTopics) - 1 then
  begin
    Inc(ActiveTopicIndex);
    ClearContext;
  end;
end;

procedure TLLMChat.PreviousTopic;
begin
  if ActiveTopicIndex > 0 then
  begin
    Dec(ActiveTopicIndex);
    ClearContext;
  end;
end;

function TLLMChat.RequestParams(const Prompt: string; const Suffix: string = ''): string;

  function GeminiParams: string;
  begin
    var JSON := TJSONObject.Create;
    try
      // start with the system message
      AddGeminiSystemPrompt(JSON);

      // then add the chat history
      var Contents := TJSONArray.Create;
      for var QAItem in ActiveTopic.QAItems do
      begin
        Contents.Add(GeminiMessage('user', QAItem.Prompt));
        Contents.Add(GeminiMessage('model', QAItem.Answer));
      end;
      // finally add the new prompt
      Contents.Add(GeminiMessage('user', Prompt));
      JSON.AddPair('contents', Contents);

      // now add parameters
      var GenerationConfig := TJSONObject.Create;
      GenerationConfig.AddPair('maxOutputTokens', Settings.MaxTokens);
      JSON.AddPair('generationConfig', GenerationConfig);

      Result := JSON.ToJSON;
    finally
      JSON.Free;
    end;
  end;

  function NewMessage(const Role, Content: string): TJSONObject;
  begin
    Result := TJSONObject.Create;
    Result.AddPair('role', Role);
    Result.AddPair('content', Content);
  end;

begin
  if FEndPointType = etGemini then
    Exit(GeminiParams);

  var JSON := TJSONObject.Create;
  try
    JSON.AddPair('model', Settings.Model);
    JSON.AddPair('stream', False);

    case FEndPointType of
      etOllamaChat:
        begin
          var Options := TJSONObject.Create;
          Options.AddPair('num_predict', Settings.MaxTokens);
          JSON.AddPair('options', Options);
        end;
      etOpenAIChatCompletion:
        JSON.AddPair('max_tokens', Settings.MaxTokens);
    end;

    var Messages := TJSONArray.Create;
    // start with the system message
    if Settings.SystemPrompt <> '' then
      Messages.Add(NewMessage('system', Settings.SystemPrompt));
    // add the history
    for var QAItem in ActiveTopic.QAItems do
    begin
      Messages.Add(NewMessage('user', QAItem.Prompt));
      Messages.Add(NewMessage('assistant', QAItem.Answer));
    end;
    // finally add the new prompt
    Messages.Add(NewMessage('user', Prompt));

    JSON.AddPair('messages', Messages);

    Result := JSON.ToJSON;
  finally
    JSON.Free;
  end;
end;

procedure TLLMChat.RemoveTopic;
begin
  Delete(ChatTopics, ActiveTopicIndex, 1);

  if ActiveTopicIndex > High(ChatTopics) then
  begin
    if ActiveTopicIndex > 0 then
      Dec(ActiveTopicIndex)
    else
      ChatTopics := [Default(TChatTopic)];
  end;
  ClearContext;
end;

procedure TLLMChat.SaveChat(const FName: string);
begin
  TFile.WriteAllText(FName, FSerializer.Serialize(ChatTopics));
end;

function TLLMChat.ValidateSettings: TLLMSettingsValidation;
begin
  Result := Settings.Validate;
  if (Result = svValid) and
    not (Settings.EndpointType in [etOllamaChat, etGemini, etOpenAIChatCompletion])
  then
    Result := svInvalidEndpoint;
end;

{ TQAItem }

constructor TQAItem.Create(const AQuestion, AnAnswer: string);
begin
  Self.Prompt := AQuestion;
  Self.Answer := AnAnswer;
end;

{ TLLMSettings }

function TLLMSettings.EndpointType: TEndpointType;
begin
  Result := etUnsupported;
  if EndPoint.Contains('googleapis') then
    Result := etGemini
  else if EndPoint.Contains('openai') then
  begin
    if EndPoint = 'https://api.openai.com/v1/chat/completions' then
      Result := etOpenAIChatCompletion
    else if EndPoint = 'https://api.openai.com/v1/completions' then
      Result := etOpenAICompletion;
  end
  else
  begin
    if EndPoint.EndsWith('api/generate') then
      Result := etOllamaGenerate
    else if EndPoint.EndsWith('api/chat') then
      Result := etOllamaChat;
  end;
end;

function TLLMSettings.IsLocal: Boolean;
begin
  Result := EndPoint.Contains('localhost')  or EndPoint.Contains('127.0.0.1');
end;

function TLLMSettings.Validate: TLLMSettingsValidation;
begin
  if Model = '' then
    Exit(svModelEmpty);
  case EndpointType of
    etUnsupported: Exit(svInvalidEndpoint);
    etOpenAICompletion, etOpenAIChatCompletion, etGemini:
      if ApiKey = '' then
        Exit(svAPIKeyMissing);
  end;
  Result := svValid;
end;

end.
