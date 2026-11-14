"""Makes every web icon from the owner's logo: app/assets/icon/licheckers.png.
Run: python3 tools/icons/make_icons.py   (needs Pillow)
Change the logo file, run this again, and all sizes update."""
import os
from PIL import Image

HERE = os.path.dirname(os.path.abspath(__file__))
APP = os.path.join(HERE, '..', '..', 'app')
WEB = os.path.join(APP, 'web')
logo = Image.open(os.path.join(APP, 'assets', 'icon', 'licheckers.png')).convert('RGBA')
bg = logo.getpixel((logo.width // 2, logo.height // 12))  # the logo's own dark background

def plain(size):
    return logo.resize((size, size), Image.LANCZOS)

def maskable(size):
    # Phones crop icons into circles or squircles: keep the drawing inside
    # the middle 80 % and fill the rest with the logo's background colour.
    im = Image.new('RGBA', (size, size), bg)
    inner = int(size * .8)
    im.alpha_composite(logo.resize((inner, inner), Image.LANCZOS), ((size - inner) // 2,) * 2)
    return im

os.makedirs(os.path.join(WEB, 'icons'), exist_ok=True)
for s in (192, 512):
    plain(s).save(os.path.join(WEB, 'icons', f'Icon-{s}.png'))
    maskable(s).save(os.path.join(WEB, 'icons', f'Icon-maskable-{s}.png'))
plain(64).save(os.path.join(WEB, 'favicon.png'))
plain(64).save(os.path.join(APP, 'assets', 'icon-64.png'))  # used inside the app
print('icons written; background colour', '#%02X%02X%02X' % bg[:3])
