object FrmQuestor: TFrmQuestor
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Teste Questor'
  ClientHeight = 376
  ClientWidth = 737
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object lbInserirClientes: TLabel
    Left = 16
    Top = 19
    Width = 187
    Height = 28
    Caption = 'Cadastrar 5 clientes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblInserirCarros: TLabel
    Left = 16
    Top = 139
    Width = 172
    Height = 28
    Caption = 'Cadastrar 5 carros'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 16
    Top = 259
    Width = 152
    Height = 28
    Caption = 'Lan'#231'ar 5 vendas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnInserirClientes: TButton
    Left = 16
    Top = 53
    Width = 187
    Height = 57
    Caption = 'Cadastrar clientes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnInserirClientesClick
  end
  object btnInserirCarros: TButton
    Left = 16
    Top = 173
    Width = 169
    Height = 57
    Caption = 'Cadastrar carros'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnInserirCarrosClick
  end
  object btnLancarVendas: TButton
    Left = 16
    Top = 293
    Width = 169
    Height = 57
    Caption = 'Lan'#231'ar vendas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnLancarVendasClick
  end
  object sdLog: TSaveDialog
    DefaultExt = '.txt'
    FileName = 'log_vendas'
    Filter = 'Arquivo de Texto|.txt'
    Left = 248
    Top = 296
  end
end
