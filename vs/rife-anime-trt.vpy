import os
import sys
from pathlib import Path

import vapoursynth as vs
from vapoursynth import core

# Load the TensorRT VapourSynth plugin and its Python wrapper.
mlrt_root = Path(os.environ["MLRT_ROOT"])
core.std.LoadPlugin(path=str(mlrt_root / "vstrt.dll"))
sys.path.insert(0, str(mlrt_root))
import vsmlrt

if "video_in" not in globals():
    raise ValueError("This script must be used through mpv vapoursynth filter")

clip = video_in
source_width = clip.width
source_height = clip.height

# TensorRT RIFE v4.6 at native resolution. The first run builds a GPU-specific engine.
clip = core.resize.Bicubic(
    clip,
    format=vs.RGBS,
    matrix_in_s="709",
    range_in_s="limited",
    range_s="full",
)

# RIFE v4.x requires both dimensions to be divisible by 32.
# 1920x1080 is padded to 1920x1088 and cropped back after interpolation.
pad_height = (32 - source_height % 32) % 32
if pad_height:
    clip = core.std.AddBorders(clip, bottom=pad_height, color=[0.0, 0.0, 0.0])

backend = vsmlrt.Backend.TRT(
    fp16=True,
    device_id=0,
    num_streams=2,
    use_cuda_graph=True,
    workspace=4 * 1024 * 1024 * 1024,
    engine_folder=os.environ["TRT_ENGINE_ROOT"],
    opt_shapes=(clip.width, clip.height),
    max_shapes=(clip.width, clip.height),
)

clip = vsmlrt.RIFE(
    clip,
    multi=2,
    scale=1.0,
    model=vsmlrt.RIFEModel.v4_6,
    backend=backend,
    video_player=True,
)

# Remove the padding before converting back to the source format.
if pad_height:
    clip = core.std.Crop(clip, bottom=pad_height)

clip = core.resize.Bicubic(
    clip,
    width=source_width,
    height=source_height,
    format=vs.YUV420P10,
    matrix_s="709",
    range_s="limited",
)
clip.set_output()
