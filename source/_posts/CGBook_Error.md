---
title: 《计算机图形学基础（OpenGL版）》勘误表
tags: [计算机图形学]
categories: 计算机图形学
---

| 页码|行或位置|原内容|更正为 |备注|
|--------|------|-------------|-------|-------|
| 38     | 9   |(1MB)  | (128KB)  |
| 41     | 16   |$$k=\Delta x/\Delta y$$  | $$k=\Delta y/\Delta x$$  |
| 43    | 9   |$$d \leq 0$$ |$$d \geq 0$$  | 
| 46     | 6   |$$ s-t = s \frac{\Delta x}{\Delta y}(x_i+1)+2b+2y_i-1$$   | $$ s-t = s \frac{\Delta x}{\Delta y}(x_i+1)+2b -2y_i-1$$  |
|46|倒数第4行|$$-1\leq1\leq0$$|$$0\leq k\leq 1$$|
|47|26|int curx = x1;|int curx = x1 + 1;|
|48|12|$$b=x_0-x_1$$|$$b=x_1-x_0$$|
|51|19|令$T$点的坐标为$（x_i, y_i)$|令$P$点的坐标为$（x_i, y_i)$|
|52|倒数第3行|Cirpot(x0, y0, x, y)|Cirpot(x0, y0, x, y, color)|
|53|9|Cirpot(x0, y0, x, y)|Cirpot(x0, y0, x, y, color)|
|57|7|FloodFill|FloodFill4|
|57|13-16|FloodFill4(..., newcolor)|FloodFill4(..., newcolor, boundaryColor)|
|58-59|58页倒数第2行~59页第11行|见教材|从点P向任意方向发出一条射线，若该射线与多边形交点的个数为奇数，则P位于多边形内；若为偶数，则P位于多边形外部。当射线与多边形边界点的交点是多边形顶点时（该交点称为奇点，如图3-13的$P_3$，$P_4$，$P_5$和$P_6$情况），如果把每一个奇点简单地计为一个交点，则交点个数为偶数时P点可能在内部，如图3-13中的$P_4$情况。但若将每一个奇点都简单地计为两个交点，同样会导致错误的结果，如图3-13中的$P_3$和$P_5$情况。因此，必须按不同情况区别对待。一般来说，多边形的顶点可分为两类：极值点和非极值点。如果顶点相邻的两边在射线的同侧时，则称该顶点为极值点（如图3-13中的$Q_0$和$Q_1$）；否则称该顶点为非极值点（如图3-13中的$Q_2$）。为了保证射线法判别结果的正确性，奇点交点的计数可以根据上述分类来采用不同的方式。当奇点是多边形的极值点时，交点按照两个交点计算，否则，按一个交点计算，如图3.13所示。|
|59|图3-13|见教材|![图片描述](http://oty0nwcbq.bkt.clouddn.com/CG-%E5%9B%BE3-13.png)|
|60|图3.16|  ![这里写图片描述](http://oty0nwcbq.bkt.clouddn.com/CG-%E5%9B%BE3-16-Error.png)    | ![这里写图片描述](http://oty0nwcbq.bkt.clouddn.com/CG-%E5%9B%BE3-16Right.png)|
|65 | 倒数第4行 | 图3.22 | 图3.23 |
|65 | 倒数第3行 | $y_i+m/2$ | $y_i-int(y_i)+m/2$ |
|73|6|$$ y'=rsin(\phi+\theta)=rcos \phi sin \theta - rsin \phi cos \theta $$| $$ y'=rsin(\phi+\theta)=rcos \phi sin \theta + rsin \phi cos \theta $$ |
|75 | 8 | 相对于y轴的反射 | 相对于x轴的反射 |
|117 | 2 | $$T=R(\theta)T(-x_0, -y_0) =\begin{bmatrix} cos\theta & \mathbf{sin\theta} & 0  \\ \mathbf{-sin\theta} & cos\theta & 0  \\ 0 & 0 & 1 \\  \end{bmatrix}  \begin{bmatrix} 1 & 0 & -x_0  \\0 & 1 & -y_0  \\0 & 0 & 1  \end{bmatrix}$$ | $$T=R(\theta)T(-x_0, -y_0) = \begin{bmatrix}	cos\theta & -sin\theta & 0  \\sin\theta & cos\theta & 0  \\	0 & 0 & 1  \end{bmatrix}  	\begin{bmatrix} 1 & 0 & -x_0  \\0 & 1 & -y_0  \\0 & 0 & 1  \end{bmatrix} $$ |
|122 | 15 | $$t_1^{''}=(x_R-x_1)/dx$$ | $$t_1^{''}=(y_B-y_1)/dy$$ |
| 130     |  24  |glLoadIdentity()  | 应移至void display(void)中的第1个glColor3f(0.0,0.0,1.0)后  |  参考[5.5 Opengl编程实例－红蓝三角形 ](http://blog.csdn.net/wpxu08/article/details/77608983)|
| 131     |  1  | ![这里写图片描述](http://oty0nwcbq.bkt.clouddn.com/CG-%E5%9B%BE5-17-Error.png)  | ![这里写图片描述](http://oty0nwcbq.bkt.clouddn.com/CG-%E5%9B%BE5-17.png)|
| 131     | 图5.17后   | 无 | 增加思考内容：“思考：教材中原代码中根据所给三角形顶点坐标，三角形应为一个正角形，为何显示时不是正角形呢？同时，在旋转后的三角形也发生了变形，请分析原因，并给出修改建议。提示：请从"glViewport()"函数入手。”|
| 135    | (6.2)  | $$u=\frac{V \times n}{\mid N \mid} = (u_x, u_y, u_z)$$  | $$u=\frac{V \times n}{\mid V \times n \mid} = (u_x, u_y, u_z)$$|
|151|(6.29)| $$  \begin{bmatrix}x_p  \\ y_p  \\	0  \\	1	\end{bmatrix} =\begin{bmatrix}1 & 0 & 0  & 0\\	0 & 1 & 0 & 0 \\	0 & 0 & 0 & 0 \\	0 & 0 & 0 & 1\end{bmatrix}	\begin{bmatrix}	1 & 0 & 0  & 0\\	0 & 1 & 0 & 0 \\	0 & 0 & 1 & 0 \\	0 & 0 & \frac{1}{d} & \mathbf{ 1}  \end{bmatrix} \begin{bmatrix}	x_s  \\ y_s  \\	z_s  \\	1	\end{bmatrix} =  \begin{bmatrix}	x_s  \\ y_s  \\	0  \\	\mathbf{1+ \frac{z_s}{d}} 	\end{bmatrix}$$ 		|$$  \begin{bmatrix}	x_p  \\ y_p  \\	0  \\	1	\end{bmatrix} =\begin{bmatrix}1 & 0 & 0  & 0\\	0 & 1 & 0 & 0 \\0 & 0 & 0 & 0 \\0 & 0 & 0 & 1\end{bmatrix} \begin{bmatrix}	1 & 0 & 0  & 0\\ 0 & 1 & 0 & 0 \\	0 & 0 & 1 & 0 \\	0 & 0 & \frac{1}{d} & \mathbf{0}\end{bmatrix} \begin{bmatrix} x_s  \\ y_s  \\	z_s  \\	1	\end{bmatrix}	 =  \begin{bmatrix}	x_s  \\ y_s  \\	0  \\	\mathbf{ \frac{z_s}{d} }	\end{bmatrix}$$ |
|151|(6.31)| $$ \begin{bmatrix}1 & 0 & 0  & 0\\	0 & 1 & 0 & 0 \\	0 & 0 & 1 & 0 \\	0 & 0 & r & \mathbf{1}\end{bmatrix} $$ |$$ \begin{bmatrix}	1 & 0 & 0  & 0\\	0 & 1 & 0 & 0 \\	0 & 0 & 1 & 0 \\	0 & 0 & r & \mathbf{0}\end{bmatrix} $$ |
|151|(6.33)| $$ \begin{bmatrix}1 & 0 & 0  & 0\\	0 & 1 & 0 & 0 \\0 & 0 & 1 & 0 \\	p & 0 & 0 & \mathbf{1}\end{bmatrix} $$ |$$ \begin{bmatrix}1 & 0 & 0  & 0 \\ 0 & 1 & 0 & 0 \\	0 & 0 & 1 & 0 \\	p & 0 & 0 & \mathbf{0 }\end{bmatrix} $$ |
|151|(6.34)| $$ \begin{bmatrix}	1 & 0 & 0  & 0\\	0 & 1 & 0 & 0 \\	0 & 0 & 1 & 0 \\	0 & q & 0 & \mathbf{1}\end{bmatrix} $$ |$$ \begin{bmatrix}	1 & 0 & 0  & 0\\	0 & 1 & 0 & 0 \\	0 & 0 & 1 & 0 \\	0 & q & 0 & \mathbf{0}\end{bmatrix} $$ |
|152|(6.35)| ![这里写图片描述](http://images2015.cnblogs.com/blog/26309/201701/26309-20170117213639458-812719339.png) |![这里写图片描述](http://images2015.cnblogs.com/blog/26309/201701/26309-20170117213640942-1081172362.png) |
|152|(6.35)| ![这里写图片描述](http://images2015.cnblogs.com/blog/26309/201701/26309-20170117213718536-1468325746.png) |![这里写图片描述](http://images2015.cnblogs.com/blog/26309/201701/26309-20170117213722567-1226100288.png) |
| 152     |  12  |线性关系  | 非线性关系  |  |
| 152     |  (6.37)  |$$ a=\frac{-(z_{far}+z_{near})z_{near}}{z_{far}-z_{near}}$$  | $$ a=\frac{z_{far}+z_{near}}{z_{near}(z_{far}-z_{near})}$$  |  |
| 224     |  2  |对于**右手**坐标系  | 对于**OpenGL所采用的左手**坐标系  | 烟台大学韩明峰指正 |
|      |  图8.17  |![这里写图片描述](https://img-blog.csdn.net/20180914224000616?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dweHUwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)  |![这里写图片描述](https://img-blog.csdn.net/2018091422402764?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dweHUwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)  |  |
|      |  8  | 深度缓冲器所有单元均置为最**小** z值   |  深度缓冲器所有单元均置为最**大** z值  | 为保持与图8.17一致而修改，原内容也没错，下同  |
|      |  11 |若z **>** ZB(x, y)，则ZB(x, y)=z   | 若z **&lt;** ZB(x, y)，则ZB(x, y)=z |   |
|      |  20 |ZB(x,y)单元置为最**小**值  | ZB(x,y)单元置为最**大**值  |   |
|      |  26  | if(z(x,y) **>** ZB(x,y))   |  if(z(x,y) **&lt;** ZB(x,y))  |   |

### 附录B 模拟试题及答案
| 页码|位置|原内容|更正 |备注
|--------|------|-------------|-------|-------|
| 337    |  图B.1  | ![这里写图片描述](http://oty0nwcbq.bkt.clouddn.com/CG-%E5%9B%BEB-1-Wrong.png)  | ![这里写图片描述](http://oty0nwcbq.bkt.clouddn.com/CG-%E5%9B%BEB-1-Right.png)| |
| 340    |  模2试题，一.单选题，第6题  |$$T= \left[ \begin{matrix}   2 & 0 & 0 \\   0 & 1 & 0 \\   1 & 1 & 1  \end{matrix}  \right]  $$  | $$P^{'}= PT =\left[ \begin{matrix}   x & y & 1  \end{matrix}  \right] \left[ \begin{matrix}   2 & 0 & 0 \\   0 & 1 & 0 \\   1 & 1 & 1  \end{matrix}  \right]   $$  |  |
| 345    |  模3试题，一.单选题，第1题B选项  |高光域准确  | 可以产生高光  |此题正确答案为B，见后  |
| 347    |  四.填空题，第3题  |点坐标采用**行**向量形式  | 点坐标采用**列**向量形式  |  |
| 349    |  模1答案，二.多选题，第1题答案  |ABC  | ABCD  | 错切变换是沿坐标轴错切，参考对象仍为坐标原点 |
| 350    |  模2答案，一.单选题，第1题答案  |B  | C  |  |
| 350    |  一.单选题，第3题答案  |B  | C  |  |
| 350    |  一.单选题，第4题答案  |C  | D  |  |
| 350    |  二.多选题，第10题答案  |ACD  | ABCD  |  |
| 350    |  二.多选题，第11题答案  |CD  | BCD  |  |
| 352    |  模3答案，一.单选题，第1题答案  |D  | B  |  |
| 352    |  二.多选题，第1题答案  |BCE  | AD  |  |
| 352    |  二.多选题，第2题答案  |BD  | B  |  |
| 352    |  二.多选题，第6题答案  |BD  | BCD  |  |
| 354    |  第1行  |$$\begin{bmatrix}	0 & 0 & 0 & 1  \\	1/27 & 1/9 & 1/3 & 0  \\  8/27 & 4/9 & 1/3 & 0  \\	1 & 1 & 1 & 1 \end{bmatrix}$$  | $$\begin{bmatrix}	0 & 0 & 0 & 1  \\	1/27 & 1/9 & 1/3 & 1  \\  8/27 & 4/9 & 2/3 & 1  \\	1 & 1 & 1 & 1 \end{bmatrix}$$  |  |


- **P349, 模拟试题1，第四大题第3小题答案：**
$$T_1= \left[ \begin{matrix}
   1 & 0 & 0 \\
   0 & 1 & 0 \\
   -2 & -4 & 1
  \end{matrix}
  \right]  $$
  
$$T_2= \left[ \begin{matrix}
   cos600^\circ & sin600^\circ & 0 \\
   -sin600^\circ & cos600^\circ & 0 \\
   0 & 0 & 1
  \end{matrix}
  \right]  =\left[ \begin{matrix}
   -1/2 & -\sqrt{3}/2 & 0 \\
   \sqrt{3}/2 & -1/2 & 0 \\
   0 & 0 & 1
  \end{matrix}
  \right]$$
  
$$T_3= \left[ \begin{matrix}
   1 & 0 & 0 \\
   0 & 1 & 0 \\
   2 & 4 & 1
  \end{matrix}
  \right]  $$

$$T= T_1T_2T_3= \left[ \begin{matrix}
   -1/2 & -\sqrt{3}/2 &  0\\
   \sqrt{3}/2 & -1/2 & 0 \\
   3-2 \sqrt{3} & 6+ \sqrt{3} & 1
  \end{matrix}
  \right]  $$
由 $ P^{'}= PT$  可得：$$ \left[ \begin{matrix}
    A^{'} \\
    B^{'} \\
    C^{'}
  \end{matrix}
  \right] =\left[ \begin{matrix}
    A \\
    B \\
    C
  \end{matrix}
  \right] T
  = \left[ \begin{matrix}
   2 & 4 & 1 \\
   4 & 4 & 1 \\
   4 & 1 & 1
  \end{matrix}
  \right] T= 
  \left[ \begin{matrix}
   2 & 4 & 1 \\
   1 & 4-\sqrt{3} & 1 \\
   1-3\sqrt{3}/2 & 11/2-\sqrt{3} & 1
  \end{matrix}
  \right]$$ 

<!---列向量模式
      1.变换过程：
(1) 平移三角形，使其角点A与原点重合。其中，平移变换对应的矩阵为
$$T_1= \left[ \begin{matrix}
   1 & 0 & -2 \\
   0 & 1 & -4 \\
   0 & 0 & 1
  \end{matrix}
  \right]  $$
  (2) 对平移后三角形进行旋转变换，使其绕角点A（即原点）逆时针旋转600度。相应的旋转变换矩阵为
$$T_2= \left[ \begin{matrix}
   cos600^\circ & -sin600^\circ & 0 \\
   sin600^\circ & cos600^\circ & 0 \\
   0 & 0 & 1
  \end{matrix}
  \right]  $$
  (3) 平移三角形，使其角点A回到原有位置即点（2,4）。其中，平移变换对应的矩阵为
$$T_3= \left[ \begin{matrix}
   1 & 0 & 2 \\
   0 & 1 & 4 \\
   0 & 0 & 1
  \end{matrix}
  \right]  $$
综合（1）、（2）、（3）可得最终的变换矩阵为：
$$T= T_3T_2T_1= \left[ \begin{matrix}
   -1/2 & \sqrt{3}/2 &  3-2 \sqrt{3}\\
   - \sqrt{3}/2 & -1/2 & 6+ \sqrt{3} \\
   0 & 0 & 1
  \end{matrix}
  \right]  $$
  2. 由变换计算式$ P^{'}＝TP$，可计算变换后的三角形顶点坐标分别为：
  $$ A^{'}＝TA=T \left[ \begin{matrix}
    2 \\
    4 \\
    1
  \end{matrix}
  \right]=\left[ \begin{matrix}
    2 \\
    4 \\
    1
  \end{matrix}
  \right]$$
 $$ B^{'}＝TB=T \left[ \begin{matrix}
    4 \\
    4 \\
    1
  \end{matrix}
  \right]=\left[ \begin{matrix}
    1 \\
    4-\sqrt{3} \\
    1
  \end{matrix}
  \right]$$
   $$ C^{'}＝TC=T \left[ \begin{matrix}
    4 \\
    1 \\
    1
  \end{matrix}
  \right]=\left[ \begin{matrix}
    1-3\sqrt{3}/2  \\
    11/2-\sqrt{3}  \\
    1
  \end{matrix}
  \right]$$  
  -->

- **P350, 模拟试题1，第四大题第4小题答案：**
由相似三角形关系可得$$ \frac{x^{'}} {x} =  \frac{d} {d-z} $$于是
$$x^{'} =  \frac{xd} {d-z}=  \frac{x} {1-\frac{z}{d}}$$
同理有：$$y^{'} =  \frac{y} {1-\frac{z}{d}}$$
另外，$z^{'}=0$.
于是有：
$$ P^{'}  = \left[ \begin{matrix}
    x^{'} \\
    y^{'} \\
    z^{'} \\
    1
  \end{matrix}
  \right] =\left[ \begin{matrix}
    \frac{x} {1-\frac{z}{d}} \\
    \frac{y} {1-\frac{z}{d}} \\
    0 \\
    1
  \end{matrix}
  \right] 
  \equiv \left[ \begin{matrix}
   x \\
   y \\
   0 \\
   1-\frac{z}{d}
  \end{matrix}
  \right] = 
  \left[ \begin{matrix}
   1 & 0 & 0 & 0 \\
   0 & 1 & 0 & 0 \\
   0 & 0 & 0 & 0 \\
  0 & 0 & -\frac{1}{d} & 1 \\
  \end{matrix}
  \right] 
  \left[ \begin{matrix}
   x \\
   y \\
   z \\
   1
  \end{matrix}
  \right] ＝ TP $$
  上式中$T$即为透视变换矩阵，其中$ \equiv$表示齐次坐标转化。
  顶点坐标计算：以G点为例，G点齐次坐标为(1,1,-1,1)，则由透视变换可知：
  $$ G^{'}  = TG =T \left[ \begin{matrix}
    1 \\
    1 \\
    -1 \\
    1
  \end{matrix}
  \right] =
  \left[ \begin{matrix}
   1 & 0 & 0 & 0 \\
   0 & 1 & 0 & 0 \\
   0 & 0 & 0 & 0 \\
  0 & 0 & -\frac{1}{d} & 1 \\
  \end{matrix}
  \right] 
  \left[ \begin{matrix}
   1 \\
    1 \\
    -1 \\
    1
  \end{matrix}
  \right] ＝ \left[ \begin{matrix}
   1 \\
    1 \\
    0 \\
    1+\frac{1}{d}
  \end{matrix}
  \right]
  \equiv \left[ \begin{matrix}
   \frac{d}{d+1} \\
    \frac{d}{d+1} \\
    0 \\
    1
  \end{matrix}
  \right]  $$
故透视变换后G点变为$G^{'}=( \frac{d}{d+1},  \frac{d}{d+1}, 0)$.

- **P351, 模拟试题2，第五大题第2小题答案：**
$$ cosi=\vec{L} \cdot \vec{N}=0.5, \vec{R} = 2cosi\vec{N}-\vec{L}=(-1/2,1/2,-\sqrt{2}/2).$$
$$cos\theta= \vec{R} \cdot \vec{V} = -\sqrt{2}/2<0, \vec{R}与\vec{V}夹角大于90度，因此\vec{V}方向上无镜面反射光，所以 cos\theta取0. $$
$$\therefore I=I_{pa}k_a+I_p(k_dcosi+k_scos^n\theta)=160*0.5+175(0.2*0.5+0)=97.5$$


- **P353, 模拟试题3，第五大题第1小题答案：**
$a=y_0-y_1=-4, b=x_1-x_0=8, d_0=a+0.5b=0; a+b=4, a=-4$，当$d_i<0$时，中点M在直线下方，下一点取当前点P的右上方点，记为NE，同时$d_{i+1}=d_i+a+b$；当$d_i\geq0$时，中点M在直线上方，下一点取当前点P的右侧点，记为E，同时$d_{i+1}=d_i+a$。根据中点线算法原理可得下表：

| x|y|$d_i$|Next Point |
|--------|------|-------------|-------|
| 2     | 1   |0  | E  |
| 3     | 1   |0-4=-4  | NE  |
| 4     | 2   |-4+4=0  | E  |
| 5     | 2   |0-4=-4  | NE  |
| 6     | 3   |-4+4=0  | E  |
| 7     | 3   |0-4=-4  | NE  |
| 8     | 4   |-4+4=0  | E  |
| 9     | 4   |0-4=-4  | NE  |
| 10     | 5   |  |   |

<!--- 中点线有关原理
令直线方程为$F(x,y)=ax+by+c=0$，设当前点为$P(x_p, y_p)$，则可根据中点构造判别式
$$d=F(M)=F(x_p+1, y_p+0.5)=a(x_p+1)+b(y_p+0.5)+c$$
-->