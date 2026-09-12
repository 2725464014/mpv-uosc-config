@echo off
setlocal

set "MPV_HOME=%~dp0"
set "MLRT_ROOT=%MPV_HOME%rife\vs-mlrt"

set "PLUGIN=%MLRT_ROOT%\vstrt.dll"
set "MODEL=%MLRT_ROOT%\models\rife\rife_v4.6.onnx"
set "ENGINE_DIR=%MLRT_ROOT%\engines"

set "OK=1"

if exist "%PLUGIN%" (
    echo [OK] TensorRT plugin: %PLUGIN%
) else (
    echo [MISSING] TensorRT plugin: %PLUGIN%
    set "OK=0"
)

if exist "%MODEL%" (
    echo [OK] RIFE v4.6 model: %MODEL%
) else (
    echo [MISSING] RIFE v4.6 model: %MODEL%
    set "OK=0"
)

set "ENGINE_COUNT=0"
for /f "delims=" %%F in ('dir /b /s "%ENGINE_DIR%\*.engine" 2^>nul') do (
    set /a ENGINE_COUNT+=1
    echo [OK] TensorRT engine: %%F
)
if %ENGINE_COUNT%==0 (
    echo [MISSING] No TensorRT engine cache. Start mpv-rife.bat once to build it.
    set "OK=0"
)

echo.
echo Launcher target (mpv-rife.bat):
findstr /C:"rife-anime-trt.vpy" "%MPV_HOME%mpv-rife.bat" >nul
if %ERRORLEVEL%==0 (
    for /f "delims=" %%L in ('findstr /C:"rife-anime-trt.vpy" "%MPV_HOME%mpv-rife.bat"') do echo   -> %%L
) else (
    echo   -> Not referencing rife-anime-trt.vpy
)

echo.
if %OK%==1 (
    echo RESULT: TensorRT FP16 RIFE is installed and an engine has been built.
) else (
    echo RESULT: TensorRT setup is incomplete.
)

pause
endlocal
