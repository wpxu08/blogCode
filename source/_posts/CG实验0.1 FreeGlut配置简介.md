---
title: 实验0.1 FreeGlut配置简介
tags: [计算机图形学]
categories: 计算机图形学基础（第2版）
---

## 1．FreeGlut简介：
先介绍下**Glut库**。GLUT最初由MarkKilgard编写，从OpenGL Redbook（红宝书）第二版起就用来作为示例程序的支持环境，直到第八版为止（注：第九版开始改为GLFW）。从那时起，GLUT因为其简单、可用性广、可移植性强，被广泛应用于各种OpenGL实际应用中。Glut最新版本为3.7版，大致在1998年8月停止维护和更新，同时其代码也没有开源。
[**Freeglut**](http://freeglut.sourceforge.net/)是Glut库(OpenGL Utility Toolkit，OpenGL实用工具包)的免费开源替代品。它是由Pawel W. Olszta在1999年12月创建，最新版本为2015年3月的3.0版本。
## 2. FreeGlut获取
可以选择源码自己编译，也可以直接使用编译好的文件。
(1) 源码下载链接：http://prdownloads.sourceforge.net/freeglut/freeglut-3.0.0.tar.gz?download
(2) 编译好的文件下载链接：
https://www.transmissionzero.co.uk/software/freeglut-devel/
其中如果以VS为编程环境，可以直接下载上述链接页面中的MSVC包（“freeglut 3.0.0 MSVC Package”）。
## 3．FreeGlut配置
下面以freeglut-MSVC.zip文件介绍FreeGlut在VS2017中的配置。
**(1) 头文件**
　　将freeglut\include\GL目录复制到 Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\include目录下;
**(2) 库文件**
　　将freeglut\lib\freeglut.lib文件复制到Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\lib\x86目录下;
　　将freeglut\lib\x64\freeglut.lib文件复制到Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\lib\x64目录下;
**(3) Dll文件**
- 64位Windows系统：
　　将freeglut\bin\freeglut.dll文件复制到C:\Windows\SysWOW64目录下;
　　将freeglut\bin\x64\freeglut.dll文件复制到c:\Windows\System32目录下;
- 32位Windows系统：
　　将freeglut\bin\freeglut.dll文件复制到c:\Windows\System32目录下;
## 4．补充
为防止出现“无法打开文件“freeglutd.lib””的错误，需要在代码文件中#include <GL/glut.h>语句前加上#define NDEBUG，如下所示：
```
#define NDEBUG 
#include <GL/glut.h>
......
```
原因请参考文章[Freeglut中无法打开文件"freeglutd.lib"](https://blog.csdn.net/csxiaoshui/article/details/78720651)。