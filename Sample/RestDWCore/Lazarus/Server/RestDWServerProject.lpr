program RestDWServerProject;

uses
  {$IFDEF FPC}
   {$IFDEF UNIX}cthreads,
   {$ENDIF}
  {$ENDIF}
  Forms, Interfaces,
  RestDWServerFormU in 'RestDWServerFormU.pas' {RestDWForm},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {ServerMethods1: TDataModule},
  uDmService in 'uDmService.pas' {DataModule1: TDataModule};

{.$R *.res}

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TRestDWForm, RestDWForm);
  Application.Run;
end.
