import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:licheckers/src/tournament/sponsor_logo.dart';
import 'package:licheckers/src/tournament/tournament_rules.dart';

// An 8x8 PNG: a white border around a yellow (255, 204, 0) middle.
final yellowPng = base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAFklEQVR4nGP4jwMwgIgzDOhoMEhgAwAN6pQ5bH1eLQAAAABJRU5ErkJggg==');

Uint8List pixels(List<List<int>> list) =>
    Uint8List.fromList([for (final p in list) ...p]);

void main() {
  test('file checks: type and size', () {
    expect(logoFileProblem('logo.png', 1000), isNull);
    expect(logoFileProblem('logo.JPG', 1000), isNull);
    expect(logoFileProblem('logo.svg', 1000), contains('SVG'));
    expect(logoFileProblem('logo.exe', 1000), isNotNull);
    expect(logoFileProblem('big.png', 3 * 1024 * 1024), contains('2 MB'));
    expect(logoFileProblem('empty.png', 0), isNotNull);
  });

  test('main colour ignores white, black, grey and see-through parts', () {
    final red = [200, 30, 30, 255];
    final px = pixels([
      for (var i = 0; i < 50; i++) [255, 255, 255, 255], // white background
      for (var i = 0; i < 20; i++) [10, 10, 10, 255], // black text
      for (var i = 0; i < 20; i++) [128, 128, 128, 255], // grey
      for (var i = 0; i < 40; i++) [0, 200, 0, 0], // invisible green
      for (var i = 0; i < 10; i++) red,
    ]);
    final c = dominantFromRgba(px)!;
    expect((c.r * 255).round(), 200);
    expect((c.g * 255).round(), 30);
  });

  test('a picture with no lively colour gives null', () {
    expect(dominantFromRgba(pixels([for (var i = 0; i < 9; i++) [250, 250, 250, 255]])),
        isNull);
  });

  test('reads a real PNG and finds its yellow', () async {
    final c = await logoColour(yellowPng);
    expect((c.r * 255).round(), 255);
    expect((c.g * 255).round(), closeTo(204, 2));
    expect((c.b * 255).round(), lessThan(10));
  });

  test('refuses bytes that are not a picture', () async {
    expect(() => logoColour(Uint8List.fromList(utf8.encode('hello'))),
        throwsA(isA<LogoError>()));
  });

  test('links must be https', () async {
    expect(() => fetchLogo('http://example.com/a.png'), throwsA(isA<LogoError>()));
    expect(() => fetchLogo('not a link'), throwsA(isA<LogoError>()));
  });

  test('the logo colour becomes the sponsor colour', () {
    final d = TournamentDraft()
      ..logoColourA = const Color(0xFFFFCC00)
      ..colourA = 'Logo';
    expect(d.sponsorColourA, const Color(0xFFFFCC00));
    d.colourA = 'Green';
    expect(d.sponsorColourA, sponsorColours['Green']);
  });
}
