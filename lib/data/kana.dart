import '../models/syllabary.dart';

/// Asset key (relative to `assets/`, as `AssetSource` expects) of the folder
/// with the pronunciation files. One flat folder, named by romaji id: `ka.mp3`.
const kanaAudioDir = 'audio/kana';

class Kana {
  const Kana({
    required this.char,
    required this.romaji,
    required this.audioPath,
  });

  final String char;
  final String romaji;
  final String audioPath;

  /// Spoken label for screen readers, e.g. "あ, a".
  String get semanticsLabel => '$char, $romaji';
}

/// Number of columns of the gojūon table.
const kanaTableColumns = 5;

// Hepburn romaji, hiragana, katakana, in gojūon order, 5 slots per row.
// `null` marks the empty slots of the ya, wa and n rows.
const _gojuon = <(String, String, String)?>[
  ('a', 'あ', 'ア'),
  ('i', 'い', 'イ'),
  ('u', 'う', 'ウ'),
  ('e', 'え', 'エ'),
  ('o', 'お', 'オ'),
  ('ka', 'か', 'カ'),
  ('ki', 'き', 'キ'),
  ('ku', 'く', 'ク'),
  ('ke', 'け', 'ケ'),
  ('ko', 'こ', 'コ'),
  ('sa', 'さ', 'サ'),
  ('shi', 'し', 'シ'),
  ('su', 'す', 'ス'),
  ('se', 'せ', 'セ'),
  ('so', 'そ', 'ソ'),
  ('ta', 'た', 'タ'),
  ('chi', 'ち', 'チ'),
  ('tsu', 'つ', 'ツ'),
  ('te', 'て', 'テ'),
  ('to', 'と', 'ト'),
  ('na', 'な', 'ナ'),
  ('ni', 'に', 'ニ'),
  ('nu', 'ぬ', 'ヌ'),
  ('ne', 'ね', 'ネ'),
  ('no', 'の', 'ノ'),
  ('ha', 'は', 'ハ'),
  ('hi', 'ひ', 'ヒ'),
  ('fu', 'ふ', 'フ'),
  ('he', 'へ', 'ヘ'),
  ('ho', 'ほ', 'ホ'),
  ('ma', 'ま', 'マ'),
  ('mi', 'み', 'ミ'),
  ('mu', 'む', 'ム'),
  ('me', 'め', 'メ'),
  ('mo', 'も', 'モ'),
  ('ya', 'や', 'ヤ'),
  null,
  ('yu', 'ゆ', 'ユ'),
  null,
  ('yo', 'よ', 'ヨ'),
  ('ra', 'ら', 'ラ'),
  ('ri', 'り', 'リ'),
  ('ru', 'る', 'ル'),
  ('re', 'れ', 'レ'),
  ('ro', 'ろ', 'ロ'),
  ('wa', 'わ', 'ワ'),
  null,
  null,
  null,
  ('wo', 'を', 'ヲ'),
  ('n', 'ん', 'ン'),
  null,
  null,
  null,
  null,
];

// Hiragana and katakana share one recording per sound. を/ヲ has no file of
// its own because it sounds exactly like お/オ.
const _audioIdOverrides = {'wo': 'o'};

String _audioPathFor(String romaji) =>
    '$kanaAudioDir/${_audioIdOverrides[romaji] ?? romaji}.mp3';

List<Kana?> _buildTable(String Function((String, String, String)) charOf) =>
    List.unmodifiable([
      for (final entry in _gojuon)
        if (entry == null)
          null
        else
          Kana(
            char: charOf(entry),
            romaji: entry.$1,
            audioPath: _audioPathFor(entry.$1),
          ),
    ]);

final List<Kana?> hiraganaTable = _buildTable((e) => e.$2);
final List<Kana?> katakanaTable = _buildTable((e) => e.$3);

List<Kana?> kanaTableFor(Syllabary syllabary) => switch (syllabary) {
  Syllabary.hiragana => hiraganaTable,
  Syllabary.katakana => katakanaTable,
};
