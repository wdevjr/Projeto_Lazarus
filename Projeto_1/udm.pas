unit UDM;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, IBConnection, sqldb, db, FileUtil, Forms, Controls,
  Graphics, Dialogs, DBGrids, ZConnection, ZDataset, ZSqlUpdate,IniFiles;

type

  { TDM }

  TDM = class(TDataModule)
    Conexao_ZEOS: TZConnection;
    ZQAssunto: TZQuery;
    ZQAssuntoCODIGO: TLongintField;
    ZQAssuntoCURSO: TStringField;
    ZQAssuntoDATA: TDateField;
    ZQAssuntoTITULOASSUN: TStringField;
    ZQLocalisaAssunto: TZQuery;
    ZQLocalisaAssuntoCODIGO: TLongintField;
    ZQLocalisaAssuntoCURSO: TStringField;
    ZQLocalisaAssuntoDATA: TDateField;
    ZQLocalisaAssuntoTITULOASSUN: TStringField;
    ZQuery1: TZQuery;
    ZQuery1CODIGO: TLongintField;
    ZQuery1CURSO: TStringField;
    ZQuery1DATA: TDateField;
    ZQuery1TITULOASSUN: TStringField;
    ZUpdateSQL1: TZUpdateSQL;
    procedure Conexao_ZEOSBeforeConnect(Sender: TObject);
    procedure ZQAssuntoNewRecord(DataSet: TDataSet);
    procedure ZQAssuntoPostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure ZQLocalisaAssuntoPostError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
  private
    procedure Incrementa(Tabela: String; FieldOBX: TField);
  public
    { public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.lfm}

{ TDM }

procedure TDM.Conexao_ZEOSBeforeConnect(Sender: TObject);
var
  Ini: TIniFile;
begin
    Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'String_Conexao.ini');
    try
        Conexao_ZEOS.Connected       := False;
        Conexao_ZEOS.HostName        := Ini.ReadString('Conexao_ZEOS', 'Hostname', '');
        Conexao_ZEOS.Port            := Ini.ReadInteger('Conexao_ZEOS', 'Port', 0);
        Conexao_ZEOS.Protocol        := Ini.ReadString('Conexao_ZEOS', 'Protocol', '');
        Conexao_ZEOS.LibraryLocation := Ini.ReadString('Conexao_ZEOS', 'LibraryLocation', '');
        Conexao_ZEOS.User            := Ini.ReadString('Conexao_ZEOS', 'User', '');
        Conexao_ZEOS.Password        := Ini.ReadString('Conexao_ZEOS', 'Password', '');
        Conexao_ZEOS.Database        := Ini.ReadString('Conexao_ZEOS', 'Database', '');
        Conexao_ZEOS.ClientCodepage  := Ini.ReadString('Conexao_ZEOS', 'Charset', '');

    except
         on E:Exception do
         MessageDlg('Erro ao conectar!'#13'Erro: ' + e.Message, mtError, [mbOK], 0);
    end;
end;

procedure TDM.ZQAssuntoNewRecord(DataSet: TDataSet);
begin
   if (ZQAssunto.State = dsInsert) then
       Incrementa('ASSUNTO',ZQAssuntoCODIGO);
end;

procedure TDM.ZQAssuntoPostError(DataSet: TDataSet; E: EDatabaseError;
  var DataAction: TDataAction);
begin
  MessageDlg('Erro no Banco de Dados A mensagem Nativa do Banco é: '+ E.Message,mtInformation,[mbOK],0);
end;

procedure TDM.ZQLocalisaAssuntoPostError(DataSet: TDataSet; E: EDatabaseError;
  var DataAction: TDataAction);
begin
  MessageDlg('Erro no Banco de Dados A mensagem Nativa do Banco é: '+E.Message,mtInformation,[mbOK],0);
end;

procedure TDM.Incrementa(tabela: String; FieldOBX:TField);
var Qry:TZQuery;
 begin
   Qry:=TZQuery.Create(nil);

  Qry.Connection:=Conexao_ZEOS;
  Qry.Close;
  Qry.SQL.Clear;
  Qry.SQL.Add('select MAX('+FieldOBX.FieldName+') from '+tabela);
  Qry.Open;

      If (Qry.Fields[0].IsNull ) then
      begin
             Fieldobx.AsInteger:=102040;
      end else

             Fieldobx.AsInteger:=Qry.Fields[0].AsInteger + 1;

      FreeAndNil(Qry);
  end;


end.

