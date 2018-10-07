---
title: 实验2 关系可视化
tags: [可视化, 地理空间数据]
categories: 数据可视化
---

## 一. 实验目的和要求
### 1. 了解关系可视化知识，了解和学习散点图、饼图、堆叠柱形图、板块层级图和直方图等常见图表类型；
### 2. 学习图形语法方式绘图；
### 3. 学习与巩固R+Illustrator可视化绘图模式。
## 二. 实验内容
### 1. 根据《鲜活的数据》第6章6.2.1介绍的方法与提供的数据，在R中绘制基本散点图，并存为PDF文件；
### 2. 将上一步所得的PDF文件，导入Illustrator，以教材图6-7为模板，完成图6-7，并添上自己的署名。图6-7英文如下图所示，大家提交作品文字部分按中文版处理，图形效果参考英文版。
![图6-7](http://oty0nwcbq.bkt.clouddn.com/DV_%E5%9B%BE6-7.png)

## 三. 实验报告
实验报告中的实验过程请根据实验内容结合自己的具体实验过程填写；

实验结果为上图，可以手绘，可以文字描述，也可以将图缩小打印贴上；

实验分析部分可以对整个实验过程进行回顾与总结，可以从以下一些问题角度进行分析：
- 实验难度与自身水平相比如何？
- 通过实验有无发现自己有待提高的知识或能力吗？
- 碰到什么问题？如何解决？
- 本次实验有何收获或心得？简单介绍下。
## 附加-实验步骤
### 1. 下载编程工具R, 推荐用RStudio免费版（free），下载地址：https://www.rstudio.com/products/rstudio/download/；
### 2. 数据下载地址：http://datasets.flowingdata.com/crimeRatesByState2005.csv。
### 3. 用R绘图，具体如下：
#### （1）安装ggplot2包：
启动RStudio后，菜单栏点击Tools>Install Packages...中输入ggplot2，安装；
#### （2）新建一个R Script文件；
#### （4）启用ggplot2包：
在新建的R Script文件中输入下面代码来启用ggplot2包：
library(ggplot2)
将光标放在上面代码所在行，点击菜单Code->Run Select Lines运行本行代码；快捷键Ctrl+Enter;以下每行代码都需运行，不再重复。
#### （3）数据读取：
输入以下代码来读取CSV文件数据到crime变量中：
crime<-read.csv('c:\\Users\\...\\crimeRatesByState2005.csv',sep=",", header=TRUE)
其中，请将“c:\\Users\\...\\crimeRatesByState2005.csv”改为你自己的文件路径。
#### （4）数据整理：
通过以下两行代码来剔除掉华盛顿特区和全美平均值，并将剔除后的数据存入crime2变量中：
crime2 <- crime[crime$state != "District of Columbia",] 

crime2 <- crime2[crime2$state != "United States",] 
#### （5）ggplot2绘图：通过以下代码来绘制：
##### （i）基本图形：
以数据集中的murder列为x坐标，burglary为y坐标绘制散点图如下：
ggplot(crime2, aes(x = murder, y = burglary)) +  geom_point()
##### （ii）增加坐标轴范围：
ggplot(crime2, aes(x = murder, y = burglary)) +geom_point()+  xlim(0, 10)+  ylim(0, 1200)
##### （iii）增加回归曲线：
ggplot(crime2, aes(x = murder, y = burglary)) +
  geom_point()+  xlim(0, 10)+  ylim(0, 1200)+ geom_smooth()
#### （6）保存绘图：
在R绘图窗口中点击Export->Save as PDF将绘图结果保存为pdf，注意保存选项的Orientation。
### 4. 用Illustrator来修饰完善：
将所保存的绘图结果Pdf文件导入到Illustrator中，进行修饰完善，具体过程不再赘述，请自行百度解决。