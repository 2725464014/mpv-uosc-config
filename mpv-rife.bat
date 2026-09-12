@echo off
setlocal
set "MPV_HOME=%~dp0"
set "RIFE_HOME=%MPV_HOME%rife\vs"
set "MLRT_ROOT=%MPV_HOME%rife\vs-mlrt"
set "VS_PKG=%RIFE_HOME%\Lib\site-packages\vapoursynth"
set "TRT_ENGINE_ROOT=%MLRT_ROOT%\engines"
set "PATH=%MLRT_ROOT%;%MLRT_ROOT%\vsmlrt-cuda;%RIFE_HOME%;%VS_PKG%;%VS_PKG%\plugins;%RIFE_HOME%\vs-plugins;%PATH%"
set "PYTHONHOME=%RIFE_HOME%"
set "VSSCRIPT_PATH=%VS_PKG%\vsscript.dll"
if not exist "%MLRT_ROOT%\vstrt.dll" (
  echo Missing vs-mlrt TensorRT plugin: "%MLRT_ROOT%\vstrt.dll"
  exit /b 1
)
if not exist "%MLRT_ROOT%\models\rife\rife_v4.6.onnx" (
  echo Missing RIFE v4.6 model: "%MLRT_ROOT%\models\rife\rife_v4.6.onnx"
  exit /b 1
)
if not exist "%TRT_ENGINE_ROOT%" mkdir "%TRT_ENGINE_ROOT%"
"%MPV_HOME%mpv.exe" --config-dir="%MPV_HOME%portable_config" --glsl-shaders="" --interpolation=no --video-sync=audio --vf="@rife:vapoursynth=file=~~/vs/rife-anime-trt.vpy:buffered-frames=8:concurrent-frames=2" %*
endlocal
