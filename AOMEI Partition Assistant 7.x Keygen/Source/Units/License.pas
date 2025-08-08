unit License;

interface

type
  TEditionInfo = record
    Name: String;
    Id: String;
    Code: Word;
  end;

const
  EditionList: array[0..3] of TEditionInfo = (
    (
      Name: 'Professional Edition';
      Id: 'AOPR';
      Code: $0157;
    ),
    (
      Name: 'Server Edition';
      Id: 'AOSR';
      Code: $0158;
    ),
    (
      Name: 'Technician Edition';
      Id: 'AOTE';
      Code: $015A;
    ),
    (
      Name: 'Unlimited Edition';
      Id: 'AOUN';
      Code: $0159;
    )
  );

function GenerateRegCode(const EditionInfo: TEditionInfo): String;

implementation

function GenerateRegCode(const EditionInfo: TEditionInfo): String;
const
  Charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
var
  I, K: Integer;
  J: Word;
begin
  repeat
    Result := EditionInfo.Id;
    J := 0;

    for I := 1 to 15 do
    begin
      K := Random(Length(Charset));
      Inc(J, K);
      Result := Result + Charset[K + 1];
    end;
  until J = EditionInfo.Code;

  Insert('-', Result, 5);
  Insert('-', Result, 11);
  Insert('-', Result, 17);
end;

end.
