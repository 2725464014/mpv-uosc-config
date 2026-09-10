# mpv-uosc-config

个人 Windows mpv portable 配置，集成：

- uosc UI
- uosc_danmaku 弹幕
- Anime4K GLSL 着色器
- mpv GPU 插帧
- 可选的 RIFE 启动器方案
- 番剧目录自动载入与上一集/下一集快捷键

## 安装

1. 下载官方 mpv Windows portable 版本，并进入它的 `portable_config` 目录。
2. 将本仓库的 `mpv.conf`、`input.conf` 和 `script-opts/` 复制到该目录。
3. 从官方仓库安装 uosc：
   - https://github.com/tomasklaen/uosc
4. 安装 uosc_danmaku 到 `scripts/uosc_danmaku/`：
   - https://github.com/yinghau76/uosc_danmaku
5. 安装 Anime4K GLSL 文件到 `shaders/`：
   - https://github.com/bloc97/Anime4K
   - 本配置使用 `Anime4K_Clamp_Highlights.glsl`、`Anime4K_Restore_CNN_M.glsl`、`Anime4K_Upscale_CNN_x2_M.glsl`
6. 启动 mpv 播放视频。

## 常用快捷键

| 快捷键 | 功能 |
|---|---|
| `PageDown` | 下一集 |
| `PageUp` | 上一集 |
| `Ctrl+1` / `Ctrl+2` | 开启/关闭 Anime4K |
| `Ctrl+F` | 切换 mpv GPU 插帧 |
| `Ctrl+3` / `Ctrl+4` | 强制开启/关闭 GPU 插帧 |
| `I` | 显示渲染器统计信息 |
| `J` | 弹幕键盘控制 |
| `Ctrl+Shift+D` | 打开弹幕搜索/添加菜单 |
| `Ctrl+Shift+S` | 保存弹幕 |
| `Ctrl+Shift+Y` | 打开弹幕样式菜单 |

## 说明

`interpolation=yes` 是 mpv 自带的 GPU display-resample 插帧，不是 AI RIFE。RIFE 需要单独安装 VapourSynth、模型和对应启动脚本。

## 上游项目

- uosc: https://github.com/tomasklaen/uosc
- uosc_danmaku: https://github.com/yinghau76/uosc_danmaku
- Anime4K: https://github.com/bloc97/Anime4K
