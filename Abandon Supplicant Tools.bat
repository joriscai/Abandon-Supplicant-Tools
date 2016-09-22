@echo off
title Abandon Supplicant Tools by joriscai
cls
echo             Abandon Supplicant Tools
echo  ================================================
echo        本工具是基于华软学校校园网，利用双网卡和
echo    手机流量，实现抛弃蝴蝶进行外网访问。
echo    注：DNS是用学校的         	--by joriscai
echo  ================================================
ECHO.
call :Main
exit /b 0

:Main
	echo 1.设置双网卡内外网分工
	echo 2.恢复默认设置
	echo 3.退  出
	echo 请输入数字(1~3):
	set "key="
	set /p key= 
	if "%key%"=="" ( goto :Main )
	if not %key%==1 (if not %key%==2 (if not %key%==3 ( goto :Main )))
	if %key%==1 ( call :Set )
    if %key%==2 ( call :Restore )
    if %key%==3 ( exit )
    ECHO.
	pause
exit /b 0

:Set
	call :Delete
	call :Set-in	
	pause
exit /b 0

:Set-in 
	cls
	echo 内网设置开始
	echo 请输入你所在楼层的网关（eg: 172.16.xxx.254）
	set /p inIp=
	if "%inIp%"=="" ( goto :Set-in)
	route -p add 172.16.0.0 mask 255.255.0.0 %inIp% METRIC 1
	echo 内网设置结束
	call :Set-out
exit /b 0

:Set-out
	ECHO. 
	echo 外网设置开始
	echo 请输入你WIFI的网关（eg: 192.168.xxx.1）
	set /p outIp=
	if "%outIp%"=="" ( goto :Set-out)
	route -p add 0.0.0.0 mask 0.0.0.0 %outIp% METRIC 5
	echo 外网设置结束,请测试！
	pause
	cls
	ECHO.
	goto :Main
exit /b 0

:Restore
	route delete 0.0.0.0
	cls
	route delete 172.16.0.0
	echo 若不能恢复，请重插网卡或重连WIFI!
	ECHO.
	pause
	cls
	goto :Main
exit /b 0

:Delete
	@echo off
	cls	
	route delete 0.0.0.0
	cls
	route delete 172.16.0.0
exit /b 0