function shift-right ([int]$numob,[int]$bits){
    $numres=[Math]::Floor(($numob/[Math]::Pow(2,$bits)))
    Write-Output $numres
}
function shift-left ([int]$numob,[int]$bits){
    $numres=($numob*[Math]::Pow(2,$bits))
    Write-Output $numres
}
$username = "12312341234@GDPF.XY"
$RAD = "zjxinlisx01"
$time = (New-Timespan 1/1/1970 $(Get-Date).ToUniversalTime()).TotalSeconds
$timediv5 = [Math]::Floor($time/5)
$timehash = @(0,0,0,0)
for ($i=0;$i -le 3;$i++) {
    for ($j=0;$j -le 7;$j++) {
        $timehash[$i] += (shift-left (((shift-right $timediv5 ($i+4*$j)) -band 1)) (7-$j))
    }
}
$tmp = @(0,0,0,0)
$tmp[0] = ($timediv5 -band 0xff000000)/0x1000000
$tmp[1] = ($timediv5 -band 0xff0000)/0x10000
$tmp[2] = ($timediv5 -band 0xff00)/0x100
$tmp[3] = ($timediv5 -band 0xff)
for ($i=0;$i -le 3;$i++) {
    $PIN0 += [convert]::ToChar($tmp[$i])
}
$bm = "$PIN0"+$username.split('@')[0]+$RAD
$cryptoServiceProvider = [System.Security.Cryptography.MD5CryptoServiceProvider]
$hashAlgorithm = new-object $cryptoServiceProvider
$hashByteArray = $hashAlgorithm.ComputeHash([Char[]]$bm)
foreach ($byte in $hashByteArray) {$bm0 += "{0:X2}" -f $byte}
$pk = $bm0.ToLower().substring(0,2)
$PIN27 = @(0,0,0,0,0,0)
$PIN2 = ''
$PIN27[0] = ((shift-right $timeHash[0] 2) -band 0x3F)
$PIN27[1] = ((shift-left ($timeHash[0] -band 0x03) 4) -band 0xff) -bor ((shift-right $timeHash[1] 4) -band 0x0F)
$PIN27[2] = ((shift-left ($timeHash[1] -band 0x0F) 2) -band 0xff) -bor ((shift-right $timeHash[2] 6) -band 0x03)
$PIN27[3] = $timeHash[2] -band 0x3F
$PIN27[4] = (shift-right $timeHash[3] 2) -band 0x3F
$PIN27[5] = (shift-left ($timeHash[3] -band 0x03) 4) -band 0xff
for ($i=0;$i -le 5;$i++) {
    if ((($PIN27[$i]+0x20) -band 0xff) -lt 0x40) {$PIN27[$i]=(($PIN27[$i]+0x20) -band 0xff)}else {$PIN27[$i]=(($PIN27[$i]+0x21) -band 0xff)}
}
for ($i=0;$i -le 5;$i++) {
    $PIN2 += [convert]::ToChar($PIN27[$i])
}
$PIN = "`n`r"+$PIN2+$pk+$username
