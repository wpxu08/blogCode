---
title: 实验0.2 OpenGL程序创建与运行
tags: [计算机图形学]
categories: 计算机图形学基础（第2版）
---

下列介绍与图示均以Microsoft Visual Studio Community 2017版本（下面简称为VS）为例，其它版本类似。
## 1. 创建控制台应用
（1）点击：文件&rarr;新建&rarr;项目，如下图所示：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200520054720575.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dweHUwOA==,size_16,color_FFFFFF,t_70)
选择“Visual C++ &rarr; Windows桌面&rarr;控制台应用”：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200520054720489.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dweHUwOA==,size_16,color_FFFFFF,t_70)
在名称对应文本框中，修改工程名称为“HelloPoint”：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200520060836182.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dweHUwOA==,size_16,color_FFFFFF,t_70)
点击“确定”，得到缺省工程结果，如图所示：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200520060836189.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dweHUwOA==,size_16,color_FFFFFF,t_70)
## 2. 生成解决方案，确认生成没有错误
(1) 点击菜单：生成&rarr;生成解决方案，如图所示：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200520060836201.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dweHUwOA==,size_16,color_FFFFFF,t_70)
(2) 观察VS下方“输出”窗口中提示：“生成：成功1个...”，确认生成没有错误，如下图所示：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200520060836208.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dweHUwOA==,size_16,color_FFFFFF,t_70)
## 3. OpenGL代码替换，解决方案重新生成、运行
在运行下面代码前，请先配置FreeGlut库，这是一个OpenGL程序的支持环境库，具体信息与配置方法请参考： [FreeGlut配置简介](https://blog.csdn.net/wpxu08/article/details/87785547)。
(1) 将原有缺省代码替换为下列OpenGL代码：
```
#include <GL/glut.h>
void myDisplay(void)
{
	glClearColor(0.0, 0.0, 0.0, 0.0);
	glClear(GL_COLOR_BUFFER_BIT);

	glPointSize(3);
	glBegin(GL_POINTS);
	glColor3f(1.0f, 0.0f, 0.0f);   glVertex2f(-0.4f, -0.4f);
	glColor3f(0.0f, 1.0f, 0.0f);   glVertex2f(0.0f, 0.0f);
	glColor3f(0.0f, 0.0f, 1.0f);   glVertex2f(0.4f, 0.4f);
	glEnd();

	glFlush();
}

int main(int argc, char *argv[])
{
	glutInit(&argc, argv);
	glutInitWindowPosition(100, 100);
	glutInitWindowSize(400, 400);
	glutCreateWindow("Hello Point!");
	glutDisplayFunc(&myDisplay);
	glutMainLoop();
	return 0;
}
```
替换完成后并重新生成，结果如下图所示：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200520060836202.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dweHUwOA==,size_16,color_FFFFFF,t_70)
(2)运行程序，观察程序运行结果
点击菜单：调试&rarr;开始执行（不调试），如图所示：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200520075018132.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dweHUwOA==,size_16,color_FFFFFF,t_70#pic_center)
弹出两个窗口，其中一个窗口中显示红、绿、蓝三个点，即为程序运行结果，如图所示：
 ![在这里插入图片描述](https://img-blog.csdnimg.cn/20200520060836185.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dweHUwOA==,size_16,color_FFFFFF,t_70)
 至此，完成了一个简单的OpenGL程序创建与运行。