---
title: 实验6 简单光照与材质
tags: [计算机图形学]
categories: 计算机图形学
---
## 1．实验目的：

- 通过示范代码1，理解简单光照明模型的基本原理与实现；
- 通过示范代码2和[太阳系示范代码](https://blog.csdn.net/wpxu08/article/details/70208361)，学习与掌握OpenGL光照与材质设置与使用方法。

## 2．实验内容：

在示范代码1基础上，按以下要求修改：

（1） 阅读和修改示范代码中的有关参数，产生不同光照效果，观察显示效果。挑选两张修改的效果图保存为图1-2，与对应修改的代码一起保存至word实验文档中（15分钟）；

（2） 将代码中的球体改为圆柱体，将圆柱体的光照效果图存为图3，与对应修改的代码一起保存至word实验文档中（25分钟）；

在示范代码2的基础上，按以下要求完成任务：

（3） 阅读和修改示范代码2中的有关参数，产生不同光照效果，观察显示效果。挑选两张修改的效果图保存为图4-5，与对应修改的代码一起保存至word实验文档中（15分钟）；

（4）参考[太阳系示范代码](https://blog.csdn.net/wpxu08/article/details/70208361)，该代码显示一个简单的太阳系模型，尝试为其增加光照与材质效果，挑选两张修改的效果图保存为图6-7，与对应修改的代码一起保存至word实验文档中（25分钟）；

（5） 整理word实验文档，将其命名为“序号-姓名-Prj6.doc”，电子版提交至雨课堂，A4打印稿下一次课前或实验课前提交。

## 3．实验原理：

Phong光照明模型是由物体表面上一点P反射到视点的光强I为环境光的反射光强Ie、理想漫反射光强Id、和镜面反射光Is的总和，即
$$
I = I_a k_a + I_p K_d(LN) + I_p K_s(RV)^n
$$
其中R，V，N为单位矢量；$I_p$为点光源发出的入射光强；$I_a$为环境光的漫反射光强；$K_a$环境光的漫反射系数；$K_d$漫反射系数（ ）取决于表面的材料；$K_s$镜面反射系数（ ）；n幂次，用以模拟反射光的空间分布，表面越光滑，n越大。
在用Phong模型进行真实感图形计算时，对物体表面上的每个点P，均需计算光线的反射方向R，再由V计算 。为减少计算量，我们可以作如下假设：a)光源在无穷远处,即光线方向L为常数；b)视点在无穷远处，即视线方向V为常数；c)用 近似 。这里H为L和V的角平分向量， 。在这种简化下，由于对所有的点总共只需计算一次H的值，节省了计算时间。结合RGB颜色模型，Phong光照明模型的最终形式详见教材公式（8.21）。

示范代码1中，光源在无穷远处，光线方向为单位向量L（0.5, 0.5, 0.707）,视点在无穷远处，视线方向V为（0， 0， 1）。

## 4．示范代码：
### (1) 示范代码1-球体简单光照模型效果图
```
#include <GL/glut.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

struct Vector
{
	float fx, fy, fz;
};

struct Color
{
	float Ir, Ig, Ib;
};

float KaIa;
float Kd, n;
Vector H, light;
Color mLight, mColor;

void Init()
{
	float mo;
	Vector eye;
	mLight.Ir = 0;
	mLight.Ig = 175;
	mLight.Ib = 0;
	KaIa = 100;
	Kd = 0.7;
	n = 20;

	light.fx = 0.50; light.fy = 0.50;
	light.fz = sqrt(1 - (light.fx*light.fx) - (light.fy*light.fy));
	eye.fx = 0; eye.fy = 0; eye.fz = 1;
	H.fx = light.fx + eye.fx;
	H.fy = light.fy + eye.fy;
	H.fz = light.fz + eye.fz;
	mo = sqrt(H.fx*H.fx + H.fy*H.fy + H.fz*H.fz);
	H.fx = (H.fx / mo); H.fy = (H.fy / mo); H.fz = (H.fz / mo);
	H.fx = (H.fx / mo); H.fy = (H.fy / mo); H.fz = (H.fz / mo);

	glClearColor(1.0, 1.0, 1.0, 0.0);
	glShadeModel(GL_SMOOTH);
}

Color Phong(int x0, int y0, int r, int x, int y)
{
	Vector N;
	float z, alpha, theta, Ks;
	Ks = 1.0 - Kd;
	z = sqrt((float)(r*r - (x - x0)*(x - x0) - (y - y0)*(y - y0)));
	N.fx = (x - x0)*1.0 / r;
	N.fy = (y - y0)*1.0 / r;
	N.fz = z * 1.0 / r;
	theta = N.fx * light.fx + N.fy * light.fy + N.fz * light.fz;
	if (theta < 0)
		theta = 0;
	alpha = H.fx*N.fx + H.fy*N.fy + H.fx*N.fz;
	if (alpha < 0)
		alpha = 0;
	mColor.Ir = KaIa + mLight.Ir*Kd*theta + mLight.Ir*Ks*pow(alpha, n);
	mColor.Ig = KaIa + mLight.Ig*Kd*theta + mLight.Ig*Ks*pow(alpha, n);
	mColor.Ib = KaIa + mLight.Ib*Kd*theta + mLight.Ib*Ks*pow(alpha, n);
	return mColor;
}

void MidCircle(int x0, int y0, int r)
{
	int x, y, deltax, deltay, d;
	x = 0;
	y = r;
	deltax = 3;
	deltay = 5 - r - r;
	d = 1 - r;

	glBegin(GL_POINTS);
	{
		for (int i = -x; i <= x; i++)
		{
			mColor = Phong(x0, y0, r, i + x0, y + y0);
			glColor3ub(mColor.Ir, mColor.Ig, mColor.Ib);
			glVertex2i(i + x0, y + y0);
			glColor3ub(mColor.Ir, mColor.Ig, mColor.Ib);
			glVertex2i(i + x0, -y + y0);
		}
		for (int i = -y; i <= y; i++)
		{
			mColor = Phong(x0, y0, r, i + x0, x + y0);
			glColor3ub(mColor.Ir, mColor.Ig, mColor.Ib);
			glVertex2i(i + x0, x + y0);
			glColor3ub(mColor.Ir, mColor.Ig, mColor.Ib);
			glVertex2i(i + x0, -x + y0);
		}

		while (x < y)
		{
			if (d < 0)
			{
				d += deltax;
				deltax += 2;
				deltay += 2;
				x++;
			}
			else
			{
				d += deltay;
				deltax += 2;
				deltay += 4;
				x++;
				y--;
			}

			for (int i = -x; i <= x; i++)
			{
				mColor = Phong(x0, y0, r, i + x0, y + y0);
				glColor3ub(mColor.Ir, mColor.Ig, mColor.Ib);
				glVertex2i(i + x0, y + y0);
				glColor3ub(mColor.Ir, mColor.Ig, mColor.Ib);
				glVertex2i(i + x0, -y + y0);
			}
			for (int i = -y; i <= y; i++)
			{
				mColor = Phong(x0, y0, r, i + x0, x + y0);
				glColor3ub(mColor.Ir, mColor.Ig, mColor.Ib);
				glVertex2i(i + x0, x + y0);
				glColor3ub(mColor.Ir, mColor.Ig, mColor.Ib);
				glVertex2i(i + x0, -x + y0);
			}
		}
	}
	glEnd();
}

void myDisplay()
{
	glClear(GL_COLOR_BUFFER_BIT);
	glColor3f(1.0f, 1.0f, 1.0f);
	MidCircle(250, 250, 60);

	glFlush();
}

void Reshape(int w, int h)
{
	glViewport(0, 0, (GLsizei)w, (GLsizei)h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluOrtho2D(0.0, (GLdouble)w, 0.0, (GLdouble)h);
}

int main(int argc, char *argv[])
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB | GLUT_SINGLE);
	glutInitWindowPosition(100, 100);
	glutInitWindowSize(640, 480);
	glutCreateWindow("Hello World!");

	Init();
	glutDisplayFunc(myDisplay);
	glutReshapeFunc(Reshape);
	glutMainLoop();
	return 0;
}

```
程序运行结果： <img src="http://oty0nwcbq.bkt.clouddn.com/CG-Prj6-Light-Sphere1.png" width="300" align=center />

图1

### (2) 示范代码2-OpenGL光照与材质下球体效果图
```
#include <GL/glut.h>

#include <stdlib.h>

// Initialize material property, light source, lighting model, and depth buffer.

void init(void)

{

	GLfloat mat_specular[] = { 1.0, 1.0, 1.0, 1.0 };

	GLfloat mat_shininess[] = { 50.0 };

	GLfloat light_position[] = { 1.0, 1.0, 1.0, 0.0 };

	GLfloat white_light[] = { 1.0, 1.0, 1.0, 1.0 };

	GLfloat Light_Model_Ambient[] = { 0.2 , 0.2 , 0.2 , 1.0 }; //

	glClearColor(0.0, 0.0, 0.0, 0.0);

	glShadeModel(GL_SMOOTH);

	glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);

	glMaterialfv(GL_FRONT, GL_SHININESS, mat_shininess);

	glLightfv(GL_LIGHT0, GL_POSITION, light_position);

	glLightfv(GL_LIGHT0, GL_DIFFUSE, white_light);

	glLightfv(GL_LIGHT0, GL_SPECULAR, white_light);

	glLightModelfv(GL_LIGHT_MODEL_AMBIENT, Light_Model_Ambient); //

	glEnable(GL_LIGHTING);

	glEnable(GL_LIGHT0);

	glEnable(GL_DEPTH_TEST);

}

void display(void)

{

	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	glutSolidSphere (0.5, 20, 16);

	//glutSolidTeapot(0.5);

	glFlush();

}

void reshape(int w, int h)

{

	glViewport(0, 0, (GLsizei)w, (GLsizei)h);

	glMatrixMode(GL_PROJECTION);

	glLoadIdentity();

	if (w <= h)

		glOrtho(-1.5, 1.5, -1.5*(GLfloat)h / (GLfloat)w,

			1.5*(GLfloat)h / (GLfloat)w, -10.0, 10.0);

	else

		glOrtho(-1.5*(GLfloat)w / (GLfloat)h,

			1.5*(GLfloat)w / (GLfloat)h, -1.5, 1.5, -10.0, 10.0);

	glMatrixMode(GL_MODELVIEW);

	glLoadIdentity();

}

int main(int argc, char** argv)

{

	glutInit(&argc, argv);

	glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB | GLUT_DEPTH);

	glutInitWindowSize(500, 500);

	glutInitWindowPosition(100, 100);

	glutCreateWindow(argv[0]);

	init();

	glutDisplayFunc(display);

	glutReshapeFunc(reshape);

	glutMainLoop();

	return 0;

}
```
程序运行结果：
<img src="http://oty0nwcbq.bkt.clouddn.com/CG-Prj6-Light-Sphere2.png" width="300" align=center />

图2