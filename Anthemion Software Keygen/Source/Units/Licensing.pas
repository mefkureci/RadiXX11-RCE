unit Licensing;

interface

const
  ProductCount = 5;
  ProductList: array[0..ProductCount - 1] of String = (
    'Anthemion Software Writer''s Cafe 2',
    'Anthemion Software Writer''s Cafe 2+',
    'Anthemion Software DialogBlocks',
    'Anthemion Software Jutoh',
    'Anthemion Software HelpBlocks'
  );

function GenerateKey(const Product, Name: String): String;

implementation

uses
  MD5,
  SysUtils;

function GenerateKey(const Product, Name: String): String;
begin
  Result := LowerCase(StringReplace(Name, ' ', '', [rfReplaceAll])) + Product;
  Result := Copy(MD5ToString(MD5FromString(Result), True), 1, 24);
  
  Insert('-', Result, 9);
  Insert('-', Result, 18);
end;

end.
