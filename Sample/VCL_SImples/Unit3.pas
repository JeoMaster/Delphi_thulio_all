unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Vcl.ExtCtrls,
  Vcl.DBCtrls,  Vcl.Mask, Data.FMTBcd,
  Data.SqlExpr, Data.DBXFirebird, Datasnap.Provider, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection,  Vcl.Imaging.jpeg,
  TBGFiredacDriver.View.Driver, TBGDBExpressDriver.View.Driver,
  TBGConnection.View.Principal, TBGZeosDriver.View.Driver, TBGConnection.Model.Interfaces,
  TBGQuery.View.Principal, TBGUnidacDriver.View.Driver, UniProvider,
  InterBaseUniProvider, DBAccess, Uni;

type
  TForm3 = class(TForm)
    Button1: TButton;
    FDConnection1: TFDConnection;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    Button3: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    ZConnection1: TZConnection;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    ComboBox1: TComboBox;
    Label3: TLabel;
    SQLConnection1: TSQLConnection;
    BGZeosDriverConexao1: TBGZeosDriverConexao;
    TBGConnection1: TTBGConnection;
    BGDBExpressDriverConexao1: TBGDBExpressDriverConexao;
    BGFiredacDriverConexao1: TBGFiredacDriverConexao;
    TBGQuery1: TTBGQuery;
    UniConnection1: TUniConnection;
    InterBaseUniProvider1: TInterBaseUniProvider;
    BGUnidacDriverConexao1: TBGUnidacDriverConexao;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure preencherDados;
    procedure SelecionaDriver;
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  SelecionaDriver;
  TBGQuery1.Query.Open('SELECT * FROM CLIENTE ORDER BY ID');
  TBGQuery1.Query.Fields.FieldByName('NOME').DisplayWidth := 102;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  TBGConnection1.Driver.Conexao.StartTransaction;
  try
    TBGQuery1.Query.ExecSQL('INSERT INTO CLIENTE (ID, NOME) VALUES ((SELECT MAX(ID) +1 FROM CLIENTE), ' + QuotedStr('Registro Inserido via ExecSQL') + ')');
    TBGConnection1.Driver.Conexao.Commit;
  except
    TBGConnection1.Driver.Conexao.RollbackTransaction;
  end;

end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  ShowMessage(
      TBGQuery1
      .Query
      .DataSet
      .FieldByName('NOME')
      .AsString
  );
end;

procedure TForm3.Button4Click(Sender: TObject);
var
 i : Integer;
begin
  TBGQuery1.Query.DataSet.Insert;
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
  TBGQuery1.Query.DataSet.Edit;
end;

procedure TForm3.Button6Click(Sender: TObject);
begin
  TBGQuery1.Query.DataSet.Delete;
end;

procedure TForm3.Button7Click(Sender: TObject);
begin
  preencherDados;
  TBGQuery1.Query.DataSet.Post;
end;

procedure TForm3.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  if DataSource1.State = dsBrowse then
  begin
    Edit1.Text := TBGQuery1.Query.Fields.FieldByName('ID').AsString;
    Edit2.Text := TBGQuery1.Query.Fields.FieldByName('NOME').AsString;
  end;
end;

procedure TForm3.preencherDados;
begin
  TBGQuery1.Query.DataSet.FieldByName('ID').Value := StrToInt(Edit1.Text);
  TBGQuery1.Query.DataSet.FieldByName('NOME').Value := Edit2.Text;
end;

procedure TForm3.SelecionaDriver;
begin
  case ComboBox1.ItemIndex of
    0 : TBGConnection1.Driver := BGDBExpressDriverConexao1;
    1 : TBGConnection1.Driver := BGFiredacDriverConexao1;
    2 : TBGConnection1.Driver := BGZeosDriverConexao1;
   // 3 : TBGConnection1.Driver := BGUnidacDriverConexao1;
  end;
end;

end.