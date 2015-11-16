unit Main;

interface

{$I Definitions.inc}

uses
  // WinAPI:
  Windows, Messages, ShellAPI, PsAPI,

  // Delphi RTL:
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Math.Vectors, System.Math,

  // FireMonkey:
  FMX.Platform.Win, FMX.Types    , FMX.Controls, FMX.Forms   , FMX.Graphics, FMX.Dialogs,
  FMX.TabControl  , FMX.Layouts  , FMX.StdCtrls, FMX.Objects , FMX.Controls.Presentation,
  FMX.Effects     , FMX.Edit     , FMX.Menus   , FMX.Ani     , FMX.Filter.Effects, FMX.Viewport3D,
  FMX.Controls3D  , FMX.Objects3D, FMX.Types3D , FMX.ExtCtrls, FMX.Layers3D, FMX.MaterialSources,

  // HoShiMin's API:
  FileAPI, FormatPE, PowerUP, RegistryUtils,

  // LauncherAPI:
  LauncherAPI, Authorization, Registration, FilesValidation, ServerQuery,
  MinecraftLauncher, SkinSystem, JNIWrapper, AuxUtils,

  // AUX Modules:
  LauncherSettings, PopupManager, ServerPanel, StackCapacitor;

type
  TMainForm = class(TForm)
    MainTabControl: TTabControl;
    AuthTab: TTabItem;
    GameTab: TTabItem;
    SettingsTab: TTabItem;
    HeaderImage: TImage;
    CloseImage: TImage;
    SettingsImage: TImage;
    HideImage: TImage;
    StyleBook: TStyleBook;
    BigLogoImage: TImage;
    SmallLogoImage: TImage;
    ScrollBox: TVertScrollBox;
    DeauthLabel: TLabel;
    MainFormLayout: TLayout;
    FormShadowEffect: TShadowEffect;
    PlayButton: TButton;
    AuthButton: TButton;
    LoginEdit: TEdit;
    PasswordEdit: TEdit;
    HeaderLayout: TLayout;
    SkinPanel: TPanel;
    ServerPanelContainerSample: TPanel;
    ServerPreviewSample: TImage;
    ServerNameSample: TLabel;
    ServerInfoSample: TLabel;
    ServerProgressBarSample: TProgressBar;
    PreviewShadowSample: TShadowEffect;
    MonitoringLampSample: TCircle;
    LampGlowSample: TGlowEffect;
    MonitoringInfoSample: TLabel;
    CloseImageGlowEffect: TGlowEffect;
    HideImageGlowEffect: TGlowEffect;
    SettingsImageGlowEffect: TGlowEffect;
    ServersPopupMenu: TPopupMenu;
    OpenFolderItem: TMenuItem;
    UpdateClientItem: TMenuItem;
    Viewport3D: TViewport3D;
    StopButtonSample: TRectangle;
    PauseButtonSample: TPath;
    PauseButtonGlowSample: TGlowEffect;
    StopButtonGlowSample: TGlowEffect;
    DeleteClientItem: TMenuItem;
    HeadContainer: TDummy;
    HeadFront: TPlane;
    HeadLeft: TPlane;
    HeadRight: TPlane;
    HeadBack: TPlane;
    HeadBottom: TPlane;
    HeadTop: TPlane;
    ModelContainer: TDummy;
    TorsoContainer: TDummy;
    TorsoFront: TPlane;
    TorsoBack: TPlane;
    TorsoLeft: TPlane;
    TorsoRight: TPlane;
    TorsoTop: TPlane;
    TorsoBottom: TPlane;
    HelmetContainer: TDummy;
    HelmetFront: TPlane;
    HelmetBack: TPlane;
    HelmetLeft: TPlane;
    HelmetRight: TPlane;
    HelmetTop: TPlane;
    HelmetBottom: TPlane;
    RightLegContainer: TDummy;
    RightLegFront: TPlane;
    RightLegBack: TPlane;
    RightLegLeft: TPlane;
    RightLegRight: TPlane;
    RightLegTop: TPlane;
    RightLegBottom: TPlane;
    RightArmContainer: TDummy;
    RightArmFront: TPlane;
    RightArmBack: TPlane;
    RightArmLeft: TPlane;
    RightArmRight: TPlane;
    RightArmTop: TPlane;
    RightArmBottom: TPlane;
    LeftLegContainer: TDummy;
    LeftLegFront: TPlane;
    LeftLegBack: TPlane;
    LeftLegLeft: TPlane;
    LeftLegRight: TPlane;
    LeftLegTop: TPlane;
    LeftLegBottom: TPlane;
    LeftArmContainer: TDummy;
    LeftArmFront: TPlane;
    LeftArmBack: TPlane;
    LeftArmLeft: TPlane;
    LeftArmRight: TPlane;
    LeftArmTop: TPlane;
    LeftArmBottom: TPlane;
    Camera: TCamera;
    CloakContainer: TDummy;
    CloakFront: TPlane;
    CloakBack: TPlane;
    CloakLeft: TPlane;
    CloakRight: TPlane;
    CloakTop: TPlane;
    CloakBottom: TPlane;
    SkinPopupMenu: TPopupMenu;
    SkinItem: TMenuItem;
    CloakItem: TMenuItem;
    DrawHelmetItem: TMenuItem;
    SetupSkinItem: TMenuItem;
    DeletSkinItem: TMenuItem;
    DownloadSkinItem: TMenuItem;
    SetupCloakItem: TMenuItem;
    DeleteCloakItem: TMenuItem;
    DownloadCloakItem: TMenuItem;
    DrawCloakItem: TMenuItem;
    DrawWireframeItem: TMenuItem;
    Label1: TLabel;
    JVMPathEdit: TEdit;
    RAMEdit: TEdit;
    Label2: TLabel;
    JavaVersionEdit: TEdit;
    Label3: TLabel;
    BackButton: TButton;
    DeauthLabelHoverAnimation: TColorAnimation;
    PlotGrid: TPlotGrid;
    HardwareMonitoring: TTimer;
    CPUPath: TPath;
    CPUGlowEffect: TGlowEffect;
    Label4: TLabel;
    CPULoadingLabel: TLabel;
    Label5: TLabel;
    FreeRAMLabel: TLabel;
    Label7: TLabel;
    CPUFrequencyLabel: TLabel;
    Label9: TLabel;
    CPUFrequencyGlowEffect: TGlowEffect;
    CPUFrequencyColorAnimation: TColorAnimation;
    CPUFrequencyGlowAnimation: TFloatAnimation;
    RAMPath: TPath;
    RAMGlowEffect: TGlowEffect;
    CameraRotator: TFloatAnimation;
    RegLabel: TLabel;
    AutoLoginCheckbox: TCheckBox;

    procedure ShowErrorMessage(Text: string);
    procedure ShowSuccessMessage(Text: string);
    procedure ShowNullErrorMessage(Text: string);
    procedure ShowNullSuccessMessage(Text: string);

    procedure CloseImageClick(Sender: TObject);
    procedure HideImageClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);

    procedure DrawSkin(const Bitmap: FMX.Graphics.TBitmap);
    procedure DrawCloak(const Bitmap: FMX.Graphics.TBitmap);

    procedure CreateMaterialSources;
    procedure DestroyMaterialSources;

    procedure OnPlaneRender(Sender: TObject; Context: TContext3D);
    procedure Viewport3DMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure Viewport3DMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure SkinPopupMenuPopup(Sender: TObject);
    procedure HeaderImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);

    procedure DrawHelmetItemClick(Sender: TObject);
    procedure DrawCloakItemClick(Sender: TObject);
    procedure DrawWireframeItemClick(Sender: TObject);

    procedure BackButtonClick(Sender: TObject);
    procedure SettingsImageClick(Sender: TObject);
    procedure DeauthLabelClick(Sender: TObject);
    procedure AuthButtonClick(Sender: TObject);
    procedure OpenFolderItemClick(Sender: TObject);
    procedure UpdateClientItemClick(Sender: TObject);
    procedure DeleteClientItemClick(Sender: TObject);
    procedure OnDownload(ClientNumber: Integer; const DownloadInfo: TMultiLoaderDownloadInfo);
    procedure DeletSkinItemClick(Sender: TObject);
    procedure DownloadSkinItemClick(Sender: TObject);
    procedure SetupSkinItemClick(Sender: TObject);
    procedure DeleteCloakItemClick(Sender: TObject);
    procedure DownloadCloakItemClick(Sender: TObject);
    procedure SetupCloakItemClick(Sender: TObject);
    procedure PlayButtonClick(Sender: TObject);
    procedure ServersPopupMenuPopup(Sender: TObject);
    procedure HardwareMonitoringTimer(Sender: TObject);
    procedure PlotGridPaint(Sender: TObject; Canvas: TCanvas;
      const [Ref] ARect: TRectF);
    procedure Viewport3DMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Viewport3DMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure RegLabelClick(Sender: TObject);
  private type
    TABS = (
      AUTH_TAB,
      GAME_TAB,
      SETTINGS_TAB
    );
  private const
    StacksCapacity: Integer = 300;
    SparsingCoeff: Integer = 5;
  private
    FLastFrequency : ULONG;
    FIsAutoLogin   : Boolean;
    FIsRegPanel    : Boolean;
    FIsPopup       : Boolean;
    FIsDrag        : Boolean;
    FDrawWireframe : Boolean;
    FLastPoint     : TPointF;
    FSparsingCounter: Integer;
    FServerPanels  : array of TServerPanel;
    FSelectedClientNumber       : Integer;
    FSelectedToPlayClientNumber : Integer;
    FCPUStack, FRAMStack: TStackCapacitor<Single>;
    FLastCPUTimes: TThread.TSystemTimes;
    function ShowOpenDialog(out SelectedPath: string; const Mask: string = ''): Boolean;
    function ShowSaveDialog(out SelectedPath: string; const Mask: string = ''; const InitialFileName: string = ''): Boolean;
    procedure SwitchTab(DesiredTab: TABS);
    procedure SelectClient(ClientNumber: Integer; SelectToPlay: Boolean = False);
    procedure SetAuthTabActiveState(State: Boolean);
    procedure OnSuccessfulAuth;
    {$IFDEF USE_MONITORING}
      procedure OnMonitoring(ServerNumber: Integer; const MonitoringInfo: TMonitoringInfo);
    {$ENDIF}
    procedure CheckSkinSystemErrors(Status: SKIN_SYSTEM_STATUS; ImageType: IMAGE_TYPE; const ErrorReason: string);
    procedure ValidateClient(ClientNumber: Integer; PlayAfterValidation: Boolean);
    procedure AttemptToLaunchClient;
    procedure LaunchClient(ClientNumber: Integer);
    procedure SaveSettings(AutoLogin, ExternalJava: Boolean);
    procedure LoadSettings;
  end;

var
  MainForm: TMainForm;
  LauncherAPI: TLauncherAPI;

implementation

{$R *.fmx}

procedure TMainForm.PlotGridPaint(Sender: TObject; Canvas: TCanvas;
  const [Ref] ARect: TRectF);
  function GetOffset(const Height, Percentage: Single): Single; inline;
  begin
    Result := (Height * (100 - Percentage)) / 100;
  end;
var
  Offset, Height: Single;
  I: Integer;
begin
  Offset := PlotGrid.Width / (StacksCapacity - 1);
  Height := PlotGrid.Height;

  CPUPath.Data.Clear;
  RAMPath.Data.Clear;

  CPUPath.Data.MoveTo(TPointF.Create(-1, Height));
  RAMPath.Data.MoveTo(TPointF.Create(-1, Height));

  for I := 0 to StacksCapacity - 1 do
  begin
    CPUPath.Data.LineTo(TPointF.Create(I * Offset, GetOffset(Height, FCPUStack.Items[I])));
    RAMPath.Data.LineTo(TPointF.Create(I * Offset, GetOffset(Height, FRAMStack.Items[I])));
  end;

  CPUPath.Data.LineTo(TPointF.Create((StacksCapacity - 1) * Offset, Height));
  CPUPath.Data.LineTo(TPointF.Create(0, Height));
  CPUPath.Data.LineTo(TPointF.Create(0, GetOffset(Height, FCPUStack.Items[0])));
  CPUPath.Data.LineTo(TPointF.Create(0, GetOffset(Height, FCPUStack.Items[0])));

  RAMPath.Data.LineTo(TPointF.Create((StacksCapacity - 1) * Offset, Height));
  RAMPath.Data.LineTo(TPointF.Create(0, Height));
  RAMPath.Data.LineTo(TPointF.Create(0, GetOffset(Height, FCPUStack.Items[0])));
  RAMPath.Data.LineTo(TPointF.Create(0, GetOffset(Height, FCPUStack.Items[0])));

  CPUPath.Data.ClosePath;
  RAMPath.Data.ClosePath;

  CPUPath.BringToFront;
  RAMPath.SendToBack;

  CPUGlowEffect.UpdateParentEffects;
  RAMGlowEffect.UpdateParentEffects;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.HardwareMonitoringTimer(Sender: TObject);
  function GetFreqString(Freq: ULONGLONG): string; inline;
  var
    MHz: Single;
  begin
    MHz := Freq;
    if MHz >= 1024 then
      Result := FormatFloat('0.0', MHz / 1024) + ' ���'
    else
      Result := FormatFloat('0.0', MHz) + ' ���';
  end;

  function GetMemString(Memory: ULONGLONG): string; inline;
  var
    MB: Single;
  begin
    MB := Memory / 1048576;
    if MB > 1024 then
      Result := FormatFloat('0.0', MB / 1024) + ' ��'
    else
      Result := FormatFloat('0.0', MB) + ' ��';
  end;
var
  CurrentCPUTimes: TThread.TSystemTimes;
  CPUUsage: Integer;
  CurrentFrequency: ULONG;
  MemoryStatusEx: _MEMORYSTATUSEX;
begin
  if FSparsingCounter = SparsingCoeff then
  begin
    // ������������� ��:
    TThread.GetSystemTimes(CurrentCPUTimes);
    CPUUsage := TThread.GetCPUUsage(FLastCPUTimes);
    FCPUStack.Add(CPUUsage);
    FLastCPUTimes := CurrentCPUTimes;
    CPULoadingLabel.Text := IntToStr(CPUUsage) + '%';
    case CPUUsage of
      0..55   : CPULoadingLabel.FontColor := $FFFFFFFF;
      56..75  : CPULoadingLabel.FontColor := $FFDFA402;
      76..100 : CPULoadingLabel.FontColor := $FFFF0000;
    end;

    // ������� ��:
    CPUFrequencyLabel.BeginUpdate;
    CurrentFrequency := GetCPUFrequency;
    CPUFrequencyLabel.Text := GetFreqString(CurrentFrequency);
    if CurrentFrequency > FLastFrequency then
    begin
      CPUFrequencyGlowEffect.GlowColor      := $FF12FF00;
      CPUFrequencyColorAnimation.StartValue := $FF12FF00;
      CPUFrequencyColorAnimation.StopValue  := $FFFFFFFF;
      CPUFrequencyColorAnimation.Start;
      CPUFrequencyGlowAnimation.Start;
    end
    else if CurrentFrequency < FLastFrequency then
    begin
      CPUFrequencyGlowEffect.GlowColor      := $FFFF0000;
      CPUFrequencyColorAnimation.StartValue := $FFFF0000;
      CPUFrequencyColorAnimation.StopValue  := $FFFFFFFF;
      CPUFrequencyColorAnimation.Start;
      CPUFrequencyGlowAnimation.Start;
    end;
    FLastFrequency := CurrentFrequency;
    CPUFrequencyLabel.EndUpdate;

    MemoryStatusEx.dwLength := SizeOf(MemoryStatusEx);
    GlobalMemoryStatusEx(MemoryStatusEx);
    FreeRAMLabel.Text := GetMemString(MemoryStatusEx.ullAvailPhys);
    FRAMStack.Add(MemoryStatusEx.dwMemoryLoad);
    case MemoryStatusEx.dwMemoryLoad of
      0..55   : CPULoadingLabel.FontColor := $FFFFFFFF;
      56..75  : CPULoadingLabel.FontColor := $FFDFA402;
      76..100 : CPULoadingLabel.FontColor := $FFFF0000;
    end;

    FSparsingCounter := 0;
  end
  else
  begin
    FCPUStack.Add(FCPUStack.Items[StacksCapacity - 1]);
    FRAMStack.Add(FRAMStack.Items[StacksCapacity - 1]);
    Inc(FSparsingCounter);
  end;

  PlotGrid.Repaint;
end;




//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
//                        ��������������� �������
//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

function GetFmxWND(const WindowHandle: TWindowHandle): THandle; inline;
begin
  Result := WindowHandleToPlatform(WindowHandle).Wnd
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.ShowNullErrorMessage(Text: string);
begin
  MessageBox(0, PChar(Text), '������!', MB_ICONERROR);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.ShowNullSuccessMessage(Text: string);
begin
  MessageBox(0, PChar(Text), '�������!', MB_ICONASTERISK);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.ShowErrorMessage(Text: string);
begin
  MessageBox(GetFmxWND(Handle), PChar(Text), '������!', MB_ICONERROR);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.ShowSuccessMessage(Text: string);
begin
  MessageBox(GetFmxWND(Handle), PChar(Text), '�������!', MB_ICONASTERISK);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function TMainForm.ShowOpenDialog(out SelectedPath: string; const Mask: string = ''): Boolean;
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(MainForm);
  OpenDialog.Filter := Mask;
  Result := OpenDialog.Execute;
  if Result then SelectedPath := OpenDialog.FileName;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function TMainForm.ShowSaveDialog(out SelectedPath: string; const Mask: string = ''; const InitialFileName: string = ''): Boolean;
var
  SaveDialog: TOpenDialog;
begin
  SaveDialog := TOpenDialog.Create(MainForm);
  SaveDialog.Filter := Mask;
  SaveDialog.FileName := InitialFileName;
  Result := SaveDialog.Execute;
  if Result then SelectedPath := SaveDialog.FileName;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.SelectClient(ClientNumber: Integer; SelectToPlay: Boolean = False);
var
  I: Integer;
begin
  if (ClientNumber < 0) or (LauncherAPI.Clients.Count = 0) or (ClientNumber >= LauncherAPI.Clients.Count) then Exit;

  FSelectedClientNumber := ClientNumber;
  if SelectToPlay then FSelectedToPlayClientNumber := ClientNumber;

  ScrollBox.BeginUpdate;
  for I := 0 to LauncherAPI.Clients.Count - 1 do
  begin
    if I <> ClientNumber then
    begin
      if SelectToPlay then
        FServerPanels[I].SetDisabledView
      else
        FServerPanels[I].SetNormalView;
    end
    else
    begin
      FServerPanels[I].SetSelectedView;
    end;
  end;
  ScrollBox.EndUpdate;
  ScrollBox.Repaint;
end;




//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
//                          ���������� ��������
//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

procedure TMainForm.SaveSettings(AutoLogin, ExternalJava: Boolean);
begin
  SaveStringToRegistry(RegistryPath, 'Login'   , LoginEdit.Text);

  if AutoLogin then
    SaveStringToRegistry(RegistryPath, 'Password', PasswordEdit.Text)
  else
    SaveStringToRegistry(RegistryPath, 'Password', '');

  if ExternalJava then
  begin
    {$IFDEF CPUX64}
      SaveStringToRegistry(RegistryPath, 'JavaVersion64', JavaVersionEdit.Text);
      SaveStringToRegistry(RegistryPath, 'JVMPath64'    , JVMPathEdit.Text);
    {$ELSE}
      SaveStringToRegistry(RegistryPath, 'JavaVersion32', JavaVersionEdit.Text);
      SaveStringToRegistry(RegistryPath, 'JVMPath32'    , JVMPathEdit.Text);
    {$ENDIF}
  end;
  SaveStringToRegistry(RegistryPath, {$IFDEF CPUX64}'RAM64'{$ELSE}'RAM32'{$ENDIF}, RAMEdit.Text);
  SaveBooleanToRegistry(RegistryPath, 'AutoLogin', AutoLogin);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.LoadSettings;
  function GetJavaLowVersion(const FullVersion: string): string; inline;
  var
    DelimiterPos, FullVersionLength: Integer;
  begin
    FullVersionLength := Length(FullVersion);
    if FullVersionLength = 0 then Exit('');

    DelimiterPos := Pos('.', FullVersion);
    if DelimiterPos = 0 then Exit(FullVersion);

    Result := Copy(FullVersion, DelimiterPos + 1, FullVersionLength - DelimiterPos);
  end;
var
  JavaHome, LibPath, JavaVersion: string;
begin
  GetCurrentJavaInfo(JavaHome, LibPath, JavaVersion);
  JavaVersion := GetJavaLowVersion(JavaVersion);

  LoginEdit.Text    := ReadStringFromRegistry(RegistryPath, 'Login'   , LoginEdit.Text);
  PasswordEdit.Text := ReadStringFromRegistry(RegistryPath, 'Password', '');
  {$IFDEF CPUX64}
    RAMEdit.Text         := ReadStringFromRegistry(RegistryPath, 'RAM64'        , RAMEdit.Text);
    JavaVersionEdit.Text := ReadStringFromRegistry(RegistryPath, 'JavaVersion64', JavaVersion);
    JVMPathEdit.Text     := ReadStringFromRegistry(RegistryPath, 'JVMPath64'    , LibPath);
  {$ELSE}
    RAMEdit.Text         := ReadStringFromRegistry(RegistryPath, 'RAM32'        , RAMEdit.Text);
    JavaVersionEdit.Text := ReadStringFromRegistry(RegistryPath, 'JavaVersion32', JavaVersion);
    JVMPathEdit.Text     := ReadStringFromRegistry(RegistryPath, 'JVMPath32'    , LibPath);
  {$ENDIF}
  FIsAutoLogin := ReadBooleanFromRegistry(RegistryPath, 'AutoLogin', False);
  AutoLoginCheckbox.IsChecked := FIsAutoLogin;
end;





//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
//                      ���������� ������ ���������
//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

procedure TMainForm.CloseImageClick(Sender: TObject);
begin
  ExitProcess(0);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.HideImageClick(Sender: TObject);
begin
  ShowWindow(GetFmxWND(MainForm.Handle), SW_MINIMIZE);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.HeaderImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
const
  SC_DRAGMOVE = $F012;
begin
  if ssLeft in Shift then
  begin
    FIsDrag := True;
    MainForm.BeginUpdate;
    ReleaseCapture;
    SendMessage(GetFmxWND(Self.Handle), WM_SYSCOMMAND, SC_DRAGMOVE, 0);
    MainForm.EndUpdate;
    FIsDrag := False;
  end;
end;


//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
//                  ��������� ��������� ����� ���������
//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

procedure TMainForm.SwitchTab(DesiredTab: TABS);
var
  TabIndex: Byte;
begin
  TabIndex := Byte(DesiredTab);
  MainTabControl.BeginUpdate;
  MainTabControl.TabIndex := TabIndex;
  MainTabControl.UpdateEffects;
  MainTabControl.EndUpdate;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.DeauthLabelClick(Sender: TObject);
var
  I, ServerPanelsCount: Integer;
begin
  // ��������� ���������:
  FIsAutoLogin := False;
  AutoLoginCheckbox.IsChecked := FIsAutoLogin;
  SaveSettings(FIsAutoLogin, LauncherAPI.JavaInfo.ExternalJava);

  MainFormLayout.BeginUpdate;

  DestroyMaterialSources;
  LauncherAPI.Deauthorize;

  // ������ ������ ������� ��������:
  ServerPanelsCount := Length(FServerPanels);
  if ServerPanelsCount > 0 then for I := 0 to ServerPanelsCount - 1 do
  begin
    FreeAndNil(FServerPanels[I]);
  end;
  SetLength(FServerPanels, 0);

  // ���������� ������ �������� ������� - ��� ����������� ��������� �� ����� ��� �������:
  ServerPanelContainerSample.Visible := True;

  PlayButton.Enabled := True;
  DeauthLabel.Visible := False;
  SwitchTab(AUTH_TAB);

  MainFormLayout.EndUpdate;
  MainFormLayout.Repaint;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.SettingsImageClick(Sender: TObject);
begin
  if not LauncherAPI.IsAuthorized then
  begin
    ShowErrorMessage('������������� ��� ������� � ����������!');
    Exit;
  end;

  case MainTabControl.TabIndex of
    Byte(GAME_TAB)     : SwitchTab(SETTINGS_TAB);
    Byte(SETTINGS_TAB) : SwitchTab(GAME_TAB);
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.BackButtonClick(Sender: TObject);
begin
  SwitchTab(GAME_TAB);
end;




//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // ��������� ��������� ����������:
  FCPUStack := TStackCapacitor<Single>.Create(StacksCapacity, 0);
  FRAMStack := TStackCapacitor<Single>.Create(StacksCapacity, 0);
  TThread.GetSystemTimes(FLastCPUTimes);
  HardwareMonitoring.Enabled := True;

  // ������� ���������:
  FormatSettings.DecimalSeparator := '.';
  DeauthLabel.Visible := False;
  FIsRegPanel := False;
  SwitchTab(AUTH_TAB);

  // ����������� ������:
{
  // ���� ������ ��� ���������� ModelContainer:
  Camera.RotationCenter.X := ModelContainer.Position.X;
  Camera.RotationCenter.Y := ModelContainer.Position.Y;
  Camera.RotationCenter.Z := ModelContainer.Position.Z - Camera.Position.Z;
}
{
  // ���� ������ ������ ���������� ModelContainer:
  Camera.RotationCenter.X := - Camera.Position.X;
  Camera.RotationCenter.Y := - Camera.Position.Y;
  Camera.RotationCenter.Z := - Camera.Position.Z;
}
  // ������ ������ LauncherAPI:
  LauncherAPI := TLauncherAPI.Create(GetSpecialFolderPath(CSIDL_APPDATA) + '\' + LocalWorkingFolder, ServerWorkingFolder);
  LauncherAPI.EncryptionKey := EncryptionKey;
  LauncherAPI.LauncherInfo.LauncherVersion := LauncherVersion;

  // ��������� ���������:
  LoadSettings;
  if FIsAutoLogin then
    AuthButton.OnClick(Self);
end;


//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
//                         �����������/�����������
//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

procedure TMainForm.SetAuthTabActiveState(State: Boolean);
begin
  MainTabControl.Tabs[Byte(AUTH_TAB)].BeginUpdate;
  LoginEdit.Enabled         := State;
  PasswordEdit.Enabled      := State;
  AuthButton.Enabled        := State;
  AutoLoginCheckbox.Enabled := State;
  RegLabel.Enabled          := State;
  MainTabControl.Tabs[Byte(AUTH_TAB)].EndUpdate;
  MainTabControl.Tabs[Byte(AUTH_TAB)].Repaint;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.RegLabelClick(Sender: TObject);
begin
  FIsRegPanel := not FIsRegPanel;
  if FIsRegPanel then
  begin
    AuthButton.Text := '������������������';
    RegLabel.Text   := '�����������';
  end
  else
  begin
    AuthButton.Text := '��������������';
    RegLabel.Text   := '�����������';
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.AuthButtonClick(Sender: TObject);
begin
  SetAuthTabActiveState(False);
  if not FIsRegPanel then
  begin
    LauncherAPI.Authorize(
                            LoginEdit.Text,
                            PasswordEdit.Text,
                            True,
                            procedure(const AuthStatus: AUTH_STATUS)
                            begin
                              SetAuthTabActiveState(True);
                              if AuthStatus.StatusCode = AUTH_STATUS_SUCCESS then
                              begin
                                OnSuccessfulAuth;
                                SwitchTab(GAME_TAB);
                              end
                              else
                              begin
                                ShowErrorMessage('[' + IntToStr(Integer(AuthStatus.StatusCode)) + '] ' + AuthStatus.StatusString);
                              end;
                            end
                           );
  end
  else
  begin
    LauncherAPI.RegisterPlayer(LoginEdit.Text, PasswordEdit.Text, True, procedure(const RegStatus: REG_STATUS)
    begin
      SetAuthTabActiveState(True);
      if RegStatus.StatusCode = REG_STATUS_SUCCESS then
      begin
        ShowSuccessMessage('�������� �����������!');
        RegLabel.OnClick(Self);
      end
      else
      begin
        ShowErrorMessage('[' + IntToStr(Integer(RegStatus.StatusCode)) + '] ' + RegStatus.StatusString);
      end;
    end);
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.OnSuccessfulAuth;
var
  ServerPanelSample: TServerPanel.TServerPanelSample;
  ServerPanel: TServerPanel;
  Client: TMinecraftLauncher;
  PopupBinder: TPopupMenuBinder;
  I: Integer;
begin
  // ��������� ���������:
  FIsAutoLogin := AutoLoginCheckbox.IsChecked;
  SaveSettings(FIsAutoLogin, LauncherAPI.JavaInfo.ExternalJava);

  // ��������� ������ ��������:
  if not LauncherAPI.LauncherInfo.IsLauncherValid(False) then
  begin
    if MessageBox(GetFmxWND(MainForm.Handle), '��������� ���������� ��������! �������� ������?', '��������!', MB_ICONQUESTION + MB_YESNO) = ID_YES then
    begin
      if not LauncherAPI.LauncherInfo.UpdateLauncher then
      begin
        ShowErrorMessage('�� ���������� �������� �������!');
        ExitProcess(0);
      end;
    end
    else
    begin
      ShowErrorMessage('�������� ������� ��� �����������!');
      ExitProcess(0);
    end;
  end;

  FSelectedClientNumber       := -1;
  FSelectedToPlayClientNumber := -1;

  MainFormLayout.BeginUpdate;

  DeauthLabel.Visible := True;

  // ������ ������ ������ � ������ ��������:
  ServerPanelSample.ServerPanel           := ServerPanelContainerSample;
  ServerPanelSample.NameLabel             := ServerNameSample;
  ServerPanelSample.InfoLabel             := ServerInfoSample;
  ServerPanelSample.ProgressBar           := ServerProgressBarSample;
  ServerPanelSample.PreviewImage          := ServerPreviewSample;
  ServerPanelSample.MonitoringLamp        := MonitoringLampSample;
  ServerPanelSample.MonitoringInfo        := MonitoringInfoSample;
  ServerPanelSample.PreviewShadowEffect   := PreviewShadowSample;
  ServerPanelSample.LampGlowEffect        := LampGlowSample;
  ServerPanelSample.PauseButton           := PauseButtonSample;
  ServerPanelSample.PauseButtonGlowEffect := PauseButtonGlowSample;
  ServerPanelSample.StopButton            := StopButtonSample;
  ServerPanelSample.StopButtonGlowEffect  := StopButtonGlowSample;

  {$IFNDEF USE_MONITORING}
    ServerPanelSample.MonitoringLamp.Visible := False; // ������ ��������� �������� �����������
  {$ENDIF}

  // ������ ������ ��������, ����������� �������:
  if LauncherAPI.Clients.Count > 0 then
  begin
    SetLength(FServerPanels, LauncherAPI.Clients.Count);
    for I := 0 to LauncherAPI.Clients.Count - 1 do
    begin
      Client := LauncherAPI.Clients.ClientsArray[I];

      // ������ �������� �������:
      FServerPanels[I] := TServerPanel.Create(ScrollBox, ServerPanelSample, I);
      ServerPanel := FServerPanels[I];
      ServerPanel.Content.NameLabel.Text := Client.ServerInfo.Name;
      ServerPanel.Content.InfoLabel.Text := Client.ServerInfo.Info;
      if Client.HasPreview then
        ServerPanel.Content.PreviewImage.Bitmap := Client.PreviewBitmap;

      ServerPanel.OnClick := procedure(const Sender: TServerPanel)
      begin
        SelectClient(Sender.Number);
      end;

      ServerPanel.OnDblClick := procedure(const Sender: TServerPanel)
      begin
        SelectClient(Sender.Number);
        AttemptToLaunchClient;
      end;

      ServerPanel.OnPauseClick := procedure(const Sender: TServerPanel)
      begin
        if Sender.ResumeState then
        begin
          LauncherAPI.Clients.ClientsArray[Sender.Number].MultiLoader.Resume;
          Sender.ShowPauseButton;
        end
        else
        begin
          LauncherAPI.Clients.ClientsArray[Sender.Number].MultiLoader.Pause;
          Sender.Content.ServerPanel.BeginUpdate;
          Sender.Content.InfoLabel.Text := '�������� ��������������';
          Sender.ShowResumeButton;
          Sender.Content.ServerPanel.EndUpdate;
          Sender.Content.ServerPanel.Repaint;
        end;
      end;

      ServerPanel.OnStopClick := procedure(const Sender: TServerPanel)
      begin
        LauncherAPI.Clients.ClientsArray[Sender.Number].MultiLoader.Cancel;
        Sender.Content.ServerPanel.BeginUpdate;
        Sender.Content.InfoLabel.Text := '��������� ��������...';
        Sender.ShowPauseButton;
        Sender.DisableDownloadButtons;
        Sender.Content.ServerPanel.EndUpdate;
        Sender.Content.ServerPanel.Repaint;
      end;

      // ������� � ������� ����������� ����:
      PopupBinder := TPopupMenuBinder.Create(ServersPopupMenu);
      PopupBinder.Bind(ServerPanel.Content.ServerPanel, I);
    end;

    // �������� ������ ������ � ������:
    SelectClient(0);
  end;

  // �������� ������ ������ ��������, �� ��� ������ �� �����:
  ServerPanelContainerSample.Visible := False;

  // ����������� ���� �������� ��������:
  ModelContainer.ResetRotationAngle;
  ModelContainer.RotationAngle.Y  := 25;
  CloakContainer.RotationCenter.Y := -3;
  CloakContainer.RotationAngle.X  := -7;

  // ������ ���� � ����:
  CreateMaterialSources;
  DrawSkin(LauncherAPI.UserInfo.SkinBitmap);
  DrawCloak(LauncherAPI.UserInfo.CloakBitmap);

  // ���������� ������ ��������:
  if not LauncherAPI.JavaInfo.ExternalJava then
  begin
    JVMPathEdit.Text     := LauncherAPI.LocalWorkingFolder + '\' + LauncherAPI.JavaInfo.JavaParameters.JavaFolder + '\' + LauncherAPI.JavaInfo.JavaParameters.JVMPath;
    JavaVersionEdit.Text := LauncherAPI.JavaInfo.JavaParameters.JavaVersion.ToString;
    JVMPathEdit.Enabled     := False;
    JavaVersionEdit.Enabled := False;
  end;

  MainFormLayout.EndUpdate;
  MainFormLayout.Repaint;

  // ��������� ����������:
  {$IFDEF USE_MONITORING}
    LauncherAPI.StartMonitoring(MonitoringInterval, OnMonitoring);
  {$ENDIF}
end;




//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
//                   ��������, ���������� � ������ �������
//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

procedure TMainForm.LaunchClient(ClientNumber: Integer);
var
  Status: JNI_RETURN_VALUES;
  JVMPath: string;
begin
  PlayButton.Enabled := True;

  // �������� ���� � �����:
  if LauncherAPI.JavaInfo.ExternalJava then
  begin
    JVMPath := JVMPathEdit.Text;
    LauncherAPI.JavaInfo.SetJVMPath(JVMPath, StrToInt(JavaVersionEdit.Text));
  end
  else
  begin
    JVMPath := LauncherAPI.LocalWorkingFolder + '\' +
               LauncherAPI.JavaInfo.JavaParameters.JavaFolder + '\' +
               LauncherAPI.JavaInfo.JavaParameters.JVMPath;
  end;

  // ���������, ��� ���� ������:
  if not FileExists(JVMPath) then
  begin
    ShowErrorMessage('���������� jvm.dll �� ������� �� ������������:' + #13#10 + JVMPath);
    Exit;
  end;

  // ����������, ��� ��������� ���� - ����������:
  if GetPEType(JVMPath) <> peDll then
  begin
    ShowErrorMessage('��������� � ���������� ���� - �� DLL!' + #13#10 + '������� ���������� ���� � jvm.dll!');
    Exit;
  end;

  // ����������, ��� ����������� ���������� ������������� ����������� ��������:
  if GetPEMachineType(JVMPath) <> {$IFDEF CPUX64}mt64Bit{$ELSE}mt32Bit{$ENDIF} then
  begin
    ShowErrorMessage('�������� ����������� jvm.dll!' + #13#10 + '����������� ���������� ������ ��������������� ����������� ��������!');
    Exit;
  end;

  // ����������, ��� jvm ��� ��� � ��������:
  if GetModuleHandle('jvm.dll') <> 0 then
  begin
    ShowErrorMessage('� ������� ��������� ����������� JVM!' + #13#10 + '����������� ����������!');
    Exit;
  end;

  // ��������� ���������:
  SaveSettings(FIsAutoLogin, LauncherAPI.JavaInfo.ExternalJava);

  HardwareMonitoring.Enabled := False; // ��������� ��������� ����������
  LauncherAPI.StopMonitoring; // ��������� ����������

  // �������� ����� ��������:
  ShowWindow(GetFmxWND(MainForm.Handle), SW_HIDE);
  ShowWindow(ApplicationHWND, SW_HIDE);

  {$IFDEF FLUSH_JVM_FLAGS}
    SetEnvironmentVariable('_JAVA_OPTIONS', '');
    SetEnvironmentVariable('JAVA_TOOL_OPTIONS', '');
  {$ENDIF}

  // ��������� ����:
  Status := LauncherAPI.LaunchClient(ClientNumber, StrToInt(RAMEdit.Text));
  case Status of
    JNIWRAPPER_UNKNOWN_ERROR       : ShowNullErrorMessage('����������� ������ � JVM!');
    JNIWRAPPER_JNI_INVALID_VERSION : ShowNullErrorMessage('�������� ������ JNI!');
    JNIWRAPPER_NOT_ENOUGH_MEMORY   : ShowNullErrorMessage('������������ ����������� ������ ��� ������� JVM!');
    JNIWRAPPER_JVM_ALREADY_EXISTS  : ShowNullErrorMessage('JVM ��� ����������! ������ ��������� ��� � ����� JVM � ����� ��������!');
    JNIWRAPPER_INVALID_ARGUMENTS   : ShowNullErrorMessage('�������� ��������� JVM!');
    JNIWRAPPER_CLASS_NOT_FOUND     : ShowNullErrorMessage('����� �� ������!');
    JNIWRAPPER_METHOD_NOT_FOUND    : ShowNullErrorMessage('����� �� ������!');
  else
    {$IFDEF INGAME_FILES_MONITORING}
      LauncherAPI.StartInGameChecking(ClientNumber, procedure(const ErrorFiles: TStringList)
      begin
        ErrorFiles.SaveToFile('ErrorFiles.txt');
        MessageBoxTimeout(
                           0,
                           PChar(
                                  '���������� ��������� ��������� ������!' + #13#10 +
                                  '������ ������ ������� � ErrorFiles.txt'
                                 ),
                           '���������� ��������� �������!',
                           MB_ICONERROR,
                           0,
                           5000
                          );
        ExitProcess(0);
      end);
    {$ENDIF}

    // ����������� �������, ��� ��� ������ �� �����������:
    DestroyComponents;
    DestroyHandle;
    Self.Destroy;
    EmptyWorkingSet(GetCurrentProcess);
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.ValidateClient(ClientNumber: Integer;
  PlayAfterValidation: Boolean);
begin
  if (ClientNumber < 0) or (LauncherAPI.Clients.Count = 0) or (ClientNumber > LauncherAPI.Clients.Count - 1) then
  begin
    ShowErrorMessage('�������� ��������� ������!');
    PlayButton.Enabled := True;
    Exit;
  end;

  if LauncherAPI.Clients.ClientsArray[ClientNumber].GetValidationStatus then
  begin
    if not PlayAfterValidation then ShowErrorMessage('������ ��� �����������! ��������� ���������� � ���������� �����!');
    Exit;
  end;

  FServerPanels[ClientNumber].Content.InfoLabel.Text := '�������� ������ ������...';
  LauncherAPI.GetValidFilesList(ClientNumber, procedure(ClientNumber: Integer; QueryStatus: QUERY_STATUS)
  begin
    if QueryStatus.StatusCode <> QUERY_STATUS_SUCCESS then
    begin
      ShowErrorMessage('[��� ������ ' + IntToStr(Integer(QueryStatus.StatusCode)) + '] ' + QueryStatus.StatusString);
      FServerPanels[ClientNumber].Content.InfoLabel.Text := LauncherAPI.Clients.ClientsArray[ClientNumber].ServerInfo.Info;
      PlayButton.Enabled := True;
      Exit;
    end;

    FServerPanels[ClientNumber].Content.InfoLabel.Text := '��������� �����...';
    LauncherAPI.ValidateClient(ClientNumber, True, procedure(ClientNumber: Integer; ClientValidationStatus, JavaValidationStatus: VALIDATION_STATUS)
    begin
      if (ClientValidationStatus = VALIDATION_STATUS_SUCCESS) and (JavaValidationStatus = VALIDATION_STATUS_SUCCESS) then
      begin
        FServerPanels[ClientNumber].Content.InfoLabel.Text := LauncherAPI.Clients.ClientsArray[ClientNumber].ServerInfo.Info;
        if PlayAfterValidation then LaunchClient(ClientNumber);
        Exit;
      end;

      if (ClientValidationStatus = VALIDATION_STATUS_DELETION_ERROR) or (JavaValidationStatus = VALIDATION_STATUS_DELETION_ERROR) then
      begin
        ShowErrorMessage(
                          '�� ���������� ������� ��������� �����:' + #13#10 +
                          LauncherAPI.Clients.ClientsArray[ClientNumber].FilesValidator.ErrorFiles.Text + #13#10 +
                          LauncherAPI.JavaInfo.FilesValidator.ErrorFiles.Text
                         );
        FServerPanels[ClientNumber].Content.InfoLabel.Text := LauncherAPI.Clients.ClientsArray[ClientNumber].ServerInfo.Info;
        PlayButton.Enabled := True;
        Exit;
      end;

      if (ClientValidationStatus = VALIDATION_STATUS_NEED_UPDATE) or (JavaValidationStatus = VALIDATION_STATUS_NEED_UPDATE) then
      begin
        FServerPanels[ClientNumber].Content.InfoLabel.Text := '�������� ��������...';
        FServerPanels[ClientNumber].ShowDownloadPanel;
        LauncherAPI.UpdateClient(ClientNumber, {$IFDEF SINGLE_THREAD_DOWNLOADING}False{$ELSE}True{$ENDIF}, OnDownload);
      end;
    end);
  end);
end;




//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
//                             ������ ����
//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

procedure TMainForm.AttemptToLaunchClient;
var
  I: Integer;
begin
  // ��������� ���������� ������ �������:
  if (LauncherAPI.Clients.Count = 0) or (FSelectedClientNumber < 0) or (FSelectedClientNumber >= LauncherAPI.Clients.Count) then
  begin
    ShowErrorMessage('������ �� ������!');
    Exit;
  end;

  if Length(JavaVersionEdit.Text) = 0 then
  begin
    ShowErrorMessage('������� ���������� ������ Java!');
    Exit;
  end;

  if Length(RAMEdit.Text) = 0 then
  begin
    ShowErrorMessage('������� ���������� �������� RAM!');
    Exit;
  end;

  // ������ ��� ��������, ����� ���������, �����������:
  ScrollBox.BeginUpdate;
  FSelectedToPlayClientNumber := FSelectedClientNumber;
  for I := 0 to LauncherAPI.Clients.Count - 1 do
  begin
    if I <> FSelectedToPlayClientNumber then
    begin
      FServerPanels[I].SetDisabledView;
      LauncherAPI.Clients.ClientsArray[I].MultiLoader.Cancel; // ������������� ��� ��������
    end;
  end;
  FServerPanels[FSelectedToPlayClientNumber].SetSelectedView;
  ScrollBox.EndUpdate;
  ScrollBox.Repaint;

  PlayButton.Enabled := False;

  // ��������� �������� �������:
  ValidateClient(FSelectedClientNumber, True);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.PlayButtonClick(Sender: TObject);
begin
  AttemptToLaunchClient;
end;



//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
//                        ��������� ������� �������
//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

{$IFDEF USE_MONITORING}
procedure TMainForm.OnMonitoring(ServerNumber: Integer;
  const MonitoringInfo: TMonitoringInfo);
var
  ServerPanel: TServerPanel;
begin
  ServerPanel := FServerPanels[ServerNumber];
  if MonitoringInfo.IsActive then
  begin
    ServerPanel.Content.MonitoringInfo.Text := '(' + MonitoringInfo.CurrentPlayers + '/' + MonitoringInfo.MaxPlayers + ')';
    {$IFDEF FLASHING_LAMP}ServerPanel.BlinkGood;{$ELSE}ServerPanel.SetGoodLight;{$ENDIF}
  end
  else
  begin
    ServerPanel.Content.MonitoringInfo.Text := '';
    {$IFDEF FLASHING_LAMP}ServerPanel.BlinkBad;{$ELSE}ServerPanel.SetBadLight;{$ENDIF}
  end;
end;
{$ENDIF}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.OnDownload(ClientNumber: Integer;
  const DownloadInfo: TMultiLoaderDownloadInfo);

  function GetSizeString(BytesCount: Integer): string; inline;
  var
    Kilobytes: Integer;
  begin
    Kilobytes := BytesCount div 1024;
    if Kilobytes > 1024 then Result := FormatFloat('0.0', Kilobytes / 1024) + ' ��' else Result := IntToStr(Kilobytes) + ' ��';
  end;

  function GetSpeedString(const BytesPerSec: Single): string; inline;
  var
    KbPerSec: Single;
  begin
    KbPerSec := BytesPerSec / 1024;
    if KbPerSec > 1024 then Result := FormatFloat('0.0', KbPerSec / 1024) + ' ��/�.' else Result := FormatFloat('0.0', KbPerSec) + ' ��/�.';
  end;

var
  ServerPanel: TServerPanel;
  Time: Single;
  SpeedStr, TimeStr: string;
begin
  if FIsDrag then Exit;

  ServerPanel := FServerPanels[ClientNumber];

  if DownloadInfo.SummaryDownloadInfo.IsFinished then
  begin
    ServerPanel.Content.ServerPanel.BeginUpdate;
    ServerPanel.HideDownloadPanel;
    ServerPanel.EnableDownloadButtons;
    ServerPanel.Content.ProgressBar.Value := 0;
    ServerPanel.Content.NameLabel.Text := LauncherAPI.Clients.ClientsArray[ClientNumber].ServerInfo.Name;
    ServerPanel.Content.InfoLabel.Text := LauncherAPI.Clients.ClientsArray[ClientNumber].ServerInfo.Info;
    ServerPanel.Content.ServerPanel.EndUpdate;
    ServerPanel.Content.ServerPanel.Repaint;

    if not DownloadInfo.SummaryDownloadInfo.IsCancelled then
      ValidateClient(ClientNumber, ClientNumber = FSelectedToPlayClientNumber)
    else if ClientNumber = FSelectedToPlayClientNumber then
      PlayButton.Enabled := True;
  end
  else
  begin
    if not DownloadInfo.SummaryDownloadInfo.IsCancelled and not DownloadInfo.SummaryDownloadInfo.IsPaused then
    begin
      Time := DownloadInfo.SummaryDownloadInfo.RemainingTime;
      SpeedStr := GetSpeedString(DownloadInfo.SummaryDownloadInfo.Speed);

      TimeStr := FormatFloat('0.0', Time) + ' ���.';

      ServerPanel.Content.ServerPanel.BeginUpdate;
      ServerPanel.Content.ProgressBar.Value := 100 * DownloadInfo.SummaryDownloadInfo.Downloaded / DownloadInfo.SummaryDownloadInfo.FullSize;
      ServerPanel.Content.NameLabel.Text := LauncherAPI.Clients.ClientsArray[ClientNumber].ServerInfo.Name + ' (' +
                                            DownloadInfo.SummaryDownloadInfo.FilesDownloaded.ToString + '/' +
                                            DownloadInfo.SummaryDownloadInfo.FilesCount.ToString + ')';
      ServerPanel.Content.InfoLabel.Text := SpeedStr + ', ' + TimeStr;
      ServerPanel.Content.ServerPanel.EndUpdate;
    end;
  end;
end;




//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
//                ��������� ������������ ���� ������ ��������
//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

procedure TMainForm.ServersPopupMenuPopup(Sender: TObject);
begin
  SelectClient(TControl(Sender).Tag);
  FIsPopup := True;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.OpenFolderItemClick(Sender: TObject);
var
  Client: TMinecraftLauncher;
  Path: string;
begin
  Client := LauncherAPI.Clients.ClientsArray[TControl(Sender).Tag];
  Path := LauncherAPI.LocalWorkingFolder + '\' + Client.ServerInfo.ClientFolder;
  CreatePath(Path);
  ShellExecute(GetFmxWND(Handle), nil, PChar(Path), nil, nil, SW_SHOWNORMAL);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.UpdateClientItemClick(Sender: TObject);
begin
  ValidateClient(TControl(Sender).Tag, False);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.DeleteClientItemClick(Sender: TObject);
var
  Client: TMinecraftLauncher;
  Path: string;
begin
  Client := LauncherAPI.Clients.ClientsArray[TControl(Sender).Tag];
  Path := LauncherAPI.LocalWorkingFolder + '\' + Client.ServerInfo.ClientFolder;
  if MessageBox(GetFmxWND(Handle), '�� ������������� ������ ������� ��� ����� �� ����� � ��������?', '��������!', MB_ICONQUESTION + MB_YESNO) = ID_YES then
  begin
    DeleteDirectory(Path + '\*');
  end;
end;






//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
//                    ��������� ������������ ���� �����
//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

procedure TMainForm.SkinPopupMenuPopup(Sender: TObject);
begin
  FIsPopUp := True;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.DrawCloakItemClick(Sender: TObject);
begin
  CloakContainer.Visible := not CloakContainer.Visible;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.DrawHelmetItemClick(Sender: TObject);
begin
  HelmetContainer.Visible := not HelmetContainer.Visible;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.DrawWireframeItemClick(Sender: TObject);
begin
  FDrawWireframe := not FDrawWireframe;
  Viewport3D.Repaint;
end;




//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
//                      ���������/�������� ������ � ������
//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

procedure TMainForm.CheckSkinSystemErrors(Status: SKIN_SYSTEM_STATUS;
  ImageType: IMAGE_TYPE; const ErrorReason: string);
begin
  case Status of
    SKIN_SYSTEM_FILE_NOT_EXISTS:
      case ImageType of
        IMAGE_SKIN  : ShowErrorMessage('���� ��� �� ����������!');
        IMAGE_CLOAK : ShowErrorMessage('���� ��� �� ����������!');
      end;
    SKIN_SYSTEM_NOT_PNG                 : ShowErrorMessage('���� - �� PNG!');
    SKIN_SYSTEM_CONNECTION_ERROR        : ShowErrorMessage('�� ������� ������������ � �������!');
    SKIN_SYSTEM_UNKNOWN_ERROR           : ShowErrorMessage(ErrorReason);
    SKIN_SYSTEM_UNKNOWN_RESPONSE_FORMAT : ShowErrorMessage('����������� ������ ������!');
  end;
end;

//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

procedure TMainForm.SetupSkinItemClick(Sender: TObject);
var
  SkinPath: string;
  Status: SKIN_SYSTEM_STATUS;
begin
  if not ShowOpenDialog(SkinPath, '*.png|*.png') then Exit;

  Status := LauncherAPI.SetupSkin(LoginEdit.Text, PasswordEdit.Text, SkinPath);
  if Status <> SKIN_SYSTEM_SUCCESS then
  begin
    CheckSkinSystemErrors(Status, IMAGE_SKIN, LauncherAPI.SkinSystem.ErrorReason);
    Exit;
  end;

  LauncherAPI.UserInfo.SkinBitmap.LoadFromFile(SkinPath);
  DrawSkin(LauncherAPI.UserInfo.SkinBitmap);
  ShowSuccessMessage('���� ������� ����������!');
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.DownloadSkinItemClick(Sender: TObject);
var
  SkinPath: string;
  Status: SKIN_SYSTEM_STATUS;
begin
  if not ShowSaveDialog(SkinPath, '*.png|*.png', LoginEdit.Text + '.png') then Exit;

  Status := LauncherAPI.DownloadSkin(LoginEdit.Text, PasswordEdit.Text, SkinPath);
  if Status <> SKIN_SYSTEM_SUCCESS then
  begin
    CheckSkinSystemErrors(Status, IMAGE_SKIN, LauncherAPI.SkinSystem.ErrorReason);
    Exit;
  end;

  ShowSuccessMessage('���� ������� � �����: ' + SkinPath);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.DeletSkinItemClick(Sender: TObject);
var
  Status: SKIN_SYSTEM_STATUS;
begin
  Status := LauncherAPI.DeleteSkin(LoginEdit.Text, PasswordEdit.Text);

  if Status <> SKIN_SYSTEM_SUCCESS then
  begin
    CheckSkinSystemErrors(Status, IMAGE_SKIN, LauncherAPI.SkinSystem.ErrorReason);
    Exit;
  end;

  DrawSkin(LauncherAPI.UserInfo.SkinBitmap);
  ShowSuccessMessage('���� �����!');
end;

//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

procedure TMainForm.SetupCloakItemClick(Sender: TObject);
var
  CloakPath: string;
  Status: SKIN_SYSTEM_STATUS;
begin
  if not ShowOpenDialog(CloakPath) then Exit;

  Status := LauncherAPI.SetupCloak(LoginEdit.Text, PasswordEdit.Text, CloakPath);
  if Status <> SKIN_SYSTEM_SUCCESS then
  begin
    CheckSkinSystemErrors(Status, IMAGE_CLOAK, LauncherAPI.SkinSystem.ErrorReason);
    Exit;
  end;

  DrawCloak(LauncherAPI.UserInfo.CloakBitmap);
  ShowSuccessMessage('���� ������� ����������!');
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.DownloadCloakItemClick(Sender: TObject);
var
  CloakPath: string;
  Status: SKIN_SYSTEM_STATUS;
begin
  if not ShowSaveDialog(CloakPath, '*.png|*.png', LoginEdit.Text + '_cloak.png') then Exit;

  Status := LauncherAPI.DownloadCloak(LoginEdit.Text, PasswordEdit.Text, CloakPath);
  if Status <> SKIN_SYSTEM_SUCCESS then
  begin
    CheckSkinSystemErrors(Status, IMAGE_CLOAK, LauncherAPI.SkinSystem.ErrorReason);
    Exit;
  end;

  ShowSuccessMessage('���� ������� � �����: ' + CloakPath);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.DeleteCloakItemClick(Sender: TObject);
var
  Status: SKIN_SYSTEM_STATUS;
begin
  Status := LauncherAPI.DeleteCloak(LoginEdit.Text, PasswordEdit.Text);

  if Status <> SKIN_SYSTEM_SUCCESS then
  begin
    CheckSkinSystemErrors(Status, IMAGE_CLOAK, LauncherAPI.SkinSystem.ErrorReason);
    Exit;
  end;

  DrawCloak(LauncherAPI.UserInfo.CloakBitmap);
  ShowSuccessMessage('���� �����!');
end;




//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
//                                3D-�����
//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

procedure TMainForm.CreateMaterialSources;
var
  Component: TComponent;
  Plane: TPlane;
begin
  Viewport3D.BeginUpdate;
  for Component in MainForm do if Component is TPlane then
  begin
    Plane := TPlane(Component);
    Plane.MaterialSource := TTextureMaterialSource.Create(ModelContainer);
    TTextureMaterialSource(Plane.MaterialSource).Texture.Clear($00000000);
    Plane.OnRender := OnPlaneRender;
  end;
  Viewport3D.EndUpdate;
  Viewport3D.Repaint;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.DestroyMaterialSources;
var
  Component: TComponent;
  Plane: TPlane;
begin
  Viewport3D.BeginUpdate;
  for Component in MainForm do if Component is TPlane then
  begin
    Plane := TPlane(Component);
    Plane.MaterialSource.Free;
  end;
  Viewport3D.EndUpdate;
  Viewport3D.Repaint;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.Viewport3DMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  ScrollBox.BeginUpdate;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.Viewport3DMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  ScrollBox.EndUpdate;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.Viewport3DMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
var
  DeltaX, DeltaY: Single;
begin
  if ssLeft in Shift then
  begin
    if FIsPopup then
    begin
      FLastPoint := PointF(X, Y);
      FIsPopup := False;
      Exit;
    end;

    DeltaX := FLastPoint.X - X;
    DeltaY := FLastPoint.Y - Y;

    Viewport3D.BeginUpdate;
    with ModelContainer do
    begin
      // ������������ ����:
      RotationAngle.Y := RotationAngle.Y + DeltaX;
      RotationAngle.X := RotationAngle.X - DeltaY * Cos((Pi * RotationAngle.Y) / 180);
      RotationAngle.Z := RotationAngle.Z - DeltaY * Sin((Pi * RotationAngle.Y) / 180);
    end;
{
    with CameraContainer do
    begin
      // ������������ ������:
      RotationAngle.Y := RotationAngle.Y + DeltaX;
      RotationAngle.X := RotationAngle.X - DeltaY * Cos((Pi * RotationAngle.Y) / 180);
      RotationAngle.Z := RotationAngle.Z - DeltaY * Sin((Pi * RotationAngle.Y) / 180);
    end;
}
    Viewport3D.EndUpdate;
    Viewport3D.Repaint;
  end;
  FLastPoint := PointF(X, Y);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.Viewport3DMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; var Handled: Boolean);
  function Sign(Value: Single): Integer; inline;
  begin
    if Value = 0 then Exit(0);
    if Value > 0 then Exit(1) else Exit(-1);
  end;
var
  Direction: Integer;
begin
  Direction := Sign(WheelDelta);

  case Direction of
    1  : if Camera.Position.Z < -3 then Camera.Position.Z := Camera.Position.Z + Direction;
    -1 : if Camera.Position.Z > -16 then Camera.Position.Z := Camera.Position.Z + Direction;
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.OnPlaneRender(Sender: TObject; Context: TContext3D);
const
  WireframeColor = $FF00FFFF;
  WireframeOpacity = 0.7;
  DiagonalLineColor = $FFFFFF00;
  DiagonalLineOpacity = 0.6;
begin
  if FDrawWireframe then
  begin
    Context.BeginScene;
    Context.DrawLine(TPoint3D.Create(-0.5, -0.5, 0), TPoint3D.Create(-0.5, 0.5 , 0), WireframeOpacity, WireframeColor);
    Context.DrawLine(TPoint3D.Create(-0.5, 0.5 , 0), TPoint3D.Create(0.5 , 0.5 , 0), WireframeOpacity, WireframeColor);
    Context.DrawLine(TPoint3D.Create(0.5 , 0.5 , 0), TPoint3D.Create(0.5 , -0.5, 0), WireframeOpacity, WireframeColor);
    Context.DrawLine(TPoint3D.Create(0.5 , -0.5, 0), TPoint3D.Create(-0.5, -0.5, 0), WireframeOpacity, WireframeColor);
    Context.DrawLine(TPoint3D.Create(-0.5, -0.5, 0), TPoint3D.Create(0.5 , 0.5 , 0), DiagonalLineOpacity, DiagonalLineColor);
    Context.EndScene;
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// ����������� ����� ������� � ������ ������:
procedure CopyBitmapToBitmap(
                              const SrcBitmap    : FMX.Graphics.TBitmap; // �� ������ ������� ��������
                              const DestBitmap   : FMX.Graphics.TBitmap; // � ����� ������ ��������
                              const SrcRect      : TRectF;               // ����� �������������
                              const DstRect      : TRectF;               // � ����� �������������
                              ScaleCoeff         : Single  = 1.0;        // ����������� ��������������� (DstRect * ScaleCoeff)
                              Opacity            : Single  = 1.0;        // ����������� ������������ �������������� �����������
                              FlushBeforeDrawing : Boolean = True;       // ������� �� ���������� ����������
                              Interpolate        : Boolean = False       // ��������������� �� ��� ���������������
                             );

  function Max(const A, B: Single): Single; inline;
  begin
    if A > B then Result := A else Result := B;
  end;

begin
  if not Assigned(SrcBitmap) or not Assigned(DestBitmap) then Exit;

  DestBitmap.SetSize(Round(Max(DstRect.Left, DstRect.Right) * ScaleCoeff), Round(Max(DstRect.Top, DstRect.Bottom) * ScaleCoeff));
  DestBitmap.Canvas.BeginScene;
  if FlushBeforeDrawing then DestBitmap.Clear($00000000);
  DestBitmap.Canvas.DrawBitmap(
                                SrcBitmap,
                                SrcRect,
                                RectF(
                                       DstRect.Left,
                                       DstRect.Top,
                                       DstRect.Left + ((DstRect.Right - DstRect.Left) * ScaleCoeff),
                                       DstRect.Top  + ((DstRect.Bottom - DstRect.Top) * ScaleCoeff)
                                      ),
                                Opacity,
                                not Interpolate
                               );
  DestBitmap.Canvas.EndScene;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TMainForm.DrawSkin(const Bitmap: FMX.Graphics.TBitmap);
type
  TTextureInfo  = array of Integer;      // OffsetX, OffsetY, Width, Height
  TCubeTexture  = array of TTextureInfo; // Front, Back, Left, Right, Top, Bottom
  TSurfaceArray = array of ^TPlane;

// ������� ��������� � ��������:
const
  iOffsetX = 0;
  iOffsetY = 1;
  iWidth   = 2;
  iHeight  = 3;

  iFront  = 0;
  iBack   = 1;
  iLeft   = 2;
  iRight  = 3;
  iTop    = 4;
  iBottom = 5;

  iHead     = 0;
  iTorso    = 1;
  iLeftArm  = 2;
  iRightArm = 3;
  iLeftLeg  = 4;
  iRightLeg = 5;
  iHelmet   = 6;

const
  HeadTexture : TCubeTexture = [// X  Y  W  H
                                 [8 , 8, 8, 8], // Front
                                 [24, 8, 8, 8], // Back
                                 [16, 8, 8, 8], // Left
                                 [0 , 8, 8, 8], // Right
                                 [8 , 0, 8, 8], // Top
                                 [16, 0, 8, 8]  // Bottom
                                ];

  TorsoTexture : TCubeTexture = [
                                  [20, 20, 8, 12], // Front
                                  [32, 20, 8, 12], // Back
                                  [28, 20, 4, 12], // Left
                                  [16, 20, 4, 12], // Right
                                  [20, 16, 8, 4 ], // Top
                                  [28, 16, 8, 4 ]  // Bottom
                                 ];

  LeftArmTexture : TCubeTexture = [
                                    [44, 20, 4, 12], // Front
                                    [52, 20, 4, 12], // Back
                                    [48, 20, 4, 12], // Left
                                    [40, 20, 4, 12], // Right
                                    [44, 16, 4, 4 ], // Top
                                    [48, 16, 4, 4 ]  // Bottom
                                   ];

  RightArmTexture : TCubeTexture = [
                                     [44, 20, 4, 12], // Front
                                     [52, 20, 4, 12], // Back
                                     [48, 20, 4, 12], // Left
                                     [40, 20, 4, 12], // Right
                                     [44, 16, 4, 4 ], // Top
                                     [48, 16, 4, 4 ]  // Bottom
                                    ];

  LeftLegTexture : TCubeTexture = [
                                    [4 , 20, 4, 12], // Front
                                    [12, 20, 4, 12], // Back
                                    [0 , 20, 4, 12], // Left
                                    [8 , 20, 4, 12], // Right
                                    [4 , 16, 4, 4 ], // Top
                                    [8 , 16, 4, 4 ]  // Bottom
                                   ];

  RightLegTexture : TCubeTexture = [
                                     [4 , 20, 4, 12], // Front
                                     [12, 20, 4, 12], // Back
                                     [0 , 20, 4, 12], // Left
                                     [8 , 20, 4, 12], // Right
                                     [4 , 16, 4, 4 ], // Top
                                     [8 , 16, 4, 4 ]  // Bottom
                                    ];

  HelmetTexture : TCubeTexture = [
                                   [40, 8, 8, 8], // Front
                                   [56, 8, 8, 8], // Back
                                   [48, 8, 8, 8], // Left
                                   [32, 8, 8, 8], // Right
                                   [40, 0, 8, 8], // Top
                                   [48, 0, 8, 8]  // Bottom
                                  ];

const
  ScaleCoeff: Single = 10.0;

var
  // ������ ������������ ������ ����� ������:
  HeadPlanes     : TSurfaceArray;
  TorsoPlanes    : TSurfaceArray;
  LeftArmPlanes  : TSurfaceArray;
  RightArmPlanes : TSurfaceArray;
  LeftLegPlanes  : TSurfaceArray;
  RightLegPlanes : TSurfaceArray;
  HelmetPlanes   : TSurfaceArray;

  // ������ ������ ������:
  ModelParts: array of ^TSurfaceArray;

  // ������ ������� ������ ����� ������:
  DefaultTextures: array of ^TCubeTexture;
  ObjectTextures: array of TCubeTexture;

  // ����������� ��������������� ��������� ��� HD-������:
  CoordScaleCoeffX, CoordScaleCoeffY: Integer;

  // I - ������� �� ������ ������, J - ������� �� ������������:
  I, J: LongWord;

begin
  if not Assigned(Bitmap) then Exit;

  Viewport3D.BeginUpdate;

  // �������� ������������ ��������������� ���������:
  CoordScaleCoeffX := Bitmap.Width div 64;
  CoordScaleCoeffY := Bitmap.Height div 32;

  // ���������� ������ �� ����� ������� ��� ������ ����� ������:
  DefaultTextures := [@HeadTexture, @TorsoTexture, @LeftArmTexture, @RightArmTexture, @LeftLegTexture, @RightLegTexture, @HelmetTexture];

  // ������ ������ ������������������ ���������:
  SetLength(ObjectTextures, Length(DefaultTextures));
  for I := 0 to Length(ObjectTextures) - 1 do
  begin
    SetLength(ObjectTextures[I], Length(DefaultTextures[I]^));
    for J := 0 to Length(ObjectTextures[I]) - 1 do
    begin
      SetLength(ObjectTextures[I][J], 4);
      ObjectTextures[I][J][0] := DefaultTextures[I]^[J][0] * CoordScaleCoeffX;
      ObjectTextures[I][J][1] := DefaultTextures[I]^[J][1] * CoordScaleCoeffY;
      ObjectTextures[I][J][2] := DefaultTextures[I]^[J][2] * CoordScaleCoeffX;
      ObjectTextures[I][J][3] := DefaultTextures[I]^[J][3] * CoordScaleCoeffY;
    end;
  end;

  // ���������� ������ ������������:
  HeadPlanes     := [@HeadFront    , @HeadBack    , @HeadLeft     , @HeadRight    , @HeadTop    , @HeadBottom    ];
  TorsoPlanes    := [@TorsoFront   , @TorsoBack   , @TorsoLeft    , @TorsoRight   , @TorsoTop   , @TorsoBottom   ];
  LeftArmPlanes  := [@LeftArmFront , @LeftArmBack , @LeftArmRight , @LeftArmLeft  , @LeftArmTop , @LeftArmBottom ];
  RightArmPlanes := [@RightArmFront, @RightArmBack, @RightArmLeft , @RightArmRight, @RightArmTop, @RightArmBottom];
  LeftLegPlanes  := [@LeftLegFront , @LeftLegBack , @LeftLegLeft  , @LeftLegRight , @LeftLegTop , @LeftLegBottom ];
  RightLegPlanes := [@RightLegFront, @RightLegBack, @RightLegRight, @RightLegLeft , @RightLegTop, @RightLegBottom];
  HelmetPlanes   := [@HelmetFront  , @HelmetBack  , @HelmetLeft   , @HelmetRight  , @HelmetTop  , @HelmetBottom  ];

  // ���������� ������ ������ ������:
  ModelParts := [@HeadPlanes, @TorsoPlanes, @LeftArmPlanes, @RightArmPlanes, @LeftLegPlanes, @RightLegPlanes, @HelmetPlanes];

  // ���������� �� ������ ����� ������ (������, ������, ...):
  for I := 0 to High(ModelParts) do
  begin
    // ���������� �� ������ ����������� ������:
    for J := 0 to High(ModelParts[I]^) do
    begin
      // ������ �������� �� ������ �����������:
      with ModelParts[I]^[J]^ do
      begin
        ModelParts[I]^[J]^.BeginUpdate;

        CopyBitmapToBitmap(
                            Bitmap,
                            TTextureMaterialSource(MaterialSource).Texture,
                            RectF(
                                   ObjectTextures[I][J][iOffsetX],
                                   ObjectTextures[I][J][iOffsetY],
                                   ObjectTextures[I][J][iOffsetX] + ObjectTextures[I][J][iWidth],
                                   ObjectTextures[I][J][iOffsetY] + ObjectTextures[I][J][iHeight]
                                  ),
                            RectF(0, 0, ObjectTextures[I][J][iWidth], ObjectTextures[I][J][iHeight]),
                            ScaleCoeff / ((CoordScaleCoeffX + CoordScaleCoeffY) div 2)
                           );

        // ����������� �������� ��� ���������:
        if (I in [iLeftArm, iLeftLeg]) then
          TTextureMaterialSource(MaterialSource).Texture.FlipHorizontal;

        ModelParts[I]^[J]^.EndUpdate;
      end;
    end;
  end;

  // ����������� ������ ������������������ ���������:
  for I := 0 to Length(ObjectTextures) - 1 do
  begin
    for J := 0 to Length(ObjectTextures[I]) - 1 do
      SetLength(ObjectTextures[I][J], 0);
    SetLength(ObjectTextures[I], 0);
  end;
  SetLength(ObjectTextures, 0);

  Viewport3D.EndUpdate;
  Viewport3D.RecalcOpacity;
  Viewport3D.Repaint;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure DbgPrint(const Str: string);
begin
  OutputDebugString(PChar(Str));
end;

procedure TMainForm.DrawCloak(const Bitmap: FMX.Graphics.TBitmap);
type
  TTextureInfo  = array of Integer;      // OffsetX, OffsetY, Width, Height
  TCubeTexture  = array of TTextureInfo; // Front, Back, Left, Right, Top, Bottom
  TSurfaceArray = array of ^TPlane;

// ������� ��������� � ��������:
const
  iOffsetX = 0;
  iOffsetY = 1;
  iWidth   = 2;
  iHeight  = 3;

  iFront  = 0;
  iBack   = 1;
  iLeft   = 2;
  iRight  = 3;
  iTop    = 4;
  iBottom = 5;

  iCloak = 0;

const
  CloakTexture : TCubeTexture = [// X  Y  W  H
                                  [1 , 1, 10, 16], // Front
                                  [12, 1, 10, 16], // Back
                                  [11, 1, 1 , 16], // Left
                                  [0 , 1, 1 , 16], // Right
                                  [1 , 0, 10, 1],  // Top
                                  [11, 0, 10, 1]   // Bottom
                                 ];
const
  ScaleCoeff: Single = 10.0;

var
  // ������ ������������ ������ ����� ������:
  CloakPlanes: TSurfaceArray;

  // ������ �� ������� ������ �����������:
  ObjectTexture: TCubeTexture;

  // ����������� ��������������� ��������� ��� HD-������:
  CoordScaleCoeffX, CoordScaleCoeffY: Integer;

  // I - ������� �� ������������:
  I: LongWord;

begin
  if not Assigned(Bitmap) then Exit;

  Viewport3D.BeginUpdate;

  // �������� ������������ ��������������� ���������:
  CoordScaleCoeffX := Bitmap.Width div 64;
  CoordScaleCoeffY := Bitmap.Height div 32;

  // ������ ������ ������������������ ���������:
  SetLength(ObjectTexture, Length(CloakTexture));
  for I := 0 to Length(ObjectTexture) - 1 do
  begin
    SetLength(ObjectTexture[I], 4);
    ObjectTexture[I][0] := CloakTexture[I][0] * CoordScaleCoeffX;
    ObjectTexture[I][1] := CloakTexture[I][1] * CoordScaleCoeffY;
    ObjectTexture[I][2] := CloakTexture[I][2] * CoordScaleCoeffX;
    ObjectTexture[I][3] := CloakTexture[I][3] * CoordScaleCoeffY;
  end;

  // ���������� ������ ������������:
  CloakPlanes := [@CloakFront, @CloakBack, @CloakLeft, @CloakRight, @CloakTop, @CloakBottom];

  // ���������� �� ������������ �����:
  for I := 0 to Length(CloakPlanes) - 1 do
  begin
    // ������ �������� �� ������ �����������:
    with CloakPlanes[I]^ do
    begin
      BeginUpdate;
      CopyBitmapToBitmap(
                          Bitmap,
                          TTextureMaterialSource(MaterialSource).Texture,
                          RectF(
                                 ObjectTexture[I][iOffsetX],
                                 ObjectTexture[I][iOffsetY],
                                 ObjectTexture[I][iOffsetX] + ObjectTexture[I][iWidth],
                                 ObjectTexture[I][iOffsetY] + ObjectTexture[I][iHeight]
                                ),
                          RectF(0, 0, ObjectTexture[I][iWidth], ObjectTexture[I][iHeight]),
                          ScaleCoeff / ((CoordScaleCoeffX + CoordScaleCoeffY) div 2)
                         );

      EndUpdate;
    end;
  end;

  // ����������� ������ ������������������ ���������:
  for I := 0 to Length(ObjectTexture) - 1 do
  begin
    SetLength(ObjectTexture[I], 0);
  end;
  SetLength(ObjectTexture, 0);

  Viewport3D.EndUpdate;
  Viewport3D.RecalcOpacity;
  Viewport3D.Repaint;
end;


end.
