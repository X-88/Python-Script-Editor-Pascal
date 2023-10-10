unit U2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLType, Windows, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFAbout }

  TFAbout = class(TForm)
    M1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private

  public

  end;

var
  FAbout: TFAbout;

implementation

{$R *.lfm}

{ TFAbout }

procedure TFAbout.FormCreate(Sender: TObject);
begin
    M1.Font.Handle := GetStockObject(OEM_Fixed_Font);
end;

procedure TFAbout.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
{if button <> MBRight then
    exit
else
    close;
    }
end;

end.

