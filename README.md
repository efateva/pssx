pssx
====
Netkeeper for Powershell is a ps1 script to dial Shanxun in Windows and Routers.

闪讯Powershell版是一个能在Windows系统和路由器上拨闪讯的ps1脚本。

Features
--------
Netkeeper for Powershell
 - Including username Encryption.
 - TPlink/Mercury/Fast routers support.
 - Windows rasdial support.
 
Usage
-----
First edit sx.ps1 to config your Shanxun account and router parameters:

    ...
    $RouterUrl = "192.168.1.1"
    $RouterPort = "80"
    $RouterUserName = "admin"
    $RouterPassword = "admin"
    ...
    ##闪讯账户
   	$username = "chinanet@xy"
   	$password = "123456"
	
 - In Powershell:  PS YourPath> .\sx.ps1
 - In Explorer  :  Right click on sx.ps1 and choose "使用Powershell运行"
