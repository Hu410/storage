@echo off  
setlocal  
  
:: 切换到你的Git仓库目录（如果脚本不在仓库根目录下）  
:: cd /d C:\path\to\your\repo
  
:: 检查当前目录是否为Git仓库
if not exist .git (
    echo This is not a Git repository.
	pause
    goto end
)

::从远程仓库获取最新的更改
::git pull origin master

:: 获取当前时间，并格式化为YYYY-MM-DD HH:MM:SS的格式
for /f "tokens=2 delims==" %%I in ('wmic OS Get localdatetime /value') do set datetime=%%I

:: 转换datetime格式为YYYY-MM-DD HH:MM
set year=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%
set hour=%datetime:~8,2%
set minute=%datetime:~10,2%
set default_commit_message=%year%-%month%-%day% %hour%:%minute%

:: 添加所有已修改的文件到暂存区
echo Adding all modified files to staging area...
git add .

:: 提示用户输入提交信息，如果为空则使用默认值
set /p user_commit_message="Enter commit message (or press Enter for default): "
if "%user_commit_message%"=="" (
    set commit_message=commit at %default_commit_message%
) else (
    set commit_message=%user_commit_message%
)

:: 提交更改，使用当前时间作为提交描述
git commit -m "%commit_message%"

:: 如果需要，可以在这里添加推送更改到远程仓库的命令
git push -f origin master

echo Script execution completed.

:: 脚本结束前的暂停，以便用户查看输出
pause
:: 脚本结束
:end
endlocal