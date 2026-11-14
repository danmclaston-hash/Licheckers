"""Makes the game sounds from scratch (no copyright, tiny files).
Run: python3 tools/sounds/make_sounds.py"""
import math, os, random, struct, wave

RATE = 22050
OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'app', 'assets', 'sounds')
random.seed(7)

def tock(freq, ms, noise=.35, decay=45.0):
    n = int(RATE * ms / 1000)
    out = []
    for i in range(n):
        t = i / RATE
        env = math.exp(-decay * t)
        s = math.sin(2 * math.pi * freq * t) * .7 + math.sin(2 * math.pi * freq * 2.7 * t) * .2
        s += (random.random() * 2 - 1) * noise * math.exp(-180 * t)
        out.append(s * env)
    return out

def tone(freq, ms, decay=6.0):
    n = int(RATE * ms / 1000)
    return [math.sin(2 * math.pi * freq * i / RATE) * math.exp(-decay * i / RATE)
            * min(1, i / (RATE * .004)) for i in range(n)]

def silence(ms):
    return [0.0] * int(RATE * ms / 1000)

def save(name, samples, gain=.8):
    peak = max(abs(s) for s in samples) or 1
    with wave.open(os.path.join(OUT, name), 'wb') as w:
        w.setnchannels(1); w.setsampwidth(2); w.setframerate(RATE)
        w.writeframes(b''.join(struct.pack('<h', int(s / peak * gain * 32767)) for s in samples))

os.makedirs(OUT, exist_ok=True)
save('move.wav', tock(190, 90))
save('capture.wav', tock(150, 70) + silence(25) + tock(130, 110, noise=.5))
save('king.wav', tone(660, 120, 10) + tone(990, 260, 7), gain=.5)
save('lowtime.wav', tone(880, 90, 18) + silence(70) + tone(880, 90, 18), gain=.45)
save('end.wav', tone(523, 160, 6) + tone(659, 160, 6) + tone(784, 420, 4), gain=.5)
for f in sorted(os.listdir(OUT)):
    print(f, os.path.getsize(os.path.join(OUT, f)), 'bytes')
