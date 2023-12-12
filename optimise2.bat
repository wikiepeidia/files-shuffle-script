@echo off
setlocal enabledelayedexpansion

if "%~1" == "" (
  echo Usage: FileNameRandomizer {directory} [file mask] - MARKS necessary
  echo.
  echo Examples:
  echo   FileNameRandomizer "C:\Users\phamt\OneDrive - caugiay.edu.vn\Máy tính\New folder"
  echo   FileNameRandomizer ..\testdir * *.txt
  echo   FileNameRandomizer testdir "the file*.*"
  goto :eof
)

pushd %1
if errorlevel 1 goto :eof
set mask=%~2
if "%mask%" == "" set mask=*

echo GET file list...
set namecount=0
for %%A in (%mask%) do (
  set /a namecount+=1
  set name!namecount!=%%A
)
if %namecount% lss 2 (
  echo Need at least two files for shuffling.
  goto :eof
)

echo WORKING IN PROGRESS
mkdir temp
for /l %%A in (1,1,%namecount%) do (
    set /a r=%random%
    copy "!name%%A!" temp\file%%A_!r!.tmp
)

:mkrnd
for /l %%A in (1,1,%namecount%) do (
  set rnd%%A=
)

set i=1
:getrnd
set /a r=%random%%%namecount+1
if not defined rnd%r% (
  set rnd%i%=!r!
  set /a i+=1
  set rnd%r%=1
  if %i% leq %namecount% goto getrnd
)

echo PERFORMING TASK
for /l %%A in (1,1,%namecount%) do (
  echo !name%%A! ^>^> !name!rnd%%A!
  move /y temp\file!rnd%%A!.tmp "!name!rnd%%A!"
)

rmdir /s /q temp
popd
