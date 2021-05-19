unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects, FMX.Edit,
  FMX.ScrollBox, FMX.Memo;

type
  TForm2 = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Layout2: TLayout;
    Label2: TLabel;
    Button1: TButton;
    Rectangle2: TRectangle;
    Edit1: TEdit;
    Layout3: TLayout;
    Rectangle3: TRectangle;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure LoadDictClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TSortedWordIndex = record SortedAnagram: UTF8string; Index: array[0..7] of integer; end;  //max 7 anagrm

var
  Form2: TForm2;
  StringDict:TStringList;              //declare dictionary
  SortedWordIndices: array[0..68455] of TSortedWordIndex;  // sorted anagrams  was 74462
  // if this is declared within procedure it becomes 'local' and causes stack overflow

implementation
  uses System.IOUtils;      //placed here (for GetDocumentsName) to avoid clash with TRectangle

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

//procedure TForm2.Button1Click(Sender: TObject);
//begin
//ShowMessage('Hello World');
//end;
function ValidWord(s_in:string; var Index:integer):boolean;    forward;

procedure Try3LtrWords(Letters :string);
var i,j,k,Index,h,LineNum :integer; Temp, Wurds, StLetters :string;

begin
Temp:=''; Wurds:='';
StLetters:=Letters;
Form2.Memo1.TextSettings.WordWrap:= True; //keep all 3 letter words on one line with wrap
LineNum:= Form2.Memo1.Lines.Add(' ');     // create a new line and obtain Line Number
// ----------------------- 3 letter word subsets -------------------------------
i:=Low(StLetters);             // 1 based string on Windows, 0 on Android
  repeat
  begin
  j:=i+1; repeat
          begin
            k:=j+1; repeat
                    begin
                    Temp:= StLetters[i]+StLetters[j]+StLetters[k];
                    if ValidWord(Temp,Index) then    // output as many amagrams as exist
                      begin
                        h:=0;   // first 'anagram' always exists
                        repeat
                         Wurds:=StringDict[SortedWordIndices[Index].Index[h]] +' ';
                         // next line of code is to not enter duplicates that arise from repeated characters
                         if Form2.Memo1.Lines[LineNum].IndexOf(Wurds) = -1  then // not in StringList so add the Wurds
                          Form2.Memo1.Lines[LineNum]:= Form2.Memo1.Lines[LineNum] + Wurds;  // keep all Wurds on same line
                         h:=h+1;
                        until (h=8) or (SortedWordIndices[Index].Index[h]=0);
                       end;
                    end;
                    inc(k);
                    until k > High(StLetters);
          end; inc(j);
          until j > High(StLetters)-1;
  end; inc(i);
  until i > High(StLetters)-2;
// ---------------------- endof 3 letter word subsets --------------------------
end;

procedure Try4LtrWords(Letters:string);
var  i,j,k,l,Index,h,LineNum :integer; Temp, Wurds, StLetters :string;
begin
Temp:=''; Wurds:='';
StLetters:=Letters;
Form2.Memo1.TextSettings.WordWrap:= True; //keep all 3 letter words on one line with wrap
LineNum:= Form2.Memo1.Lines.Add(' ');     // create a new line and obtain Line Number
// ----------------------- 4 letter word subsets -------------------------------
i:=Low(StLetters);
  repeat
  begin
  j:=i+1; repeat
           begin
            k:=j+1; repeat
                     Begin
                     l:=k+1;repeat
                              begin
                                Temp:= StLetters[i]+StLetters[j]+StLetters[k]+StLetters[l];
                                if ValidWord(Temp,Index) then    // output as many amagrams as exist
                                begin
                                  h:=0;   // first 'anagram' always exists
                                  repeat
                                   Wurds:=StringDict[SortedWordIndices[Index].Index[h]] +' ';
                                   // next line of code is to not enter duplicates that arise from repeated characters
                                   if Form2.Memo1.Lines[LineNum].IndexOf(Wurds) = -1  then // not in StringList so add the Wurds
                                   Form2.Memo1.Lines[LineNum]:= Form2.Memo1.Lines[LineNum] + Wurds;  // keep all Wurds on same line
                                   h:=h+1;
                                  until (h=8) or (SortedWordIndices[Index].Index[h]=0);
                                end;
                              end; inc(l);
                            until l >High(StLetters);
                     End; inc(k);
                    until k > High(StLetters)-1;
           end; inc(j);
          until j > High(StLetters)-2;
  end; inc(i);
  until i > High(StLetters)-3;
end;

procedure Try5LtrWords(Letters:string);
var  i,j,k,l,m,Index,h,LineNum :integer; Temp, Wurds, StLetters :string;
begin
Temp:=''; Wurds:='';
StLetters:=Letters;
Form2.Memo1.TextSettings.WordWrap:= True; //keep all 5 letter words on one line with wrap
LineNum:= Form2.Memo1.Lines.Add(' ');     // create a new line and obtain Line Number
// ----------------------- 5 letter word subsets -------------------------------
i:=Low(StLetters);
  repeat
  begin
  j:=i+1; repeat
           begin
            k:=j+1; repeat
                     Begin
                     l:=k+1;repeat
                              begin
                              m:=l+1; repeat
                                      begin
                                       Temp:= StLetters[i]+StLetters[j]+StLetters[k]+StLetters[l]+StLetters[m];
                                       if ValidWord(Temp,Index) then    // output as many amagrams as exist
                                       begin
                                        h:=0;   // first 'anagram' always exists
                                        repeat
                                         Wurds:=StringDict[SortedWordIndices[Index].Index[h]] +' ';
                                         // next line of code is to not enter duplicates that arise from repeated characters
                                         if Form2.Memo1.Lines[LineNum].IndexOf(Wurds) = -1  then // not in StringList so add the Wurds
                                         Form2.Memo1.Lines[LineNum]:= Form2.Memo1.Lines[LineNum] + Wurds;  // keep all Wurds on same line
                                         h:=h+1;
                                        until (h=8) or (SortedWordIndices[Index].Index[h]=0);
                                       end; //inc(m);
                                      end;  inc(m);
                                      until m > High(StLetters);
                              end; inc(l);
                            until l >High(StLetters) -1;
                     End; inc(k);
                    until k > High(StLetters)-2;
           end; inc(j);
          until j > High(StLetters)-3;
  end; inc(i);
  until i > High(StLetters)-4;
end;

procedure Try6LtrWords(Letters:string);
var  i,j,k,l,m,n,Index,h,LineNum :integer; Temp, Wurds, StLetters :string;
begin
Temp:=''; Wurds:='';
StLetters:=Letters;
Form2.Memo1.TextSettings.WordWrap:= True; //keep all 6 letter words on one line with wrap
LineNum:= Form2.Memo1.Lines.Add(' ');     // create a new line and obtain Line Number
// ----------------------- 6 letter word subsets -------------------------------
i:=Low(StLetters);
  repeat
   begin
  j:=i+1; repeat
           begin
            k:=j+1; repeat
                     Begin
                     l:=k+1;repeat
                              begin
                              m:=l+1; repeat
                                       begin
                                       n:=m+1; repeat
                                                begin
                                                Temp:= StLetters[i]+StLetters[j]+StLetters[k]+StLetters[l]+StLetters[m]+StLetters[n];
                                                if ValidWord(Temp,Index) then    // output as many amagrams as exist
                                                begin
                                                h:=0;   // first 'anagram' always exists
                                                repeat
                                                 Wurds:=StringDict[SortedWordIndices[Index].Index[h]] +' ';
                                                 // next line of code is to not enter duplicates that arise from repeated characters
                                                 if Form2.Memo1.Lines[LineNum].IndexOf(Wurds) = -1  then // not in StringList so add the Wurds
                                                 Form2.Memo1.Lines[LineNum]:= Form2.Memo1.Lines[LineNum] + Wurds;  // keep all Wurds on same line
                                                 h:=h+1;
                                                until (h=8) or (SortedWordIndices[Index].Index[h]=0);
                                                 end; //inc(n);
                                                end;  inc(n);
                                                until n > High(StLetters);
                                       end; inc(m);
                                      until m > High(StLetters) -1;
                              end; inc(l);
                            until l >High(StLetters) -2;
                     End; inc(k);
                    until k > High(StLetters)-3;
           end; inc(j);
          until j > High(StLetters)-4;
   end; inc(i);
   until i > High(StLetters)-5;
end;

procedure Try7LtrWords(Letters:string);
var  i,j,k,l,m,n,o,Index,h,LineNum :integer; Temp, Wurds, StLetters :string;
begin
Temp:=''; Wurds:='';
StLetters:=Letters;
Form2.Memo1.TextSettings.WordWrap:= True; //keep all 7 letter words on one line with wrap
LineNum:= Form2.Memo1.Lines.Add(' ');     // create a new line and obtain Line Number
// ----------------------- 7 letter word subsets -------------------------------
i:=Low(StLetters);
  repeat
   begin
   j:=i+1; repeat
            begin
            k:=j+1; repeat
                     Begin
                     l:=k+1;repeat
                             begin
                              m:=l+1;repeat
                                      begin
                                      n:=m+1;repeat
                                              begin
                                               o:=n+1;repeat
                                                       begin

                                                       Temp:= StLetters[i]+StLetters[j]+StLetters[k]+StLetters[l]+StLetters[m]+StLetters[n]+StLetters[o];
                                                       if ValidWord(Temp,Index) then    // output as many amagrams as exist
                                                       begin
                                                       h:=0;   // first 'anagram' always exists
                                                       repeat
                                                       Wurds:=StringDict[SortedWordIndices[Index].Index[h]] +' ';
                                                       // next line of code is to not enter duplicates that arise from repeated characters
                                                       if Form2.Memo1.Lines[LineNum].IndexOf(Wurds) = -1  then // not in StringList so add the Wurds
                                                       Form2.Memo1.Lines[LineNum]:= Form2.Memo1.Lines[LineNum] + Wurds;  // keep all Wurds on same line
                                                       h:=h+1;
                                                       until (h=8) or (SortedWordIndices[Index].Index[h]=0);
                                                       end;
                                                        end; inc(o);
                                                       until o > High(StLetters);
                                               end;  inc(n);
                                             until n > High(StLetters) -1;
                                       end; inc(m);
                                      until m > High(StLetters) -2;
                              end; inc(l);
                            until l >High(StLetters) -3;
                     End; inc(k);
                    until k > High(StLetters)-4;
           end; inc(j);
          until j > High(StLetters)-5;
   end; inc(i);
  until i > High(StLetters)-6;
end;

procedure Try8LtrWords(Letters:string);
var  i,j,k,l,m,n,o,p,Index,h,LineNum :integer; Temp, Wurds, StLetters :string;
begin
Temp:=''; Wurds:='';
StLetters:=Letters;
Form2.Memo1.TextSettings.WordWrap:= True; //keep all 8 letter words on one line with wrap
LineNum:= Form2.Memo1.Lines.Add(' ');     // create a new line and obtain Line Number
// ----------------------- 8 letter word subsets -------------------------------
i:=Low(StLetters);
  repeat
   begin
   j:=i+1; repeat
            begin
            k:=j+1; repeat
                     Begin
                     l:=k+1;repeat
                             begin
                              m:=l+1;repeat
                                      begin
                                      n:=m+1;repeat
                                              begin
                                               o:=n+1;repeat
                                                       begin
                                                       p:=o+1;repeat
                                                               begin
                                                                Temp:= StLetters[i]+StLetters[j]+StLetters[k]+StLetters[l]+StLetters[m]+StLetters[n]+StLetters[o]+StLetters[p];
                                                                if ValidWord(Temp,Index) then    // output as many amagrams as exist
                                                                begin
                                                                h:=0;   // first 'anagram' always exists
                                                                repeat
                                                                Wurds:=StringDict[SortedWordIndices[Index].Index[h]] +' ';
                                                                // next line of code is to not enter duplicates that arise from repeated characters
                                                                if Form2.Memo1.Lines[LineNum].IndexOf(Wurds) = -1  then // not in StringList so add the Wurds
                                                                Form2.Memo1.Lines[LineNum]:= Form2.Memo1.Lines[LineNum] + Wurds;  // keep all Wurds on same line
                                                                h:=h+1;
                                                                until (h=8) or (SortedWordIndices[Index].Index[h]=0);
                                                                end;
                                                               end; inc(p);
                                                              until p> High(StLetters);
                                                        end; inc(o);
                                                       until o > High(StLetters) -1;
                                               end;  inc(n);
                                             until n > High(StLetters) -2;
                                       end; inc(m);
                                      until m > High(StLetters) -3;
                              end; inc(l);
                            until l >High(StLetters) -4;
                     End; inc(k);
                    until k > High(StLetters)-5;
           end; inc(j);
          until j > High(StLetters)-6;
   end; inc(i);
  until i > High(StLetters)-7;
end;


procedure mysort(ByteArray: TBytes);
var i, j, min, temp: integer;
begin
for i:=Low(ByteArray) to High(ByteArray) do
   begin
   min:=i;
   for j:=i+1 to High(ByteArray) do
   if ByteArray[j] < ByteArray[min] then min:=j;
   temp:=ByteArray[min]; ByteArray[min]:=ByteArray[i]; ByteArray[i]:=temp
   end ;
end ;

function ValidWord(s_in:string; var Index:integer):boolean;
{string parameter is upto 15 chars long,
 extend to 15 chars with spaces and then do binary chop against Words array}
var
start, middle, endpos, I:integer;
state:(chopping, foundatendpos, foundatmiddle, givenup);
//Words: array of string;                                           //TEMPORARY
begin
for I:= 15-length(s_in) downto 1 do s_in:= s_in + ' ';
ValidWord:=False;    {this is probably redundant, see last line of code}
start:=1; endpos:=68455; state:=chopping;
repeat
  if (endpos = start) or (start > endpos) then
    case SortedWordIndices[endpos].SortedAnagram = s_in of
      true : state:= foundatendpos;
      false: state:=givenup
    end { case}     else
    begin
      middle:= (endpos+start) div 2;
      if s_in < SortedWordIndices[middle].SortedAnagram then endpos:= middle-1 else
        if s_in > SortedWordIndices[middle].SortedAnagram then
          start:= middle + 1
        else state:= foundatmiddle
    end
until state <> chopping;
if state=foundatmiddle then Index:=middle
 else Index:= endpos;

ValidWord:=state in [foundatendpos,foundatmiddle];
end;

procedure TForm2.Button1Click(Sender: TObject);
var Input: string; Temp, Letters: UTF8String; Index:integer;
ByteArray : Tbytes;   I:integer;
begin
  if Form2.Edit1.Text = '' then
   begin Memo1.Lines.Clear; Memo1.Lines.Add('Enter text in letters box ') end
  else if Length(Form2.Edit1.Text) > 15 then
    begin Memo1.Lines.Clear; Memo1.Lines.Add('Letters max number is 15 ') end
  else
  begin
    Input:=Lowercase(Form2.Edit1.Text);   // get rid of uppercase first character
    Input:=TrimLeft(Input);               //trim any leading spaces
    Input:=TrimRight(Input);             // remove any trailing spaces from Android keyboard
    ByteArray:=TEncoding.UTF8.GetBytes(Input);
    mysort(ByteArray);                         // sort letters for Anagram list
    Letters:= TEncoding.UTF8.GetString(ByteArray);  // convert to string
//  ShowMessage(Letters);
    Memo1.Lines.Clear;  Temp:='';
    if ValidWord(Letters,Index) then    // output as many amagrams as exist
    begin
      I:=0;   // first 'anagram' always exists
      repeat
        //Memo1.Lines.Add(StringDict[SortedWordIndices[Index].Index[I]]);
        Temp:=Temp + StringDict[SortedWordIndices[Index].Index[I]] +' ';       // bundle all anagrams onto one line
        I:=I+1;
      until (I=8) or (SortedWordIndices[Index].Index[I]=0);
      Memo1.Lines.Add(Temp);
    end
    else Memo1.Lines.Add('No anagrams found');
//   Memo1.Lines.Add(StringDict[SortedWordIndices[Index].Index[0]]);

    // Now process all the possible subset combinations
    if Length(Form2.Edit1.Text) > 3 then Try3LtrWords(Letters);
    if Length(Form2.Edit1.Text) > 4 then  Try4LtrWords(Letters);
    if Length(Form2.Edit1.Text) > 5 then  Try5LtrWords(Letters);
    if Length(Form2.Edit1.Text) > 6 then  Try6LtrWords(Letters);
    if Length(Form2.Edit1.Text) > 7 then  Try7LtrWords(Letters);
    if Length(Form2.Edit1.Text) > 8 then  Try8LtrWords(Letters);

  end;

  end;

procedure TForm2.LoadDictClick(Sender: TObject);
const MaxWordLen: Integer = 15;
var
Filepath, SWord,OldWord :UTF8String;    //was utf8string
StreamFile : TFileStream;    AnaFile: TextFile;
Ch:byte;
ByteArray : TBytes;
Stch,SortedS,Value : UTF8String;
I,J,NoofWords,CharPos,Index,Number,DictWordIndex: integer;
WordLen: byte;   //8 bit unsigned integer
Row, IndexPos: integer;

begin   // Determine filepath for dictionary.dct file
     {$IFDEF ANDROID}
        FilePath:= Tpath.GetDocumentsPath + PathDelim + 'Dictionary.dct';
     {$ENDIF}
     {$IFDEF WIN32}
        FilePath:= 'Dictionary.dct';
     {$ENDIF}
    StreamFile:=TFileStream.Create(Filepath, fmOpenRead);
    NoofWords:= 74741 + 1; // I added 'a' to Dictionary to avoid binary chop prob.74400 words loaded

    StringDict:=TStringList.Create;  //stringlist to hold all the dictionary words

           Index:=1; Number:=0;

  try      // Read desired words from Dictionary.dct into stringlist
  begin
    For I:= 1 to 6 do StreamFile.ReadBuffer(Ch,1);      // discard 6 header bytes in dictionary.
    for I := 1 to NoofWords do //NoofWords do
      begin
      StreamFile.ReadBuffer(Ch,1); //read length of next word
      WordLen:=Ch;
      if WordLen <= MaxWordLen then
        begin
        SetLength(ByteArray,WordLen);
        StreamFile.ReadBuffer(ByteArray,WordLen);      // read next word into bytearray buffer
        Stch:= TEncoding.UTF8.GetString(ByteArray);      // convert to string
        StringDict.Add(Stch);                          // add to StringList
//        mysort(ByteArray);                         // sort letters for Anagram list        | NOT
//        SortedS:= TEncoding.UTF8.GetString(ByteArray);  // convert to string               | NEEDED
        Index:=Index+1;                                                                //  | YET
        end
        else For CharPos :=1 to WordLen do StreamFile.ReadBuffer(Ch,1);// discard word as it's too big
      end;
  end;
  finally
    StreamFile.Free; // ShowMessage(InttoStr(Number));
  end;
  Memo1.Lines.Add('Dictionary V1.0 Loaded ok');
//  Memo1.Lines.Add(StringDict[74400]);                   // to check can read from StringList on Android.

// Read Anagram sorted list into 15 char space filled array.
// File format is sorted word, number of chars in word, index into dictionary.dct
// Reading from text file 3 items per line, space delimited, so use readln.
{$IFDEF ANDROID}
 FilePath:= Tpath.GetDocumentsPath + PathDelim + 'WordsSorted.txt';
{$ENDIF}
{$IFDEF WIN32}
 FilePath:= 'WordsSorted.txt';
{$ENDIF}
    AssignFile(AnaFile,FilePath); Reset(AnaFile);         //move this under the TRY???

  try
    begin
      Row:=-1; IndexPos:=0; OldWord:=' ';
     repeat
      readln(Anafile,WordLen,DictWordIndex,SWord);  // SEEM TO HAVE LEADING SPACE ON SWORD
      {$IFDEF WIN32}
      SWord:=TrimLeft(SWord);     //remove leading space
      {$ENDIF}
      {$IFDEF ANDROID}
        Sword:=TrimLeft(SWord);
      {$ENDIF}
      for I:=15 - Length(SWord) downto 1 do SWord:=SWord + ' ';       // spacefill to 15 chars

      if SWord = OldWord then //we have an anagram
      begin
        IndexPos:=IndexPos + 1; // stay on same row, slot in new index ref to Dict StringList
        SortedWordIndices[Row].Index[IndexPos]:=DictWordIndex;
      end
      else  // move down a row  in Table of Anagrams & Indices
      begin
        IndexPos:=0;  Row:=Row+1;
        SortedWordIndices[Row].SortedAnagram:=SWord;   //what about space filling to 15?
        SortedWordIndices[Row].Index[IndexPos]:=DictWordIndex;
        OldWord:=SWord;  //ShowMessage(InttoStr(Length(SWord)) + ' |' +SWord +'|');
      end;
      until eof(Anafile);
    end;
  finally
    CloseFile(AnaFile);
  end;
//  ShowMessage('Number of rows ' + InttoStr(Row));

end;

end.
