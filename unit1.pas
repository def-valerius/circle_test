unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Buttons, StdCtrls, Menus, vars, unit2, openal;

type {
{circle}
  Tcircle = object
    px,py,px_2,py_2,v,spd,vx,vy,uprug:double;
    shape_1,shape_2:TShape;
    napr:array[0..3] of boolean;
    procedure move();
    procedure moveshape();

{circle end}

  end;}

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    bh_Shape: TShape;
    Timer1: TTimer;
    sound_timer: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure onkeydown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure onkeyup(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Shape1ChangeBounds(Sender: TObject);
    procedure sound_timerTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

{thread}
  draw = class(Tthread)
  private

  protected
    procedure execute; override;
  public
    constructor create(createSuspended : boolean);
  end;

{thread end}
{const g=0.1;
  usk_upr=0.2;
  zamedl=0; //сопротивление "воздуха" }


var
  Form1: TForm1;
  //circle1,circle2:Tcircle;
  //bhx,bhy,bhg,bh_test:double;

  draw_test:draw;
  uskor1,uskor2,uskor3:double;


  //OpenAl
  buffer : TALuint;
  source : TALuint;
  sourcepos: array [0..2] of TALfloat= ( 0.0, 0.0, 0.0 );
  sourcevel: array [0..2] of TALfloat= ( 0.0, 0.0, 0.0 );
  listenerpos: array [0..2] of TALfloat= ( 0.0, 0.0, 0.0);
  listenervel: array [0..2] of TALfloat= ( 0.0, 0.0, 0.0);
  listenerori: array [0..5] of TALfloat= ( 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
  //another openal vars
  argv: array of PalByte;
  format: TALEnum;
  size: TALSizei;
  freq: TALSizei;
  loop: TALInt;
  data: TALVoid;
  //end of openal vars


implementation

{$R *.lfm}
{draw thread}
constructor draw.Create(createsuspended : boolean);
  begin
    freeonterminate := true;
    inherited Create(CreateSuspended);
  end;
{end draw}

 {
{circle}
procedure Tcircle.move();
begin

  //изменение вектора от управления (WASD)
  if napr[0] then
     vy:=vy+vars.usk_upr;
  if napr[1] then
     vy:=vy-vars.usk_upr;
  if napr[2] then
     vx:=vx-vars.usk_upr;
  if napr[3] then
     vx:=vx+vars.usk_upr;
  //изменение позиции
  px:=px+vx;
  py:=py-vy;
  //сопротивление "воздуха"
  if vy>0 then
    vy:=vy-(vy*vars.zamedl)
  else
    vy:=vy-(vy*vars.zamedl);
  if vx>0 then
    vx:=vx-vx*vars.zamedl
  else
    vx:=vx-vx*vars.zamedl;

end;

procedure Tcircle.moveshape();
begin
  shape_2.Top:=round(vars.vars.circle1.py_2);
  Shape_2.Left:=round(vars.circle1.px_2);
  Shape_1.Top:=round(vars.circle1.py);
  Shape_1.Left:=round(vars.circle1.px);

end;

{circle end}
         }
{ TForm1 }

procedure sound_test;
begin
  AlSourcePlay(source);
  form1.sound_timer.Enabled:=true;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  vars.circle1.spd:=5;
  //vars.circle1.v:=4.7123;
  vars.circle1.px:=168;
  vars.circle1.py:=256;
  vars.circle1.shape_1:=form1.shape1;

end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  draw_test.Terminate;
  timer1.Enabled:=false;
  sound_timer.Enabled:=false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  {vars.g:=0;
  vars.zamedl:=0;
  vars.usk_upr:=0.2;
  vars.circle1.shape_1:=form1.shape1;
  vars.circle1.py:=100;
  vars.circle1.px:=100;
  vars.circle1.uprug:=1;}
  vars.circle1.shape_1:=form1.shape1;
  unit2.Form2.file_test;
  draw_test:=draw.create(false);
  //vars.bhg:=1000;
  //openal init
  InitOpenAl;
  AlutInit(nil,argv);
  //
  AlGenBuffers(1, @buffer);
  AlutLoadWavFile('sounds/test.wav', format, data, size, freq, loop);
  AlBufferData(buffer, format, data, size, freq);
  AlutUnloadWav(format, data, size, freq);
  //end of openal
  //test sound
  AlGenSources(1, @source);
  AlSourcei ( source, AL_BUFFER, buffer);
  AlSourcef ( source, AL_PITCH, 1.0 );
  AlSourcef ( source, AL_GAIN, 1.0 );
  AlSourcefv ( source, AL_POSITION, @sourcepos);
  AlSourcefv ( source, AL_VELOCITY, @sourcevel);
  AlSourcei ( source, AL_LOOPING, loop);

  AlListenerfv ( AL_POSITION, @listenerpos);
  AlListenerfv ( AL_VELOCITY, @listenervel);
  AlListenerfv ( AL_ORIENTATION, @listenerori);

  //end of test sound

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  AlDeleteBuffers(1, @buffer);
  AlDeleteSources(1, @source);
  AlutExit();
end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  unit2.form2.show;
end;

procedure TForm1.onkeydown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  label1.Caption:=inttostr(key);
  case key of
    32:begin
         vars.circle1.vx:=0;
         vars.circle1.vy:=0;
       end;
    87:vars.circle1.napr[0]:=true;
    83:vars.circle1.napr[1]:=true;
    65:vars.circle1.napr[2]:=true;
    68:vars.circle1.napr[3]:=true;
  end;
end;

procedure TForm1.onkeyup(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    {32:begin
         vars.circle1.vx:=0;
         vars.circle1.vy:=0;
       end;}
    87:vars.circle1.napr[0]:=false;
    83:vars.circle1.napr[1]:=false;
    65:vars.circle1.napr[2]:=false;
    68:vars.circle1.napr[3]:=false;
  end;
end;

procedure TForm1.Shape1ChangeBounds(Sender: TObject);
begin

end;

procedure TForm1.sound_timerTimer(Sender: TObject);
begin
  sound_timer.Enabled:=false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var bh_dy,bh_dy2,bh_dx,bh_dx2,bh_d:double;
begin
  vars.circle1.move();
  circle2.move();

  //Shape1.Top:=round(vars.circle1.py);
  //shape1.Left:=round(vars.circle1.px);
  //vars.circle1.vy:=vars.circle1.vy-g; //гравитация вниз
  //vars.circle1.vx:=vars.circle1.vx-zamedl;
  //circle2.vy:=circle2.vy-g;



  if vars.loop_world=false then
    begin
  //отражается от стен
  if vars.circle1.py>(form1.Height-20) then
     begin
       vars.circle1.vy:=-vars.circle1.vy*vars.circle1.uprug;
       vars.circle1.py:=vars.circle1.py-15;
     end;
  if vars.circle1.py<0 then
     begin
       vars.circle1.vy:=-vars.circle1.vy*vars.circle1.uprug;
       vars.circle1.py:=vars.circle1.py+15;
     end;

  if vars.circle1.px<0 then
     begin
       vars.circle1.vx:=-vars.circle1.vx*vars.circle1.uprug;
       vars.circle1.px:=vars.circle1.px+15;
     end;
  if vars.circle1.px>(form1.Width-20) then
     begin
       vars.circle1.vx:=-vars.circle1.vx*vars.circle1.uprug;
       vars.circle1.px:=vars.circle1.px-15;

     end;
    end
  else
    begin
  //не отражается от стен (верхняя стена соедина с нижней, првая с левой
  if vars.circle1.py>(form1.Height-20) then
     begin
       vars.circle1.py:=0;
       sound_test();
     end;
  if vars.circle1.py<0 then
     begin
       vars.circle1.py:=form1.Height-20;
       sound_test();
     end;
  if vars.circle1.px<0 then
     begin
       vars.circle1.px:=form1.Width-20;
       sound_test();
     end;
  if vars.circle1.px>(form1.Width-20) then
     begin
       vars.circle1.px:=0;
       sound_test();
     end;

    end;

  label5.Caption:=floattostr(vars.circle1.px);
  label6.Caption:=floattostr(vars.circle1.py);

  label7.Caption:=floattostr(vars.circle1.vx);
  //label7.Width:=150;
  label8.caption:=floattostr(vars.circle1.vy);
  //label8.Width:=150;
  label10.caption:=floattostr(sqrt((vars.circle1.vx*circle1.vx)+(vars.circle1.vy*circle1.vy)));
  //ускорение
  uskor1:=sqrt((vars.circle1.vx*circle1.vx)+(vars.circle1.vy*circle1.vy));

  //гравитация в определённой точке, здесь есть большая ошибка
  if vars.circle1.py>vars.bhy then
    begin
      bh_dy:=vars.circle1.py-bhy;
      bh_dy2:=bh_dy*bh_dy;
    end
  else
    begin
      bh_dy:=bhy-vars.circle1.py;
      bh_dy2:=bh_dy*bh_dy;
    end;
  if vars.circle1.px>bhx then
    begin
      bh_dx:=vars.circle1.px-bhx;
      bh_dx2:=bh_dx*bh_dx;
    end
  else
    begin
      bh_dx:=bhx-vars.circle1.px;
      bh_dx2:=bh_dx*bh_dx;
    end;
  //bh_dy:=vars.circle1.py-bhy;
  //bh_dy2:=bh_dy*bh_dy;
  //bh_dx:=vars.circle1.px-bhx;
  //bh_dx2:=bh_dx*bh_dx;
  bh_test:=bh_dy2+bh_dx2;
  //bh_test:=6.67*(bhg/vars.bh_test);
  if vars.circle1.py>vars.bhy then
    begin
      vars.circle1.vy:=vars.circle1.vy+(6.67*bhg*(bh_dy/bh_test)); //вот эта ошибка и ещё 3
      //vars.circle1.vy:=vars.circle1.vy+(6.67/bh_dy2)*vars.bhg;
      //vars.circle1.vy:=vars.circle1.vy+(6.67*bhg);
    end
  else
    begin
      vars.circle1.vy:=vars.circle1.vy-(6.67*bhg*(bh_dy/bh_test));
      //vars.circle1.vy:=vars.circle1.vy-(6.67/bh_dy2)*vars.bhg;
      //vars.circle1.vy:=vars.circle1.vy-(6.67*bhg);
    end;
  if vars.circle1.px>vars.bhx then
    begin
      vars.circle1.vx:=vars.circle1.vx-(6.67*bhg*(bh_dx/bh_test));
      //vars.circle1.vx:=vars.circle1.vx-(6.67/bh_dx2)*vars.bhg;
      //vars.circle1.vx:=vars.circle1.vx-(6.67*bhg);
    end
  else
    begin
      vars.circle1.vx:=vars.circle1.vx+(6.67*bhg*(bh_dx/bh_test));
      //vars.circle1.vx:=vars.circle1.vx+(6.67/bh_dx2)*vars.bhg;
      //vars.circle1.vx:=vars.circle1.vx+(6.67*bhg);
    end;
  //конец гравитации в точке
  {uskor2:=sqrt((vars.circle1.vx*circle1.vx)+(vars.circle1.vy*circle1.vy));
  if uskor1>uskor2 then
    begin
      uskor3:=uskor3-(uskor1-uskor2);
    end
  else
    begin
      uskor3:=uskor3+(uskor2-uskor1);
    end;
  label11.Caption:=floattostr(uskor3); }

end;

procedure draw.execute;
begin
  while true do
    begin
      with form1 do
        begin
          vars.circle1.moveshape();
          //circle2.moveshape();
          if shape3.Left<0 then
            begin
              shape3.Left:=1;
              image1.Width:=form1.Width;
              image1.Refresh;
            end
          else
            begin
              shape3.left:=-1;
              image1.height:=form1.height;
              image1.Refresh;
            end;
          bh_shape.Left:=round(vars.bhx);
          bh_shape.top:=round(vars.bhy);
          sleep(1);
        end;
    end;
end;


end.

