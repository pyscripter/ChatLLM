unit LLMChatUI;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.UITypes,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Menus,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.ImgList,
  Vcl.VirtualImageList,
  Vcl.ComCtrls,
  Vcl.WinXPanels,
  Vcl.WinXCtrls,
  Vcl.ActnList,
  Vcl.AppEvnts,
  SynEditHighlighter,
  SynEdit,
  SynHighlighterGeneral,
  SynHighlighterMulti,
  SynHighlighterPython,
  SVGIconImage,
  SpTBXItem,
  SpTBXControls,
  TB2Dock,
  TB2Toolbar,
  TB2Item,
  SpTBXEditors,
  LLMSupport;

type

  TLLMChatForm = class(TForm)
    pnlQuestion: TPanel;
    vilImages: TVirtualImageList;
    reQuestion: TRichEdit;
    ScrollBox: TScrollBox;
    QAStackPanel: TStackPanel;
    aiBusy: TActivityIndicator;
    ActionList: TActionList;
    actChatSave: TAction;
    sbAsk: TSpeedButton;
    ApplicationEvents: TApplicationEvents;
    SpTBXDock: TSpTBXDock;
    SpTBXToolbar: TSpTBXToolbar;
    spiSave: TSpTBXItem;
    SpTBXSubmenuItem1: TSpTBXSubmenuItem;
    spiApiKey: TSpTBXEditItem;
    SpTBXRightAlignSpacerItem: TSpTBXRightAlignSpacerItem;
    spiEndpoint: TSpTBXEditItem;
    spiModel: TSpTBXEditItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    spiTimeout: TSpTBXEditItem;
    spiMaxTokens: TSpTBXEditItem;
    spiSystemPrompt: TSpTBXEditItem;
    actChatRemove: TAction;
    actChatNew: TAction;
    actChatPrevious: TAction;
    actChatNext: TAction;
    SpTBXItem1: TSpTBXItem;
    SpTBXItem2: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    SpTBXItem3: TSpTBXItem;
    SpTBXItem4: TSpTBXItem;
    actCopyText: TAction;
    popTextMenu: TPopupMenu;
    Copy1: TMenuItem;
    actAskQuestion: TAction;
    procedure actChatSaveExecute(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: TMsg; var Handled: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure reQuestionKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbAskClick(Sender: TObject);
    procedure AcceptSettings(Sender: TObject; var NewText: string; var
        Accept: Boolean);
    procedure actChatNewExecute(Sender: TObject);
    procedure actChatNextExecute(Sender: TObject);
    procedure actChatPreviousExecute(Sender: TObject);
    procedure actChatRemoveExecute(Sender: TObject);
    procedure actCopyTextExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure SpTBXSubmenuItem1InitPopup(Sender: TObject; PopupView: TTBView);
  private
    procedure QPanelResize(Sender: TObject);
    procedure APanelResize(Sender: TObject);
    procedure DisplayQuestion(const Question: string);
    procedure DisplayAnswer(Answer: string);
    procedure ClearConversation;
    procedure DisplayActiveChatTopic;
    procedure OnLLMResponse(Sender: TObject; const Question, Answer: string);
    procedure OnLLMError(Sender: TObject; const Error: string);
  public
    LLMChat: TLLMChat;
  end;

const
  GPT_4_Settings: TLLMSettings = (
    EndPoint: 'https://api.openai.com/v1/chat/completions';
    ApiKey: 'Key needed';
    Model: 'gpt-4';
    TimeOut: 20000;
    MaxTokens: 1000;
    SystemPrompt: 'You are my expert python coding assistant.');

  GPT_35_Settings: TLLMSettings = (
    EndPoint: 'https://api.openai.com/v1/chat/completions';
    ApiKey: 'Key needed';
    Model: 'gpt-3.5-turbo';
    TimeOut: 20000;
    MaxTokens: 1000;
    SystemPrompt: 'You are my expert python coding assistant.');

  GPT_35_Instruct_Settings: TLLMSettings = (
    EndPoint: 'https://api.openai.com/v1/completions';
    ApiKey: 'Key needed';
    Model: 'gpt-3.5-turbo-instruct';
    TimeOut: 20000;
    MaxTokens: 1000;
    SystemPrompt: '');

  OllamaSettings: TLLMSettings = (
    EndPoint: 'http://localhost:11434/api/generate';
    ApiKey: '';
    Model: 'codegema';
    //Model: 'starcoder2';
    //Model: 'codellama:';
    //Model: 'stable-code';
    TimeOut: 60000;
    MaxTokens: 1000;
    SystemPrompt: 'You are my expert python coding assistant.');

var
  LLMChatForm: TLLMChatForm;

implementation

{$R *.dfm}

uses
  System.Math,
  System.IOUtils,
  Vcl.Themes,
  Vcl.Clipbrd,
  dmResources;

procedure TLLMChatForm.actChatSaveExecute(Sender: TObject);
begin
  var FileName := TPath.Combine(TPath.GetDirectoryName(Application.ExeName),
    'Chat history.json');
  LLMChat.SaveChat(FileName);
end;

procedure TLLMChatForm.FormDestroy(Sender: TObject);
begin
  var FileName := TPath.Combine(TPath.GetDirectoryName(Application.ExeName),
    'Chat Settings.json');
  LLMChat.SaveSettings(FileName);
  LLMChat.Free;
end;

procedure TLLMChatForm.APanelResize(Sender: TObject);
begin
  var pnlAnswer := Sender as TSpTBXPanel;
  var synAnswer := pnlAnswer.Controls[1] as TSynEdit;
  var NewHeight := Max(MulDiv(50, CurrentPPI, 96), 2 * Margins.Bottom +
    synAnswer.DisplayRowCount * synAnswer.LineHeight);
  if NewHeight <> pnlAnswer.Height then
    pnlAnswer.Height := NewHeight;
end;

procedure TLLMChatForm.ApplicationEventsMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if Msg.message = WM_MOUSEWHEEL then
  begin
    var Window := WindowFromPoint(Msg.pt);
    var WinControl := FindControl(Window);
    if (WinControl is TSynEdit) and string(WinControl.Name).StartsWith('synAnswer') then
    begin
      SendMessage(WinControl.Parent.Handle, WM_MOUSEWHEEL, Msg.WParam, Msg.LParam);
      Handled := True;
    end;
  end;
end;

procedure TLLMChatForm.ClearConversation;
begin
  while QAStackPanel.ControlCount > 0  do
    QAStackPanel.Controls[QAStackPanel.ControlCount - 1].Free;
end;

procedure TLLMChatForm.DisplayAnswer(Answer: string);
begin
  var pnlAnswer := TSpTBXPanel.Create(Self);
  with pnlAnswer do begin
    Name := 'pnlAnswer' + QAStackPanel.ControlCount.ToString;
    Anchors := [akLeft,akTop,akRight];
    Width := 570;
    Height := 50;
    Anchors := [akLeft, akTop, akRight];
    Borders := False;
    AlignWithMargins := True;
  end;
  var svgChatGPT := TSVGIconImage.Create(Self);
  with svgChatGPT do begin
    Left := 0;
    Top := 0;
    Width := 24;
    Height := 24;
    AutoSize := False;
    ImageList := vilImages;
    ImageName := 'ChatGPT';
    Anchors := [akLeft, akTop];
    FixedColor := StyleServices.GetSystemColor(clWindowText);
    Parent := pnlAnswer;
  end;
  var synAnswer := TSynEdit.Create(Self);
  with synAnswer do begin
    Name := 'synAnswer' + QAStackPanel.ControlCount.ToString;
    Anchors := [akLeft, akRight, akTop, akBottom];
    UseCodeFolding := False;
    Highlighter := Resources.SynMultiSyn;
    ReadOnly := True;
    RightEdge := 0;
    Top := 0;
    Left := 40;
    Width := pnlAnswer.Width - 40;
    Height := pnlAnswer.Height;
    Font.Name := 'Consolas';
    Font.Size := 10;
    Gutter.Visible := False;
    PopUpMenu := popTextMenu;
    Parent := pnlAnswer;
  end;
  pnlAnswer.ScaleForPPI(CurrentPPI);
  pnlAnswer.Parent := QAStackPanel;
  synAnswer.WordWrap := True;
  synAnswer.Text := Answer;
  pnlAnswer.OnResize :=  APanelResize;
  APanelResize(pnlAnswer);
  ScrollBox.VertScrollBar.Position := ScrollBox.VertScrollBar.Range;
end;

procedure TLLMChatForm.DisplayActiveChatTopic;
begin
  ClearConversation;
  for var Response in LLMChat.ActiveTopic do
  begin
    DisplayQuestion(Response.Question);
    DisplayAnswer(Response.Answer);
  end;
end;

procedure TLLMChatForm.DisplayQuestion(const Question: string);
begin
  var pnlUserQuestion := TSpTBXPanel.Create(Self);
  with pnlUserQuestion do begin
    Name := 'pnlUserQuestion' + QAStackPanel.ControlCount.ToString;
    Anchors := [akLeft,akTop,akRight];
    Width := 570;
    Height := 40;
    Borders := False;
    Margins.Top := 10;
    AlignWithMargins := True;
  end;
  var svgUser := TSVGIconImage.Create(Self);
  with svgUser do begin
    Left := 0;
    Top := 0;
    Width := 24;
    Height := 24;
    AutoSize := False;
    ImageList := vilImages;
    ImageName := 'UserQuestion';
    FixedColor := StyleServices.GetSystemColor(clWindowText);
    Parent := pnlUserQuestion;
  end;
  var pnlQuestion := TSpTBXPanel.Create(Self);
  with pnlQuestion do begin
    Caption := '';
    Anchors := [akLeft, akRight, akTop, akBottom];
    Borders := False;
    Top := 0;
    Left := 40;
    Width := pnlUserQuestion.Width - 40;
    Height := pnlUserQuestion.Height;
    Parent := pnlUserQuestion;
  end;
  var lblQuestion := TSpTBXLabel.Create(Self);
  with lblQuestion do begin
    Font.Name := 'Consolas';
    Font.Size := 10;
    Wrapping := twWrap;
    Parent := pnlQuestion;
    Align := alTop;
    PopUpMenu := popTextMenu;
  end;
  pnlUserQuestion.OnResize :=  QPanelResize;
  lblQuestion.Caption := Question;
  pnlUserQuestion.ScaleForPPI(CurrentPPI);
  pnlUserQuestion.Parent := QAStackPanel;
end;

procedure TLLMChatForm.FormCreate(Sender: TObject);
begin
  LLMChat := TLLMChat.Create(GPT_35_Settings);
  LLMChat.OnLLMError := OnLLMError;
  LLMChat.OnLLMResponse := OnLLMResponse;

  var FileName := TPath.Combine(TPath.GetDirectoryName(Application.ExeName),
    'Chat history.json');
  LLMChat.LoadChat(FileName);

  FileName := TPath.Combine(TPath.GetDirectoryName(Application.ExeName),
    'Chat Settings.json');
  LLMChat.LoadSettrings(FileName);
end;

procedure TLLMChatForm.FormShow(Sender: TObject);
begin
  DisplayActiveChatTopic;
end;

procedure TLLMChatForm.OnLLMError(Sender: TObject; const Error: string);
begin
  aiBusy.Animate := False;
  MessageDlg(Error, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
end;

procedure TLLMChatForm.OnLLMResponse(Sender: TObject; const Question,
  Answer: string);
begin
  aiBusy.Animate := False;
  DisplayQuestion(Question);
  DisplayAnswer(Answer);
  reQuestion.Clear;
end;

procedure TLLMChatForm.QPanelResize(Sender: TObject);
begin
  var pnlUserQuestion := Sender as TSpTBXPanel;
  var lblQuestion := (pnlUserQuestion.Controls[1] as TSpTBXPanel).Controls[0] as TSpTBXLabel;
  var NewHeight := Max(MulDiv(40, CurrentPPI, 96), lblQuestion.Height + Margins.Bottom);
  if NewHeight <> pnlUserQuestion.Height then
    pnlUserQuestion.Height := NewHeight;
end;

procedure TLLMChatForm.reQuestionKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if (ssShift in Shift) and  (Key = vkReturn) then
    SbAskClick(Self);
end;

procedure TLLMChatForm.sbAskClick(Sender: TObject);
begin
  if reQuestion.Text = '' then
    Exit;
  aiBusy.Animate := True;
  LLMChat.Ask(reQuestion.Text);
end;

procedure TLLMChatForm.AcceptSettings(Sender: TObject; var NewText:
    string; var Accept: Boolean);
begin
  Accept := False;
  try
    if Sender = spiEndpoint then
      LLMChat.Settings.EndPoint := NewText
    else if Sender = spiModel then
      LLMChat.Settings.Model := NewText
    else if Sender = spiApiKey then
      LLMChat.Settings.ApiKey := NewText
    else if Sender = spiTimeout then
      LLMChat.Settings.TimeOut := NewText.ToInteger * 1000
    else if Sender = spiMaxTokens then
      LLMChat.Settings.MaxTokens := NewText.ToInteger
    else if Sender = spiSystemPrompt then
      LLMChat.Settings.SystemPrompt := NewText;
    LLMChat.ClearContext;
    Accept := True;
  except
    on E: Exception do
      MessageDlg(E.Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  end;
end;

procedure TLLMChatForm.actChatNewExecute(Sender: TObject);
begin
  LLMChat.NewTopic;
  DisplayActiveChatTopic;
end;

procedure TLLMChatForm.actChatNextExecute(Sender: TObject);
begin
  LLMChat.NextTopic;
  DisplayActiveChatTopic;
end;

procedure TLLMChatForm.actChatPreviousExecute(Sender: TObject);
begin
  LLMChat.PreviousTopic;
  DisplayActiveChatTopic;
end;

procedure TLLMChatForm.actChatRemoveExecute(Sender: TObject);
begin
  LLMChat.RemoveTopic;
  DisplayActiveChatTopic;
end;

procedure TLLMChatForm.actCopyTextExecute(Sender: TObject);
begin
  if popTextMenu.PopupComponent is TSynEdit then with TSynEdit(popTextMenu.PopupComponent) do
  begin
    if SelAvail then
      Clipboard.AsText := SelText
    else
      Clipboard.AsText := Text;
  end
  else if popTextMenu.PopupComponent is TSpTBXLabel then
    Clipboard.AsText := TSpTBXLabel(popTextMenu.PopupComponent).Caption;
end;

procedure TLLMChatForm.ActionListUpdate(Action: TBasicAction; var Handled:
    Boolean);
begin
  Handled := True;
  actChatNew.Enabled := ScrollBox.ControlCount > 0;
  actChatNext.Enabled := LLMChat.ActiveTopicIndex < High(LLMChat.ChatTopics);
  actChatPrevious.Enabled := LLMChat.ActiveTopicIndex > 0;
end;

procedure TLLMChatForm.SpTBXSubmenuItem1InitPopup(Sender: TObject; PopupView:
    TTBView);
begin
  spiEndpoint.Text := LLMChat.Settings.EndPoint;
  spiModel.Text := LLMChat.Settings.Model;
  spiApiKey.Text := LLMChat.Settings.ApiKey;
  spiTimeout.Text := (LLMChat.Settings.TimeOut div 1000).ToString;
  spiMaxTokens.Text := LLMChat.Settings.MaxTokens.ToString;
  spiSystemPrompt.Text := LLMChat.Settings.SystemPrompt;
end;


end.
