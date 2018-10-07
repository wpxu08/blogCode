---
title: WebGL画点程序v1
tags:
categories:
---

本文程序实现画一个点的任务，如下图。其中，点的位置直接给定（“硬编码”）在顶点着色器中。

![Hello_Point](http://oty0nwcbq.bkt.clouddn.com/helloPoint.png)

整个程序包含两个文件，分别是：
## 1. HelloPoint1.html
```javascript
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>画一个点</title>
    </head>
    <body onload="startup()">
        <canvas id="myGLCanvas" width="640" height="480">
        </canvas>
    </body>
    <script type="text/javascript" src="HelloPoint1.js">
    </script>
</html>
```

## 2. HelloPoint1.js
```javascript
var gl;
function createGLContext(canvas) {
  var names = ["webgl", "experimental-webgl"];
  var context = null;
  for (var i=0; i < names.length; i++) {
    try {
      context = canvas.getContext(names[i]); //获取webgl context绘图上下文
    } catch(e) {}
    if (context) {
      break;
    }
  }
  if (context) {
    context.viewportWidth = canvas.width;
    context.viewportHeight = canvas.height;
  } else {
    alert("Failed to create WebGL context!");
  }
  return context;
}

function loadShader(type, shaderSource) {
  var shader = gl.createShader(type);
  gl.shaderSource(shader, shaderSource);
  gl.compileShader(shader);
  
  if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
      alert("Error compiling shader" + gl.getShaderInfoLog(shader));
      gl.deleteShader(shader);   
      return null;
  }
  return shader;  
}

function setupShaders() {
    //顶点着色器程序
    var vertexShaderSource = 'void main(){ \n' +
    '    gl_Position = vec4(0.0, 0.0, 0.0, 1.0); \n' + //gl_Position指定了点的位置
    '    gl_PointSize = 10.0; \n' +
    '} \n';
    
    //片元着色器程序
    var fragmentShaderSource = 'void main(){ \n' +
    '    gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0); \n' + //gl_FragColor指定像素的颜色
    '} \n';                                         
     
  var vertexShader = loadShader(gl.VERTEX_SHADER, vertexShaderSource);
  var fragmentShader = loadShader(gl.FRAGMENT_SHADER, fragmentShaderSource);
  
  var shaderProgram = gl.createProgram();
  gl.attachShader(shaderProgram, vertexShader);
  gl.attachShader(shaderProgram, fragmentShader);
  gl.linkProgram(shaderProgram);

  if (!gl.getProgramParameter(shaderProgram, gl.LINK_STATUS)) {
    alert("Failed to setup shaders");
  }

  gl.useProgram(shaderProgram);
  gl.program= shaderProgram;
}

function startup(){
    var canvas = document.getElementById('myGLCanvas');//获取<canvas>元素
    gl = createGLContext(canvas);
    setupShaders(); 

    gl.clearColor(0.0, 0.0, 0.0, 1.0);//指定清空<canvas>的颜色    
    gl.clear(gl.COLOR_BUFFER_BIT);//清空<canvas>
    gl.drawArrays(gl.POINTS, 0, 1);//从第0个元素开始，在指定位置（gl_Position）画1个点
 }
```

## 参考代码
1. Hello Point——WebGL, http://www.cnblogs.com/idealer3d/p/3513838.html
1. Professional WebGL Programming: Developing 3D Graphics for the Web,Listing 2-1,http://media.wiley.com/product_ancillary/60/11199688/DOWNLOAD/Listing-2-1.html

>转载请注明出处：http://www.cnblogs.com/opengl/p/7262596.html