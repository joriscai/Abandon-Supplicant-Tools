@echo off
title Abandon Supplicant Tools by joriscai
cls
echo             Abandon Supplicant Tools
echo  ================================================
echo        �������ǻ��ڻ���ѧУУ԰��������˫������
echo    �ֻ�������ʵ���������������������ʡ�
echo    ע��DNS����ѧУ��         	--by joriscai
echo  ================================================
ECHO.
call :Main
exit /b 0

:Main
	echo 1.����˫�����������ֹ�
	echo 2.�ָ�Ĭ������
	echo 3.��  ��
	echo ����������(1~3):
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
	echo �������ÿ�ʼ
	echo ������������¥������أ�eg: 172.16.xxx.254��
	set /p inIp=
	if "%inIp%"=="" ( goto :Set-in)
	route -p add 172.16.0.0 mask 255.255.0.0 %inIp% METRIC 1
	echo �������ý���
	call :Set-out
exit /b 0

:Set-out
	ECHO. 
	echo �������ÿ�ʼ
	echo ��������WIFI�����أ�eg: 192.168.xxx.1��
	set /p outIp=
	if "%outIp%"=="" ( goto :Set-out)
	route -p add 0.0.0.0 mask 0.0.0.0 %outIp% METRIC 5
	echo �������ý���,����ԣ�
	pause
	cls
	ECHO.
	goto :Main
exit /b 0

:Restore
	route delete 0.0.0.0
	cls
	route delete 172.16.0.0
	echo �����ָܻ������ز�����������WIFI!
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