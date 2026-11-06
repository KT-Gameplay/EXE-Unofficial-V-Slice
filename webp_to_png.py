import os
from PIL import Image

FOLDER_PATH = os.getcwd()

converted = 0
failed = 0

print(f"Scanning: {FOLDER_PATH}\n")

for root, dirs, files in os.walk(FOLDER_PATH):
    for file in files:
        if file.lower().endswith(".webp"):
            webp_path = os.path.join(root, file)
            png_path = os.path.splitext(webp_path)[0] + ".png"

            try:
                with Image.open(webp_path) as img:
                    img.save(png_path, "PNG")

                os.remove(webp_path)

                print(f"[SUCCESS] {file} -> {os.path.basename(png_path)}")
                converted += 1

            except Exception as e:
                print(f"[FAILED] {webp_path}: {e}")
                failed += 1

print("\n========== COMPLETE ==========")
print(f"Converted: {converted}")
print(f"Failed: {failed}")
print("==============================")

input("\nPress Enter to exit...")
