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
  set/a namecount+=1
  set name!namecount!=%%A
)
if %namecount% == 0 (
  echo No file found.
  goto :eof
)

echo WORKING IN progrESS
:mkrnd
for /l %%A in (1,1,%namecount%) do (
  set tmp%%A=!name%%A!
  set rnd%%A=
)
set i=1
:getrnd
set/a r=%random%%%namecount+1
if %r% == %i% (
  if %r% == %namecount% goto mkrnd
  goto getrnd
)
if "!tmp%r%!" == "" goto getrnd
set rnd%i%=!tmp%r%!
set tmp%r%=
set/a i+=1
if %i% leq %namecount% goto getrnd


echo PERFORMING TASK
for /l %%A in (1,1,%namecount%) do (
  set tmp%%A=file%%A.tmp
  ren "!name%%A!" !tmp%%A!
)
for /l %%A in (1,1,%namecount%) do (
  echo !name%%A! ^>^> !rnd%%A!
  ren !tmp%%A! "!rnd%%A!"
)