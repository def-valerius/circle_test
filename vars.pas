unit vars;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls;
{const g=0.1;   //гравитация вниз
  usk_upr=0.2; //ускорение в управлении
  zamedl=0; //сопротивление "воздуха"    }

type
{circle}
  Tcircle = object
    px,py,px_2,py_2,v,spd,vx,vy,uprug:double;
    shape_1,shape_2:TShape;
    napr:array[0..3] of boolean;
    procedure move();
    procedure moveshape();

{circle end}

end;


var bhx, //"черная дыра X
    bhy,              //Y
    bhg,              //гравитация этой дыры
    bh_test:          //вспомогательная переменная
    double;           //ну и всё в double, почему бы и нет?
    circle1,circle2:Tcircle;
    g,          //гравитация вниз
    usk_upr,    //ускорение в управлении
    zamedl:     //сопротивление "воздуха"
    double;
    loop_world:boolean; //залупить мир?
    trail:boolean; //хвост за точкой

implementation

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
    vy:=vy-(vy*zamedl)
  else
    vy:=vy-(vy*zamedl);
  if vx>0 then
    vx:=vx-vx*zamedl
  else
    vx:=vx-vx*zamedl;

end;

procedure Tcircle.moveshape();
begin
  Shape_1.Top:=round(py)-16;
  Shape_1.Left:=round(px)-16;
end;

{circle end}


end.

