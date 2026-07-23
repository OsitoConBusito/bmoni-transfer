import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';
import 'package:bmoni_transfer/features/transfer/presentation/pages/amount_entry_page.dart';
import 'package:bmoni_transfer/features/transfer/presentation/pages/confirmation_page.dart';
import 'package:bmoni_transfer/features/transfer/presentation/pages/result_page.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoute {
  static const String amountEntry = '/';
  static const String confirmation = '/confirmation';
  static const String result = '/result';
}

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoute.amountEntry,
      builder: (context, state) => const AmountEntryPage(),
    ),
    GoRoute(
      path: AppRoute.confirmation,
      builder: (context, state) =>
          ConfirmationPage(quote: state.extra! as Quote),
    ),
    GoRoute(
      path: AppRoute.result,
      builder: (context, state) {
        final outcome = state.extra;
        return outcome is Transfer
            ? ResultPage.success(outcome)
            : ResultPage.failure(outcome! as Failure);
      },
    ),
  ],
);
