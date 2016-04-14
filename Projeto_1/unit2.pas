unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics,
  Controls, Forms, Dialogs,DB,
  StdCtrls, ExtCtrls, Buttons, DBGrids, Grids;

type

  { TFrmDlgPesquisa }

  TFrmDlgPesquisa = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Dtsrc: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmDlgPesquisa: TFrmDlgPesquisa;

implementation

{$R *.lfm}

uses UDM;

{ TFrmDlgPesquisa }

procedure TFrmDlgPesquisa.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  DM.ZQLocalisaAssunto.Close;
  DM.ZQLocalisaAssunto.Params[0].AsString:='%'+Edit1.Text+'%';
  DM.ZQLocalisaAssunto.Open;
      With Dtsrc.DataSet do
    begin
      BitBtn2.Enabled:=not IsEmpty;
    end;
  DBGrid1.AlternateColor:=$00BFFFFF;
  DBGrid1.Color:=clBtnFace;
end;

procedure TFrmDlgPesquisa.FormShow(Sender: TObject);
begin
    With Dtsrc.DataSet do
    begin
      BitBtn2.Enabled:=not IsEmpty;
    end;
end;



end.

