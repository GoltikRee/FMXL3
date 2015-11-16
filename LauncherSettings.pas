unit LauncherSettings;

interface

const
  // ���� � %APPDATA%:
  LocalWorkingFolder: string = '.FMXL3';

  // ���� � �������, ��� ����� ��������� ��������� (HKCU//Software//RegistryPath):
  RegistryPath: string = 'FMXL3';

  // ���� � ������� ����� �� ������� (���, ��� ����� ���-�����):
  ServerWorkingFolder: string = 'http://froggystyle.ru/WebFMX3/';

  // ���� ���������� (������ ��������� � ������ � ���-�����!):
  EncryptionKey: AnsiString = 'FMXL3';

  // �������� ����� ����������� ������ ����������� � �������������:
  MonitoringInterval: Integer = 450;

  // ������ ��������:
  LauncherVersion: Integer = 2;



implementation

end.
