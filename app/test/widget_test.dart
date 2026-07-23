import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:bmoni_transfer/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('given English, when the app boots, then amount entry renders', (
    tester,
  ) async {
    LocaleSettings.setLocaleSync(AppLocale.en);

    await tester.pumpWidget(
      TranslationProvider(
        child: const ProviderScope(child: BmoniApp()),
      ),
    );

    expect(find.text('Send money'), findsOneWidget);
    expect(find.text('YOU SEND · MXN'), findsOneWidget);
  });
}
