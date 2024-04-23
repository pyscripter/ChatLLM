unit dmResources;

interface

uses
  System.SysUtils, System.Classes, Vcl.BaseImageCollection,
  SVGIconImageCollection, SynHighlighterGeneral, SynEditCodeFolding,
  SynHighlighterPython, SynEditHighlighter, SynHighlighterMulti,
  SynHighlighterPas;

type
  TResources = class(TDataModule)
    LLMImages: TSVGIconImageCollection;
    SynMultiSyn: TSynMultiSyn;
    SynPythonSyn: TSynPythonSyn;
    SynGeneralSyn: TSynGeneralSyn;
    SynPasSyn: TSynPasSyn;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Resources: TResources;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  Vcl.Graphics,
  Vcl.Themes;

procedure TResources.DataModuleCreate(Sender: TObject);
begin
  LLMImages.FixedColor := StyleServices.GetSystemColor(clWindowText)
end;

end.
