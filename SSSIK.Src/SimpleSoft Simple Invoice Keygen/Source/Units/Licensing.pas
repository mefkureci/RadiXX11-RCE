unit Licensing;

interface

function GetActivationCode(const EMail: String): String;

implementation

uses
  MD5,
  SysUtils;

//------------------------------------------------------------------------------

function GetActivationCode(const EMail: String): String;
begin
  Result := Copy(MD5ToString(MD5FromString(EMail + '23m0odr32')), 1, 19);
  Result[5] := '-';
  Result[10] := '-';
  Result[15] := '-';
end;

end.
