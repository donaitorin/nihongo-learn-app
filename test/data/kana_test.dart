import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nihongo_learn_app/data/kana.dart';

void main() {
  for (final entry in {
    'hiragana': hiraganaTable,
    'katakana': katakanaTable,
  }.entries) {
    group(entry.key, () {
      final table = entry.value;
      final kana = table.whereType<Kana>().toList();

      test('has 55 slots and 46 characters', () {
        expect(table, hasLength(55));
        expect(kana, hasLength(46));
      });

      test('keeps the empty slots of the ya, wa and n rows', () {
        List<String?> row(int i) => [
          for (var c = 0; c < 5; c++) table[i * 5 + c]?.romaji,
        ];
        expect(row(7), ['ya', null, 'yu', null, 'yo']);
        expect(row(9), ['wa', null, null, null, 'wo']);
        expect(row(10), ['n', null, null, null, null]);
      });

      test('uses Hepburn romaji', () {
        final romaji = kana.map((k) => k.romaji);
        expect(romaji, containsAll(['shi', 'chi', 'tsu', 'fu', 'wo']));
      });

      test('every kana maps to an existing audio file', () {
        for (final k in kana) {
          expect(
            File('assets/${k.audioPath}').existsSync(),
            isTrue,
            reason: '${k.char} → ${k.audioPath}',
          );
        }
      });
    });
  }

  test('を and ヲ reuse the お audio', () {
    Kana wo(List<Kana?> t) =>
        t.whereType<Kana>().firstWhere((k) => k.romaji == 'wo');
    expect(wo(hiraganaTable).audioPath, '$kanaAudioDir/o.mp3');
    expect(wo(katakanaTable).audioPath, '$kanaAudioDir/o.mp3');
  });

  test('semantics label reads "char, romaji"', () {
    expect(hiraganaTable.first!.semanticsLabel, 'あ, a');
  });
}
