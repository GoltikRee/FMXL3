unit JavaInformation;

interface

uses
  Windows, SysUtils, System.JSON, JSONUtils, FilesValidation, AuxUtils, StringsAPI;

type
  TJavaParameters = record
    JavaVersion : Integer; // ������ Java
    JNIVersion  : Integer; // ������ JNI
    JavaFolder  : string;  // ������� ����� � Java ������������ BaseFolder
    JVMPath     : string;  // ���� � jvm.dll ������������ JavaFolder (� ������ "�����" �����) ��� ���������� ���� (� ������ "�������" �����)
    Arguments   : string;
  end;

  // ���������� � ������� ���������� � ������ �������, �������������� ������ ����������:
  TValidationStatus = record
    Status: Boolean;
    StartedByClientID: Integer;
  end;

  TJavaInfo = class
    private
      FCriticalSection  : _RTL_CRITICAL_SECTION;
      FValidationStatus : TValidationStatus;
      FJavaParameters   : TJavaParameters;
      FExternalJava     : Boolean;
      FUseJNI           : Boolean;
      FFilesValidator   : TFilesValidator;
      function GetExternalStatus: Boolean;
    public
      property JavaParameters: TJavaParameters read FJavaParameters;

      property ExternalJava: Boolean read GetExternalStatus;
      property FilesValidator: TFilesValidator read FFilesValidator;

      constructor Create;
      destructor Destroy; override;

      procedure ExtractJavaInfo(const ServersInfo: TJSONObject);
      procedure Clear;

      procedure SetValidationStatus(Status: Boolean; ClientID: Integer);
      function GetValidationStatus: Boolean;
      function GetValidationClientID: Integer;

      procedure SetJVMPath(const AbsoluteJVMPath: string; Version: Integer);
  end;

implementation

{ TJavaInfo }

constructor TJavaInfo.Create;
begin
  FFilesValidator := TFilesValidator.Create;
  InitializeCriticalSection(FCriticalSection);
  Clear;
end;

destructor TJavaInfo.Destroy;
begin
  Clear;
  DeleteCriticalSection(FCriticalSection);
  FreeAndNil(FFilesValidator);
  inherited;
end;

procedure TJavaInfo.ExtractJavaInfo(const ServersInfo: TJSONObject);
var
  JavaObject: TJSONObject;
  CheckedFoldersArray: TJSONArray;
begin
  Clear;

  if ServersInfo = nil then Exit;

  JavaObject := GetJSONObjectValue(ServersInfo, 'java_info');
  FExternalJava := JavaObject = nil;
  if FExternalJava then Exit;

  FUseJNI := True;
  //FUseJNI := GetJSONBooleanValue(JavaObject, 'use_jni');

  if FUseJNI then
  begin
    // �������� ���� � jvm.dll ������ ����������� (����� ��, ��� � ����������� ��������):
    {$IFDEF CPUX64}
      FJavaParameters.JavaFolder := GetJSONStringValue(JavaObject, 'java64_folder');
      FJavaParameters.JVMPath := GetJSONStringValue(JavaObject, 'jvm64_library_path');
    {$ELSE}
      FJavaParameters.JavaFolder := GetJSONStringValue(JavaObject, 'java32_folder');
      FJavaParameters.JVMPath := GetJSONStringValue(JavaObject, 'jvm32_library_path');
    {$ENDIF}

    // �������� ������ JNI:
    FJavaParameters.JavaVersion := GetJSONIntValue(JavaObject, 'java_version');
    case FJavaParameters.JavaVersion of
      6, 7: FJavaParameters.JNIVersion := $00010006;
         8: FJavaParameters.JNIVersion := $00010008;
         9: FJavaParameters.JNIVersion := $00010009; // �� �������
    end;
  end
  else
  begin
    // �������� ���� � java(w).exe ����������� ������������ �������:
    if Is64BitWindows then
    begin
      FJavaParameters.JavaFolder := GetJSONStringValue(JavaObject, 'java64_folder');
      FJavaParameters.JVMPath := GetJSONStringValue(JavaObject, 'java64_executable_path');
    end
    else
    begin
      FJavaParameters.JavaFolder := GetJSONStringValue(JavaObject, 'java32_folder');
      FJavaParameters.JVMPath := GetJSONStringValue(JavaObject, 'java32_executable_path');
    end;
  end;

  FJavaParameters.JavaFolder := FixSlashes(FJavaParameters.JavaFolder);
  FJavaParameters.JVMPath := FixSlashes(FJavaParameters.JVMPath);

  FJavaParameters.Arguments := GetJSONStringValue(JavaObject, {$IFDEF CPUX64}'jvm64_arguments'{$ELSE}'jvm32_arguments'{$ENDIF});

  // �������� ������ ������ � ����� �� ��������:
  CheckedFoldersArray := GetJSONArrayValue(JavaObject, 'checked_folders');
  FFilesValidator.ExtractCheckingsInfo(CheckedFoldersArray);
end;

function TJavaInfo.GetExternalStatus: Boolean;
begin
  EnterCriticalSection(FCriticalSection);
  Result := FExternalJava;
  LeaveCriticalSection(FCriticalSection);
end;


procedure TJavaInfo.SetValidationStatus(Status: Boolean; ClientID: Integer);
begin
  EnterCriticalSection(FCriticalSection);
  FValidationStatus.Status := Status;
  FValidationStatus.StartedByClientID := ClientID;
  LeaveCriticalSection(FCriticalSection);
end;

function TJavaInfo.GetValidationStatus: Boolean;
begin
  EnterCriticalSection(FCriticalSection);
  Result := FValidationStatus.Status;
  LeaveCriticalSection(FCriticalSection);
end;

function TJavaInfo.GetValidationClientID: Integer;
begin
  EnterCriticalSection(FCriticalSection);
  Result := FValidationStatus.StartedByClientID;
  LeaveCriticalSection(FCriticalSection);
end;


procedure TJavaInfo.Clear;
begin
  FJavaParameters.JNIVersion := 0;
  FJavaParameters.JVMPath    := '';
  FJavaParameters.Arguments  := '';
  FExternalJava := False;
  FUseJNI       := False;
  SetValidationStatus(False, -1);
  FFilesValidator.Clear;
end;


procedure TJavaInfo.SetJVMPath(const AbsoluteJVMPath: string; Version: Integer);
begin
  FJavaParameters.JVMPath := AbsoluteJVMPath;
  case Version of
    6, 7: FJavaParameters.JNIVersion := $00010006;
       8: FJavaParameters.JNIVersion := $00010008;
       9: FJavaParameters.JNIVersion := $00010009; // �� �������
  end;
  FExternalJava := True;
end;


end.
