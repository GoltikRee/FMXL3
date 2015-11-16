 unit Authorization;

interface

uses
  System.JSON, SysUtils, Classes, HTTPUtils,
  HWID, Encryption, JSONUtils, CodepageAPI;

type
  TAuthResponse = TJSONObject;
  PAuthResponse = ^TAuthResponse;

  // ��������� � ������ ������������, ������� ������� ������ �����������:
  TAuthData = record
    Login    : string;
    Password : string;
    SendHWID : Boolean;
  end;

  // ��������� ���� �����������:
  AUTH_STATUS_CODE = (
    AUTH_STATUS_SUCCESS,          // �������� �����������
    AUTH_STATUS_UNKNOWN_ERROR,    // ����������� ������
    AUTH_STATUS_CONNECTION_ERROR, // �� ������� ������������
    AUTH_STATUS_BAD_RESPONSE      // �� ������� ����������� �����
  );

  // ��������� � ����������� �����������, ������������ � �������:
  AUTH_STATUS = record
    StatusCode   : AUTH_STATUS_CODE;
    StatusString : string;
  end;

  // ������� �����������:
  TOnAuth = reference to procedure(const AuthStatus: AUTH_STATUS);

  // ����� �����������:
  TAuthWorker = class(TThread)
    private
      FAuthStatus: AUTH_STATUS;
      FAuthData: TAuthData;
      FAuthResponse: PAuthResponse;
      FOnAuth: TOnAuth;
      FAuthScriptAddress: string;
      FEncryptionKey: AnsiString;
    public
      property EncryptionKey: AnsiString read FEncryptionKey write FEncryptionKey;

      procedure Authorize(
                           const AuthScriptAddress : string;        // ����� ������� �����������
                           const AuthData          : TAuthData;     // ������, ������������ �������
                           out   AuthResponse      : TAuthResponse; // JSON-����� �� �������
                           OnAuth                  : TOnAuth        // ������� ���������� �����������
                          );
    protected
      procedure Execute; override;
  end;

implementation

{ TAuthWorker }

procedure TAuthWorker.Authorize(const AuthScriptAddress: string; const AuthData: TAuthData;
  out AuthResponse: TAuthResponse; OnAuth: TOnAuth);
begin
  // ��������� �����������:
  FAuthScriptAddress := AuthScriptAddress;
  FAuthResponse      := @AuthResponse;
  FAuthData          := AuthData;
  FOnAuth            := OnAuth;

  // ��������� ������:
  FreeOnTerminate := True;
  Start;
end;

procedure TAuthWorker.Execute;
var
  HTTPSender: THTTPSender;
  Response: TStringStream;
  Request: string;
  Status: string;
begin
  inherited;

  // ��������� ������:
  Request := 'login=' + FAuthData.Login + '&password=' + FAuthData.Password;
  if FAuthData.SendHWID then Request := Request + '&hwid=' + GetHWID;

  // ���������� ������ �� ������:
  HTTPSender := THTTPSender.Create;
  Response   := TStringStream.Create;
  HTTPSender.POST(FAuthScriptAddress, Request, Response);

  if  HTTPSender.Status then
  begin
    // �������������� ������:
    EncryptDecryptVerrnam(Response.Memory, Response.Size, PAnsiChar(FEncryptionKey), Length(FEncryptionKey));
    UTF8Convert(Response);

    // ��������������� ������ � JSON:
    FAuthResponse^ := JSONStringToJSONObject(Response.DataString);
    if FAuthResponse^ <> nil then
    begin
      // ��������� ���� "status" � ���������� JSON'�:
      if GetJSONStringValue(FAuthResponse^, 'status', Status) then
      begin
        Status := LowerCase(Status);
        if Status = 'success' then
        begin
          FAuthStatus.StatusCode := AUTH_STATUS_SUCCESS;
          FauthStatus.StatusString := '�������� �����������!';
        end
        else
        begin
          FAuthStatus.StatusCode := AUTH_STATUS_UNKNOWN_ERROR;

          // �������� ������� ������:
          if not GetJSONStringValue(FAuthResponse^, 'reason', FAuthStatus.StatusString) then
            FAuthStatus.StatusString := '����������� ������!';
        end;
      end
      else
      begin
        FAuthStatus.StatusCode := AUTH_STATUS_UNKNOWN_ERROR;
        FAuthStatus.StatusString := 'JSON ������������ �������! ��������� ��������� ���-�����!';
      end;
    end
    else
    begin
      FAuthStatus.StatusCode := AUTH_STATUS_BAD_RESPONSE;
      FAuthStatus.StatusString := '�� ������� ������������� ����� �� ������� � JSON!' + #13#10 +
                                  '��������� ������������ ����� ����������!';
    end;
  end
  else
  begin
    FAuthStatus.StatusCode := AUTH_STATUS_CONNECTION_ERROR;
    FAuthStatus.StatusString := '�� ������� ������������ � �������!';
  end;

  FreeAndNil(Response);
  FreeAndNil(HTTPSender);

  // ���������� ���������:
  Synchronize(procedure()
  begin
    FOnAuth(FAuthStatus);
  end);
end;

end.
