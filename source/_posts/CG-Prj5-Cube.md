---
title: 实验5 立方体显示与变换
tags: [计算机图形学]
categories: 计算机图形学
---
## 1．实验目的：

- 通过示范代码1的立方体实例，理解巩固点的透视投影变换知识；
- 通过示范代码1的立方体实例，了解OpenGL实体显示的基本原理与方法；
- 通过示范代码2的立方体实例，学习OpenGL观察变换函数、投影变换函数的设置与使用方法；

## 2．实验内容：

在示范代码1基础上，按以下要求修改：

（1） 修改代码，让立方体平移和旋转，产生两点透视和三点透视，将两种透视图结果存为图1-2，与对应修改的代码一起保存至word实验文档中（20分钟）；

（2） 参考教材代码7.3.5，将代码中的立方体改为四棱锥，将测试结果存为图3，与对应修改的代码一起保存至word实验文档中（20分钟）；

在示范代码2基础上，按以下要求修改：

（3） 学习OpenGL观察变换函数gluLookAt的设置与使用方法，并在代码中修改参数产生两点透视和三点透视，将两种透视图结果存为图4-5，与对应修改的代码一起保存至word实验文档中（20分钟）；

（4）学习OpenGL投影变换函数gluPerspective和glOrtho的设置与使用方法，启用gluPerspective函数并修改参数得到不同的透视图6-7，将图和代码保存；启用glOrtho并修改参数得到不同的正交投影图8-9，将图和代码保存（20分钟）；

（5） 整理word实验文档，将其命名为“序号-姓名-Prj5.doc”，电子版提交至雨课堂，A4打印稿下一次课前或实验课前提交。

## 3．实验原理：

在OpenGL程序中，观察变换必须出现在模型变换之前，但可以在绘图之前的任何时候执行投影变换和视口变换。

（1）在给定的观察变换之前，应该使用glLoadIdentity函数把当前矩阵设置为单位矩阵。

（2）在载入单位矩阵之后，使用gluLookAt函数指定观察变换。如果程序没有调用gluLookAt()，那么照相机会设定为一个默认的位置和方向。在默认的情况下，照相机位于原点，指向z轴负方向，朝上向量为(0,1,0)。

（3）一般而言，display函数包括：观察变换 + 模型变换 + 绘制图形的函数（如ColorCube）。display会在窗口被移动或者原来先遮住这个窗口的东西被移开时，被重复调用，并经过适当变换，保证绘制的图形是按照希望的方式进行绘制。

（4）在调用gluPerspective设置投影变换之前，在reshape函数中有一些准备工作：视口变换 + 投影变换 + 观察变换 + 模型变换。由于投影变换，视口变换共同决定了场景是如何映射到计算机的屏幕上的，而且它们都与屏幕的宽度、高度密切相关，因此应该放在reshape函数中。reshape函数会在窗口初次创建，移动或改变时被调用。

总结起来，OpenGL中矩阵坐标之间的关系为：物体世界坐标→观察坐标→投影坐标→透视除法→规范化设备坐标→窗口坐标。

（1）用观察变换函数gluLookAt(0.0,0.0,5.0,0.0,0.0,0.0,0.0,1.0,0.0)设置照相机的位置。把照相机放在(0,0,5)，镜头瞄准(0,0,0)，朝上向量定为(0,1,0)，朝上向量为照相机指定了一个唯一的方向。如果没有调用gluLookAt函数，照相机就设定一个默认的位置和方向，如上所述。glLoadIdentity函数把当前矩阵设置为单位矩阵。

（2）使用模型变换的目的是设置模型的位置和方向。

（3）投影变换，指定投影变换类似于为照相机选择镜头，可以认为这种变换的目的是确定视野，并因此确定哪些物体位于视野之内以及它们能够被看到的程度。除了考虑视野之外，投影变换确定物体如何投影到屏幕上，OpenGL提供了两种基本类型的投影：(i)透视投影：远大近小；(ii)正投影：不影响相对大小，一般用于工程当中。

（4）视口变换。视口变换指定一个图像在屏幕上所占的区域，可参考[OpenGL的glViewport视口变换函数详解](https://www.cnblogs.com/1024Planet/p/5641410.html)。

（5）绘制场景。

## 4．示范代码：
### (1) 示范代码1-通过透视投影变换计算投影点来显示立方体投影图
```
// Projection.cpp : Defines the entry point for the console application.
//
#include <GL/glut.h>
#include <stdio.h>
#include <math.h>

struct Matrix
{
	double p[4][4];
	Matrix(int val = 1);//默认val =1 为单位阵，val =0 为零阵
};

double lx = 0, ly = 0, lz = -1;
double phi = 0;
double d = 5;
Matrix mT, mR, mP, mTemp, mA;
int flag = 1; // display cube with wireframe 1 or face mode 2

GLfloat vertices0[8][3] = { {-1.0, -1.0, 1.0},{-1.0, 1.0, 1.0},{1.0,1.0, 1.0},{1.0,-1.0,1.0},  
{-1.0,-1.0,-1.0}, {-1.0,1.0,-1.0},{1.0,1.0,-1.0}, {1.0,-1.0,-1.0} };

GLfloat vertices1[8][2] = { {-1.0,-1.0},{1.0,-1.0},{1.0,1.0},{-1.0,1.0},
{-1.0,-1.0},{1.0,-1.0},{1.0,1.0},{-1.0,1.0} };

GLfloat colors[6][3] = { {1.0,1.0,1.0}, {1.0,0.0,0.0}, {1.0,1.0,0.0},
{0.0,0.0,1.0}, {1.0,0.0,1.0}, {0.0,1.0,1.0} };

Matrix::Matrix(int val)
{
	for (long i = 0; i < 4; i++) {
		for (long j = 0; j < 4; j++) {
			if (i == j) p[i][j] = val;
			else p[i][j] = 0;
		}
	}
}

Matrix Multiply(Matrix& m1, Matrix& m2)
{
	Matrix m(0);
	for (int i = 0; i < 4; i++)
		for (int j = 0; j < 4; j++)
			for (int k = 0; k < 4; k++)
				m.p[i][j] += (m1.p[i][k] * m2.p[k][j]);

	return m;
}

void InitParameter()//初始化参数
{
	mT.p[3][0] = lx; mT.p[3][1] = ly; mT.p[3][2] = lz;
	mR.p[0][0] = cos(phi); mR.p[0][2] = -sin(phi); mR.p[2][0] = sin(phi); mR.p[2][2] = cos(phi);

	mP.p[2][2] = 0;
	mP.p[2][3] = -1 / d;

	mTemp = Multiply(mT, mR);
	mA = Multiply(mTemp, mP);
}

void Project(int num, GLfloat vertices0[][3], GLfloat vertices1[][2])//透视变换
{
	for (int i = 0; i < num; i++)
	{
		GLfloat ptH[4] = { vertices0[i][0], vertices0[i][1], vertices0[i][2], 1 };//齐次坐标
		GLfloat res[4] = {0, 0, 0, 0};

		for (int j = 0; j < 4; j++)
			for (int k = 0; k < 4; k++)
				res[j] += (ptH[k] * mA.p[k][j]);

		vertices1[i][0] = res[0] / res[3];
		vertices1[i][1] = res[1] / res[3];
	}
}

void Polygon(int clr, int a, int b, int c, int d)
{
	glColor3fv(colors[clr]);
	if (flag == 1)
		glBegin(GL_LINE_LOOP);
	else
		glBegin(GL_POLYGON);

	glVertex2fv(vertices1[a]);
	glVertex2fv(vertices1[b]);
	glVertex2fv(vertices1[c]);
	glVertex2fv(vertices1[d]);
	glEnd();
}

void ColorCube(void)
{
	Polygon(0, 0, 3, 2, 1);
	Polygon(1, 2, 3, 7, 6);
	Polygon(2, 0, 4, 7, 3);
	Polygon(3, 1, 2, 6, 5);
	Polygon(4, 4, 5, 6, 7);
	Polygon(5, 0, 1, 5, 4);
	//Polygon(0, 0, 3, 2, 1);
}

void myDisplay()
{
	glClear(GL_COLOR_BUFFER_BIT);
	glColor3f(1.0f, 0.0f, 0.0f);

	InitParameter();

	Project(8, vertices0, vertices1);
	ColorCube();

	glutSwapBuffers();
}

void Init()
{
	glClearColor(0.0, 0.0, 0.0, 0.0);
	glShadeModel(GL_FLAT);

	printf("Hello Cube!\n");
}

void Reshape(int w, int h)
{
	glViewport(0, 0, (GLsizei)w, (GLsizei)h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrtho(-5, 5, -5, 5, -10, 10);
}

void keyboard(unsigned char key, int x, int y)
{
	switch (key)
	{
	case '1':
		flag = 1;
		glutPostRedisplay();
		break;
	case '2':
		flag = 2;
		glutPostRedisplay();
		break;
	default:
		break;
	}
}

int main(int argc, char *argv[])
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE);
	glutInitWindowPosition(100, 100);
	glutInitWindowSize(600, 600);
	glutCreateWindow("Hello World!");

	glutDisplayFunc(myDisplay);
	glutReshapeFunc(Reshape);
	glutKeyboardFunc(keyboard);
	glutMainLoop();
	return 0;
}
```
程序运行结果： <img src="http://oty0nwcbq.bkt.clouddn.com/CG-Prj5-Cube1.png" width="300" align=center />

图1

### (2) 示范代码2-通过OpenGL观察变换和投影变换函数来显示立方体投影图
```
#include <gl/glut.h>  

int flag = 1;
GLfloat rquad = 0;
GLfloat vertices[8][3] = { {-1.0, -1.0, 1.0},{-1.0, 1.0, 1.0},{1.0,1.0, 1.0},{1.0,-1.0,1.0},
{-1.0,-1.0,-1.0}, {-1.0,1.0,-1.0},{1.0,1.0,-1.0}, {1.0,-1.0,-1.0} };

GLfloat colors[6][3] = { {1.0,1.0,1.0}, {1.0,0.0,0.0}, {1.0,1.0,0.0},
{0.0,0.0,1.0}, {1.0,0.0,1.0}, {0.0,1.0,1.0} };

void InitGL(GLvoid)
{
	glShadeModel(GL_SMOOTH);
	glClearColor(0.0, 0.0, 0.0, 0.0);
	glClearDepth(1.0f);
	glEnable(GL_DEPTH_TEST);
	glDepthFunc(GL_LEQUAL);
	glEnable(GL_COLOR_MATERIAL);
	glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
}

void Polygon(int clr, int a, int b, int c, int d)
{
	glColor3fv(colors[clr]);
	if (flag == 1)
		glBegin(GL_LINE_LOOP);
	else
		glBegin(GL_POLYGON);

	glVertex3fv(vertices[a]);
	glVertex3fv(vertices[b]);
	glVertex3fv(vertices[c]);
	glVertex3fv(vertices[d]);
	glEnd();
}

void ColorCube(void)
{
	Polygon(0, 0, 3, 2, 1);
	Polygon(1, 2, 3, 7, 6);
	Polygon(2, 0, 4, 7, 3);
	Polygon(3, 1, 2, 6, 5);
	Polygon(4, 4, 5, 6, 7);
	Polygon(5, 0, 1, 5, 4);
}

void display(void)
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();
	glPushMatrix();
   
	gluLookAt(0, 0, 5, 0, 0, 0, 0, 1, 0);
	glTranslatef(0.0f, 0.0f, -1.0f);	//平移
	//glRotatef(rquad, 1.0f, 0.0f, 0.0f);	//旋转一个角度
	ColorCube();
	glPopMatrix();

	rquad -= 0.15f;	//修改立方体的旋转角度
	glutSwapBuffers();
}
void reshape(int width, int height)
{
	if (height == 0)
		height = 1;
	glViewport(0, 0, width, height);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	//gluPerspective(90.0f, (GLfloat)width / (GLfloat)height, 0.0f, 100.0f);
	gluPerspective(90.0f, (GLfloat)width / (GLfloat)height, 0.1f, 100.0f);
	//if (width <= height)
	//	glOrtho(-2.0, 2.0, -2.0*(GLfloat)height / (GLfloat)width, 2.0*(GLfloat)height / (GLfloat)width, 1.0, 20.0);
	//else
	//	glOrtho(-2.0*(GLfloat)width / (GLfloat)height, 2.0*(GLfloat)width / (GLfloat)height, -2.0, 2.0, 1.0, 20.0);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
}

void keyboard(unsigned char key, int x, int y)
{
	switch (key)
	{
	case '1':
		flag = 1;
		glutPostRedisplay();
		break;
	case '2':
		flag = 2;
		glutPostRedisplay();
		break;
	default:
		break;
	}
}

int main(int argc, char** argv)
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE);
	glutInitWindowSize(600, 600);
	glutCreateWindow("Hello Cube");
	InitGL();
	glutDisplayFunc(display);
	glutReshapeFunc(reshape);
	glutIdleFunc(display);
	glutKeyboardFunc(keyboard);
	glutMainLoop();

	return 0;
}
```
程序运行结果：
<img src="http://oty0nwcbq.bkt.clouddn.com/CG-Prj5-Cube2.png" width="300" align=center />

图2


## 5．实验思考
在示范代码2中，若将`gluPerspective(90.0f, (GLfloat)width / (GLfloat)height, 0.1f, 100.0f)`代码改为如下：

`gluPerspective(90.0f, (GLfloat)width / (GLfloat)height, 0.0f, 100.0f)`，

点击按键1和2，切换显示方式，观察下显示效果有何不同，试解释原因。