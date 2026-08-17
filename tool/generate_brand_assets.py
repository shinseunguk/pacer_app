#!/usr/bin/env python3
"""브랜드 이미지(앱 아이콘·스플래시 마크) 생성기.

디자인 시안(docs/design)의 로고마크 `PacerMark` — 62% 진행한 페이스 링 +
러너 도트 — 를 그대로 그린다. 색은 시안의 oklch 토큰을 sRGB로 변환한 값이다.

사용:
    pip install pillow
    python3 tool/generate_brand_assets.py
    dart run flutter_launcher_icons
    dart run flutter_native_splash:create
"""

import math
from pathlib import Path

from PIL import Image, ImageDraw

SIZE = 1024
SUPERSAMPLE = 4  # 링을 매끈하게 그리려고 4배로 그린 뒤 축소한다
OUTPUT_DIR = Path(__file__).resolve().parent.parent / "assets" / "brand"

ACCENT = (0x8E, 0x9A, 0xFF, 255)  # oklch(0.72 0.15 277)
ACCENT_2 = (0x72, 0x7B, 0xED, 255)  # oklch(0.63 0.17 277)
ACCENT_SOFT = (0x8E, 0x9A, 0xFF, 0x50)
ON_ACCENT = (0xFC, 0xFC, 0xFD, 255)
TRANSPARENT = (0, 0, 0, 0)

PROGRESS = 0.62  # 링이 도는 비율


def diagonal_gradient(size: int, start: tuple, end: tuple) -> Image.Image:
    """시안 히어로와 같은 140° 방향 그라데이션."""
    image = Image.new("RGBA", (size, size))
    draw = ImageDraw.Draw(image)
    for y in range(size):
        for_x_ratio = y / (size - 1)
        color = tuple(
            int(start[i] + (end[i] - start[i]) * for_x_ratio) for i in range(4)
        )
        draw.line([(0, y), (size, y)], fill=color)
    return image


def draw_mark(
    draw: ImageDraw.ImageDraw,
    center: tuple,
    radius: float,
    stroke: float,
    ring_color: tuple,
    track_color: tuple,
) -> None:
    box = [
        center[0] - radius,
        center[1] - radius,
        center[0] + radius,
        center[1] + radius,
    ]
    draw.ellipse(box, outline=track_color, width=int(stroke))
    # PIL의 각도는 3시 방향 0도 → 12시에서 시작하려면 -90도.
    draw.arc(box, -90, -90 + 360 * PROGRESS, fill=ring_color, width=int(stroke))

    angle = math.radians(-90 + 360 * PROGRESS)
    dot_r = stroke * 0.95
    dot_center = (
        center[0] + radius * math.cos(angle),
        center[1] + radius * math.sin(angle),
    )
    draw.ellipse(
        [
            dot_center[0] - dot_r,
            dot_center[1] - dot_r,
            dot_center[0] + dot_r,
            dot_center[1] + dot_r,
        ],
        fill=ring_color,
    )

    core_r = stroke * 0.7
    draw.ellipse(
        [
            center[0] - core_r,
            center[1] - core_r,
            center[0] + core_r,
            center[1] + core_r,
        ],
        fill=ring_color,
    )


def render(background, mark_ratio: float, mark_color: tuple,
           track_color: tuple) -> Image.Image:
    """background가 None이면 투명 배경 위에 마크만 그린다."""
    size = SIZE * SUPERSAMPLE
    canvas = Image.new("RGBA", (size, size), TRANSPARENT)
    draw = ImageDraw.Draw(canvas)

    radius = size * mark_ratio / 2
    draw_mark(
        draw,
        (size / 2, size / 2),
        radius,
        radius * 0.20,
        mark_color,
        track_color,
    )
    canvas = canvas.resize((SIZE, SIZE), Image.LANCZOS)

    if background is None:
        return canvas

    result = background.copy()
    result.alpha_composite(canvas)
    return result


def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    # 런처 아이콘: 액센트 그라데이션 위에 흰 마크
    icon_bg = diagonal_gradient(SIZE, ACCENT, ACCENT_2)
    render(icon_bg, 0.52, ON_ACCENT, (255, 255, 255, 0x55)).save(
        OUTPUT_DIR / "app_icon.png"
    )

    # 적응형 아이콘 전경: 바깥 33%가 잘릴 수 있어 작게
    render(None, 0.40, ON_ACCENT, (255, 255, 255, 0x55)).save(
        OUTPUT_DIR / "app_icon_foreground.png"
    )

    # 스플래시: 다크 배경 위 액센트 마크
    render(None, 0.46, ACCENT, ACCENT_SOFT).save(OUTPUT_DIR / "splash_mark.png")

    print(f"생성 완료: {OUTPUT_DIR}")


if __name__ == "__main__":
    main()
