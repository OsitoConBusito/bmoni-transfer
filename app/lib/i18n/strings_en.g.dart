///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'BMONI'
	String get appName => 'BMONI';

	/// en: 'Send money from Mexico to the US'
	String get tagline => 'Send money from Mexico to the US';

	late final Translations$amountEntry$en amountEntry = Translations$amountEntry$en._(_root);
	late final Translations$confirmation$en confirmation = Translations$confirmation$en._(_root);
	late final Translations$result$en result = Translations$result$en._(_root);
	late final Translations$errors$en errors = Translations$errors$en._(_root);
	late final Translations$common$en common = Translations$common$en._(_root);
}

// Path: amountEntry
class Translations$amountEntry$en {
	Translations$amountEntry$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Send money'
	String get title => 'Send money';

	/// en: 'To'
	String get recipientTo => 'To';

	/// en: 'Wallet ···· 4821'
	String get recipientAccount => 'Wallet ···· 4821';

	/// en: 'Change'
	String get recipientChange => 'Change';

	/// en: 'YOU SEND · MXN'
	String get heroLabel => 'YOU SEND · MXN';

	/// en: 'You send (MXN)'
	String get amountLabel => 'You send (MXN)';

	/// en: '0.00'
	String get amountHint => '0.00';

	/// en: 'Recipient gets'
	String get youReceive => 'Recipient gets';

	/// en: 'Exchange rate'
	String get rate => 'Exchange rate';

	/// en: 'Fee'
	String get fee => 'Fee';

	/// en: 'Enter an amount to see how much they receive in dollars.'
	String get emptyHint => 'Enter an amount to see how much they receive in dollars.';

	/// en: 'Continue'
	String get continueCta => 'Continue';
}

// Path: confirmation
class Translations$confirmation$en {
	Translations$confirmation$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Confirm your transfer'
	String get title => 'Confirm your transfer';

	/// en: 'YOU'RE SENDING'
	String get heroLabel => 'YOU\'RE SENDING';

	/// en: 'You send'
	String get youSend => 'You send';

	/// en: 'Fee'
	String get fee => 'Fee';

	/// en: 'Converted'
	String get converted => 'Converted';

	/// en: 'Exchange rate'
	String get rate => 'Exchange rate';

	/// en: 'Recipient gets'
	String get youReceive => 'Recipient gets';

	/// en: 'This rate holds for'
	String get rateHold => 'This rate holds for';

	/// en: 'Quote expires in {seconds}s'
	String expiresIn({required Object seconds}) => 'Quote expires in ${seconds}s';

	/// en: 'The quote expired'
	String get expiredTitle => 'The quote expired';

	/// en: 'The exchange rate may have changed — request a new quote to continue.'
	String get expiredBody => 'The exchange rate may have changed — request a new quote to continue.';

	/// en: 'Get a new quote'
	String get backToQuote => 'Get a new quote';

	/// en: 'Confirm and send'
	String get confirmCta => 'Confirm and send';

	/// en: 'Sending…'
	String get sending => 'Sending…';
}

// Path: result
class Translations$result$en {
	Translations$result$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sent!'
	String get sentTitle => 'Sent!';

	/// en: 'The recipient will receive'
	String get recipientWillReceive => 'The recipient will receive';

	/// en: 'Available in ~2 minutes'
	String get availableIn => 'Available in ~2 minutes';

	/// en: 'Reference'
	String get reference => 'Reference';

	/// en: 'You sent'
	String get youSent => 'You sent';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Send another'
	String get sendAnother => 'Send another';

	/// en: 'Transfer failed'
	String get failureTitle => 'Transfer failed';

	/// en: 'Try again'
	String get retryCta => 'Try again';

	/// en: 'Done'
	String get doneCta => 'Done';
}

// Path: errors
class Translations$errors$en {
	Translations$errors$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No connection. Check your internet and try again.'
	String get network => 'No connection. Check your internet and try again.';

	/// en: 'Exchange rate is temporarily unavailable.'
	String get rateUnavailable => 'Exchange rate is temporarily unavailable.';

	/// en: 'Enter a valid amount.'
	String get amountNotNumeric => 'Enter a valid amount.';

	/// en: 'Enter an amount greater than zero.'
	String get amountNotPositive => 'Enter an amount greater than zero.';

	/// en: 'Amount is below the minimum.'
	String get amountTooLow => 'Amount is below the minimum.';

	/// en: 'Amount is above the maximum.'
	String get amountTooHigh => 'Amount is above the maximum.';

	/// en: 'Amount must be greater than the fee.'
	String get amountBelowFee => 'Amount must be greater than the fee.';

	/// en: 'This quote expired. Please request a new one.'
	String get quoteExpired => 'This quote expired. Please request a new one.';

	/// en: 'Something went wrong. Please try again.'
	String get unexpected => 'Something went wrong. Please try again.';
}

// Path: common
class Translations$common$en {
	Translations$common$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: '1 MXN ≈ {rate} USD'
	String rateValue({required Object rate}) => '1 MXN ≈ ${rate} USD';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'BMONI',
			'tagline' => 'Send money from Mexico to the US',
			'amountEntry.title' => 'Send money',
			'amountEntry.recipientTo' => 'To',
			'amountEntry.recipientAccount' => 'Wallet ···· 4821',
			'amountEntry.recipientChange' => 'Change',
			'amountEntry.heroLabel' => 'YOU SEND · MXN',
			'amountEntry.amountLabel' => 'You send (MXN)',
			'amountEntry.amountHint' => '0.00',
			'amountEntry.youReceive' => 'Recipient gets',
			'amountEntry.rate' => 'Exchange rate',
			'amountEntry.fee' => 'Fee',
			'amountEntry.emptyHint' => 'Enter an amount to see how much they receive in dollars.',
			'amountEntry.continueCta' => 'Continue',
			'confirmation.title' => 'Confirm your transfer',
			'confirmation.heroLabel' => 'YOU\'RE SENDING',
			'confirmation.youSend' => 'You send',
			'confirmation.fee' => 'Fee',
			'confirmation.converted' => 'Converted',
			'confirmation.rate' => 'Exchange rate',
			'confirmation.youReceive' => 'Recipient gets',
			'confirmation.rateHold' => 'This rate holds for',
			'confirmation.expiresIn' => ({required Object seconds}) => 'Quote expires in ${seconds}s',
			'confirmation.expiredTitle' => 'The quote expired',
			'confirmation.expiredBody' => 'The exchange rate may have changed — request a new quote to continue.',
			'confirmation.backToQuote' => 'Get a new quote',
			'confirmation.confirmCta' => 'Confirm and send',
			'confirmation.sending' => 'Sending…',
			'result.sentTitle' => 'Sent!',
			'result.recipientWillReceive' => 'The recipient will receive',
			'result.availableIn' => 'Available in ~2 minutes',
			'result.reference' => 'Reference',
			'result.youSent' => 'You sent',
			'result.date' => 'Date',
			'result.sendAnother' => 'Send another',
			'result.failureTitle' => 'Transfer failed',
			'result.retryCta' => 'Try again',
			'result.doneCta' => 'Done',
			'errors.network' => 'No connection. Check your internet and try again.',
			'errors.rateUnavailable' => 'Exchange rate is temporarily unavailable.',
			'errors.amountNotNumeric' => 'Enter a valid amount.',
			'errors.amountNotPositive' => 'Enter an amount greater than zero.',
			'errors.amountTooLow' => 'Amount is below the minimum.',
			'errors.amountTooHigh' => 'Amount is above the maximum.',
			'errors.amountBelowFee' => 'Amount must be greater than the fee.',
			'errors.quoteExpired' => 'This quote expired. Please request a new one.',
			'errors.unexpected' => 'Something went wrong. Please try again.',
			'common.retry' => 'Retry',
			'common.rateValue' => ({required Object rate}) => '1 MXN ≈ ${rate} USD',
			_ => null,
		};
	}
}
