import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:bmoni_transfer/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('given the app boots in English, then the landing renders', (
    tester,
  ) async {
    LocaleSettings.setLocaleSync(AppLocale.en);

    await tester.pumpWidget(
      TranslationProvider(
        child: const ProviderScope(child: BmoniApp()),
      ),
    );

    expect(find.text('BMONI'), findsOneWidget);
    expect(find.text('Send money from Mexico to the US'), findsOneWidget);
  });
}
