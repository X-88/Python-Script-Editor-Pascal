{
 I apologize in advance because I'm not good at English,
 so perhaps the mention in the comments is not appropriate.
 and maybe there are too many abbreviations for naming variables and naming components
}

unit U1;

//{$mode objfpc}{$H+}
 {$mode delphi}
interface

uses
    Classes, ShellApi, jwatlhelp32, Messages, U2, SynEditMarks, LMessages, LCLType,
    LCLIntf, Windows, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
    Buttons, Menus, StdCtrls, SynEdit, SynHighlighterPython, Types;

type

{ TFZP1 }

TFZP1 = class(TForm)
  B5: TButton;
  B6: TButton;
  B7: TButton;
    CB1: TComboBox;
    CB2: TComboBox;
    CD1: TColorDialog;
    EI1: TEdit;
    ES1: TEdit;
    About: TMenuItem;
    IL1: TImageList;
    LBS1: TListBox;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    B8: TSpeedButton;
    B9: TSpeedButton;
    ToolButton4: TToolButton;
    Undo2: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    EditorColor1: TMenuItem;
    InstallModule1: TMenuItem;
    Copy2: TMenuItem;
    Cut2: TMenuItem;
    Paste2: TMenuItem;
    SelectAll: TMenuItem;
    MenuItem9: TMenuItem;
    P3: TPanel;
    P4: TPanel;
    PUM2: TPopupMenu;
    Run2: TMenuItem;
    BC2: TSpeedButton;
    Stop: TMenuItem;
    OpenWith1: TMenuItem;
    Open1: TMenuItem;
    Search1: TMenuItem;
    P1: TPanel;
    P2: TPanel;
    BC1: TSpeedButton;
    B3: TSpeedButton;
    T2: TTimer;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Undo1: TMenuItem;
    SelectAll1: TMenuItem;
    Paste1: TMenuItem;
    Setting1: TMenuItem;
    SaveAs1: TMenuItem;
    Save1: TMenuItem;
    New1: TMenuItem;
    Tools1: TMenuItem;
    Run1: TMenuItem;
    Edit1: TMenuItem;
    File1: TMenuItem;
    OD1: TOpenDialog;
    PUM1: TPopupMenu;
    SD1: TSaveDialog;
    SB1: TStatusBar;
    SE1: TSynEdit;
    B1: TSpeedButton;
    SPS1: TSynPythonSyn;
    TB1: TToolBar;
    T1: TTimer;

procedure AboutClick(Sender: TObject);
procedure B1Click(Sender: TObject);
procedure B1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
procedure B1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
procedure B3Click(Sender: TObject);
procedure B5Click(Sender: TObject);
procedure B6Click(Sender: TObject);
procedure B7Click(Sender: TObject);
procedure B8Click(Sender: TObject);
procedure B9Click(Sender: TObject);
procedure BC2Click(Sender: TObject);
procedure CB1Change(Sender: TObject);
procedure CB2Change(Sender: TObject);
procedure Copy1Click(Sender: TObject);
procedure Copy2Click(Sender: TObject);
procedure Cut1Click(Sender: TObject);
procedure Cut2Click(Sender: TObject);
procedure EI1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
procedure ES1KeyPress(Sender: TObject; var Key: char);
procedure ES1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
procedure FormActivate(Sender: TObject);
procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
procedure FormCreate(Sender: TObject);
procedure FormDropFiles(Sender: TObject; const FileNames: array of String);
procedure InstallModule1Click(Sender: TObject);
procedure LBS1DblClick(Sender: TObject);
procedure LBS1DrawItem(Control: TWinControl; Index: Integer; ARect: TRect;
  State: TOwnerDrawState);
procedure EditorColor1Click(Sender: TObject);
procedure Paste2Click(Sender: TObject);
procedure SelectAllClick(Sender: TObject);
procedure Undo2Click(Sender: TObject);
procedure P4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
procedure Paste1Click(Sender: TObject);
procedure Run2Click(Sender: TObject);
procedure SaveAs1Click(Sender: TObject);
procedure SelectAll1Click(Sender: TObject);
procedure StopClick(Sender: TObject);
procedure OpenWith1Click(Sender: TObject);
procedure Open1Click(Sender: TObject);
procedure New1Click(Sender: TObject);
procedure P2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
procedure PUM1Popup(Sender: TObject);
procedure Save1Click(Sender: TObject);
procedure SE1Change(Sender: TObject);
procedure BC1Click(Sender: TObject);
procedure SE1Click(Sender: TObject);
procedure Search1Click(Sender: TObject);
procedure T1Timer(Sender: TObject);
procedure TB1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
procedure T2Timer(Sender: TObject);
procedure Undo1Click(Sender: TObject);

private
{Coded By: Zephio, April 26, 2021}
public
procedure CaretPos;
procedure ResettoDefault;
procedure GetFontName;
procedure TRSCreate;
procedure TRSDelete;
procedure FNew(Sender: TObject);
procedure SConfirm(Sender: TObject);
procedure ReadConfig(ConfigName : String);
procedure WriteConfig(ConfigName : String);
function BackupScript: String;
function KillTask(ExeFileName: string): Integer;
end;

var
    //Main Form
    FZP1: TFZP1;
    //File Path
    FPath,
    //Temporary Path
    TPath,
    //Temporary File Path
    TFPath: String;
    //Variable to check modified or not
    BStatus: Boolean;
    //Init Animation Arrow
    ArAni: Integer;
    //SynEdit Mark
    CMark: TSynEditMark;
    //convert String to pChar
    St: Array[0..255] of char;

const
    //Test Path
    TRSPath = 'C:\test.py';
    //Default Form Caption or Title on Taskbar
    ZAName = 'Z-Code Editor v1.0.0';
    //Default Caret Position
    DCarpos = 'Line: 1, Col: 1';
    //Set Status
    DStatus = '';
    MStatus = 'Modified';
    //Default Project Title
    DTitle = 'Untitled';


implementation

{$R *.lfm}

{ TFZP1 }

//Reset Any Change to Default
procedure TFZP1.ResettoDefault;
begin
    ArAni :=  0;
    BStatus := False;
    FZP1.Caption := ZAName;
    Application.Title := ZAName;
    FZP1.AllowDropFiles := true;
    CD1.Color := SE1.Color;
    Save1.Enabled := false;
    SaveAs1.Enabled := false;
    P1.Visible := false;
    P3.Visible := false;
    OD1.FileName := '';
    SD1.FileName := '';
    ES1.Text := 'Type Here To Search...';
    SB1.Panels[0].Text:= DCarPos;
    SB1.Panels[1].Text:= DStatus;
    SB1.Panels[2].Text:= DTitle;
    CB1.Text := SE1.Font.Name;
    CB2.Text := IntToStr(SE1.Font.Size);
end;

//Save Temporary File to Test
procedure TFZP1.TRSCreate;
begin
if not FileExists(TRSPath) then
    SE1.Lines.SaveToFile(TRSPath);
end;

//Delete Temporary File to Test
procedure TFZP1.TRSDelete;
begin
if not FileExists(TRSPath) then
    exit
else
    DeleteFile(TRSPath);
end;

//just Modified few part, original from swissdelphicenter.ch
function TFZP1.KillTask(ExeFileName: string): Integer;
const
    PROCESS_TERMINATE = $0001;
var
    ContinueLoop: BOOL;
    FSnapshotHandle: THandle;
    FProcessEntry32: TProcessEntry32;
begin
    Result := 0;
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
while Integer(ContinueLoop) <> 0 do
begin
if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
end;
    CloseHandle(FSnapshotHandle);
end;

//Write INI Configuration
procedure TFZP1.WriteConfig(ConfigName : String);
var
    SL : TStringList;
begin
    SL := TStringList.Create;
    SL.Add('[' + ZAName + ']');
    SL.Add('Font Name: ' + CB1.Text); //SE1.Font.Name);
    SL.Add('Font Size: ' + CB2.Text); //IntToStr(SE1.Font.Size));
    SL.Add('Path: ' + SD1.FileName);
    SL.SaveToFile(ConfigName);
    SL.Free;
end;

//Read INI Configuration
procedure TFZP1.ReadConfig(ConfigName : String);
var
    SL : TStringList;
begin
if not FileExists(ConfigName) then
    WriteConfig(ExtractFilePath(Application.ExeName) + 'Config.zcon')
else
begin
    SL := TStringList.Create;
    SL.LoadFromFile(ConfigName);
    CB1.Text := Copy(SL.Strings[1], 12, Length(SL.Strings[1]));
    CB2.Text := Copy(SL.Strings[2], 12, Length(SL.Strings[2]));
    OD1.FileName := Copy(SL.Strings[3], 7, Length(SL.Strings[3]));
end;
    SL.Free;
end;

//Update Caret Position
procedure TFZP1.CaretPos;
begin
    SB1.Panels[0].Text:= 'Line: ' + InttoStr(SE1.CaretY) + ', Col: ' + InttoStr(SE1.CaretX);
end;

//Confirmation Before Close
procedure TFZP1.SConfirm(Sender: TObject);
var
    MsgText, MsgCaption : String;
    MsgType, UserResp : integer;
begin
    MsgCaption := 'Confirmation';
    MsgText := 'Save Change?...';
    MsgType := MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON1 + MB_APPLMODAL;
    UserResp := MessageBox( Handle, PChar(MsgText), PChar(MsgCaption), MsgType);
Case UserResp of
    IDYES :
begin
    Save1Click(Sender);
end;
    IDNO :
begin
    FNew(Sender);
end;

end;

end;

//Create New Project, While Editor Changed
procedure TFZP1.FNew(Sender: TObject);
begin
    SE1.Clear;
    SE1.SetFocus;
    ResetToDefault;
    //BStatus := false;
end;

//Create New Project, to check maybe the Editor is not empty
procedure TFZP1.New1Click(Sender: TObject);
begin
if BStatus = true then
    Sconfirm(Sender)
else
    FNew(Sender);
end;

//Backup Project on Close
function TFZP1.BackupScript: String;
const
    TDir = 'ZBackup';
    TFile = 'temp.py';
begin
    TPath := ExtractFilePath(Application.ExeName);
if not DirectoryExists(TPath + TDir) then
    CreateDir(TPath + TDir);
if SE1.Lines.Count < 1 then
    exit
else
begin
    TFPath := TPath + TDir + '\' + TFile;
    SE1.Lines.SaveToFile(TFPath);
    Result := TFPath;
end;

end;

//to Show Font Name
function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
    TStrings(Data).Add(LogFont.lfFaceName);
    Result := 1;
end;

//Get Font Name
procedure TFZP1.GetFontName;
var
    DC: HDC;
begin
    DC := GetDC(0);
    EnumFonts(DC, nil, @EnumFontsProc, Pointer(CB1.Items));
    ReleaseDC(0, DC);
    CB1.Sorted := True;
end;

//Event on Create
procedure TFZP1.FormCreate(Sender: TObject);
begin
    GetFontName; //Get Font Name
    ResettoDefault; //Reset to Default Configuration
    CMark := TSynEditMark.Create(SE1); //Create Mark on Editor
    CMark.ImageList := IL1; //Mark Image Source
    CMark.Visible := true; //Set Mark Visible
    SE1.Marks.Add(CMark);  //Insert Mark
end;

//Drag & Drop Files (*.py)
procedure TFZP1.FormDropFiles(Sender: TObject; const FileNames: array of String
  );
var
    i: Integer;
begin
if BStatus = true then
    SConfirm(Sender)
else
begin
for i := Low(FileNames) to High(FileNames) do
if ExtractFileExt(FileNames[i]) <> '.py' then
    exit
else
begin
    SE1.Clear;
    SE1.Lines.LoadFromFile(FileNames[i]);
    SE1.SetFocus;
    FPath := ChangeFileExt(ExtractFileName(FileNames[i]), '');
end;
    OD1.FileName := FPath;
    //SD1.FileName := FPath;
    BStatus := false;
    SB1.Panels[1].Text := DStatus;
    SB1.Panels[2].Text := FPath;
end;

end;

//to Show Library Installer
procedure TFZP1.InstallModule1Click(Sender: TObject);
begin
    P3.Visible := not P3.Visible;
    EI1.Text := 'Module Name';
end;

//to Get Position (to Find Text Position)
procedure TFZP1.LBS1DblClick(Sender: TObject);
begin
    SE1.CaretY := StrToInt(Copy(LBS1.Items[LBS1.ItemIndex], 7, 4));
    SE1.LineHighlightColor.BackGround := $808080;
    SE1.SetFocus;
end;

//Drawing Find Text Positin
procedure TFZP1.LBS1DrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
begin
with (control as TListbox) do
begin
    Canvas.Brush.Style := BSSolid;
    Canvas.Fillrect(ARect);
if (Index mod 2) = 0 then
    Canvas.Font.Color := $0000ff;
    Canvas.Textout(ARect.left + 5, ARect.top, Items[index]);
end;

end;

//to Displays Text Search
procedure TFZP1.B3Click(Sender: TObject);
var
    i: Integer;
begin
    LBS1.Clear;
for I := 0 to SE1.Lines.Count - 1 do
if Pos(LowerCase(ES1.Text), LowerCase(SE1.Lines[i])) > 0 then
    LBS1.Items.Add('Line: ' + Format('%.*d',[4, i + 1]) + ' - [' + SE1.Lines[i]+']');
end;

//to Set Editor Color (Background)
procedure TFZP1.EditorColor1Click(Sender: TObject);
begin
if not CD1.Execute then
    exit
else
    SE1.Color := CD1.Color;
end;

//Clipboard
//Paste from Clipboard (PopUpMenu)
procedure TFZP1.Paste2Click(Sender: TObject);
begin
    Paste1Click(Sender);
end;

//Paste from Clipboard (PopUpMenu)
procedure TFZP1.Paste1Click(Sender: TObject);
begin
    SE1.PasteFromClipboard;
end;

//Select All (PopUpMenu)
procedure TFZP1.SelectAllClick(Sender: TObject);
begin
    SelectAll1Click(Sender);
end;

//Select All (PopUpMenu)
procedure TFZP1.SelectAll1Click(Sender: TObject);
begin
    SE1.SelectAll;
end;

//Undo (PopUpMenu)
procedure TFZP1.Undo2Click(Sender: TObject);
begin
    Undo1Click(Sender);
end;

//Copy (PopUpMenu)
procedure TFZP1.Copy1Click(Sender: TObject);
begin
    SE1.CopyToClipboard;
end;

//Copy (PopUpMenu)
procedure TFZP1.Copy2Click(Sender: TObject);
begin
    Copy1Click(Sender);
end;

//Cut (PopUpMenu)
procedure TFZP1.Cut1Click(Sender: TObject);
begin
    SE1.CutToClipboard;
end;

//Cut (PopUpMenu)
procedure TFZP1.Cut2Click(Sender: TObject);
begin
    Cut1Click(Sender);
end;

//to Move Dialog Library Install/Uninstall/List
procedure TFZP1.P4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Button <> MBLeft then
    exit
else
    ReleaseCapture;
    SendMessage(P3.Handle, LM_SYSCOMMAND, 61458, 0);
end;

//to Move Search Dialog
procedure TFZP1.P2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Button <> MBLeft then
    exit
else
    ReleaseCapture;
    SendMessage(P1.Handle, LM_SYSCOMMAND, 61458, 0);
end;

//to Running Project
procedure TFZP1.Run2Click(Sender: TObject);
const
    cnMaxUserNameLen = 256;
var
    sUserName     : string;
    dwUserNameLen : DWord;
    CBat: TStringList;
begin
//to Get User Nameame
    dwUserNameLen := cnMaxUserNameLen-1;
    SetLength(sUserName, cnMaxUserNameLen);
    GetUserName(PChar(sUserName), dwUserNameLen);
    SetLength(sUserName, dwUserNameLen);
//Create StringList (*.bat)
    CBat := TStringList.Create;
if (SE1.Lines.Count < 1) then
begin
    MessageBox(Handle, 'Plase Write a Script before Running the interpreter!...', 'Informaion', MB_OK + MB_ICONWARNING);
    exit
end
else
begin
//Maybe the interpreter is still running, so it must be stopped to anticipate a crash
    StopClick(Sender);
//Create Temporary File to test
    TRSCreate;
//Test Running Project
    ShellExecute(Handle, nil, 'cmd.exe', StrPCopy(St, '/k Python -i ' + pChar(TRSPath)), nil, SW_SHOWNORMAL);
//to Create *.bat
{
not used or called in this application, only generate,
just helps people who are lazy about typing when running projects
(like me who is lazy about typing in the command prompt just to run scripts) :D
}
    CBat.Add('@echo off');
    CBat.Add('title Zephio Test Running python');
    CBat.Add('color 3');
    CBat.Add('echo Running Python');
    CBat.Add('pause');
    CBat.Add('color A');
    CBat.Add('"C:\Users\'+ Copy(sUserName, 0, Length(sUserName) - 1) +'\AppData\Local\Programs\Python\Python310\python.exe" "'+ TRSPath + '"');
    CBat.Add('pause');
    CBat.SaveToFile(ExtractFilePath(Application.ExeName) + 'ZRun.bat' );
end;
    CBat.Free;
end;

//Save As Project to File
{
I always use "not" or "<>" or "!=" then exit to avoid errors when canceling open/save in the Open/Save Dialog box,
I encountered this case more than 10 years ago on BCB 6 & Delphi 7, so this it has become my habit
}
procedure TFZP1.SaveAs1Click(Sender: TObject);
begin
    SD1.Title:= 'Save As';
if not SD1.Execute then
    exit
else
begin
    SE1.Lines.SaveToFile(OD1.FileName);
    SB1.Panels[1].Text := DStatus;
    SD1.FileName := SB1.Panels[2].Text;
    BStatus := false;
    Save1.Enabled := false;
    SaveAs1.Enabled := false;
end;

end;

//Save Project to File
procedure TFZP1.Save1Click(Sender: TObject);
begin
    SD1.Title:= 'Save To File';
if not SD1.Execute then
    exit
else
begin
    SE1.Lines.SaveToFile(OD1.FileName);
    SB1.Panels[1].Text := DStatus;
    SD1.FileName := SB1.Panels[2].Text;
    BStatus := false;
    Save1.Enabled := false;
    SaveAs1.Enabled := false;
end;

end;

//to Stop Interpreter
procedure TFZP1.StopClick(Sender: TObject);
begin
    KillTask('cmd.exe');  //Terminate Command Promp
    KillTask('python.exe'); //Terminate Python
    //TRSDelete;
    //ShellExecute(0, 'open', 'taskkill', pChar('-f /im CMD.exe'), nil, SW_HIDE);
    //ShellExecute(0, 'open', 'taskkill', pChar('-f /im python.exe'), nil, SW_HIDE);
end;

//Open With Other Editor
procedure TFZP1.OpenWith1Click(Sender: TObject);
begin
    TRSCreate;
    ShellExecute(Handle, 'open', StrPCopy(St, pChar(TFPath)), nil, nil, SW_SHOWNORMAL);
end;

//to Open Project
procedure TFZP1.Open1Click(Sender: TObject);
begin
{if BStatus = true then
    SConfirm(Sender)
else
begin
}
if not OD1.Execute then
    exit
else
    SE1.Lines.LoadFromFile(OD1.FileName);
    SE1.SetFocus;
    BStatus := false;
    FPath := ChangeFileExt(ExtractFileName(OD1.FileName), '');
    SD1.FileName := FPath;
    SB1.Panels[1].Text := DStatus;
    SB1.Panels[2].Text := FPath;
end;

//end;

//Main Menu Button Color
procedure TFZP1.PUM1Popup(Sender: TObject);
begin
    B1.Font.Color := $000000;
end;

procedure TFZP1.B1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Button <> MBLeft then
    exit
else
    B1.Font.Color := $ff0000;
end;

procedure TFZP1.B1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
    B1.Font.Color := $000000;
end;

//Set Popup Menu Position like Main Menu
procedure TFZP1.B1Click(Sender: TObject);
begin
    PUM1.Popup(FZP1.Left + B1.Left + 8, FZP1.Top + B1.Height + 38);
end;

//to Show Form About
procedure TFZP1.AboutClick(Sender: TObject);
begin
    FAbout.ShowModal;
end;

//to Install Library
procedure TFZP1.B5Click(Sender: TObject);
begin
if ((Length(EI1.Text) < 1) or
    (EI1.Text = 'Module Name')) then
    exit
else
    ShellExecute(Handle, nil, 'cmd.exe', StrPCopy(St, '/k Python -m pip install ' + pChar(EI1.Text)), nil, SW_Show);
end;

//to Uninstall Library
procedure TFZP1.B6Click(Sender: TObject);
begin
if ((Length(EI1.Text) < 1) or
    (EI1.Text = 'Module Name')) then
    exit
else
    ShellExecute(Handle, nil, 'cmd.exe', StrPCopy(St, '/k Python -m pip uninstall ' + pChar(EI1.Text)), nil, SW_Show);
end;

//to Display the Installed Libraries
procedure TFZP1.B7Click(Sender: TObject);
begin
    ShellExecute(Handle, nil, 'cmd.exe', '/k Python -m pip list', nil, SW_Show);
end;

//Running Project Sender
procedure TFZP1.B8Click(Sender: TObject);
begin
    Run2Click(Sender);
end;

//Stop Project
procedure TFZP1.B9Click(Sender: TObject);
begin
    StopClick(Sender);
end;

//to Show/Hide Library Dialog
procedure TFZP1.BC2Click(Sender: TObject);
begin
    P3.Visible := not P3.Visible;
end;

//to Change Font Name
procedure TFZP1.CB1Change(Sender: TObject);
begin
if Length(CB1.Text) < 1 then
    exit
else
    SE1.Font.Name := CB1.Text;
end;

//to Change Font Size
procedure TFZP1.CB2Change(Sender: TObject);
begin
if Length(CB2.Text) < 1 then
    exit
else
    SE1.Font.Size := StrToInt(CB2.Text);
end;

//to clear Library Edit
procedure TFZP1.EI1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if EI1.Text = 'Module Name' then
begin
    EI1.Clear;
    EI1.SetFocus;
end
else
    exit;
end;

//[Enter] Button Text Search
procedure TFZP1.ES1KeyPress(Sender: TObject; var Key: char);
begin
if key <> #13 then
    exit
else
    B3Click(Sender);
end;

//to Clear Edit Search
procedure TFZP1.ES1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if ES1.Text = 'Type Here To Search...' then
begin
    ES1.Clear;
    ES1.SetFocus;
end
else
    exit;
end;

//to Terminate the Ppplication if it is being Debugged
procedure TFZP1.FormActivate(Sender: TObject);
begin
if (FindWindow('OllyDbg', nil) +
    FindWindow('TIdaWindow', nil) +
    FindWindow('OWL_Window', nil) <> 0) then
    Application.Terminate
else
//Load Configuration Font Name & Size
    ReadConfig(ExtractFilePath(Application.ExeName) + 'Config.zcon');
end;

//Save Configuration Font Name & Size, backup Script
procedure TFZP1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    FZP1.Caption := ZAName + ' - [Please Waiting...]';
    Sleep(200);
    StopClick(Sender);
    BackupScript;
    TRSDelete;
    WriteConfig(ExtractFilePath(Application.ExeName) + 'Config.zcon');
end;

procedure TFZP1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
const
    SWarningText = 'Save Change?...';
begin
if BStatus = true then
begin
case MessageDlg(Format(SWarningText, [FPath]), mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
    idYes:
        Save1Click(Self);
    idCancel:
        CanClose := False;
end;

end;

end;

procedure TFZP1.SE1Change(Sender: TObject);
begin
    T2.Enabled := true;
if SE1.Lines.Count < 1 then
begin
    BStatus := false;
    SB1.Panels[1].Text:= DStatus;
end
else
begin
    BStatus := true;
    SB1.Panels[1].Text:= MStatus;
    Save1.Enabled := true;
    SaveAs1.Enabled := true;
end;

end;

procedure TFZP1.BC1Click(Sender: TObject);
begin
    P1.Visible:= not P1.Visible;
end;

procedure TFZP1.SE1Click(Sender: TObject);
begin
    SE1.LineHighlightColor.BackGround := $ffff00;
    Se1.SetFocus;
end;

procedure TFZP1.Search1Click(Sender: TObject);
begin
    P1.Visible:= not P1.Visible;
    ES1.Text := 'Type Here To Search...';
end;

procedure TFZP1.T1Timer(Sender: TObject);
begin
    CaretPos;
end;

procedure TFZP1.TB1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
  );
begin
    B1.Font.Color := $000000;
end;

procedure TFZP1.T2Timer(Sender: TObject);
begin
    ArAni := ArAni + 1;
if ArAni = 8 then
    ArAni := 0;
    CMark.Line := SE1.CaretY;
    CMark.ImageIndex := ArAni;

end;

procedure TFZP1.Undo1Click(Sender: TObject);
begin
    SE1.Undo;
end;

end.

