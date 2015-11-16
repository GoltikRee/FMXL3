unit TimeManagement;

interface

uses
  Windows;
  
function NtQueryPerformanceCounter(Counter, Frequency: PInt64): LongWord; stdcall; external 'ntdll.dll';
function NtDelayExecution(Alertable: Boolean; Delay: PInt64): LongWord; stdcall; external 'ntdll.dll';

{$DEFINE USE_ASM_SLEEP} // ������������ ������������ ���������� MicroSleep [TSC]

procedure DelayExecution(Delay: Int64); stdcall; // NtDelayExecution, 100-������������� ���������
procedure MicroSleep(Delay: Int64); overload; // ������� �� NtQueryPerformanceCounter (�������� � �������������)
procedure MicroSleep(Delay: Double); overload; // ������� �� TSC (�������� � ��������)

var RDTSC      : function: UInt64; register;
var GetLowTSC  : function: LongWord;
var GetHighTSC : function: LongWord;
var GetTimer   : function: Double; // ���������� ����� � ������� ���������� ������ �� � ��������

function GetTSCBasedFrequency(Delay: Int64 = 10000): Double;
procedure UpdateTSCFrequency(AveragingCoeff: Integer = 1);

implementation

var
  WorkingFrequency: Double = 0; // ������� TSC

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure DelayExecution(Delay: Int64); stdcall;
begin
  Delay := -1 * Delay;
  NtDelayExecution(False, @Delay);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Delay � �������������:
procedure MicroSleep(Delay: Int64); overload;
var
  Counter, Frequency: Int64;
  Delta, BorderValue: Int64;
begin
  NtQueryPerformanceCounter(@Counter, @Frequency);
  Delta := (Delay * Frequency) div 1000000;
  BorderValue := Counter + Delta;
  while BorderValue > Counter do NtQueryPerformanceCounter(@Counter, nil);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Delay � ��������:
procedure MicroSleep(Delay: Double); overload;
{$IFNDEF USE_ASM_SLEEP}
var
  InitialValue: Double;
begin
  InitialValue := GetTimer;
  while (GetTimer - InitialValue) < Delay do
end;
{$ELSE}
asm
{$IFDEF CPUX64}
  movsd xmm1, xmm0 // Delay ��������� � XMM0

  call GetTimer
  movsd xmm2, xmm0 // InitialValue (XMM2) := GetTimer (XMM0);

@SleepingLoop:
  call GetTimer      // --+
  subsd xmm0, xmm2   // --+--> while (GetTimer - InitialValue) < Delay do
  comisd xmm0, xmm1  // --+
  jb @SleepingLoop

{$ELSE}
  // ������� � ���� InitialValue:
  call GetTimer

@SleepingLoop:
  // st(0) = CurrentTimer
  // st(1) = InitialValue
  // esp+8 = Delay

  call GetTimer           // --+
  fsub st(0), st(1)       // --+--> while (GetTimer - InitialValue) < Delay do
  fcomp qword ptr [esp+8] // --+

  // ������� ����� ���������:
  fstsw ax
  sahf

  jb @SleepingLoop

  fstp st(0)
{$ENDIF}
end;
{$ENDIF}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function _RDTSC: UInt64; register;
asm
  rdtsc
{$IFDEF CPUX64}
  shl rdx, 32
  or rax, rdx
{$ENDIF}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function _RDTSCP: UInt64; register;
asm
  db $0F, $01, $F9 // rdtscp
{$IFDEF CPUX64}
  shl rdx, 32
  or rax, rdx
{$ENDIF}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function _GetLowTSC: LongWord;
asm
  rdtsc
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function _GetLowTSCP: LongWord;
asm
  db $0F, $01, $F9 // rdtscp
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function _GetHighTSC: LongWord;
asm
  rdtsc
{$IFDEF CPUX64}
  mov rax, rdx
{$ELSE}
  mov eax, edx
{$ENDIF}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function _GetHighTSCP: LongWord;
asm
  db $0F, $01, $F9 // rdtscp
{$IFDEF CPUX64}
  mov rax, rdx
{$ELSE}
  mov eax, edx
{$ENDIF}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function _GetTimerTSC: Double; // ��������� � st(0) ��� �32 � � XMM0 ��� �64
asm
{$IFDEF CPUX64}
  rdtsc
  shl rdx, 32
  or rax, rdx

  // Result := RDTSC / WorkingFrequency
  cvtsi2sd xmm0, rax
  divsd xmm0, qword ptr [WorkingFrequency]
{$ELSE}
  rdtsc
  mov dword [esp-8], eax // LowTSC
  mov dword [esp-4], edx // HighTSC

  // Result := RDTSC / WorkingFrequency
  fild qword ptr [esp-8]
  fld qword ptr [WorkingFrequency]
  fdivp
{$ENDIF}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function _GetTimerTSCP: Double; // ��������� � st(0) ��� �32 � � XMM0 ��� �64
asm
{$IFDEF CPUX64}
  db $0F, $01, $F9 // rdtscp
  shl rdx, 32
  or rax, rdx

  // Result := RDTSC / WorkingFrequency
  cvtsi2sd xmm0, rax
  divsd xmm0, qword ptr [WorkingFrequency]
{$ELSE}
  db $0F, $01, $F9 // rdtscp
  mov dword [esp-8], eax // LowTSC
  mov dword [esp-4], edx // HighTSC

  // Result := RDTSC / WorkingFrequency
  fild qword ptr [esp-8]
  fld qword ptr [WorkingFrequency]
  fdivp
{$ENDIF}
end;


//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH


function GetTSCBasedFrequency(Delay: Int64): Double;
var
  OldPriorityClass, OldPriority: Integer;
  InitialTSC: UInt64;
begin
  OldPriorityClass := GetPriorityClass(GetCurrentProcess);
  OldPriority := GetThreadPriority(GetCurrentThread);

  SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);

  InitialTSC := RDTSC;
  MicroSleep(Delay);
  Result := ((RDTSC - InitialTSC) * 1E6) / Delay;

  SetThreadPriority(GetCurrentThread, OldPriority);
  SetPriorityClass(GetCurrentProcess, OldPriorityClass);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure UpdateTSCFrequency(AveragingCoeff: Integer);
var
  I: Integer;
begin
  if AveragingCoeff < 1 then Exit;

// ��������� ������� - ���� ������� ��������������:
  WorkingFrequency := 0.0;
  for I := 0 to AveragingCoeff - 1 do
    WorkingFrequency := WorkingFrequency + GetTscBasedFrequency;

  WorkingFrequency := WorkingFrequency / AveragingCoeff;
end;


//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH


function CPUID(FunctionNumber: LongWord = 0): UInt64; register;
asm
{$IFDEF CPUX64}
  xor rax, rax
  mov eax, ecx
{$ENDIF}
  cpuid
{$IFDEF CPUX64}
  shl rdx, 32
  or rax, rdx
{$ENDIF}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function IsRdtscpPresent: Boolean;
var
  CPUIDValue: UInt64;
begin
  CPUIDValue := CPUID($80000001);
  Result := (CPUIDValue and $800000000000000) <> 0; // 27� ��� � ������� ����� EDX:EAX
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

initialization
  if IsRdtscpPresent then
  begin
    RDTSC      := _RDTSCP;
    GetLowTSC  := _GetLowTSCP;
    GetHighTSC := _GetHighTSCP;
    GetTimer   := _GetTimerTSCP;
  end
  else
  begin
    RDTSC      := _RDTSC;
    GetLowTSC  := _GetLowTSC;
    GetHighTSC := _GetHighTSC;
    GetTimer   := _GetTimerTSC;
  end;

  UpdateTSCFrequency(3);

end.
