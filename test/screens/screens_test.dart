import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nihongo_learn_app/app.dart';
import 'package:nihongo_learn_app/data/kana.dart';
import 'package:nihongo_learn_app/models/syllabary.dart';
import 'package:nihongo_learn_app/screens/kana_table_screen.dart';
import 'package:nihongo_learn_app/theme/app_theme.dart';
import 'package:nihongo_learn_app/widgets/kana_cell.dart';

import '../support/fake_audio_service.dart';

void main() {
  setUp(() => TestWidgetsFlutterBinding.ensureInitialized());

  Future<void> useBigScreen(WidgetTester tester, {double textScale = 1}) async {
    tester.view.physicalSize = const Size(390, 844) * 3;
    tester.view.devicePixelRatio = 3;
    tester.platformDispatcher.textScaleFactorTestValue = textScale;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
  }

  testWidgets(
    'Home renders levels and navigates Home → Kana → table → back home',
    (tester) async {
      await useBigScreen(tester);
      await tester.pumpWidget(const NihongoApp());

      expect(find.text('¿Qué estudiamos hoy?'), findsOneWidget);
      expect(find.text('N5'), findsOneWidget);
      expect(find.text('Se abre al terminar N5'), findsOneWidget);

      await tester.tap(find.text('Entrar a Kana'));
      await tester.pumpAndSettle();
      expect(find.text('Elegí qué silabario querés practicar'), findsOneWidget);

      await tester.tap(find.text('Katakana'));
      await tester.pumpAndSettle();
      expect(find.text('カタカナ · 46 caracteres'), findsOneWidget);

      await tester.tap(find.text('Inicio'));
      await tester.pumpAndSettle();
      expect(find.text('¿Qué estudiamos hoy?'), findsOneWidget);
    },
  );

  testWidgets('back button returns to the previous screen', (tester) async {
    await useBigScreen(tester);
    await tester.pumpWidget(const NihongoApp());
    await tester.tap(find.text('Entrar a Kana'));
    await tester.pumpAndSettle();

    await tester.tap(find.bySemanticsLabel('Volver al inicio'));
    await tester.pumpAndSettle();
    expect(find.text('¿Qué estudiamos hoy?'), findsOneWidget);
  });

  for (final syllabary in Syllabary.values) {
    testWidgets('${syllabary.title} table plays the audio of the tapped cell', (
      tester,
    ) async {
      await useBigScreen(tester);
      final audio = FakeAudioService();
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: KanaTableScreen(syllabary: syllabary, audioService: audio),
        ),
      );

      final first = kanaTableFor(syllabary).first!;
      expect(find.bySemanticsLabel(first.semanticsLabel), findsOneWidget);

      await tester.tap(find.byType(KanaCell).first);
      await tester.pumpAndSettle();
      expect(audio.played, [first.audioPath]);
    });
  }

  testWidgets('every screen lays out without overflow at 1.3x text scale', (
    tester,
  ) async {
    await useBigScreen(tester, textScale: 1.3);
    await tester.pumpWidget(const NihongoApp());
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Entrar a Kana'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Hiragana'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
