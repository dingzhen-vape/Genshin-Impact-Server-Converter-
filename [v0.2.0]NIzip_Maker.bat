::By Golden_nianhua https://space.bilibili.com/307409565
@echo off
%1 mshta vbscript:createobject("shell.application").shellexecute("%~f0","::","","runas",1)(window.close)& exit
cd /d %~dp0
chcp 936 1>nul
setlocal ENABLEDELAYEDEXPANSION


:st
call :delCache
set Bat.version=0.2.0
set title=原神下载器-换服包特供[v%Bat.version%] By Golden_nianhua
title %title%

:winv
ver|findstr "6\.1\.7601\.[0-9]*">nul&& set winv=7 SP1
ver|findstr "6\.2\.[0-9]*\.[0-9]*">nul&& set winv=8
ver|findstr "6\.3\.[0-9]*\.[0-9]*">nul&& set winv=8.1
ver|findstr "10\.0\.1[0-9]*\.[0-9]*">nul&& set winv=10
ver|findstr "10\.0\.2[0-9]*\.[0-9]*">nul&& set winv=11
(
    echo 系统版本：Windows %winv%
) >info.txt
cls & call :info
if "%winv%"=="" echo 不受支持的系统版本& pause &exit

:nt6
title %title% 下载依赖中
curl -h >nul 2>nul|| call :addcurlpath ".\curl\bin\"
curl -h >nul 2>nul&& goto :dependence
cls & call :info
echo curl工具无法正常使用，已自动打开下载网页
start https://vgn.lanzouw.com/i7ZH10ley6ub?
echo https://vgn.lanzouw.com/i7ZH10ley6ub?
echo 下载完成后，请将[GDD NT 6.exe]与脚本放到同一目录
pause
ren "GDD NT 6*.exe" "GDD NT 6.exe"
if not exist "GDD NT 6.exe" goto :nt6
"GDD NT 6.exe" -y
del "GDD NT 6.exe"

:dependence
set dcount=0
cls & call :info

:d7z
if %dcount% GEQ 10 goto :nt10
7z.exe -h >nul 2>nul&& goto :djq
echo 下载7z.exe...
curl -L --connect-timeout 3 -o "7zInstaller.exe" "https://7-zip.org/a/7z2201-x64.exe"||( set /a dcount=%dcount%+1& goto :d7z)
7zInstaller.exe /S /D="%~dp07z"
move "7z\7z.exe" ".\" >nul
move "7z\7z.dll" ".\" >nul
rd "7z\" /s /q
del /q "7zInstaller.exe"
7z.exe -h >nul 2>nul||( set /a dcount=%dcount%+1& goto :d7z)

:djq
if %dcount% GEQ 10 goto :nt10
jq.exe -h >nul 2>nul&& goto :daria2c 
echo 下载jq.exe...
curl -L --connect-timeout 3 -o "jq.exe" "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe"
jq.exe -h >nul 2>nul||( set /a dcount=%dcount%+1& goto :djq)

:daria2c
if %dcount% GEQ 10 goto :nt10
aria2c.exe -h >nul 2>nul&& goto :dhdiffpatch
echo 下载ariac.exe...
curl -L --connect-timeout 3 -o "aria2.zip" "https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0-win-64bit-build1.zip"||( set /a dcount=%dcount%+1& goto :daria2c)
7z e "aria2.zip" "aria2-1.36.0-win-64bit-build1\aria2c.exe" -aoa
del /q "aria2.zip"
aria2c.exe -h >nul 2>nul||( set /a dcount=%dcount%+1& goto :daria2c)

:dhdiffpatch
if %dcount% GEQ 10 goto :nt10
hpatchz.exe -h >nul 2>nul&& goto :getResource
set tag_name=
echo 下载hpatchz.exe...
for /f "delims=*" %%a in ('curl -L --connect-timeout 3 "https://api.github.com/repos/sisong/HDiffPatch/releases/latest"^|jq -r .tag_name') do (
    if "%%a"=="" (
        set /a dcount=%dcount%+1
        goto :dhdiffpatch
    ) else set tag_name=%%a
)
curl -L --connect-timeout 3 -o "hdiffpatch.zip" "https://github.com/sisong/HDiffPatch/releases/download/%tag_name%/hdiffpatch_%tag_name%_bin_windows64.zip"||( set /a dcount=%dcount%+1& goto :dhdiffpatch)
7z e "hdiffpatch.zip" "windows64\hpatchz.exe" -aoa
del /q "hdiffpatch.zip"
hpatchz.exe -h >nul 2>nul||( set /a dcount=%dcount%+1& goto :dhdiffpatch)
goto :getResource

:nt10
cls & call :info
echo 多次下载失败，已自动打开下载网页
start https://vgn.lanzouw.com/ib5XR0ley70h?
echo https://vgn.lanzouw.com/ib5XR0ley70h?
echo 下载完成后，请将[GDD NT 10.exe]与脚本放到同一目录
pause
ren "GDD NT 10*.exe" "GDD NT 10.exe"
if not exist "GDD NT 10.exe" goto :nt10
"GDD NT 10.exe" -y
del "GDD NT 10.exe"


:getResource
title %title% pkg下载中
cls & call :info
echo 获取resource...
curl -L --connect-timeout 3 -o "resourceN.json" "https://sdk-static.mihoyo.com/hk4e_cn/mdk/launcher/api/resource?launcher_id=17&key=KAtdSsoQ&channel_id=14"||( timeout /T 3 /NOBREAK >nul& goto :getResource)
curl -L --connect-timeout 3 -o "resourceI.json" "https://hk4e-launcher-static.hoyoverse.com/hk4e_global/mdk/launcher/api/resource?key=gcStgarh&launcher_id=10&sub_channel_id=3"|| curl -L --connect-timeout 3 -o "resource.json" "http://sdk-os-static.hoyoverse.com/hk4e_global/mdk/launcher/api/resource?key=gcStgarh&launcher_id=10&sub_channel_id=3"||( timeout /T 3 /NOBREAK >nul& goto :getResource)

for /f "delims=*" %%a in ('jq -r ".data.pre_download_game.latest.version" "resourceN.json"') do (
    if "%%a"=="null" (
        cls & call :info
        echo 未在预下载时段，按任意键继续以制作当前版本换服包
        set gameIndex=.data.game.latest
        pause >nul
    ) else set gameIndex=.data.pre_download_game.latest
)

for /f "delims=*" %%a in ('jq -r "%gameIndex%.version" "resourceN.json"') do (
    set version=%%a
    set title=%title% %version%
    title %title% pkg下载中
)
for /f "delims=*" %%a in ('jq -r "%gameIndex%.decompressed_path" "resourceN.json"') do set dcpURLN=%%a
for /f "delims=*" %%a in ('jq -r "%gameIndex%.decompressed_path" "resourceI.json"') do set dcpURLI=%%a

:getPkg
curl -L --connect-timeout 3 "%dcpURLN%/pkg_version" 1>pkgN||( timeout /T 3 /NOBREAK 1>nul& goto :getPkg)
curl -L --connect-timeout 3 "%dcpURLI%/pkg_version" 1>pkgI||( timeout /T 3 /NOBREAK 1>nul& goto :getPkg)

cls & call :info
title %title% 文件比对中
call :gfc

title %title% 链接整合中
(
    for /f "delims=*" %%a in (dfileN) do (
        echo %dcpURLN%/%%a
        echo  out=National/%%a
    )
    for /f "delims=*" %%a in (dfileI) do (
        echo %dcpURLI%/%%a
        echo  out=International/%%a
    )
) >filelist.txt

title %title% 下载中
rd "National\" /s /q
rd "International\" /s /q
aria2c -i "filelist.txt" -c -j 20 -s 10 --file-allocation=none

call :creatconfig "National"
call :creatconfig "International"
7z a [%version:~,3%]原神国际服转国服.zip ".\National\*" -r
7z a [%version:~,3%]原神国服转国际服.zip ".\International\*" -r
call :delCache
cls & call :info
title %title% 制作成功
mshta vbscript:Execute("MsgBox ""%version:~,3%换服包制作成功，感谢使用"",0,""原神下载器-换服包特供 By Golden_nianhua""")(window.close)
goto :eof

:info
echo ----------------------------
echo 原神下载器-换服包特供[v%Bat.version%] By Golden_nianhua
echo B站主页 https://space.bilibili.com/307409565
if exist info.txt for /f "delims=*" %%a in (info.txt) do echo %%a
echo ----------------------------
goto :eof

:delCache
(
    del filelist.txt
    del info.txt
    del resourceI.json
    del resourceN.json
    del pkgI
    del pkgN
) 2>nul
goto :eof

:creatconfig
(
echo [General]
echo game_version=%version%
echo channel=1
) >"%~1\config.ini"
(
echo https://www.bilibili.com/read/cv15768559
) >"%~1\使用方法.txt"
goto :eof

:gfc
setlocal
jq -r ".remoteName,.md5" "pkgN" >reN_
jq -r ".remoteName,.md5" "pkgI" >reI_
(
    echo reN
    set count=0
    for /f "delims=*" %%a in (reN_) do (
        set /a count+=1
        if !count!==1 set re=%%a
        if !count!==2 (
            echo !re!:%%a
            set count=0
        )
    )
) >reN
(
    echo reI
    set count=0
    for /f "delims=*" %%a in (reI_) do (
        set /a count+=1
        if !count!==1 set re=%%a
        if !count!==2 (
            echo !re:GenshinImpact=YuanShen!:%%a
            set count=0
        )
    )
) >reI
del reN_
del reI_
for /f "tokens=3*" %%a in ('find /V "" /C "reN"') do set lineN=%%a
for /f "tokens=3*" %%a in ('find /V "" /C "reI"') do set lineI=%%a
set skipN=1
set skipI=1
( echo dfileN) >dfileN
( echo dfileI) >dfileI
:gfc2
for /f "delims=: tokens=1* skip=%skipN%" %%a in (reN) do (
    set remoteNameN=%%a
    set md5N=%%b
    if %skipI% GEQ %lineI% (
        ( for /f "delims=: tokens=1* skip=%skipN%" %%a in (reN) do echo %%a) >>dfileN
        goto :gfc6
    ) else (
        for /f "delims=: tokens=1* skip=%skipI%" %%a in (reI) do (
            set remoteNameI=%%a
            if "!remoteNameN!"=="%%a" (
                if not "!md5N!"=="%%b" (
                    ( echo !remoteNameN!) >>dfileN
                    ( echo !remoteNameI:YuanShen=GenshinImpact!) >>dfileI
                )
            ) else goto :gfc3
            set /a skipN+=1
            set /a skipI+=1
            if !skipN! GEQ !lineN! goto :gfc5
            goto :gfc2
        )
    )
)
:gfc3
set count=0
set sI=%skipI%
if exist "dfileI_" del dfileI_
for /f "delims=: tokens=1* skip=%sI%" %%a in (reI) do (
    set reI=%%a
    if "%remoteNameN%"=="%%a" (
        set skipI=!sI!
        if exist "dfileI_" copy /b "dfileI"+"dfileI_" >nul
        goto :gfc2
    )
    set /a sI+=1
    ( echo !reI:YuanShen=GenshinImpact!) >>dfileI_
    if !sI! GEQ %lineI% goto :gfc4
    if !count! GEQ 10 goto :gfc4
    set /a count+=1
)
:gfc4
set count=0
set sN=%skipN%
if exist "dfileN_" del dfileN_
for /f "delims=: tokens=1* skip=%sN%" %%a in (reN) do (
    if "%remoteNameI%"=="%%a" (
        set skipN=!sN!
        if exist "dfileN_" copy /b "dfileN"+"dfileN_" >nul
        goto :gfc2
    )
    set /a sN+=1
    ( echo %%a) >>dfileN_
    if !sN! GEQ %lineN% (
        ( echo %remoteNameN%) >>dfileN
        ( echo %remoteNameI:YuanShen=GenshinImpact%) >>dfileI
        set /a skipN+=1
        set /a skipI+=1
        if !skipN! GEQ !lineN! goto :gfc5
        goto :gfc2
    )
    if !count! GEQ 10 (
        ( echo %remoteNameN%) >>dfileN
        ( echo %remoteNameI:YuanShen=GenshinImpact%) >>dfileI
        set /a skipN+=1
        set /a skipI+=1
        goto :gfc2
    )
    set /a count+=1
)
:gfc5
( for /f "delims=: tokens=1* skip=%skipI%" %%a in (reI) do echo %%a) >>dfileI
:gfc6
(
    del reI
    del reN
    del dfileI_
    del dfileN_
) 2>nul
goto :eof