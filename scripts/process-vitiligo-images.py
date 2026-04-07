#!/usr/bin/env python3
"""
Process vitiligo images:
1. Read EXIF dates (falls back to file modification date)
2. Detect face using macOS Vision framework and crop with padding
3. Convert to JPEG at consistent size
4. Copy into public/vitiligo/ with date-based filenames
5. Generate src/data/vitiligo-entries.ts grouped by month
"""

import os
import re
import subprocess
from collections import defaultdict
from datetime import datetime
from pathlib import Path

from PIL import Image

SRC_DIR = Path("/Users/mart/Code/vitiligo")
DST_DIR = Path("/Users/mart/Code/heymart/public/vitiligo")
ENTRIES_FILE = Path("/Users/mart/Code/heymart/src/data/vitiligo-entries.ts")
R2_BASE_URL = "https://pub-9f715203429d4980835940686b854b49.r2.dev"
OUTPUT_SIZE = 800
SUPPORTED_EXT = {".heic", ".jpg", ".jpeg", ".png"}


def get_exif_date(filepath: Path) -> str | None:
    """Try DateTimeOriginal, then CreateDate via exiftool."""
    for tag in ("DateTimeOriginal", "CreateDate"):
        result = subprocess.run(
            ["exiftool", f"-{tag}", "-s3", "-d", "%Y-%m-%d %H:%M:%S", str(filepath)],
            capture_output=True, text=True,
        )
        val = result.stdout.strip()
        if val and re.match(r"\d{4}-\d{2}-\d{2}", val):
            return val
    return None


def get_file_mod_date(filepath: Path) -> str:
    """Fallback: file modification time."""
    mtime = os.path.getmtime(filepath)
    return datetime.fromtimestamp(mtime).strftime("%Y-%m-%d %H:%M:%S")


def convert_image(filepath: Path, out_path: Path):
    """
    Convert to JPEG and resize so the longest side is OUTPUT_SIZE.
    No cropping — preserves aspect ratio.
    """
    try:
        img = Image.open(filepath)
    except Exception:
        # HEIC files may not open directly — convert via sips first
        tmp = out_path.with_suffix(".tmp.jpg")
        subprocess.run(
            ["sips", "-s", "format", "jpeg", str(filepath), "--out", str(tmp)],
            capture_output=True,
        )
        img = Image.open(tmp)
        tmp.unlink()

    from PIL import ImageOps
    img = ImageOps.exif_transpose(img)

    # Resize preserving aspect ratio (fit within OUTPUT_SIZE box)
    img.thumbnail((OUTPUT_SIZE, OUTPUT_SIZE), Image.LANCZOS)

    if img.mode == "RGBA":
        img = img.convert("RGB")
    img.save(out_path, "JPEG", quality=85)


def main():
    DST_DIR.mkdir(parents=True, exist_ok=True)

    # Clear old outputs
    for old in DST_DIR.glob("*.jpg"):
        old.unlink()

    files = sorted([
        f for f in SRC_DIR.iterdir()
        if f.suffix.lower() in SUPPORTED_EXT
    ])
    print(f"Found {len(files)} images in {SRC_DIR}")

    month_images: dict[str, list[str]] = defaultdict(list)
    no_exif: list[tuple[str, str]] = []
    counter: dict[str, int] = defaultdict(int)

    for i, f in enumerate(files, 1):
        exif_date = get_exif_date(f)
        used_fallback = False
        if exif_date:
            date_str = exif_date
        else:
            date_str = get_file_mod_date(f)
            used_fallback = True

        date_part = date_str[:10]
        time_part = date_str[11:].replace(":", "")
        month_key = date_part[:7]

        counter[date_part] += 1
        idx = counter[date_part]
        out_name = f"{date_part}_{time_part}_{idx:02d}.jpg"
        out_path = DST_DIR / out_name

        prefix = f"[{i}/{len(files)}]"
        convert_image(f, out_path)

        status = "[NO EXIF] " if used_fallback else ""
        if used_fallback:
            no_exif.append((f.name, date_part))

        print(f"  {prefix} {status}{f.name} -> {out_name}")

        month_images[month_key].append(f"/vitiligo/{out_name}")

    for key in month_images:
        month_images[key].sort()

    # Generate entries TS file
    months_sorted = sorted(month_images.keys())

    lines = [
        'export interface VitiligoEntry {',
        '  date: string; // YYYY-MM format',
        '  text: string;',
        '  images: string[];',
        '}',
        '',
        '// Sorted newest first',
        'export const entries: VitiligoEntry[] = [',
    ]

    for month_key in reversed(months_sorted):
        images = month_images[month_key]
        images_str = ",\n".join(f'    "{img}"' for img in images)
        lines.append('  {')
        lines.append(f'    date: "{month_key}",')
        lines.append('    text: "",')
        lines.append('    images: [')
        lines.append(images_str)
        lines.append('    ],')
        lines.append('  },')

    lines.append('];')
    lines.append('')

    ENTRIES_FILE.write_text("\n".join(lines))

    print(f"\nDone! {len(files)} images -> {len(months_sorted)} monthly entries")

    if no_exif:
        print(f"\n--- NO EXIF DATE (used file mod date) ---")
        for name, date in sorted(no_exif, key=lambda x: x[1]):
            print(f"  {date}  {name}")


if __name__ == "__main__":
    main()
