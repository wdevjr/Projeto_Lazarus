unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, db, FileUtil, Forms, Controls,
  Graphics, Dialogs, DBGrids, ExtCtrls, DbCtrls, StdCtrls, Buttons, ZConnection,
  ZDataset, IniFiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    DBText2: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    trazer: TBitBtn;
    cancelar: TBitBtn;
    deletar: TBitBtn;
    inserir: TBitBtn;
    gravar: TBitBtn;
    editar: TBitBtn;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBText1: TDBText;
    Dtsrc: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure cancelarClick(Sender: TObject);
    procedure deletarClick(Sender: TObject);
    procedure DtsrcStateChange(Sender: TObject);
    procedure editarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure gravarClick(Sender: TObject);
    procedure inserirClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure trazerClick(Sender: TObject);
  private
    procedure ConfigInicial;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

Uses UDM,Unit2;

procedure TForm1.ConfigInicial;
begin
  inserir.Enabled := True;
  gravar.Enabled := False;
  editar.Enabled := False;
  deletar.Enabled := False;
  cancelar.Enabled := False;
  trazer.Enabled := True;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 // Dtsrc.DataSet.Open;
  DM.ZQuery1.Open;
  ConfigInicial;
  DBGrid1.AlternateColor:=clGradientInactiveCaption ;
  DBGrid1.Color:=$00BFFFFF;
end;

procedure TForm1.DtsrcStateChange(Sender: TObject);
begin
    with Dtsrc.DataSet do
  begin
    deletar.Enabled := not IsEmpty;
    inserir.Enabled := Dtsrc.State in [dsBrowse, dsInactive];
    gravar.Enabled := Dtsrc.State in [dsInsert];
    editar.Enabled := Dtsrc.State in [dsEdit];
    cancelar.Enabled := Dtsrc.State in [dsInsert, dsEdit];
    deletar.Enabled := Dtsrc.State in [dsBrowse];
    trazer.Enabled := Dtsrc.State in [dsBrowse];
  end;
end;

procedure TForm1.deletarClick(Sender: TObject);
begin
  if (MessageDlg('Deseja realmente Excluir este registro ?',mtConfirmation,[mbYes,mbNo],0) = mrYes) then
  begin
    Dtsrc.DataSet.Delete;
    (Dtsrc.DataSet as TZQuery).ApplyUpdates;
    DM.ZQuery1.Refresh;
  end else
       Abort;
end;

procedure TForm1.cancelarClick(Sender: TObject);
begin
  Dtsrc.DataSet.Cancel;
  ConfigInicial;
end;

procedure TForm1.editarClick(Sender: TObject);
begin
  if ((DBEdit1.Text <> '') and (DBEdit2.Text <> '') and (DBEdit3.Text <> '  /  /    ')) then
  begin
     Dtsrc.DataSet.Edit;
     (Dtsrc.DataSet as TZQuery).ApplyUpdates;
      DM.ZQuery1.Refresh;
  end else
          MessageDlg('Insera um Registro no campo vazio !',mtWarning,[mbOK],0);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Dtsrc.DataSet.Close;
  DM.ZQuery1.Close;
end;

procedure TForm1.gravarClick(Sender: TObject);
begin
  if ((DBEdit1.Text <> '') and (DBEdit2.Text <> '') and (DBEdit3.Text <> '  /  /    ')) then
  begin
     Dtsrc.DataSet.Post;
     (Dtsrc.DataSet as TZQuery).ApplyUpdates;
      DM.ZQuery1.Refresh;
  end else
          MessageDlg('Insira um Registro no campo vazio !',mtWarning,[mbOK],0);
end;

procedure TForm1.inserirClick(Sender: TObject);
begin
  Dtsrc.DataSet.Open;
  Dtsrc.DataSet.Append;
  Dtsrc.DataSet.Insert;
  DBEdit3.EditMask:='  /  /    ';
end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.trazerClick(Sender: TObject);
begin
  FrmDlgPesquisa := TFrmDlgPesquisa.Create(Owner);
  try
    if FrmDlgPesquisa.ShowModal = mrOk then
    begin
      DM.ZQAssunto.close;
      DM.ZQAssunto.Params[0].AsInteger := DM.ZQLocalisaAssuntoCODIGO.AsInteger;
      DM.ZQAssunto.Open;
    end;
  finally
    DM.ZQLocalisaAssunto.close;
    FrmDlgPesquisa.Free;
  end;
end;



end.

