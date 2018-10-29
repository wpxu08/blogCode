---
title: 实验4 二维几何变换
tags: [计算机图形学]
categories: 计算机图形学
---
## 1．实验目的：

- 巩固对二维几何变换的认识与理解；
- 学习OpenGL平移、旋转、缩放变换函数及其使用方法；
- 学习基本图形变换与复合图形变换的方法；
- 综合运用上述函数，设计复杂图形。

## 2．实验内容：

根据示范代码1，使用OpenGL平移、旋转、缩放变换函数来改写代码实现所要求的功能。示范代码1的代码运行结果为图1。

（1） 使用glTranslatef()函数，实现图形平移，并结合glTranslatef()函数的不同参数输入，实现x，y和z方向的平移，将测试结果存为图1-3，与对应修改的平移函数代码一起保存至word实验文档中（20分钟）；

（2） 使用glRotatef()函数，实现图形旋转，并结合glRotatef()函数的不同参数输入，实现x，y和z方向的旋转，将测试结果存为图4-6，与对应修改的旋转函数代码一起保存至word实验文档中（20分钟）；

（3） 使用glScalef()函数，实现图形缩放，并结合glScalef()函数的不同参数输入，实现x，y和z方向的旋转，将测试结果存为图7-9，与对应修改的缩放函数代码一起保存至word实验文档中（20分钟）；

（4）示范代码2，代码运行结果为图2，请参考它绘制如图3所示的图形，将绘图结果与代码保存至word实验文档中（30分钟）；

（5） 整理word实验文档，将其命名为“序号-姓名-Prj4.doc”，电子版提交至雨课堂，A4打印稿下一次课前或实验课前提交。

## 3．实验原理：

（1）OpenGL下的几何变换
在OpenGL的核心库中，每一种几何变换都有一个独立的函数，所有变换都在三维空间中定义。
平移矩阵构造函数为`glTranslate<f,d>(tx, ty, tz)`，作用是把当前矩阵和一个表示移动物体的矩阵相乘。tx、ty、tz指定这个移动物体的矩阵，它们可以是任意的实数值，后缀为f（单精度浮点float）或d（双精度浮点double），对于二维应用来说，tz=0.0。
旋转矩阵构造函数为`glRotate<f,d>(theta, vx, vy, vz)`，作用是把当前矩阵和一个表示旋转物体的矩阵相乘。theta，vx，vy，vz指定这个旋转物体的矩阵，物体将围绕(0,0,0)到(x,y,z)的直线以逆时针旋转，参数theta表示旋转的角度。向量v=(vx,vy,vz)的分量可以是任意的实数值，该向量用于定义通过坐标原点的旋转轴的方向，后缀为f（单精度浮点float）或d（双精度浮点double），对于二维旋转来说，vx=0.0，vy=0.0，vz=1.0。
缩放矩阵构造函数为`glScale<f,d>(sx, sy, sz)`，作用是把当前矩阵和一个表示缩放物体的矩阵相乘。sx，sy，sz指定这个缩放物体的矩阵，分别表示在x，y，z方向上的缩放比例，它们可以是任意的实数值，当缩放参数为负值时，该函数为反射矩阵，缩放相对于原点进行，后缀为f（单精度浮点float）或d（双精度浮点double）。
注意这里都是说“把当前矩阵和一个表示移动<旋转, 缩放>物体的矩阵相乘”，而不是直接说“这个函数就是旋转”或者“这个函数就是移动”，这是有原因的，马上就会讲到。
假设当前矩阵为单位矩阵，然后先乘以一个表示旋转的矩阵R，再乘以一个表示移动的矩阵T，最后得到的矩阵再乘上每一个顶点的坐标矩阵v。那么，经过变换得到的顶点坐标就是((RT)v)。由于矩阵乘法满足结合率，((RT)v) = R(Tv))，换句话说，实际上是先进行移动，然后进行旋转。即：实际变换的顺序与代码中写的顺序是相反的。由于“先移动后旋转”和“先旋转后移动”得到的结果很可能不同，初学的时候需要特别注意这一点。

（2）OpenGL下的各种变换简介
我们生活在一个三维的世界，如果要观察一个物体，我们可以：
① 从不同的位置去观察它（人运动，选定某个位置去看）。（视图变换）
② 移动或者旋转它，当然了，如果它只是计算机里面的物体，我们还可以放大或缩小它（物体运动，让人看它的不同部分）。（模型变换）
③ 如果把物体画下来，我们可以选择是否需要一种“近大远小”的透视效果。另外，我们可能只希望看到物体的一部分，而不是全部（指定看的范围）。（投影变换）
④ 我们可能希望把整个看到的图形画下来，但它只占据纸张的一部分，而不是全部（指定在显示器窗口的那个位置显示）。（视口变换）
这些，都可以在OpenGL中实现。
从“相对移动”的观点来看，改变观察点的位置与方向和改变物体本身的位置与方向具有等效性。在OpenGL中，实现这两种功能甚至使用的是同样的函数。
由于模型和视图的变换都通过矩阵运算来实现，在进行变换前，应先设置当前操作的矩阵为“模型视图矩阵”。设置的方法是以GL_MODELVIEW为参数调用glMatrixMode函数，例如：
```
glMatrixMode(GL_MODELVIEW);
```
该语句指定一个4×4的建模矩阵作为当前矩阵。
通常，我们需要在进行变换前把当前矩阵设置为单位矩阵。把当前矩阵设置为单位矩阵的函数为：
```
glLoadIdentity();
```
我们在进行矩阵操作时，有可能需要先保存某个矩阵，过一段时间再恢复它。当我们需要保存时，调用glPushMatrix()函数，它相当于把当前矩阵压入堆栈。当需要恢复最近一次的保存时，调用glPopMatrix()函数，它相当于从堆栈栈顶弹出一个矩阵为当前矩阵。OpenGL规定堆栈至少可以容纳32个矩阵，某些OpenGL实现中，堆栈的容量实际上超过了32个。因此不必过于担心矩阵的容量问题。
通常，用这种先保存后恢复的措施，比先变换再逆变换要更方便、更快速。注意：模型视图矩阵和投影矩阵都有相应的堆栈。使用glMatrixMode来指定当前操作的究竟是模型视图矩阵还是投影矩阵。

(3) 某图形绕任意点(cx, cy)旋转 $\alpha$ 角。
```
清屏
glMatrixMode(GL_MODELVIEW); //设置矩阵模式为模型变换模式，表示在世界坐标系下
glLoadIdentity();   //将当前矩阵设置为单位矩阵
glTranslatef(cx,cy,0);   //平移回去	
glRotatef(alpha,0,0,1); //绕原点旋转ALPHA角度	
glTranslatef(-cx,-cy,0);  //平移回原点
drawSquare();
```
图形绕任意点缩放方法的代码只需把旋转函数换为缩放函数即可，不再赘述。

## 4．示范代码：
### 示范代码1
```
#include <GL/glut.h>
void init (void)
{
    glClearColor (1.0, 1.0, 1.0, 0.0);  
    glMatrixMode (GL_PROJECTION);  
    gluOrtho2D (-5.0, 5.0, -5.0, 5.0);
    //设置显示的范围是X:-5.0~5.0, Y:-5.0~5.0
    glMatrixMode (GL_MODELVIEW);
}
void drawSquare(void)						//绘制中心在原点，边长为2的正方形
{
	glBegin (GL_POLYGON);					//顶点指定需要按逆时针方向
	   glVertex2f (-1.0f,-1.0f);			//左下点
	   glVertex2f (1.0f,-1.0f);				//右下点
	   glVertex2f (1.0f, 1.0f);				//右上点
	   glVertex2f (-1.0f,1.0f);				//左上点
	glEnd ( );
}

void myDraw (void)
{
	glClear (GL_COLOR_BUFFER_BIT);			//清空
	glLoadIdentity();       					//将当前矩阵设为单位矩阵
	
	glColor3f (1.0, 0.0, 0.0); 
	drawSquare();      						//上面红色矩形

	glFlush ( );
}

void main (int argc, char** argv)
{
  	glutInit (&argc, argv);                        
  	glutInitDisplayMode (GLUT_SINGLE | GLUT_RGB);  
  	glutInitWindowPosition (0, 0);  
  	glutInitWindowSize (600, 600);      
  	glutCreateWindow ("几何变换示例1"); 
    
  	init();                  
  	glutDisplayFunc (myDraw);
  	glutMainLoop();  
}
```
程序运行结果： <img src="http://oty0nwcbq.bkt.clouddn.com/CG-2D%E5%87%A0%E4%BD%95%E5%8F%98%E6%8D%A21.png" width="300" align=center />

图1

### 示范代码2
```
#include <GL/glut.h>
void init (void)
{
    glClearColor (1.0, 1.0, 1.0, 0.0);  
    glMatrixMode (GL_PROJECTION);  
    gluOrtho2D (-5.0, 5.0, -5.0, 5.0);
    //设置显示的范围是X:-5.0~5.0, Y:-5.0~5.0
    glMatrixMode (GL_MODELVIEW);
}
void drawSquare(void)						//绘制中心在原点，边长为2的正方形
{
	glBegin (GL_POLYGON);					//顶点指定需要按逆时针方向
	   glVertex2f (-1.0f,-1.0f);			//左下点
	   glVertex2f (1.0f,-1.0f);				//右下点
	   glVertex2f (1.0f, 1.0f);				//右上点
	   glVertex2f (-1.0f,1.0f);				//左上点
	glEnd ( );
}

void myDraw (void)
{
	glClear (GL_COLOR_BUFFER_BIT);			//清空
	glLoadIdentity();       					//将当前矩阵设为单位矩阵
	
	glPushMatrix();
	glTranslatef(0.0f,2.0f,0.0f);
	glScalef(3.0,0.5,1.0); 
	glColor3f (1.0, 0.0, 0.0); 
	drawSquare();      						//上面红色矩形
	glPopMatrix();

	glPushMatrix();
	
	glTranslatef(-3.0,0.0,0.0);  
	
	glPushMatrix();
	glRotatef(45.0,0.0,0.0,1.0);
	glColor3f (0.0, 1.0, 0.0);  
	drawSquare();              				//中间左菱形
	glPopMatrix();
   
   	glTranslatef(3.0,0.0,0.0); 
    
	glPushMatrix();
	glRotatef(45.0,0.0,0.0,1.0);
	glColor3f (0.0, 0.7, 0.0);  
	drawSquare();              				//中间中菱形
	glPopMatrix();

	glTranslatef(3.0,0.0,0.0); 
    
	glPushMatrix();
	glRotatef(45.0,0.0,0.0,1.0);
	glColor3f (0.0, 0.4, 0.0);  
	drawSquare();              				//中间右菱形
	glPopMatrix();
    
	glPopMatrix();

	glTranslatef(0.0,-3.0,0.0);  
	glScalef(4.0,1.5,1.0); 
	glColor3f (0.0, 0.0, 1.0);
	drawSquare();    						//下面蓝色矩形         

	glFlush ( );
}

void main (int argc, char** argv)
{
  	glutInit (&argc, argv);                        
  	glutInitDisplayMode (GLUT_SINGLE | GLUT_RGB);  
  	glutInitWindowPosition (0, 0);  
  	glutInitWindowSize (600, 600);      
  	glutCreateWindow ("几何变换示例2"); 
    
  	init();                  
  	glutDisplayFunc (myDraw);
  	glutMainLoop();  
}
```
程序运行结果：
<img src="http://oty0nwcbq.bkt.clouddn.com/CG-2D%E5%87%A0%E4%BD%95%E5%8F%98%E6%8D%A22.png" width="300" align=center />

图2

<img src="http://oty0nwcbq.bkt.clouddn.com/CG-2D%E5%87%A0%E4%BD%95%E5%8F%98%E6%8D%A23.png" width="300" align=center />

图3

## 5．实验思考
在绕任意点旋转时，若将相关代码改为如下：
```
清屏
glMatrixMode(GL_MODELVIEW); //设置矩阵模式为模型变换模式，表示在世界坐标系下
glLoadIdentity();   //将当前矩阵设置为单位矩阵
glTranslatef(-cx,-cy,0);   //平移回去	
glRotatef(theta,0,0,1); //绕原点旋转ALPHA角度	
glTranslatef(cx,cy,0);  //平移回原点
drawSquare();
```
图形将变成怎样？试解释原因。