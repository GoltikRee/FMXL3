unit ValidationTypes;

interface

uses
  SysUtils, Generics.Collections, StringsAPI;

type
  // ���������� � ������ ����� �� JSON'�:
  TValidFileInfo = record
    Size: Integer;
    Hash: string;
    Link: string; // ���� ������������ �������� ������� ����� �� ������� � �� ��������� ������
  end;
  TValidFilesHashmap = TDictionary<string, TValidFileInfo>;

  // ���������� � �����, ������� ����� ��������:
  TAbsentFileInfo = record
    Size: Integer;
    Link: string;
  end;
  TAbsentFilesList = TList<TAbsentFileInfo>;

  // ������ ������ ������:
  TValidFiles = class
    private
      FValidFilesHashmap: TValidFilesHashmap;
    public
      property ValidFilesHashmap: TValidFilesHashmap read FValidFilesHashmap;

      constructor Create;
      destructor Destroy; override;

      procedure Add(const RelativePath: string; const FileInfo: TValidFileInfo);
      function  Get(const RelativePath: string; out   FileInfo: TValidFileInfo): Boolean;
      procedure Clear;
  end;

implementation


{ TValidFiles }

constructor TValidFiles.Create;
begin
  FValidFilesHashmap := TValidFilesHashmap.Create;
  Clear;
end;

destructor TValidFiles.Destroy;
begin
  Clear;
  FreeAndNil(FValidFilesHashmap);
  inherited;
end;

procedure TValidFiles.Add(const RelativePath: string;
  const FileInfo: TValidFileInfo);
var
  FixedPath: string;
begin
  FixedPath := LowerCase(FixSlashes(RelativePath));
  FValidFilesHashmap.Add(FixedPath, FileInfo);
end;

function TValidFiles.Get(const RelativePath: string;
  out FileInfo: TValidFileInfo): Boolean;
var
  FixedPath: string;
begin
  FileInfo.Size := 0;
  FileInfo.Hash := '';
  FileInfo.Link := '';

  FixedPath := LowerCase(FixSlashes(RelativePath));
  Result := FValidFilesHashmap.TryGetValue(FixedPath, FileInfo);
end;

procedure TValidFiles.Clear;
begin
  FValidFilesHashmap.Clear;
end;

end.
