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

/// Why a logo was refused. A code, so the screen can say it in any language.
enum LogoIssue { svg, type, big, empty, https, link, http, webpage, notPicture }

class LogoError implements Exception {
  final LogoIssue issue;
  final int httpCode;
  const LogoError(this.issue, [this.httpCode = 0]);
  @override
  String toString() => 'LogoError($issue)';
}

/// null = fine, otherwise why the file is refused.
LogoIssue? logoFileProblem(String name, int size) {
  final dot = name.lastIndexOf('.');
  final ext = dot < 0 ? '' : name.substring(dot + 1).toLowerCase();
  if (ext == 'svg') return LogoIssue.svg;
  if (ext.isNotEmpty && !_okExt.contains(ext)) return LogoIssue.type;
  if (size > maxLogoBytes) return LogoIssue.big;
  if (size == 0) return LogoIssue.empty;
  return null;
}

/// Downloads a picture from a link.
Future<Uint8List> fetchLogo(String link) async {
  final uri = Uri.tryParse(link.trim());
  if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
    throw const LogoError(LogoIssue.https);
  }
  http.Response r;
  try {
    r = await http.get(uri).timeout(const Duration(seconds: 15));
  } catch (_) {
    throw const LogoError(LogoIssue.link);
  }
  if (r.statusCode != 200) {
    throw LogoError(LogoIssue.http, r.statusCode);
  }
  final type = r.headers['content-type'] ?? '';
  if (type.contains('svg')) throw const LogoError(LogoIssue.svg);
  if (type.isNotEmpty && !type.startsWith('image/')) {
    throw const LogoError(LogoIssue.webpage);
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
    throw const LogoError(LogoIssue.notPicture);
  }
  final data = await img.toByteData(format: ui.ImageByteFormat.rawRgba);
  img.dispose();
  if (data == null) throw const LogoError(LogoIssue.notPicture);
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
