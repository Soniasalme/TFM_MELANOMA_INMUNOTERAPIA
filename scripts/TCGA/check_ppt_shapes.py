"""Check shapes in slides 14 and 15 of the PPT."""
from pathlib import Path
from pptx import Presentation
from pptx.enum.shapes import MSO_SHAPE_TYPE

ROOT = Path(__file__).resolve().parents[2]
PPT_PATH = ROOT / "PRESENTACION" / "pptx final" / "TFM_Salmeron_Fructuoso_Sonia.pptx"

prs = Presentation(PPT_PATH)

for idx in [13, 14]:
    slide = prs.slides[idx]
    print(f"\n=== Slide {idx+1} ===")
    for i, shape in enumerate(slide.shapes):
        print(f"  Shape {i}: type={shape.shape_type}, name={shape.name}, "
              f"left={shape.left}, top={shape.top}, "
              f"width={shape.width}, height={shape.height}")
        if shape.shape_type == MSO_SHAPE_TYPE.PICTURE:
            print(f"    -> PICTURE: {shape.image.content_type}, size={len(shape.image.blob)} bytes")
