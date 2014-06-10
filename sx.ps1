## Encoding Username
function Shift-Right ([int]$numob,[int]$bits){
    $numres=[Math]::Floor(($numob/[Math]::Pow(2,$bits)))
    Write-Output $numres
}
function Shift-Left ([int]$numob,[int]$bits){
    $numres=($numob*[Math]::Pow(2,$bits))
    Write-Output $numres
}
function Get-PIN ($PIN0){
    $RAD = "zjxinlisx01"
    $time = (New-Timespan 1/1/1970 $(Get-Date).ToUniversalTime()).TotalSeconds
    $timediv5 = [Math]::Floor($time/5)
    $timehash = @(0,0,0,0)
    for ($i=0;$i -le 3;$i++) {
        for ($j=0;$j -le 7;$j++) {
            $timehash[$i] += (Shift-Left (((Shift-Right $timediv5 ($i+4*$j)) -band 1)) (7-$j))
        }
    }
    $tmp = @(0,0,0,0)
    $tmp[0] = ($timediv5 -band 0xff000000)/0x1000000
    $tmp[1] = ($timediv5 -band 0xff0000)/0x10000
    $tmp[2] = ($timediv5 -band 0xff00)/0x100
    $tmp[3] = ($timediv5 -band 0xff)
    for ($i=0;$i -le 3;$i++) {
        $PIN1 += [convert]::ToChar($tmp[$i])
    }
    $bm = "$PIN1"+$username.split('@')[0]+$RAD
    $cryptoServiceProvider = [System.Security.Cryptography.MD5CryptoServiceProvider]
    $hashAlgorithm = new-object $cryptoServiceProvider
    $hashByteArray = $hashAlgorithm.ComputeHash([Char[]]$bm)
    foreach ($byte in $hashByteArray) {$bm0 += "{0:X2}" -f $byte}
    $pk = $bm0.ToLower().substring(0,2)
    $PIN27 = @(0,0,0,0,0,0)
    $PIN2 = ''
    $PIN27[0] = ((Shift-Right $timeHash[0] 2) -band 0x3F)
    $PIN27[1] = ((Shift-Left ($timeHash[0] -band 0x03) 4) -band 0xff) -bor ((Shift-Right $timeHash[1] 4) -band 0x0F)
    $PIN27[2] = ((Shift-Left ($timeHash[1] -band 0x0F) 2) -band 0xff) -bor ((Shift-Right $timeHash[2] 6) -band 0x03)
    $PIN27[3] = $timeHash[2] -band 0x3F
    $PIN27[4] = (Shift-Right $timeHash[3] 2) -band 0x3F
    $PIN27[5] = (Shift-Left ($timeHash[3] -band 0x03) 4) -band 0xff
    for ($i=0;$i -le 5;$i++) {
        if ((($PIN27[$i]+0x20) -band 0xff) -lt 0x40) {$PIN27[$i]=(($PIN27[$i]+0x20) -band 0xff)} else {$PIN27[$i]=(($PIN27[$i]+0x21) -band 0xff)}
    }
    for ($i=0;$i -le 5;$i++) {
        $PIN2 += [convert]::ToChar($PIN27[$i])
    }
    $PIN = "`r`n"+$PIN2+$pk+$username
    $PIN
}
## Dial
function Dial-Netkeeper($Dialway){
    $realusername = Get-PIN($username)
    if ($Dialway -eq 0){
        rasdial $pppname $realusername $password
        #netsh wlan start hostednetwork
    }
    else {    
        [void][Reflection.Assembly]::LoadWithPartialName("System.Web")
        $PIN_urlencoded = [Web.HttpUtility]::UrlEncode("$realusername")
        $Authorization = "Basic "+[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($RouterUserName+":"+$RouterPassword))
        $RouterRequest = "http://"+$RouterUrl+":"+$RouterPort
        $headers = @{Authorization = $Authorization;"Accept-Encoding" = "gzip,deflate,sdch"}
        switch ($Dialway){
            1 { $RouterRequest += "/userRpm/PPPoECfgRpm.htm?wantype=2&VnetPap=0&acc=$PIN_urlencoded&psw=$password&confirm=$password&SecType=1&linktype=4&waittime2=0&Connect=%C1%AC+%BD%D3"
                $headers += @{Cookie = 'Authorization='+$Authorization;Referer = $RouterRequest}
                $response = Invoke-WebRequest $RouterRequest -Headers $headers -UseBasicParsing }
            2 { $RouterRequest += "/wan_work_mode_pppoeset.cgi"
                $response = Invoke-WebRequest $RouterRequest -Headers $headers -UseBasicParsing -Method Post -Body "mac_clone_value=null&mtu_value=1492&pppoe_connect_mode=3&apply=+%D3%A6%D3%C3+&pppoe_account=$PIN_urlencoded&pppoe_password=$password" }
            3 { $RouterRequest += "/ppp.cgi?type=ppp0_apply&L_sod=DISABL&autostart=ENABLE&L_sod=DISABLE&idletime=0&L_ipnego=ENABLE&T_to_hour=0&T_to_min=0&ppp_mtu=1492&user_name=$PIN_urlencoded&password=$password"
                $response = Invoke-WebRequest $RouterRequest -Headers $headers -UseBasicParsing }
        }
        $getip = "IP : "+(Invoke-WebRequest http://www.cz88.net/ip/viewip468_25.aspx -TimeoutSec 2).Links[0].innerText
        $getip
    }
}
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