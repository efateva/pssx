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
First edit sx.ps1 to config:

    ...
    $RouterUrl = "192.168.1.1"
    $RouterPort = "80"
    $RouterUserName = "admin"
    $RouterPassword = "admin"
    ...
    ##闪讯账户
    $username = "chinanet@xy"
    $password = "123456"
    ##拨号
    #Dial-Router  #拨路由 (delete the first "#" to take effect)
    #Dial-Windows #拨Windows (delete the first "#" to take effect)
    
	
 - In Powershell:  PS YourPath> .\sx.ps1
 - In Explorer  :  Right click on sx.ps1 and choose "Run with Powershell"
