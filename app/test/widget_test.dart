import 'package:bmoni_transfer/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('given the app boots, then the branded landing renders', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: BmoniApp()),
    );

    expect(find.text('BMONI'), findsOneWidget);
    expect(find.text('MXN → USD'), findsOneWidget);
  });
}
