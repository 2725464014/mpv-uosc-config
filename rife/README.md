# RIFE setup

本项目使用 VapourSynth + RIFE 插帧，通过 `mpv-rife.bat` 启动。

## 目录结构

将依赖放置为：

```text
mpv-uosc-config/
├─ mpv-rife.bat
├─ portable_config/
│  └─ vs/rife-anime.vpy
└─ rife/
   ├─ vs/                         # VapourSynth portable runtime
   └─ versions/r9_mod_v6/
      └─ librife_windows_x86-64.dll
```

本仓库中的 `vs/rife-anime.vpy` 需要复制到 mpv 的 `portable_config/vs/`。

## 依赖

- mpv Windows build，需启用 VapourSynth 支持
- VapourSynth 64-bit portable runtime
- RIFE VapourSynth plugin，建议使用 `r9_mod_v6`
- `rife-anime` 模型文件，放在对应版本目录中
- 支持 Vulkan 推理的 GPU 驱动

RIFE plugin 和模型没有提交到本仓库，因为它们是二进制大文件，并且不同发行版的目录结构、运行库依赖可能不同。RIFE ncnn Vulkan 上游下载地址：

https://github.com/nihui/rife-ncnn-vulkan/releases

## 运行

在仓库根目录运行：

```text
mpv-rife.bat "D:\\Videos\\episode.mkv"
```

启动器会自动：

- 设置 VapourSynth Python 和 DLL 搜索路径
- 通过 `RIFE_PLUGIN` 环境变量传入插件路径
- 关闭 Anime4K GLSL，避免与 RIFE 同时占用额外处理链
- 设置 `interpolation=no`
- 设置 `video-sync=audio`
- 以 4 帧缓冲、单并发请求加载 VapourSynth

RIFE 与 mpv 自带的 `interpolation=yes` 不是同一功能，不能同时启用。普通播放使用 `mpv.exe`；RIFE 播放使用 `mpv-rife.bat`。

## 性能取舍

脚本默认把输入缩放到原始分辨率的约 45% 后进行 2 倍插帧，再缩放回原始尺寸。这是针对高分辨率动画和实时播放的性能折中。想提高画质，可以提高 `work_width` / `work_height`，但需要更多 GPU 性能和显存。

不要把 `rife/` 下的 DLL、模型、Python runtime 或日志提交到 Git。仓库根目录的 `.gitignore` 已排除常见二进制、缓存和日志文件。
