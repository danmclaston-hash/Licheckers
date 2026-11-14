"""Builds app/lib/l10n/app_<lang>.arb from the Python text files here.

Why Python files instead of editing ARB by hand: one place per language,
and this script refuses to build if any language is missing a text or
breaks a {placeholder}. Run:  python3 tools/l10n/build.py
"""
import importlib, json, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, '..', '..', 'app', 'lib', 'l10n')
LANGS = ['en', 'fr', 'sw', 'lg', 'ar', 'pt', 'es']
sys.path.insert(0, HERE)
en = importlib.import_module('en')

def ordered(s):
    """Placeholders in the order they first appear (this becomes the
    order of the Dart function's parameters, so it must be stable)."""
    if ', select,' in s:  # ICU select: only the main variable counts
        return [re.match(r'\{(\w+),', s).group(1)]
    out = []
    for h in re.findall(r'\{(\w+)\}', s):
        if h not in out: out.append(h)
    return out

def holders(s):
    return set(ordered(s))

def arb_key(k):  # ARB keys must be valid Dart names
    return re.sub(r'[^A-Za-z0-9]', '_', k)

errors = []
for lang in LANGS:
    mod = en if lang == 'en' else importlib.import_module(lang)
    T = mod.T
    missing = set(en.T) - set(T)
    extra = set(T) - set(en.T)
    if missing: errors.append(f'{lang}: missing {sorted(missing)}')
    if extra: errors.append(f'{lang}: unknown keys {sorted(extra)}')
    for k, v in T.items():
        if k in en.T and holders(v) != holders(en.T[k]):
            errors.append(f'{lang}.{k}: placeholders {holders(v)} != {holders(en.T[k])}')
    out = {'@@locale': lang}
    for k in en.T:
        if k not in T: continue
        out[arb_key(k)] = T[k]
        if lang == 'en':
            hs = ordered(T[k])
            if hs:
                sel = ', select,' in T[k]
                out['@' + arb_key(k)] = {'placeholders': {
                    h: {'type': 'String' if sel or h not in en.INTS else 'int'} for h in hs}}
    with open(os.path.join(OUT, f'app_{lang}.arb'), 'w', encoding='utf-8') as f:
        json.dump(out, f, ensure_ascii=False, indent=2)
        f.write('\n')

if errors:
    print('\n'.join(errors)); sys.exit(1)
print(f'ok: {len(en.T)} texts x {len(LANGS)} languages')
