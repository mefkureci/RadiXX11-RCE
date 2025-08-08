unit License;

interface

type
  TProductInfo = record
    Name: String;
    Data: String;
  end;

const
  ProductList: array[0..7] of TProductInfo = (
    (
      Name: 'AD Audio Recorder';
      Data: 'ADAR';
    ),
    (
      Name: 'AD MP3 Cutter';
      Data: 'ADMP3C';
    ),
    (
      Name: 'AD Sound Tools';
      Data: 'ADST';
    ),
    (
      Name: 'AD Sound Recorder';
      Data:
        '12971397146115561612240724342503297631563347348736013930410541184356436344014543'+
        '45584852498249935186537756545691579758975971613063176323638165566697675073837609'+
        '7715784679298160886789859287937797409982-'+
        '11577171321275215397156634388425657405782662106601269129613428912864392976152334'+
        '31296719563215798652331076063634086232383613335510361379210936824297574137188610'+
        '43422712314576195302479497422348663928845488323045557664953157059149865742793638'+
        '58432962805916854666592877778262397339516354493062644734878564706496856843086169'+
        '71379820507408689513759010083177123027127803659454783839430878732034068100684409'+
        '85520810978575123438869297328887287061269211123348937410940695073629919633769196'+
        '97550665449932579398';
    ),
    (
      Name: 'AD Stereo Changer';
      Data:
        '10341480157516582028226525962735294431723196340935113808399742654569461547914835'+
        '52385682584966416686703770437093733473517398754176397744776277757887798080528106'+
        '8197832584628771892289479393976898539942-'+
        '12235364861517517785164792501624422716312453418468258613118629266330002995371926'+
        '31040080573105696798323192775233346420703463578617377350003939619894634159237008'+
        '42015548094250839857463054343847095586495128442399558264788355947126325622971485'+
        '58391079845916293114597987423661310274886133705762648528028267011038596782761295'+
        '72076135487312684440744187683475154492067531801001778163229478067067298387567862'+
        '86141223308793518206880904696989218348829346025534944354809595900625269683174945'+
        '98869149219940493063';
    ),
    (
      Name: 'AD Stream Recorder';
      Data:
        '10141530154216861941196622032219225624002759312431533201327532843303331933703389'+
        '35113520355838684336440145344627497853605710591959786043682968746892713673847521'+
        '7605778781498329872789289108919894579811-'+
        '12223648931270287066130530484125985451822631440264276246139927906388742931377392'+
        '31020349653295791575378335565938426554163858899737390827994039750316604224548141'+
        '44356963014736102958497217136049959830485177857047531294996753828466745637988746'+
        '57701446115833220750590627292262780338736751510988684565062969642779296971848904'+
        '72071702417279800735729554001677721881097785709066788591518378896169248127366835'+
        '81657135598402192109864069979587613342109274566738966105224697119704679732086725'+
        '98749186279977903809';
    ),
    (
      Name: 'Dual Audio Recorder';
      Data: 'ADDAR';
    ),
    (
      Name: 'Steady Recorder';
      Data: '1238-1114858741';
    )
  );

function GenerateKey(const ProductInfo: TProductInfo): String;
  
implementation

uses
  Windows,
  Classes,
  Graphics,
  SysUtils;
  
//------------------------------------------------------------------------------

const
  Charset: PChar = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

//------------------------------------------------------------------------------

function CharToIndex(C: Char): Byte;
var
  I: Byte;
begin
  for I := 0 to 35 do
  begin
    if Charset[I] = C then
    begin
      Result := I;
      Exit;
    end;
  end;

  Result := 35;
end;

//------------------------------------------------------------------------------

function IndexToChar(Index: Byte): Char;
begin
  if Index > 35 then
    Index := 35;

  Result := Charset[Index];
end;

//------------------------------------------------------------------------------

function RandomChar: Char;
begin
  Result := Charset[Random(36)];
end;

//------------------------------------------------------------------------------

function StrFromColor(Color: LongWord): String;
begin
  Result := IndexToChar(Color) + IndexToChar(Color shr 8) + IndexToChar(Color shr 16);
end;

//------------------------------------------------------------------------------

function GenerateKey(const ProductInfo: TProductInfo): String;
var
  Stream: TResourceStream;
  Bitmap: TBitmap;
  S1, S2: String;
  I: Integer;
begin
  // Determine if the app uses a key algorithm or just a hardcoded serial.
  // The presence of a character '-' indicates that a hardcoded serial is used.
  I := Pos('-', ProductInfo.Data);

  if I = 0 then
  begin
    // The app uses a key algorithm, Data contains the resource name for the
    // pixel data.
    try
      // Load resource data with pixel info for the algorithm.
      Stream := TResourceStream.Create(HInstance, ProductInfo.Data, RT_RCDATA);
      Bitmap := TBitmap.Create;

      try
        // Load first bitmap.
        Bitmap.LoadFromStream(Stream);

        SetLength(Result, 20);
        Result[1] := RandomChar;
        Result[2] := RandomChar;
        S1 := StrFromColor(Bitmap.Canvas.Pixels[CharToIndex(Result[1]), CharToIndex(Result[2])]);
        Result[3] := S1[1];
        Result[4] := S1[2];
        Result[5] := S1[3];

        // Load second bitmap.
        Bitmap.FreeImage;
        Bitmap.LoadFromStream(Stream);

        Result[6] := RandomChar;
        Result[7] := RandomChar;
        S1 := StrFromColor(Bitmap.Canvas.Pixels[CharToIndex(Result[6]), CharToIndex(Result[7])]);
        Result[8] := S1[1];
        Result[9] := S1[2];
        Result[10] := S1[3];

        // Load third bitmap.
        Bitmap.FreeImage;
        Bitmap.LoadFromStream(Stream);

        Result[11] := RandomChar;
        Result[12] := RandomChar;
        S1 := StrFromColor(Bitmap.Canvas.Pixels[CharToIndex(Result[11]), CharToIndex(Result[12])]);
        Result[13] := S1[1];
        Result[14] := S1[2];
        Result[15] := S1[3];

        // Load fourth bitmap.
        Bitmap.FreeImage;
        Bitmap.LoadFromStream(Stream);

        Result[16] := RandomChar;
        Result[17] := RandomChar;
        S1 := StrFromColor(Bitmap.Canvas.Pixels[CharToIndex(Result[16]), CharToIndex(Result[17])]);
        Result[18] := S1[1];
        Result[19] := S1[2];
        Result[20] := S1[3];

        // Format result key.
        Insert('-', Result, 6);
        Insert('-', Result, 12);
        Insert('-', Result, 18);

      finally
        if Assigned(Bitmap) then
          Bitmap.Free;

        if Assigned(Stream) then
          Stream.Free;
      end;
    except
      Result := '';
    end;
  end
  else
  begin
    // The app check for hardcoded serials. Data contains two groups of digits
    // to make the key, both separated by the character '-':
    // - From the first group, we must take 4 digits
    // - From the second group, we must take 10 digits

    S1 := Copy(ProductInfo.Data, 1, I - 1);
    S2 := Copy(ProductInfo.Data, I + 1, MaxInt);
    Result := Copy(S1, (Random(Length(S1) div 4) * 4) + 1, 4) + '-' +
              Copy(S2, (Random(Length(S2) div 10) * 10) + 1, 10);
  end;
end;

end.
 