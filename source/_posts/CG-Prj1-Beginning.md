---
title: 实验1 OpenGL初识
tags: [计算机图形学]
categories: 计算机图形学
---
## 1．实验目的：

- 熟悉编程环境；了解光栅图形显示器的特点；
- 了解计算机绘图的特点；
- 利用VC+OpenGL作为开发平台设计程序，以能够在屏幕上生成任意一个像素点为本实验的结束。

## 2．实验内容：

（0） 实验预备知识；Windows下的OpenGL编程步骤简单介绍详见课程实验教学博客－实验0 安装GLUT包与创建工程（40分钟）：

https://blog.csdn.net/wpxu08/article/details/70208353

（1） 了解和使用VC的开发环境，理解简单的OpenGL程序结构（20分钟）；

（2） 掌握OpenGL提供的基本图形函数，尤其是生成点的函数（20分钟）；

（3） 撰写实验报告，增加程序代码合并到一个word文档，将其命名为“序号-姓名-Prj1.doc”，电子版提交至雨课堂，A4打印稿下一次课前或实验课前提交（20分钟）。

## 3．实验原理：

1）基本语法

常用的程序设计语言，如C、C++、Pascal、Fortran和Java等，都支持OpenGL的开发。这里只讨论C版本下OpenGL的语法。

OpenGL基本函数均使用gl作为函数名的前缀，如glClearColor()；实用函数则使用glu作为函数名的前缀，如gluSphere()。OpenGL基本常量的名字以GL_开头，如GL_LINE_LOOP；实用常量的名字以GLU_开头，如GLU_FILL。一些函数如glColor*()（定义颜色值），函数名后可以接不同的后缀以支持不同的数据类型和格式。如glColor3b(...)、glColor3d(...)、glColor3f(...)和glColor3bv(...)等，这几个函数在功能上是相似的，只是适用于不同的数据类型和格式，其中3表示该函数带有三个参数，b、d、f分别表示参数的类型是字节型、双精度浮点型和单精度浮点型，v则表示这些参数是以向量形式出现的。

为便于移植，OpenGL定义了一些自己的数据类型，如GLfloat,GLvoid。它们其实就是C中的float和void。在gl.h文件中可以看到以下定义：

……

typedef float GLfloat;

typedef void GLvoid;

……

一些基本的数据类型都有类似的定义项。

（2）程序的基本结构

OpenGL程序的基本结构可分为三个部分：

第一部分是初始化部分。主要是设置一些OpenGL的状态开关，如颜色模式(RGBA或Alpha)的选择，是否作光照处理(若有的话，还需设置光源的特性)，深度检测，裁剪等等。这些状态一般都用函数glEnable(...), glDisable(…)来设置，…表示特定的状态。

第二部分设置观察坐标系下的取景模式和取景框位置大小。主要利用了三个函数：

函数void glViewport(left,top,right,bottom)：设置在屏幕上的窗口大小，四个参数描述屏幕窗口四个角上的坐标（以像素表示）；

函数void glOrtho(left,right,bottom,top,near,far)：设置投影方式为正交投影（平行投影），其取景体积是一个各面均为矩形的六面体;

函数void gluPerspective(fovy,aspect,zNear,zFar)：设置投影方式为透视投影，其取景体积是一个截头锥体。

第三部分是OpenGL的主要部分，使用OpenGL的库函数构造几何物体对象的数学描述，包括点线面的位置和拓扑关系、几何变换、光照处理等等。

以上三个部分是OpenGL程序的基本框架，即使移植到使用MFC的Windows程序中，也是如此。只是由于Windows自身有一套显示方式，需要进行一些必要的改动以协调这两种不同显示方式。

（3）状态机制

OpenGL的工作方式是一种状态机制，它可以进行各种状态或模式设置，这些状态或模式在重新改变它们之前一直有效。例如，当前颜色就是一个状态变量，在这个状态改变之前，绘制的每个像素都将使用该颜色，直到当前颜色被设置为其它颜色为止。OpenGL中大量地使用了这种状态机制，如颜色模式、投影模式、单双显示缓存区的设置、背景色的设置、光源的位置和特性等等。许多状态变量可以通过glEnable()、glDisable()这两个函数来设置成有效或无效状态，如是否设置光照、是否进行深度检测等；在被设置成有效状态之后，绝大部分状态变量都有一个缺省值。通常情况下，可以用下列四个函数来获取某个状态变量的值：glGetBooleanv()、glGetDouble()、glGetFloatv()和glGetIntegerv()。究竟选择哪个函数应该根据所要获得的返回值的数据类型来决定。还有些状态变量有特殊的查询函数，如glGetLight*()、glGetError()和glPolygonStipple()等。另外，使用glPushAttrib()和glPopAttrib()函数，可以存储和恢复最近的状态变量的值。只要有可能，都应该使用这些函数，因为它们比其它查询函数的效率更高。

4．实验代码：
```
#include <GL/glut.h> //需要正确安装GLUT，安装方法如预备知识中所述

void myDisplay(void)

{

glClearColor(0.0, 0.0, 0.0, 0.0);
glClear(GL_COLOR_BUFFER_BIT);

glColor3f (1.0f, 1.0f, 1.0f);

glRectf(-0.5f, -0.5f, 0.5f, 0.5f);

glBegin (GL_TRIANGLES);

glColor3f (1.0f, 0.0f, 0.0f); glVertex2f (0.0f, 1.0f);

glColor3f (0.0f, 1.0f, 0.0f); glVertex2f (0.8f, -0.5f);

glColor3f (0.0f, 0.0f, 1.0f); glVertex2f (-0.8f, -0.5f);

glEnd ();

glPointSize(3);

glBegin (GL_POINTS);

glColor3f (1.0f, 0.0f, 0.0f); glVertex2f (-0.4f, -0.4f);

glColor3f (0.0f, 1.0f, 0.0f); glVertex2f (0.0f, 0.0f);

glColor3f (0.0f, 0.0f, 1.0f); glVertex2f (0.4f, 0.4f);

glEnd ();

glFlush();
}
int main(int argc, char *argv[])
{
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGB | GLUT_SINGLE);
    glutInitWindowPosition(100, 100);
    glutInitWindowSize(400, 400);
    glutCreateWindow("Hello World!");
    glutDisplayFunc(&myDisplay);
    glutMainLoop();
    return 0;
}
```

程序说明： 
该程序的作用是在一个黑色的窗口中央画一个矩形、三角形和三个点，如图A.1(a)所示。下面对各行语句进行说明：

首先，需要包含头文件#include <GL/glut.h>，这是GLUT的头文件。本来OpenGL程序一般还要包含<GL/gl.h>和<GL/glu.h>，但GLUT的头文件中已经自动将这两个文件包含了，不必再次包含；

然后看main函数。int main(int argc, char *argv[])，这个是带命令行参数的main函数。注意main函数中的各语句，除了最后的return之外，其余全部以glut开头。这种以glut开头的函数都是GLUT工具包所提供的函数，下面对用到的几个函数进行介绍；

1）glutInit，对GLUT进行初始化，这个函数必须在其它的GLUT使用之前调用一次。其格式比较固定，一般都是glutInit(&argc, argv)就行；

2) glutInitDisplayMode，设置显示方式，其中GLUT_RGB表示使用RGB颜色，与之对应的还有GLUT_INDEX（表示使用索引颜色）。GLUT_SINGLE表示使用单缓冲，与之对应的还有GLUT_DOUBLE（使用双缓冲）。更多信息，以后的实验教程会有讲解介绍；

3) glutInitWindowPosition，设置窗口在屏幕中的位置；

4) glutInitWindowSize，设置窗口的大小；

5) glutCreateWindow，根据前述设置的信息创建窗口。参数将被作为窗口的标题。注意：窗口被创建后，并不立即显示到屏幕上。需要调用glutMainLoop才能看到窗口；

6) glutDisplayFunc，设置一个函数，当需要进行画图时，这个函数就会被调用。（暂且这样理解）；

7) glutMainLoop，进行一个消息循环。（现在只需知道这个函数可以显示窗口，并且等待窗口关闭后才会返回。）

在glutDisplayFunc函数中，我们设置了“当需要画图时，请调用myDisplay函数”。于是myDisplay函数就用来画图。观察myDisplay中的三个函数调用，发现它们都以gl开头。这种以gl开头的函数都是OpenGL的标准函数，下面对用到的函数进行介绍：

1) glClearColor(0.0, 0.0, 0.0, 0.0) ：将清空颜色设为黑色（为什么会有四个参数？）；

2) glClear(GL_COLOR_BUFFER_BIT)：将窗口的背景设置为当前清空颜色；

3) glRectf，画一个矩形。四个参数分别表示了位于对角线上的两个点的横、纵坐标；

4) glFlush，保证前面的OpenGL命令立即执行（而不是让它们在缓冲区中等待）。


## 5．实验思考

根据示范程序，能否在原有结果基础上添加三条直线组成三角形（如图A.1所示）？
![图A.1 加三角形](http://images.cnitblog.com/blog/26309/201406/151113465926805.jpg)

<center>图A.1 加三角形后的效果</center>