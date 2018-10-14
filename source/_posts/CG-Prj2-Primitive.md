---
title: 实验2 基本图元光栅化
tags: [计算机图形学]
categories: 计算机图形学
---
## 1．实验目的：

- 理解基本图形元素光栅化的基本原理；
- 掌握基本图形元素光栅化方法，如中点方法，Bresenham方法；
- 利用OpenGL实现基本图形元素的光栅化算法。

## 2．实验内容：

（1） 阅读学习所给的直线光栅化的DDA算法示范代码，将其彻底弄懂，根据实验思考题找出其中的错误；同时能在计算机上编译运行，输出正确结果，指出错误并截图保存为图1至word实验文档（30分钟）；

（2） 在示范程序的基础上，根据程序所留接口，增加中点线算法，并给出若干条测试直线实例，，截图保存为图2至word实验文档（30分钟）；

（3） 为示范程序增加中点圆绘制算法，同时增加键盘按键控制（数字按键3），并给出若干个测试圆的实例，截图保存为图3至word实验文档（30分钟）；

（4） 整理图1-3，并增加程序代码合并到一个word文档，将其命名为“序号-姓名-Prj2.doc”，电子版提交至雨课堂，A4打印稿下一次课前或实验课前提交。

## 3．实验原理：

示范代码原理参见教材直线光栅化一节中的DDA算法。下面介绍下OpenGL画线的一些基础知识和glutReshapeFunc()函数。

（1）数学上的直线没有宽度，但OpenGL的直线则是有宽度的。同时，OpenGL的直线必须是有限长度，而不是像数学概念那样是无限的。可以认为，OpenGL的“直线”概念与数学上的“线段”接近，它可以由两个端点来确定。这里的线由一系列顶点顺次连结而成，有闭合和不闭合两种。

前面的实验已经知道如何绘“点”，那么OpenGL是如何知道拿这些顶点来做什么呢？是一个一个的画出来，还是连成线？或者构成一个多边形？或是做其它事情呢？为了解决这一问题，OpenGL要求：指定顶点的命令必须包含在glBegin函数之后，glEnd函数之前（否则指定的顶点将被忽略），并由glBegin来指明如何使用这些点。

例如：
```
glBegin(GL_POINTS);

    glVertex2f(0.0f, 0.0f);

    glVertex2f(0.5f, 0.0f);

glEnd();
```
则这两个点将分别被画出来。如果将GL_POINTS替换成GL_LINES，则两个点将被认为是直线的两个端点，OpenGL将会画出一条直线。还可以指定更多的顶点，然后画出更复杂的图形。另一方面，glBegin支持的方式除了GL_POINTS和GL_LINES，还有GL_LINE_STRIP，GL_LINE_LOOP，GL_TRIANGLES，GL_TRIANGLE_STRIP，GL_TRIANGLE_FAN等，每种方式的大致效果如图A.2所示：

![图A.2 OpenGL几何图元类型](http://oty0nwcbq.bkt.clouddn.com/%E5%9B%BEA.2%20OpenGL%E5%87%A0%E4%BD%95%E5%9B%BE%E5%85%83.jpg)

图A.2 OpenGL几何图元类型


（2）首次打开窗口、移动窗口和改变窗口大小时，窗口系统都将发送一个事件，以通知程序员。如果使用的是GLUT，通知将自动完成，并调用向glutReshapeFunc()注册的函数。该函数必须完成下列工作：

- 重新建立用作新渲染画布的矩形区域；

- 定义绘制物体时使用的坐标系。

如：
```
void Reshape(int w, int h)

{

glViewport(0, 0, (GLsizei) w, (GLsizei) h);

glMatrixMode(GL_PROJECTION);

glLoadIdentity();

gluOrtho2D(0.0, (GLdouble) w, 0.0, (GLdouble) h);

}
```

在GLUT内部，将给该函数传递两个参数：窗口被移动或修改大小后的宽度和高度，单位为像素。glViewport()调整像素矩形，用于绘制整个窗口。接下来三个函数调整绘图坐标系，使左下角位置为（0， 0），右上角为（w, h）。

（3） 键盘输入

当你按下一个键后，GLUT提供了两个函数为这个键盘消息注册回调。第一个是glutKeyboardFunc，用来处理普通按键，如字母，数字，和其他可以用ASCII代码表示的键；另一个是glutSpecialFunc，用来处理特殊按键，如$F_i$，方向键，Home，End键等。

glutKeyboardFunc函数原型如下：
void glutKeyboardFunc(void(*func)(unsigned char key,int x,int y));
参数：
func: 处理普通按键消息的函数的名称。如果传递NULL，则表示GLUT忽略普通按键消息。
这个作为glutKeyboardFunc函数参数的函数需要有三个形参：第一个表示按下的键的ASCII码，其余两个提供了当键按下时当前的鼠标位置。鼠标位置是相对于当前客户窗口的左上角而言的。

glutSpecialFunc函数请参考https://blog.csdn.net/xie_zi/article/details/1911891。

4．实验代码：
```
#include <GL/glut.h>

int flag = 0;
void LineDDA(int x0,int y0,int x1,int y1/*,int color*/)
{
	int  x, dy, dx, y;
	float m;
	dx=x1-x0;
	dy=y1-y0;
	m=dy/dx;
	y=y0;

	glColor3f (1.0f, 1.0f, 0.0f);   
	glPointSize(1);
	for(x=x0;x<=x1; x++)
	{
		glBegin (GL_POINTS);
		glVertex2i (x, (int)(y+0.5));
		glEnd ();
		y+=m;
	}		
}

void LineMidPoint(int x0, int y0, int x1, int y1)
{
	//请在这里填写你的代码
}

void myDisplay(void)
{
	glClear(GL_COLOR_BUFFER_BIT);
	glColor3f (1.0f, 0.0f, 0.0f); 
	glRectf(25.0, 25.0, 75.0, 75.0);

	glPointSize(5);
	glBegin (GL_POINTS);
	glColor3f (0.0f, 1.0f, 0.0f);   glVertex2f (0.0f, 0.0f);
	glEnd ();

	glBegin (GL_LINES);
	glColor3f (1.0f, 0.0f, 0.0f);   glVertex2f (100.0f, 0.0f);
	glColor3f (0.0f, 1.0f, 0.0f);   glVertex2f (180.0f, 240.0f);	
	glEnd ();

	if(flag == 1)
		LineDDA(0, 0, 200, 300);

	//if (flag == 2)
		//LineMidPoint(...);

	glFlush();
}

void Init()
{
	glClearColor(0.0, 0.0, 0.0, 0.0);
	glShadeModel(GL_FLAT);
}

void Reshape(int w, int h)
{
	glViewport(0, 0, (GLsizei) w,  (GLsizei) h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluOrtho2D(0.0, (GLdouble) w, 0.0, (GLdouble) h);
}

void keyboard(unsigned char key, int x, int y)
{
	switch (key)
	{
	case '1'://DDA Line
		flag = 1;
		break;
	case '2': // MidPoint Line
		//请在这里填写你的代码
		
		break;
	default:
		break;
	}
	glutPostRedisplay();//重画
}

int main(int argc, char *argv[])
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB | GLUT_SINGLE);
	glutInitWindowPosition(100, 100);
	glutInitWindowSize(400, 400);
	glutCreateWindow("Hello World!");
	Init();
	glutDisplayFunc(myDisplay);
	glutReshapeFunc(Reshape);
	glutKeyboardFunc(keyboard);
	glutMainLoop();
	return 0;
}
```

注： glShadeModel选择平坦或光滑渐变模式。GL_SMOOTH为缺省值，为光滑渐变模式，GL_FLAT为平坦渐变模式。

## 5．实验思考

示范代码有个小错误，能否指出并改正？请将结果写入实验报告。