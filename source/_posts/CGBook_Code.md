---
title: 计算机图形学（OpenGL版）书中代码
tags: [图形学]
categories: 图形学
---
本处代码主要为各章中除章节末的编程实例之外的有关代码，现全部贴出以飨读者。

## 第3章 二维图形生成
### 3.1 直线生成算法
#### 3.1.1 数值微分法
```
void LineDDA(int x1, int y1, int x2, int y2, int color)
{
    int dm=0; 
    if (abs(x2-x1)>= abs(y2-y1) 	//abs是求绝对值的函数
        dm=abs(x2-x1);	//x为计长方向
    else
        dm=abs(y2-y1); 	//y为计长方向
    float dx=(float)(x2-x1)/dm;	//当x为计长方向时，dx的值为1
    float dy=(float)(y2-y1)/dm;	//当y为计长方向时，dy的值为1
    float x=x1+0.5;
    float y=y1+0.5;
    for (int i=0; i< dm; i++)
    {
        setpixel( (int)x, (int)y, color);  
        x+=dx;
        y+=dy;
    }
}
```
#### 3.1.2 逐点比较法
```
void PrintLine(int x1, int y1, int x2, int y2, int color)
{
    int x, y, xA, yA;
    if (y1>y2)	//平移直线的坐标，使y值较小的点位于坐标原点
    { yA=y1-y2; xA=x1-x2; }
    else
    {yA=y2-y1; xA=x2-x1; }
    int F=x=y=0;
    int n=abs(xA)+abs(yA);
    for (int i=0; i<n; i++) {
            if (xA>0) {	//如果斜率为正
        if (F>=0)  {x++; F-=yA;}
        else { y++; F+=xA; }
}
else {//如果斜率为负
        if (F>=0)  {y++; F+=xA;}
        else { x--; F+=yA; }
}
if (y1>y2)
        setpixel(x+x2, y+y2, color); 
else 
        setpixel(x+x1, y+y1, color); 
}


```
#### 3.1.3 Bresenham画线法
```
void swap_value (int* a, int* b)
{
    int temp=*a; 
    *a=*b;
    *b=temp;
}
void Bres_Line(int x1, int y1, int x2, int y2, int color)
{
    setpixel(x1,y1, color);
    int dx=abs(x2-x1);
    int dy=abs(y2-y1);
    if (dx==0&&dy==0)
        return; 
    int flag=0;
    if (dx<dy)         	//下面将斜率变换至0≤|k|≤1区间
    {
        flag=1;
        swap_value(&x1, &y1);
        swap_value(&x2, &y2);
        swap_value(&dx, &dy);
    }
    int tx=(x2-x1)>0 ? 1:-1;
    int ty=(y2-y1)>0 ? 1: -1;
    int curx=x1;
    int cury=y1;
    int dS=2*dy;
    int dT=2*(dy-dx);
    int d=dS-dx; 
    while (curx!=x2)
    {
        if (d<0) 
            d+=dS;
        else
        {cury+=ty;  d+=dT; }

        if (flag)
            setpixel(cury, curx, color);  
        else 
            setpixel(curx, cury, color);
        curx+=tx;
    }
}

```

#### 3.1.4 中点画线法
```
void MidPLine(int x0, int y0, int x1, int y1, int color)
{
    int a, b,  d, x, y,tag=0;
    if(abs(x1-x0)<abs(y1-y0))	//若斜率的绝对值大于1，将坐标和坐标互换
    {  
        swap(&x0,&y0);  
        swap(&x1,&y1);
        tag=1;
    }
    if(x0>x1)//保证x0<x1
    {   
        swap(&x0,&x1);
        swap(&y0,&y1);
    }
    a=y0-y1;    
    b=x1-x0; 
    d=a+b/2;    
    if(y0<y1)//斜率为正
    {
        x=x0; y=y0;
        setPixel(x, y, 255);
        while (x<x1)
        {    
            if (d<0)       
                {x++; y++; d=d+a+b; }
            else       
                {x++; d+=a;}
            if(tag)//斜率大于1
                setPixel(y, x, color);	//互换
            else
                setPixel(x, y, color);
        }  /* while */
    }
    else//斜率为负(y0>=y1)
    {	
        x=x1;
        y=y1;
        setPixel(x, y, 255);
        while (x>x0)
        {  
            if (d<0)       
                {x--; y++; d=d-a+b; }
            else       
                {x--; d-=a;}
            if(tag)//斜率大于1
                setPixel(y, x, color);	//互换
            else
                setPixel(x, y, color);
        }  /* while */
    }
}

```
### 3.2 圆弧绘制算法
#### 3.2.1 数值微分法
##### 1. Bresenham算法
```
//8路对称
void Cirpot(int x0, int y0, int x, int y, int color)
{
    SetPixel((x0+x), (y0+y), color);
    SetPixel((x0+y), (y0+x), color);
    SetPixel((x0+y), (y0-x), color);
    SetPixel((x0+x), (y0-y), color );
    SetPixel((x0-x), (y0-y), color );
    SetPixel((x0-y), (y0-x), color );
    SetPixel((x0-y), (y0+x), color);
    SetPixel((x0-x), (y0+y), color);
}

void Bres_Circle(int x0, int y0, double r)
{
    int x,y,d;
    x=0;
    y=(int)r;
    d=int(3-2*r);
    while(x<y)
    {
        Cirpot( x0,y0,x,y);
         if(d<0)
             d+=4*x+6;
         else
         {
             d+=4*(x-y)+10;
             y--;
         }
         x++;
    }
    if(x==y)
        Cirpot( x0,y0,x,y);
}

```

##### 2. 中点画圆算法
```
//Cirpot函数与上述Bresenham算法代码中的Cirpot函数相同
void MidPoint_Circle (int x0, int y0, int r, int color)
{
    int x=0;
    int y=r;
    int d=1- r;	//是d=1.25 – r取整后的结果
    Cirpot (x0, y0, x, y, color);
    while ( x<y)
    {
        if (d<0) 
            d+=2*x+3; 
        else 
        {
            d+= 2(x-y) +5;
            y--;
        }
        x++;
        Cirpot ( x0, y0, x, y, color);
    }
}

```
#### 3.2.2 角度离散法绘制圆弧和椭圆弧
```
void Arc_OpenGL(int xc, int yc, double r, double ts, double te)
{
    double pi=3.1415926;
    if (te < ts) 	//当终止角比起始角还小时，则将终止角加上2π
        te += 2*pi;
    double dt = 0.4/r;	//取角度离散值，使其与半径r成反比
    int n=(int)(( te – ts ) / dt + 0.5 );	//确定总步数
    double ta = ts;
    int x = xc + int ( r*cos(ts) );
    int y = yc + int ( r*sin(ts) );
    glBegin(GL_LINE_STRIP);	//如果绘制整圆，选GL_LINE_LOOP更好
    glVertex2f( x, y );
    for(int i=1;i<=n;i++)
    {
        ta+=dt;
        double cost = cos ( ta );
        double sint = sin ( ta );
        x = int ( xc + r * cost );
        y = int ( yc + r * sint );
        glVertex2f ( x, y );
    }
    glEnd();
}

```

#### 3.3.1 种子填充算法
```
//四连通漫水法伪代码
void FloodFill (x, y, newcolor, boundaryColor)
{
     Stack stack;
     stack.Push(Pixel(x, y));	//把种子像素(x,y)推入栈中
     while (! stack.Empty())  	//当栈不空时循环执行以下代码
     {
         pixel=stack.Pop();	//从栈顶弹出一个像素
            //当处理内定义区域时，用if (pixel.Color !=newcolor)判断即可
         if (pixel.Color !=newcolor && pixel.Color !=boundaryColor)
         {
             xx=pixel.x; yy=pixel.y;
            setpixel( xx,  yy,  newcolor, boundaryColor);
            stack. Push ( Pixel (xx-1, yy  )) ;
            stack. Push ( Pixel( xx,  yy+1)); 
            stack. Push ( Pixel (xx+1, yy  )); 
            stack.Push ( Pixel(xx, yy-1));
         }
    }
}

```
## 第5章 二维观察
### 5.3.2 直线裁剪
#### 1. Cohen-Sutherland编码裁剪算法
```
# define LEFT 1
# define RIGHT 2
# define BOTTOM 4
# define TOP 8

void encode(float x, float y, float XL, float XR, float YB, float YT, int* code)
{
    int c = 0;
    if (x<XL)	 c = c|LEFT;
    else if (x>XR)	c = c|RIGHT;
    if (y<YB)		c = c|BOTTOM;
    else if(y>YT)	c = c|TOP;
    *code=c;
    return;
}

void C_S_LineClip(float *x1, float *y1, float *x2, float *y2, float XL,
float XR, float YB, float YT)
{
    int code1,code2,code;
    float x, y;
    encode(x1, y1, XL, XR, YB, YT, &code1);
    encode(x2, y2, XL, XR, YB, YT, &code1);
    while (code1!=0 || code2!=0)
    {
        if ((code1 & code2)!=0)	return;
        code = code1;
        if (code1==0)	code = code2;
        if ((LEFT & code)!=0) {	//线段与左边界相交
            x = XL;
            y = y1+(y2-y1)*(XL-x1)/(x2-x1);
        }
        else if ((RIGHT & code)!=0)	//线段与右边界相交
        {
            x = XR;
            y = y1+(y2-y1)*(XR-x1)/(x2-x1);
        }
        else if ((BOTTOM & code)!=0)	//线段与下边界相交
        {
            y = YB;
            x= x1+(x2-x1)*(YB-y1)/(y2-y1);
        }
        else if ((TOP & code)!=0)	//线段与上边界相交
        {
            y = YT;
            x= x1+(x2-x1)*(YT-y1)/(y2-y1);
        }
        if (code==code1){ 
            *x1 = x;	*y1 = y;
            encode(x, y, XL, XR, YB, YT, &code1);
        }
        else{ 
            *x2 = x;	*y2 = y;
            encode(x, y, XL, XR, YB, YT, &code2);
        }
    }
    return;
    }

```
#### 2．Liang-Barsky参数化裁剪算法
```
//x1,y1,x2,y2为直线端点坐标，XL,XR,YB,YT为窗口边界信息
int L_B_LineClip(float *x1, float *y1, float *x2, float *y2, float XL,float XR, float YB, float YT)
{
    float u1 = 0, u2 = 1, dx = x2 – x1, dy;
    //u1为始点参数，初值0；u2为终点参数，初值1
    if (clipTest(-dx, x1-XL, &u1, &u2)) 	//计算左边界交点参数，更新u1,u2
        if (clipTest(dx, XR-x1, &u1, &u2))	//计算右边界交点参数，更新u1,u2
        {
            dy=y2-y1;
            if(clipTest(-dy, y1-YB, &u1, &u2))	//计算下边界交点参数，更新u1,u2
                if (clipTest(dy, YT-y1, &u1, &u2))//计算上边界交点参数，更新u1,u2
                {
                    if(u2 < 1){
                        *x2 = x1+u2*dx; 	//根据u2计算终点坐标
                        *y2 = y1+u2*dy;
                    }
                    if(u1 > 0){
                        *x1 += u1*dx;   	//根据u1计算始点坐标
                        *y1 += u1*dy;
                    }
                    return 1;
                }
        }
        return 0;
}
int clipTest(float p, float q,float* u1,float* u2)	//计算交点参数
{
    float r;
    int retVal = 1;
    if (p < 0){
        r= q/p;
        if (r>*u2)	 retVal = 0;
        else if (r>*u1)	*u1 = r;
    }
    else if (p > 0){
        r= q/p;
        if (r<*u1)	 retVal = 0;
        else if (r < *u2) *u2 = r;
    }
    else if (q < 0)  retVal = 0;
    return retVal;
}
```

## 第7章 三维对象
### 7.3.5  编程实例——简单实体构建
```
#include <gl/glut.h>  
#include<iostream>
using namespace std;
float	rtri;
float	rquad; 
GLfloat points0[5][3] ={{ 0, 1,  0}, {-1, -1, 1}, { 1, -1, 1}, {	1, -1, -1},{-1, -1,-1}};
GLfloat points1[8][3]={ { 1, 1, -1 }, {-1, 1, -1}, {-1, 1, 1}, { 1, 1, 1},
    { 1, -1, 1 }, {-1, -1, 1}, {-1,-1,-1}, { 1, -1, -1}};
GLfloat Colors0[4][3]={{1,0,0},{0,1,0}, {0,0,1},{1,1,0}};	//四棱锥的颜色
//下行是立方体的颜色
GLfloat Colors1[6][3]={{0,1,0},{1,0.5,0},{1,0,0},{1,1,0},{0,0,1},{1,0,1}};
int vertice0[4][3]={{0,1,2},{0,2,3},{0,3,4},{0,4,1}};	//四棱锥的顶点号序列
//下行是立方体的顶点号序列
int vertice1[6][4]={{0,1,2,3},{4,5,6,7},{3,2,5,4},{7,6,1,0},{2,1,6,5}, {0,3,4,7}};
void InitGL ( GLvoid )    
{
    glShadeModel(GL_SMOOTH);					
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);			
    glClearDepth(1.0f);								
    glEnable(GL_DEPTH_TEST);							
    glDepthFunc(GL_LEQUAL);							
    glEnable ( GL_COLOR_MATERIAL );
    glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
}
void CreatePyramid()
{
    glBegin(GL_TRIANGLES);
    for(int i=0;i<4;i++)
    {
            glColor3fv(Colors0[i]);
            for(int j=0;j<3;j++)
            {
                int VtxId=vertice0[i][j];
                glVertex3fv(points0[VtxId]);
            }
    }
    glEnd();
    glBegin( GL_QUADS); 	//构建底面
    glColor3f(1.0f, 1.0f, 1.0f );
    for(i=0;i<4;i++)
        glVertex3fv(points0[i]);	
    glEnd();
}
void CreateCube()
{
    glBegin(GL_QUADS);	
    for(int i=0;i<6;i++)
    {
        glColor3fv(Colors1[i]);
        for(int j=0;j<4;j++)
        {
            int VtxId=vertice1[i][j];
            glVertex3fv(points1[VtxId]);
        }
    }
    glEnd();						
}
void display ( void )   
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);	
    glLoadIdentity();	
    glPushMatrix();
    glTranslatef(-1.5f,0.0f,-6.0f);	//平移至左侧
    glRotatef(rtri,0.0f,1.0f,0.0f);	//旋转一个角度
    CreatePyramid();	//创建三角塔

    glLoadIdentity();	//将矩阵归一化回原样    
    glTranslatef(1.5f,0.0f,-6.0f);	//平移到右侧
    glRotatef(rquad,1.0f,0.0f,0.0f);	//旋转一个角度
    CreateCube(); 	//创建立方体
    glPopMatrix();
    
    rtri+=0.2f;	//修改三角塔旋转角度
    rquad-=0.15f;	//修改立方体的旋转角度
    glutSwapBuffers ( );  
}
void reshape ( int width , int height )  
{
    if (height==0)									
        height=1;										
    glViewport(0,0,width,height);	
    glMatrixMode(GL_PROJECTION);						
    glLoadIdentity();									
    gluPerspective(45.0f,(GLfloat)width/(GLfloat)height,0.1f,100.0f);
    glMatrixMode(GL_MODELVIEW);							
    glLoadIdentity();									
}
void main ( int argc, char** argv )  
{
    glutInit ( &argc, argv ); 
    glutInitDisplayMode ( GLUT_RGBA | GLUT_DOUBLE ); 
    glutInitWindowSize ( 600, 400 ); 
    glutCreateWindow ( "Pyramid and cube" );
    InitGL();
    glutDisplayFunc ( display ); 
    glutReshapeFunc ( reshape );
    glutIdleFunc ( display );
    glutMainLoop ( );
}
```
### 7.4.2  Hermite曲线
```
class Point  	//点类
{
Double x，y;
Point(double vx， double vy)
{
    This.x=vx;
    This.y=vy;
}
Point operator – (Point p) 	//重载运算符“-”
{
    Return new Point(x-p.x ， y-p.y);
}
}
//在p1和p2之间绘制一条Hermite曲线
//p1-p0为p1处的切线矢量，p3-p2为p2处的切线矢量
//参数区间[0，1]被离散为count份
void HermiteCurve(Point p0，Point p1，Point p2，Point p3，int count)
{
    Point r1，r2;	//切线矢量
    r1 = p1 - p0;	//调用重载-
    r2 = p3 - p2; 
    double t = 0.0;
    dt = 1.0 / count;
    moveto(p1.x，p1.y);	//设置起点
    for(int i=0; i<count+1; i++)
    {
        double tt = t * t;
        double ttt = tt * t;
        double F1，F2，F3，F4;	//调和函数
        F1 = 2 * ttt - 3 * tt + 1;
        F2 = -2 * ttt + 3 * tt;
        F3 = ttt - 2 * tt + t;
        F4 = ttt - tt;
        double x = p1.x * F1 + p2.x * F2 + r1.x * F3 + r2.x * F4;
        double y = p1.y * F1 + p2.y * F2 + r1.y * F3 + r2.y * F4;
        lineto(x，y);
        t+=dt;
    }
}
```

### 7.4.3  Bezier曲线
#### 3．三次Bezier曲线的绘制
```
//绘制由p0，p1，p2，p3确定的Bezier曲线
//参数区间[0，1]被离散为count份
void BezierCurve(Point p0,Point p1,Point p2,Point p3,int count)
{
    double t = 0.0;
    dt = 1.0 / count;
    moveto(p1.x,p1.y);	//设置起点
    for(int i=0; i<count+1; i++)
    {
        double F1,F2,F3,F4,x,y;	//调和函数
        double u = 1.0 – t ;
        F1 = u * u * u ;
        F2 = 3 * t * u * u;
        F3 = 3 * t * t * u;
        F4 = t * t * t;
        x = p0.x * F1 + p1.x * F2 + p2.x * F3 + p3.x * F4;
        y = p0.y * F1 + p1.y * F2 + p2.y * F3 + p3.y * F4;
        lineto(x,y);
          t+=dt;
    }
}
```
#### 4．离散生成Beizer曲线的de Casteljau算法
```
void Casteljau(Point p0,  Point p1,  Point p2,  Point p3) 
{
    double t=0;
    int count=20;
    double dt=1.0/count;
    MoveTo(p0);
    for(int i=0;i<count;i++)
    {
        Point p01,p11,p21,p02,p12,p03;
        p01.x=(1-t)*p0.x+t*p1.x;
        p01.y=(1-t)*p0.y+t*p1.y;

        p11.x=(1-t)*p1.x+t*p2.x;
        p11.y=(1-t)*p1.y+t*p2.y;

        p21.x=(1-t)*p2.x+t*p3.x;
        p21.y=(1-t)*p2.y+t*p3.y;

        p02.x=(1-t)*p01.x+t*p11.x;
        p02.y=(1-t)*p01.y+t*p11.y;

        p12.x=(1-t)*p11.x+t*p21.x;
        p12.y=(1-t)*p11.y+t*p21.y;

        p03.x=(1-t)*p02.x+t*p12.x;
        p03.y=(1-t)*p02.y+t*p12.y;
        dc->LineTo(p03);
        t+=dt;
    }
}
```

## 第8章真实感图形技术
### 8.3.4  OpenGL中的颜色模型
```
#include <GL/glut.h>
void init(void)
{
    glClearColor(1.0,1.0,1.0,0.0);
    glShadeModel(GL_SMOOTH);
}
void triangle(void)
{
    glBegin (GL_TRIANGLES);
    glColor3f (1.0f, 0.0f, 0.0f);   glVertex2f (5.0f,5.0f);
    glColor3f (0.0f, 1.0f, 0.0f);   glVertex2f (25.0f,5.0f);
    glColor3f (0.0f, 0.0f, 1.0f);   glVertex2f (5.0f,25.0f);
    glEnd ();

    glBegin (GL_TRIANGLES);
    glColor3f (1.0f, 1.0f, 0.0f);   glVertex2f (26.0f,25.0f);
    glColor3f (0.0f, 1.0f, 1.0f);   glVertex2f (26.0f,5.0f);
    glColor3f (1.0f, 0.0f, 1.0f);   glVertex2f (6.0f,25.0f);
    glEnd ();
}

void display(void)
{
    glClear(GL_COLOR_BUFFER_BIT);
    triangle();
    glFlush();
}

void reshape(int w,int h)
{
    glViewport(0,0,(GLsizei)w, (GLsizei)h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    if(w <= h)
        gluOrtho2D(0.0,30.0,0.0,30.0*(GLfloat)h/(GLfloat)w);
    else
        gluOrtho2D(0.0,30.0*(GLfloat)w/(GLfloat)h,0.0,30.0);
    glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{  glutInit(&argc, argv);
   glutInitDisplayMode(GLUT_RGB | GLUT_SINGLE);
   glutInitWindowSize(500, 500);
   glutInitWindowPosition(100, 100);
   glutCreateWindow("OpenGL颜色函数例程");
   init();
   glutDisplayFunc(display);
   glutReshapeFunc(reshape);
   glutMainLoop();
   return 0;
}

```