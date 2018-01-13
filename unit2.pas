unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  vars;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    bh_g: TEdit;
    Button3: TButton;
    Label10: TLabel;
    Label11: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ToggleBox1: TToggleBox;
    usk_upr: TEdit;
    vec_x: TEdit;
    vec_y: TEdit;
    cor_x: TEdit;
    cor_y: TEdit;
    bh_cor_y: TEdit;
    bh_cor_x: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    uprug: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure file_test;
    procedure ToggleBox1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;
  f1:textfile;

implementation

{$R *.lfm}

{ TForm2 }

procedure Tform2.file_test;
var s:string;
begin
  if fileexists('options.txt') then
    begin
      assignfile(f1,'options.txt');
      reset(f1);

      readln(f1,s);
      circle1.px:=strtofloat(s);

      readln(f1,s);
      circle1.py:=strtofloat(s);

      readln(f1,s);
      vars.circle1.vx:=strtofloat(s);

      readln(f1,s);
      vars.circle1.vy:=strtofloat(s);

      readln(f1,s);
      vars.circle1.uprug:=strtofloat(s);

      readln(f1,s);
      vars.usk_upr:=strtofloat(s);

      readln(f1,s);
      vars.bhx:=strtofloat(s);

      readln(f1,s);
      vars.bhy:=strtofloat(s);

      readln(f1,s);
      vars.bhg:=strtofloat(s);

      readln(f1,s);
      if s='1' then
        vars.loop_world:=true
      else vars.loop_world:=false;

      readln(f1,s);
      if s='1' then
        vars.trail:=true
      else vars.trail:=false;

      closefile(f1);
    end
  else
    begin
      vars.g:=0;
      vars.zamedl:=0;
      vars.usk_upr:=0.2;
      //vars.circle1.shape_1:=form1.shape1;
      vars.circle1.py:=100;
      vars.circle1.px:=100;
      vars.circle1.uprug:=1;
      assignfile(f1,'options.txt');
      rewrite(f1);
      s:=floattostr(vars.circle1.px);
      writeln(f1,s);
      s:=floattostr(vars.circle1.py);
      writeln(f1,s);
      s:=floattostr(vars.circle1.vx);
      writeln(f1,s);
      s:=floattostr(vars.circle1.vy);
      writeln(f1,s);
      s:=floattostr(vars.circle1.uprug);
      writeln(f1,s);
      s:=floattostr(vars.usk_upr);
      writeln(f1,s);
      s:=floattostr(vars.bhx);
      writeln(f1,s);
      s:=floattostr(vars.bhy);
      writeln(f1,s);
      s:=floattostr(vars.bhg);
      writeln(f1,s);
      closefile(f1);
    end;

end;

procedure TForm2.ToggleBox1Change(Sender: TObject);
begin
  if vars.loop_world then
    vars.loop_world:=false
  else vars.loop_world:=true;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  cor_x.Text:=floattostr(vars.circle1.px);
  cor_y.Text:=floattostr(vars.circle1.py);
  vec_x.text:=floattostr(vars.circle1.vx);
  vec_y.Text:=floattostr(vars.circle1.vy);
  uprug.text:=floattostr(vars.circle1.uprug);
  usk_upr.Text:=floattostr(vars.usk_upr);
  bh_cor_x.Text:=floattostr(vars.bhx);
  bh_cor_y.text:=floattostr(vars.bhy);
  bh_g.Text:=floattostr(vars.bhg);

end;

procedure TForm2.Button1Click(Sender: TObject);
var s:string;
begin
  vars.circle1.px:=strtofloat(cor_x.text);
  vars.circle1.py:=strtofloat(cor_y.text);
  vars.circle1.vx:=strtofloat(vec_x.text);
  vars.circle1.vy:=strtofloat(vec_y.text);
  vars.circle1.uprug:=strtofloat(uprug.Text);
  vars.usk_upr:=strtofloat(usk_upr.text);
  vars.bhx:=strtofloat(bh_cor_x.text);
  vars.bhy:=strtofloat(bh_cor_y.text);
  vars.bhg:=strtofloat(bh_g.text);

  assignfile(f1,'options.txt');
  rewrite(f1);
  s:=floattostr(vars.circle1.px);
  writeln(f1,s);
  s:=floattostr(vars.circle1.py);
  writeln(f1,s);
  s:=floattostr(vars.circle1.vx);
  writeln(f1,s);
  s:=floattostr(vars.circle1.vy);
  writeln(f1,s);
  s:=floattostr(vars.circle1.uprug);
  writeln(f1,s);
  s:=floattostr(vars.usk_upr);
  writeln(f1,s);
  s:=floattostr(vars.bhx);
  writeln(f1,s);
  s:=floattostr(vars.bhy);
  writeln(f1,s);
  s:=floattostr(vars.bhg);
  writeln(f1,s);
  if vars.loop_world then
    writeln(f1,'1')
  else writeln(f1,'0');
  if vars.trail then
    writeln(f1,'1')
  else writeln(f1,'0');

  closefile(f1);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin

end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  if vars.trail then
     vars.trail:=false
  else
     vars.trail:=true;
end;

end.

