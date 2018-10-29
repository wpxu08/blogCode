---
title: 实验3 直线裁剪算法
tags: [计算机图形学]
categories: 计算机图形学
---
## 1．实验目的：

- 理解直线裁剪的基本原理；
- 验证直线的编码裁剪算法，参考网络资料实现梁友栋-Barsky裁剪算法；
- 了解与掌握OpenGL鼠标操作。

## 2．实验内容：

本次实验主要结合鼠标画线程序来验证编码裁剪算法和梁友栋-Barsky裁剪算法，具体步骤如下：

（1） 阅读学习所给的编码裁剪示范代码，了解程序使用方法，并结合三种不同类型直线对其进行裁剪测试，将测试结果存为图1-3，保存至word实验文档中（30分钟）；

（2） 为示范代码增加梁友栋-Barsky裁剪算法，并通过键盘按键“L”来控制，即按键盘“L”键时，用梁友栋-Barsky算法裁剪程序窗口内的直线。同样测试三种不同类型的直线，将测试结果存为图4-6，，保存至word实验文档中（60分钟）；

（3） 整理图1-6，并增加程序代码合并到一个word文档，将其命名为“序号-姓名-Prj2.doc”，电子版提交至雨课堂，A4打印稿下一次课前或实验课前提交。

## 3．实验原理：

示范代码中编码裁剪算法原理参见教材裁剪内容，有关鼠标操作知识请参考[OpenGL编程 基础篇（四）与鼠标的交互](https://www.cnblogs.com/starryxsky/p/7184032.html)。

4．实验代码：
```
#include <GL/glut.h>
#include <stdio.h>
#include <stdlib.h>

#define LEFT_EDGE   1
#define RIGHT_EDGE  2
#define BOTTOM_EDGE 4
#define TOP_EDGE    8

struct Rectangle
{
	float xmin, xmax, ymin, ymax;
};

Rectangle  rect;
int x0, y0, x1, y1;
bool bDrawLine = true;
int width = 640, height = 480;

void LineGL(int x0, int  y0, int x1, int y1)
{
	glBegin(GL_LINES);
	glColor3f(1.0f, 0.0f, 0.0f);   glVertex2f(x0, y0);
	glColor3f(1.0f, 0.0f, 0.0f);   glVertex2f(x1, y1);
	glEnd();
}

//求p点的编码
int CompCode(int x, int y, Rectangle rect)
{
	int code = 0x00;
	if (y < rect.ymin)
		code = code | 4;//即为1000
	if (y > rect.ymax)
		code = code | 8;//即为0100
	if (x > rect.xmax)
		code = code | 2;
	if (x < rect.xmin)
		code = code | 1;
	return code;
}

bool cohensutherlandlineclip(Rectangle  rect, int &x0, int & y0, int &x1, int &y1)
{
	bool accept, done;
	float x, y;
	accept = false;
	done = false;

	int code0, code1, codeout;
	code0 = CompCode(x0, y0, rect);
	code1 = CompCode(x1, y1, rect);
	do {
		if (!(code0 | code1))
		{
			accept = true;
			done = true;
		}
		else if (code0 & code1)
			done = true;
		else
		{
			if (code0 != 0)
				codeout = code0;
			else
				codeout = code1;

			if (codeout&LEFT_EDGE) {
				y = y0 + (y1 - y0)*(rect.xmin - x0) / (x1 - x0);
				x = (float)rect.xmin;
			}
			else if (codeout&RIGHT_EDGE) {
				y = y0 + (y1 - y0)*(rect.xmax - x0) / (x1 - x0);
				x = (float)rect.xmax;
			}
			else if (codeout&BOTTOM_EDGE) {
				x = x0 + (x1 - x0)*(rect.ymin - y0) / (y1 - y0);
				y = (float)rect.ymin;
			}
			else if (codeout&TOP_EDGE) {
				x = x0 + (x1 - x0)*(rect.ymax - y0) / (y1 - y0);
				y = (float)rect.ymax;
			}

			if (codeout == code0)
			{
				x0 = x; y0 = y;
				code0 = CompCode(x0, y0, rect);
			}
			else
			{
				x1 = x; y1 = y;
				code1 = CompCode(x1, y1, rect);
			}
		}
	} while (!done);

	return accept;
}

void myDisplay()
{
	glClear(GL_COLOR_BUFFER_BIT);
	glColor3f(1.0f, 1.0f, 0.0f);
	glRectf(rect.xmin, rect.ymin, rect.xmax, rect.ymax);

	if (bDrawLine)
		LineGL(x0, y0, x1, y1);

	glFlush();
}

void Init()
{
	glClearColor(0.0, 0.0, 0.0, 0.0);
	glShadeModel(GL_FLAT);

	rect.xmin = 100; //窗口的大小
	rect.xmax = 300;
	rect.ymin = 100;
	rect.ymax = 300;

	x0 = 300, y0 = 50, x1 = 0, y1 = 450;//裁剪前的直线端点
	printf("Press key 'c' to Clip!\n");
	printf("Please Click left button of mouse to input the points of Line!!\n");
}

void Reshape(int w, int h)
{
	glViewport(0, 0, (GLsizei)w, (GLsizei)h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluOrtho2D(0.0, (GLdouble)w, 0.0, (GLdouble)h);
}

void keyboard(unsigned char key, int x, int y)
{
	switch (key)
	{
	case 'c':
		bDrawLine = cohensutherlandlineclip(rect, x0, y0, x1, y1);
		glutPostRedisplay();//重画
		break;
	case 'x':
		exit(0);
		break;
	default:
		break;
	}
}

void mouse(int button, int state, int x, int y)
{
	switch (button)
	{
	case GLUT_LEFT_BUTTON:
		if (state == GLUT_DOWN)
		{
			if(bDrawLine)
			{
				x0 = x;
				y0 = height - y;
				bDrawLine = false;
				glutPostRedisplay();//
			}
			else
			{
				x1 = x;
				y1 = height - y;
				bDrawLine = true;				
				glutPostRedisplay();//
			}
		}
		break;
	default:
		break;
	}
}

int main(int argc, char *argv[])
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB | GLUT_SINGLE);
	glutInitWindowPosition(100, 100);
	glutInitWindowSize(width, height);
	glutCreateWindow("Hello World!");

	Init();
	glutDisplayFunc(myDisplay);
	glutReshapeFunc(Reshape);
	glutKeyboardFunc(keyboard);
	glutMouseFunc(mouse);
	glutMainLoop();
	return 0;
}
```
## 5．实验思考
实验示范代码的第162行：
```
y0 = height - y;
```
请解释这行代码的含义和作用。