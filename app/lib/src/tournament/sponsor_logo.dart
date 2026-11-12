import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

/// Sponsor logos: checks, loading from a link, and finding the main colour.
///
/// The real safety check (adult content, fake brands) needs the server and a
/// person. Until then a logo is marked "waiting for check" and only the host
/// sees it.

const maxLogoBytes = 2 * 1024 * 1024; // 2 MB
const _okExt = {'png', 'jpg', 'jpeg', 'webp'};

class LogoError implements Exception {
  final String message;
  const LogoError(this.message);
  @override
  String toString() => message;
}

/// null = fine, otherwise a plain reason.
String? logoFileProblem(String name, int size) {
  final dot = name.lastIndexOf('.');
  final ext = dot < 0 ? '' : name.substring(dot + 1).toLowerCase();
  if (ext == 'svg') {
    return 'SVG files will be accepted once the server can convert them safely. '
        'For now please use PNG or JPG.';
  }
  if (ext.isNotEmpty && !_okExt.contains(ext)) {
    return 'Please use a PNG, JPG or WebP picture.';
  }
  if (size > maxLogoBytes) return 'The picture is too big. Keep it under 2 MB.';
  if (size == 0) return 'The file is empty.';
  return null;
}

/// Downloads a picture from a link.
Future<Uint8List> fetchLogo(String link) async {
  final uri = Uri.tryParse(link.trim());
  if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
    throw const LogoError('Use a full link that starts with https://');
  }
  http.Response r;
  try {
    r = await http.get(uri).timeout(const Duration(seconds: 15));
  } catch (_) {
    throw const LogoError(
        'Could not load that link. Some websites block other apps from using '
        'their pictures. Download the picture and use Upload instead.');
  }
  if (r.statusCode != 200) {
    throw LogoError('The website answered with an error (${r.statusCode}).');
  }
  final type = r.headers['content-type'] ?? '';
  if (type.contains('svg')) throw LogoError(logoFileProblem('x.svg', 1)!);
  if (type.isNotEmpty && !type.startsWith('image/')) {
    throw const LogoError('That link is a web page, not a picture. '
        'Open the picture itself and copy its address.');
  }
  final err = logoFileProblem(uri.path, r.bodyBytes.length);
  if (err != null) throw LogoError(err);
  return r.bodyBytes;
}

/// The main colour of a picture, ignoring see-through, near-white,
/// near-black and grey parts. Throws [LogoError] if it is not a picture.
Future<Color> logoColour(Uint8List bytes) async {
  ui.Image img;
  try {
    final codec = await ui.instantiateImageCodec(bytes, targetWidth: 48);
    img = (await codec.getNextFrame()).image;
  } catch (_) {
    throw const LogoError('This file is not a picture we can read.');
  }
  final data = await img.toByteData(format: ui.ImageByteFormat.rawRgba);
  img.dispose();
  if (data == null) throw const LogoError('This file is not a picture we can read.');
  return dominantFromRgba(data.buffer.asUint8List()) ?? const Color(0xFF1976D2);
}

/// Pure maths, so it can be tested: groups similar colours and returns the
/// most common lively one. null if the picture has no lively colour.
Color? dominantFromRgba(Uint8List rgba) {
  final score = <int, double>{};
  final sum = <int, List<int>>{};
  for (var i = 0; i + 3 < rgba.length; i += 4) {
    final r = rgba[i], g = rgba[i + 1], b = rgba[i + 2], a = rgba[i + 3];
    if (a < 128) continue;
    final mx = [r, g, b].reduce((x, y) => x > y ? x : y);
    final mn = [r, g, b].reduce((x, y) => x < y ? x : y);
    if (mx < 30 || mn > 225) continue; // near black / near white
    final sat = mx == 0 ? 0.0 : (mx - mn) / mx;
    if (sat < .2) continue; // grey
    final key = (r >> 5) << 6 | (g >> 5) << 3 | (b >> 5);
    score[key] = (score[key] ?? 0) + .4 + sat;
    final s = sum.putIfAbsent(key, () => [0, 0, 0, 0]);
    s[0] += r;
    s[1] += g;
    s[2] += b;
    s[3]++;
  }
  if (score.isEmpty) return null;
  final best = score.entries.reduce((x, y) => x.value >= y.value ? x : y).key;
  final s = sum[best]!;
  return Color.fromARGB(255, s[0] ~/ s[3], s[1] ~/ s[3], s[2] ~/ s[3]);
}
