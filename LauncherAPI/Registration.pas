unit Registration;

interface

uses
  System.JSON, SysUtils, Classes, HTTPUtils, HWID, Encryption, JSONUtils;

type
  TRegResponse = TJSONObject;
  PRegResponse = ^TRegResponse;

  // ��������� � ������ ������������, ������� ������� ������ �����������:
  TRegData = record
    Login    : string;
    Password : string;
    SendHWID : Boolean;
  end;

  // ��������� ���� �����������:
  REG_STATUS_CODE = (
    REG_STATUS_SUCCESS,          // �������� �����������
    REG_STATUS_UNKNOWN_ERROR,    // ����������� ������
    REG_STATUS_CONNECTION_ERROR, // �� ������� ������������
    REG_STATUS_BAD_RESPONSE      // �� ������� ����������� �����
  );

  // ��������� � ����������� �����������, ������������ � �������:
  REG_STATUS = record
    StatusCode   : REG_STATUS_CODE;
    StatusString : string;
  end;

  // ������� �����������:
  TOnReg = reference to procedure(const RegStatus: REG_STATUS);

  // ����� �����������:
  TRegWorker = class(TThread)
    private
      FRegStatus        : REG_STATUS;
      FRegData          : TRegData;
      FRegResponse      : PRegResponse;
      FOnReg            : TOnReg;
      FRegScriptAddress : string;
      FEncryptionKey    : AnsiString;
    public
      property EncryptionKey: AnsiString read FEncryptionKey write FEncryptionKey;

      procedure RegisterPlayer(
                           const RegScriptAddress : string;       // ����� ������� �����������
                           const RegData          : TRegData;     // ������, ������������ �������
                           out   RegResponse      : TRegResponse; // JSON-����� �� �������
                           OnReg                  : TOnReg        // ������� ���������� �����������
                          );
    protected
      procedure Execute; override;
  end;

implementation

{ TRegWorker }

procedure TRegWorker.RegisterPlayer(const RegScriptAddress: string; const RegData: TRegData;
  out RegResponse: TRegResponse; OnReg: TOnReg);
begin
  // ��������� �����������:
  FRegScriptAddress := RegScriptAddress;
  FRegResponse      := @RegResponse;
  FRegData          := RegData;
  FOnReg            := OnReg;

  // ��������� ������:
  FreeOnTerminate := True;
  Start;
end;

procedure TRegWorker.Execute;
var
  HTTPSender: THTTPSender;
  Response: TStringStream;
  DecodedResponse: TBytes;
  Request: string;
  Status: string;
begin
  inherited;

  // ��������� ������:
  Request := 'login=' + FRegData.Login + '&password=' + FRegData.Password;
  if FRegData.SendHWID then Request := Request + '&hwid=' + GetHWID;

  // ���������� ������ �� ������:
  HTTPSender := THTTPSender.Create;
  Response   := TStringStream.Create;
  HTTPSender.POST(FRegScriptAddress, Request, Response);

  if  HTTPSender.Status then
  begin
    // ���������� ������:
    DecodedResponse := Response.Encoding.Convert(
                                                  Response.Encoding.UTF8,
                                                  Response.Encoding.ANSI,
                                                  Response.Bytes,
                                                  0,
                                                  Length(Response.DataString)
                                                 );
    Response.Clear;
    Response.WriteData(DecodedResponse, Length(DecodedResponse));

    // ��������������� ������ � JSON:
    FRegResponse^ := JSONStringToJSONObject(Response.DataString);
    if FRegResponse^ <> nil then
    begin
      // ��������� ���� "status" � ���������� JSON'�:
      if GetJSONStringValue(FRegResponse^, 'status', Status) then
      begin
        Status := LowerCase(Status);
        if Status = 'success' then
        begin
          FRegStatus.StatusCode := REG_STATUS_SUCCESS;
          FRegStatus.StatusString := '�������� �����������!';
        end
        else
        begin
          FRegStatus.StatusCode := REG_STATUS_UNKNOWN_ERROR;

          // �������� ������� ������:
          if not GetJSONStringValue(FRegResponse^, 'reason', FRegStatus.StatusString) then
            FRegStatus.StatusString := '����������� ������!';
        end;
      end
      else
      begin
        FRegStatus.StatusCode := REG_STATUS_UNKNOWN_ERROR;
        FRegStatus.StatusString := 'JSON ������������ �������! ��������� ��������� ���-�����!';
      end;
    end
    else
    begin
      FRegStatus.StatusCode := REG_STATUS_BAD_RESPONSE;
      FRegStatus.StatusString := '�� ������� ������������� ����� �� ������� � JSON!';
    end;
  end
  else
  begin
    FRegStatus.StatusCode := REG_STATUS_CONNECTION_ERROR;
    FRegStatus.StatusString := '�� ������� ������������ � �������!';
  end;

  FreeAndNil(Response);
  FreeAndNil(HTTPSender);

  // ���������� ���������:
  Synchronize(procedure()
  begin
    FOnReg(FRegStatus);
  end);
end;

end.
