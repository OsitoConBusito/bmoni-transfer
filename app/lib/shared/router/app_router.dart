import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';
import 'package:bmoni_transfer/features/transfer/presentation/pages/amount_entry_page.dart';
import 'package:bmoni_transfer/features/transfer/presentation/pages/confirmation_page.dart';
import 'package:bmoni_transfer/features/transfer/presentation/pages/result_page.dart';
import 'package:bmoni_transfer/shared/router/page_transitions.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoute {
  static const String amountEntry = '/';
  static const String confirmation = '/confirmation';
  static const String result = '/result';

  /// Passed as `extra` when navigating back to amount entry to start a new
  /// transfer (e.g. "Send another"), as opposed to an ordinary pop back to it
  /// mid-flow. See the `pageBuilder` below for why this matters.
  static const Object resetExtra = 'reset';
}

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoute.amountEntry,
      pageBuilder: (context, state) {
        // A plain pop back to amount entry (e.g. from confirmation) keeps the
        // same Page key, so Flutter reuses the existing widget/state — the
        // typed amount survives, which is what you want mid-flow. Starting a
        // *new* transfer must not inherit that state (typed amount, in-flight
        // quote), so that navigation carries `resetExtra` and gets a fresh
        // key instead: Flutter then tears down the old instance (disposing
        // its TextEditingController and its subscription to the quote
        // provider, which is what lets that autoDispose provider reset) and
        // mounts a clean one.
        final key = state.extra == AppRoute.resetExtra
            ? UniqueKey()
            : state.pageKey;
        return slidePage(key: key, child: const AmountEntryPage());
      },
    ),
    GoRoute(
      path: AppRoute.confirmation,
      pageBuilder: (context, state) => slidePage(
        key: state.pageKey,
        child: ConfirmationPage(quote: state.extra! as Quote),
      ),
    ),
    GoRoute(
      path: AppRoute.result,
      pageBuilder: (context, state) {
        final outcome = state.extra;
        // `outcome` is whatever TransferNotifier's AsyncValue carried — a
        // Transfer on success, or in practice always a Failure on error. But
        // this is a navigation boundary reading an untyped `extra`; never
        // force-cast an unrecognized value here and crash instead of showing
        // the failure screen.
        final page = switch (outcome) {
          final Transfer transfer => ResultPage.success(transfer),
          final Failure failure => ResultPage.failure(failure),
          _ => const ResultPage.failure(UnexpectedFailure()),
        };
        return slidePage(key: state.pageKey, child: page);
      },
    ),
  ],
);
