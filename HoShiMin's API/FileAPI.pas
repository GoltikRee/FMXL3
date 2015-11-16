unit FileAPI;

interface

uses
  Windows, SysUtils, StrUtils, ShFolder, ShellAPI, Classes;

function CreateFile(
                     const FileName        : string;
                     CreatingFlag          : LongWord = OPEN_ALWAYS;
                     Access                : LongWord = GENERIC_READ    or GENERIC_WRITE;
                     ShareMode             : LongWord = FILE_SHARE_READ or FILE_SHARE_WRITE;
                     CreatePathIfNotExists : Boolean  = True
                    ): THandle; overload;
{
  ������ ��� ��������� ���� � ���������� ����� �� ����.

  CreatingFlag:
    CREATE_ALWAYS - ������ ��������� ����
    CREATE_NEW - ���������, ������ ���� ���� �� ����������, � ���� ���������� - ���������� ������
    OPEN_ALWAYS - ���� ���� ���������� - ���������, ���� ��� - ������ � ���������
    OPEN_EXISTING - ���������, ������ ���� ���� ����������
    TRUNCATE_EXISTING - ��������� � ������� ����������
	
  CreatePathIfNotExists:
    True - ��������� �������� ��������� ���� � �����
	False - �� ��������� ����� 
}

function FileExists(const FileName: string): Boolean;
{
  ��������� ������������� �����
}

function GetFileSize(const FileName: string): LongWord; overload;
{
  �������� ������ �����
}

function LoadFileToMemory(const FileName: string): Pointer; overload;
{
  ��������� ���� � ������
}

function LoadFileToMemory(const FileName: string; out FileSize: Integer): Pointer; overload;
{
  ��������� ���� � ������ � ���������� ������ ������������ �����
}

const
  FROM_BEGIN   = 0;
  FROM_CURRENT = 1;
  FROM_END     = 2;

function ReadFromFile(hFile: THandle; Buffer: Pointer; Size: LongWord): Boolean; overload;
{
  ������ �� ����� � ����� �������� ����� ����
}

function ReadFromFile(hFile: THandle; Buffer: Pointer; Size: LongWord; Offset: Integer; OffsetType: Integer = FROM_CURRENT): Boolean; overload;
{
  ������ �� ����� � ����� �������� ����� ���� �� ���������
}

function WriteToFile(hFile: THandle; Buffer: Pointer; Size: LongWord): Boolean; overload;
{
  ����� � ���� �������� ����� ���� �� ������
}

function WriteToFile(hFile: THandle; Buffer: Pointer; Size: LongWord; Offset: Integer; OffsetType: Integer = FROM_CURRENT): Boolean; overload;
{
  ����� � ���� �������� ����� ���� �� ������ �� ���������
}

function DeleteDirectory(const Directory: string; Silent: Boolean = False): Boolean;
{
  ������� ����� ������ � ������� (�������������� �����, �������� *.exe)
}

function GetSpecialFolderPath(Folder: Integer): string;
{
  �������� ����, ��������� � ���������� ����� (CSIDL_*)
}

const  
  CSIDL_APPDATA          = 26;
  CSIDL_DRIVES           = 17; // ��� ���������
  CSIDL_SYSTEM           = 37; // C:\Windows\System32
  CSIDL_WINDOWS          = 36; // C:\Windows
  CSIDL_BITBUCKET        = 10; // �������

  CSIDL_COOKIES          = 33;
  CSIDL_DESKTOP          = 0;
  CSIDL_FONTS            = 20;
  CSIDL_HISTORY          = 34;
  CSIDL_INTERNET         = 1;
  CSIDL_INTERNET_CACHE   = 32;
  CSIDL_COMMON_STARTMENU = 22;
  CSIDL_STARTMENU        = 11;
  CSIDL_LOCAL_APPDATA    = 28;
  CSIDL_ADMINTOOLS       = 48;    


function SetEnvironmentVariable(const VariableName, VariableValue: string): Integer;
{
  ����� �������� ���������� ���������
}

function GetEnvironmentVariable(const VariableName: string): string;
{
  �������� �������� ���������� ���������
}

procedure GetFilesList(const Dir, Pattern, Delimiter: string; var FilesList: string; IncludeSubfolders: Boolean = True); overload;
{
  �������� ������ ������ � ����� � ������ ����� �����������
}

procedure GetFilesList(const Dir, Pattern: string; const FilesList: TStringList; IncludeSubfolders: Boolean = True); overload;
{
  �������� ������ ������ � ����� � TStringList
}

type TStringArray = array of string;
procedure GetFilesList(const Dir, Pattern: string; var FilesList: TStringArray; IncludeSubfolders: Boolean = True); overload;
{
  �������� ������ ������ � ������ �����
}

procedure CreatePath(const EndDir: string);
{
  ������ �������� ��������� �� ��������� �������� ������������.
  ����������� �����������: "\" � "/"
}

function ExtractFileDir(Path: string): string;
{
  �������� �������, � ������� ����� ����, ��� �����. ����������� �����������: "\" � "/".
}

function ExtractFilePath(Path: string): string;
{
  ��������� ���� � �����. ����������� �����������: "\" � "/"
}

function ExtractFileName(Path: string): string;
{
  ��������� ��� �����. ����������� �����������: "\" � "/"
}

function ExtractHost(Path: string): string;
{
  ��������� ��� ����� �� �������� ������.
  http://site.ru/folder/script.php  -->  site.ru
}

function ExtractObject(Path: string): string;
{
  ��������� ��� ������� �� �������� ������:
  http://site.ru/folder/script.php  -->  folder/script.php
}

implementation

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// ��������� ������ � �������� �������� � ��������:
// ����������� ����������� "\" � "/"

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function CreateFile(
                     const FileName        : string;
                     CreatingFlag          : LongWord = OPEN_ALWAYS;
                     Access                : LongWord = GENERIC_READ    or GENERIC_WRITE;
                     ShareMode             : LongWord = FILE_SHARE_READ or FILE_SHARE_WRITE;
                     CreatePathIfNotExists : Boolean  = True
                    ): THandle; overload;
begin
  if CreatePathIfNotExists then CreatePath(ExtractFileDir(FileName) + '\');

  Result := Windows.CreateFile(
                                PChar(FileName),
                                Access,
                                ShareMode,
                                nil,
                                CreatingFlag,
                                FILE_ATTRIBUTE_NORMAL,
                                0
                               );

end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function FileExists(const FileName: string): Boolean;
var
  hFile: THandle;
begin
  hFile := CreateFile(FileName, OPEN_EXISTING, GENERIC_READ, FILE_SHARE_READ, False);
  Result := hFile <> INVALID_HANDLE_VALUE;
  if Result then CloseHandle(hFile);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function GetFileSize(const FileName: string): LongWord; overload;
var
  hFile: THandle;
begin
  hFile := CreateFile(FileName);
  Result := Windows.GetFileSize(hFile, nil);
  CloseHandle(hFile);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function LoadFileToMemory(const FileName: string): Pointer; overload;
var
  hFile: THandle;
  FileSize: LongWord;
  ReadBytes: LongWord;
begin
  Result := nil;
  hFile := CreateFile(FileName);

  if hFile <> 0 then
  begin
    FileSize := Windows.GetFileSize(hFile, nil);
    GetMem(Result, FileSize);

    ReadFile(hFile, Result^, FileSize, ReadBytes, nil);
    CloseHandle(hFile);
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function LoadFileToMemory(const FileName: string; out FileSize: Integer): Pointer; overload;
var
  hFile: THandle;
  ReadBytes: LongWord;
begin
  Result := nil;
  hFile := CreateFile(FileName, OPEN_EXISTING, GENERIC_READ, FILE_SHARE_READ, False);

  if hFile <> INVALID_HANDLE_VALUE then
  begin
    FileSize := Windows.GetFileSize(hFile, nil);
    GetMem(Result, FileSize);

    ReadFile(hFile, Result^, FileSize, ReadBytes, nil);
    CloseHandle(hFile);
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function ReadFromFile(hFile: THandle; Buffer: Pointer; Size: LongWord): Boolean; overload;
var
  BytesRead: Cardinal;
begin
  Result := ReadFile(hFile, Buffer^, Size, BytesRead, nil) and (BytesRead = Size);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function ReadFromFile(hFile: THandle; Buffer: Pointer; Size: LongWord; Offset: Integer; OffsetType: Integer = FROM_CURRENT): Boolean; overload;
begin
  SetFilePointer(hFile, Offset, nil, OffsetType);
  Result := ReadFromFile(hFile, Buffer, Size);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function WriteToFile(hFile: THandle; Buffer: Pointer; Size: LongWord): Boolean; overload;
var
  BytesWrote: Cardinal;
begin
  Result := WriteFile(hFile, Buffer^, Size, BytesWrote, nil) and (BytesWrote = Size);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function WriteToFile(hFile: THandle; Buffer: Pointer; Size: LongWord; Offset: Integer; OffsetType: Integer = FROM_CURRENT): Boolean; overload;
begin
  SetFilePointer(hFile, Offset, nil, OffsetType);
  Result := WriteToFile(hFile, Buffer, Size);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function DeleteDirectory(const Directory: string; Silent: Boolean = False): Boolean;
var
  FileOpStruct: TSHFileOpStruct;
begin
  ZeroMemory(@FileOpStruct, SizeOf(FileOpStruct));
  with FileOpStruct do
  begin
    wFunc  := FO_DELETE;
    fFlags := FOF_NOCONFIRMATION;
    if Silent then fFlags := fFlags or FOF_SILENT;
    pFrom  := PChar(Directory + #0);
  end;
  Result := ShFileOperation(FileOpStruct) = 0;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function GetSpecialFolderPath(Folder: Integer): string;
const
  SHGFP_TYPE_CURRENT = 0;
var
  Path: array [0..MAX_PATH] of Char;
begin
  if SUCCEEDED(SHGetFolderPath(0, Folder, 0, SHGFP_TYPE_CURRENT, @Path[0])) then
    Result := Path
  else
    Result := '';
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function SetEnvironmentVariable(const VariableName, VariableValue: string): Integer;
begin
  if Windows.SetEnvironmentVariable(PChar(VariableName), PChar(VariableValue)) then
    Result := 0
  else
    Result := GetLastError;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function GetEnvironmentVariable(const VariableName: string): string;
var
  Buffer: array [0..32767] of Char;
  BufferSize: LongWord;
begin
  Result := '';
  BufferSize := Windows.GetEnvironmentVariable(PChar(VariableName), @Buffer[0], 32768);
  if BufferSize = 0 then Exit;
  Result := Buffer;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure GetFilesList(const Dir, Pattern, Delimiter: string; var FilesList: string; IncludeSubfolders: Boolean = True); overload;
var
  SearchRec: TSearchRec;
begin
  if IncludeSubfolders then
  begin
    if FindFirst(Dir + '\*', faDirectory, SearchRec) = 0 then
    repeat
      if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        GetFilesList(Dir + '\' + SearchRec.Name, Pattern, Delimiter, FilesList, IncludeSubFolders);
    until FindNext(SearchRec) <> 0;

    FindClose(SearchRec);
  end;

  if FindFirst(Dir + '\' + Pattern, faAnyFile xor faDirectory, SearchRec) = 0 then
  repeat
    FilesList := FilesList + Dir + '\' + SearchRec.Name + Delimiter;
  until FindNext(SearchRec) <> 0;

  FindClose(SearchRec);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure GetFilesList(const Dir, Pattern: string; const FilesList: TStringList; IncludeSubfolders: Boolean = True); overload;
var
  SearchRec: TSearchRec;
begin
  if IncludeSubfolders then
  begin
    if FindFirst(Dir + '\*', faDirectory, SearchRec) = 0 then
    repeat
      if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        GetFilesList(Dir + '\' + SearchRec.Name, Pattern, FilesList, IncludeSubFolders);
    until FindNext(SearchRec) <> 0;

    FindClose(SearchRec);
  end;

  if FindFirst(Dir + '\' + Pattern, faAnyFile xor faDirectory, SearchRec) = 0 then
  repeat
    FilesList.Add(Dir + '\' + SearchRec.Name);
  until FindNext(SearchRec) <> 0;

  FindClose(SearchRec);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure GetFilesList(const Dir, Pattern: string; var FilesList: TStringArray; IncludeSubfolders: Boolean = True); overload;
var
  SearchRec: TSearchRec;
  ArrayLength: LongWord;
begin
  if IncludeSubfolders then
  begin
    if FindFirst(Dir + '\*', faDirectory, SearchRec) = 0 then
    repeat
      if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        GetFilesList(Dir + '\' + SearchRec.Name, Pattern, FilesList, IncludeSubFolders);
    until FindNext(SearchRec) <> 0;

    FindClose(SearchRec);
  end;

  if FindFirst(Dir + '\' + Pattern, faAnyFile xor faDirectory, SearchRec) = 0 then
  repeat
    ArrayLength := Length(FilesList);
    SetLength(FilesList, ArrayLength + 1);
    FilesList[ArrayLength] := Dir + '\' + SearchRec.Name;
  until FindNext(SearchRec) <> 0;

  FindClose(SearchRec);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// ������ �������� ����� �� �������� ��������� ����� ������������:
procedure CreatePath(const EndDir: string);
var
  I: LongWord;
  PathLen: LongWord;
  TempPath: string;
begin
  PathLen := Length(EndDir);
  if (EndDir[PathLen] = '\') or (EndDir[PathLen] = '/') then Dec(PathLen);
  TempPath := Copy(EndDir, 0, 3);
  for I := 4 to PathLen do
  begin
    if (EndDir[I] = '\') or (EndDir[I] = '/') then CreateDirectory(PChar(TempPath), nil);
    TempPath := TempPath + EndDir[I];
  end;
  CreateDirectory(PChar(TempPath), nil);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// �������� �������, � ������� ����� ����:
function ExtractFilePath(Path: string): string;
var
  LastDelimiterPos: Integer;
begin
  LastDelimiterPos := LastDelimiter('\/', Path);
  if LastDelimiterPos <> 0 then
    Result := Copy(Path, 1, LastDelimiterPos)
  else
    Result := Path;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// �������� �������, � ������� ����� ����, ��� �����:
function ExtractFileDir(Path: string): string;
var
  LastDelimiterPos: Integer;
begin
  LastDelimiterPos := LastDelimiter('\/', Path);
  if LastDelimiterPos <> 0 then
  begin
    Dec(LastDelimiterPos);
    if LastDelimiterPos > 0 then
      Result := Copy(Path, 1, LastDelimiterPos)
    else
      Result := Path;
  end
  else
  begin
    Result := Path;
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// �������� ��� �����:
function ExtractFileName(Path: string): string;
var
  LastDelimiterPos: Integer;
  PathLen: Integer;
begin
  PathLen := Length(Path);
  LastDelimiterPos := LastDelimiter('\/', Path);
  Result := Copy(Path, LastDelimiterPos + 1, PathLen - LastDelimiterPos);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// ��������� ��� �����:
// http://site.ru/folder/script.php  -->  site.ru
function ExtractHost(Path: string): string;
var
  I: LongWord;
  PathLen: LongWord;
begin
  PathLen := Length(Path);
  I := 8; // ����� "http://"
  while (I <= PathLen) and (Path[I] <> '\') and (Path[I] <> '/') do Inc(I);
  Result := Copy(Path, 8, I - 8);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// ��������� ��� �������:
// http://site.ru/folder/script.php  -->  folder/script.php
function ExtractObject(Path: string): string;
var
  I: LongWord;
  PathLen: LongWord;
begin
  PathLen := Length(Path);
  I := 8;
  while (I <= PathLen) and (Path[I] <> '\') and (Path[I] <> '/') do Inc(I);
  Result := Copy(Path, I + 1, PathLen - I);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



end.
