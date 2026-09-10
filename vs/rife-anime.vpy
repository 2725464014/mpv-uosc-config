import os
from pathlib import Path

import vapoursynth as vs
from vapoursynth import core

# The launcher supplies this path so the config remains portable.
plugin_path = os.environ.get("RIFE_PLUGIN")
if not plugin_path:
    raise EnvironmentError("RIFE_PLUGIN is not set; start mpv through mpv-rife.bat")
plugin = Path(plugin_path)
if not plugin.is_file():
    raise FileNotFoundError(f"RIFE plugin not found: {plugin}")
core.std.LoadPlugin(path=str(plugin))

if "video_in" not in globals():
    raise ValueError("This script must be used through mpv vapoursynth filter")

clip = video_in
source_width = clip.width
source_height = clip.height
# Run RIFE at 45% resolution, then restore source size.
work_width = max(64, ((source_width * 9 // 20) // 32) * 32)
work_height = max(64, ((source_height * 9 // 20) // 32) * 32)
clip = core.resize.Bicubic(
    clip,
    width=work_width,
    height=work_height,
    format=vs.RGBS,
    matrix_in_s="709",
)
clip = core.rife.RIFE(
    clip,
    model=3,
    factor_num=2,
    factor_den=1,
    gpu_id=0,
    gpu_thread=1,
    tta=False,
    uhd=False,
)
clip = core.resize.Bicubic(
    clip,
    width=source_width,
    height=source_height,
    format=vs.YUV420P10,
    matrix_s="709",
)
clip.set_output()
