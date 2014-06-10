pssx
====
Netkeeper for Powershell is a ps1 script to dial Shanxun in Windows and Routers.

闪讯Powershell版是一个能在Windows系统和路由器上拨闪讯的ps1脚本。

Features
--------
Netkeeper for Powershell
 - Including username Encryption.
 - TPlink/Mercury/Fast routers support.
 - Netcore/Alpha routers support(DEMO).
 - Windows rasdial support.
 
Usage
-----
First edit sx.ps1 to config:

    ## Router Parameters
    $RouterUrl = "192.168.1.1"
    $RouterPort = "80"
    $RouterUserName = "admin"
    $RouterPassword = "admin"
    ## Netkeeper Accounts
    $username = "chinanet@xy"
    $password = "123456"
    ## PPPOE Entry
    $pppname = "Netkeeper"
    ## Main
    # 0 Windows
    # 1 TPlink/Mercury/Fast
    # 2 Netcore
    # 3 Alpha
    Dial-Netkeeper(0)
    
	
 - In Powershell:  PS YourPath> .\sx.ps1
 - In Explorer  :  Right click on sx.ps1 and choose "Run with Powershell"
