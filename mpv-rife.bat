@echo off
setlocal
set "MPV_HOME=%~dp0"
set "RIFE_HOME=%MPV_HOME%rife\vs"
set "VS_PKG=%RIFE_HOME%\Lib\site-packages\vapoursynth"
set "RIFE_PLUGIN=%MPV_HOME%rife\versions\r9_mod_v6\librife_windows_x86-64.dll"
set "PATH=%RIFE_HOME%;%VS_PKG%;%VS_PKG%\plugins;%RIFE_HOME%\vs-plugins;%PATH%"
set "PYTHONHOME=%RIFE_HOME%"
set "VSSCRIPT_PATH=%VS_PKG%\vsscript.dll"
if not exist "%RIFE_PLUGIN%" (
  echo Missing RIFE plugin: "%RIFE_PLUGIN%"
  echo Download/install the r9_mod_v6 plugin before running.
  exit /b 1
)
"%MPV_HOME%mpv.exe" --config-dir="%MPV_HOME%portable_config" --glsl-shaders="" --interpolation=no --video-sync=audio --vf="@rife:vapoursynth=file=~~/vs/rife-anime.vpy:buffered-frames=4:concurrent-frames=1" %*
endlocal
