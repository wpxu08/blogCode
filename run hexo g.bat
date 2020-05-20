@echo  off
@echo hexo 
rem 进入当前所在路径
cd %~dp0
echo %~dp0
::cmd /k cd/d "c:\Users\WPXU\Documents\GitHub\blogCode" 
::cd c:\Users\WPXU\Documents\GitHub\blogCode
::start cmd /k "cd/d c:\Users\WPXU\Documents\GitHub\blogCode &&hexo g"
::start cmd /k "cd/d c:\Users\WPXU\Documents\GitHub\blogCode &&hexo s -p 5000"
hexo g
echo g
pause
hexo s -p 5000
echo serve
cmd /k echo
pause