object Form13: TForm13
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Form13'
  ClientHeight = 537
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 425
    Height = 41
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 16
      Height = 13
      Caption = 'da:'
    end
    object EditFilePath: TEdit
      Left = 32
      Top = 8
      Width = 289
      Height = 21
      TabOrder = 0
    end
    object ButtonParse: TButton
      Left = 327
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Parse'
      TabOrder = 1
      OnClick = ButtonParseClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 47
    Width = 425
    Height = 490
    TabOrder = 1
    object MemoChipsetList: TMemo
      Left = 8
      Top = 0
      Width = 409
      Height = 489
      TabOrder = 0
    end
  end
  object OpenDialog: TOpenDialog
    Left = 328
    Top = 64
  end
end
