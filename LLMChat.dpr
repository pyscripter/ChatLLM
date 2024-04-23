program LLMChat;

uses
  Vcl.Forms,
  LLMChatUI in 'LLMChatUI.pas' {LLMChatForm},
  dmResources in 'dmResources.pas' {Resources: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  LLMSupport in 'LLMSupport.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows11 Impressive Light');
  Application.CreateForm(TResources, Resources);
  Application.CreateForm(TLLMChatForm, LLMChatForm);
  Application.Run;
end.
