@echo off
chcp 65001 >nul
title GGUF转换工具 - 带自定义输出

:menu
cls
echo.
echo    ==============================
echo        GGUF转换工具 操作菜单
echo    ==============================
echo.
echo    1. 启动模型转换进程
echo    2. 退出程序
echo.
set /p choice=    请输入选项数字然后回车：

if "%choice%"=="1" goto start_conversion
if "%choice%"=="2" exit /b

echo.
echo     无效的输入，请重新选择
timeout /t 2 >nul
goto menu

:start_conversion
cls
echo.
echo    ==============================
echo        正在准备模型转换...
echo    ==============================
echo.
echo 正在检查Python环境...
if not exist "python\python.exe" (
    echo 错误：未找到Python解释器！
    pause
    goto menu
)

echo 正在检查模型目录...
if not exist "model\" (
    echo 错误：未找到model文件夹！
    pause
    goto menu
)

:get_filename
cls
echo.
echo    ==============================
echo        输出文件名设置
echo    ==============================
echo.
echo 输入规则：
echo   1. 不要包含.g后缀
echo   2. 不要使用特殊字符
echo   3. 直接回车使用默认名称
echo.
set /p outfile=    请输入输出文件名（默认new）：
if "%outfile%"=="" set outfile=new

echo 正在清理特殊字符...
set outfile=%outfile:"=%
set outfile=%outfile:&=%
set outfile=%outfile:|=%

echo 正在启动转换进程...
start "模型转换进程" cmd /k "python\python.exe convert_hf_to_gguf.py model --outfile "%outfile%.gguf" && pause"

goto menu