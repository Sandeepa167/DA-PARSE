unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

const
  MTK_DA_MAGIC: AnsiString = 'MTK_DOWNLOAD_AGENT';

type
  TForm13 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    EditFilePath: TEdit;
    ButtonParse: TButton;
    Panel2: TPanel;
    MemoChipsetList: TMemo;
    OpenDialog: TOpenDialog;
    procedure ButtonParseClick(Sender: TObject);
  private
    function ReverseBytes(const Bytes: TBytes): TBytes;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13: TForm13;

implementation

{$R *.dfm}

function GetL32(input: TBytes): Cardinal;
begin
  Move(input[0], Result, SizeOf(Cardinal));
end;

function TForm13.ReverseBytes(const Bytes: TBytes): TBytes;
var
  I, J: Integer;
begin
  SetLength(Result, Length(Bytes));
  J := Length(Bytes) - 1;
  for I := 0 to J do
    Result[J - I] := Bytes[I];
end;

procedure TForm13.ButtonParseClick(Sender: TObject);
var
  FileStream: TFileStream;
  Magic: TBytes;
  CountDA, i: Word;
  DAData, DAInfo: TBytes;
  ChipID: Cardinal;
  ChipIDStr: string;
begin
  if not OpenDialog.Execute then
    Exit;

  EditFilePath.Text := OpenDialog.FileName;

  FileStream := TFileStream.Create(OpenDialog.FileName, fmOpenRead or fmShareDenyWrite);
  try
    SetLength(Magic, Length(MTK_DA_MAGIC));
    FileStream.ReadBuffer(Magic[0], Length(MTK_DA_MAGIC));
    if not CompareMem(@Magic[0], PAnsiChar(MTK_DA_MAGIC), Length(MTK_DA_MAGIC)) then
    begin
      ShowMessage('Invalid MTK DA file');
      Exit;
    end;

    MemoChipsetList.Clear;

    FileStream.Seek($68, soBeginning);
    FileStream.ReadBuffer(CountDA, SizeOf(Word));
    for i := 0 to CountDA - 1 do
    begin
      FileStream.Seek($6C + $DC * i, soBeginning);
      SetLength(DAData, $DC);
      FileStream.ReadBuffer(DAData[0], Length(DAData));

      DAInfo := ReverseBytes(Copy(DAData, 3, 2));
      ChipID := GetL32(DAInfo);

      // Convert ChipID to hexadecimal string representation
      ChipIDStr := IntToHex(ChipID, 8);

      // Remove leading zeros after "MT"
      while (Length(ChipIDStr) > 2) and (ChipIDStr[3] = '0') do
        Delete(ChipIDStr, 3, 1);

      // Add the modified ChipID to the memo
      MemoChipsetList.Lines.Add('MT' + ChipIDStr);
    end;
  finally
    FileStream.Free;
  end;
end;








end.
