///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEs with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'BMONI';
	@override String get tagline => 'Envía dinero de México a Estados Unidos';
	@override late final _Translations$amountEntry$es amountEntry = _Translations$amountEntry$es._(_root);
	@override late final _Translations$confirmation$es confirmation = _Translations$confirmation$es._(_root);
	@override late final _Translations$result$es result = _Translations$result$es._(_root);
	@override late final _Translations$errors$es errors = _Translations$errors$es._(_root);
	@override late final _Translations$feeInfo$es feeInfo = _Translations$feeInfo$es._(_root);
	@override late final _Translations$common$es common = _Translations$common$es._(_root);
}

// Path: amountEntry
class _Translations$amountEntry$es implements Translations$amountEntry$en {
	_Translations$amountEntry$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Enviar dinero';
	@override String get recipientTo => 'Para';
	@override String get recipientAccount => 'Cuenta ···· 4821';
	@override String get recipientChange => 'Cambiar';
	@override String get heroLabel => 'TÚ ENVÍAS · MXN';
	@override String get amountLabel => 'Envías (MXN)';
	@override String get amountHint => '0.00';
	@override String get youReceive => 'El destinatario recibe';
	@override String get rate => 'Tipo de cambio';
	@override String get fee => 'Comisión';
	@override String get emptyHint => 'Escribe un monto para ver cuánto recibe en dólares.';
	@override String get continueCta => 'Continuar';
}

// Path: confirmation
class _Translations$confirmation$es implements Translations$confirmation$en {
	_Translations$confirmation$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirma tu envío';
	@override String get heroLabel => 'VAS A ENVIAR';
	@override String get youSend => 'Envías';
	@override String get fee => 'Comisión';
	@override String get converted => 'Se convierten';
	@override String get rate => 'Tipo de cambio';
	@override String get youReceive => 'El destinatario recibe';
	@override String get rateHold => 'Este tipo de cambio se mantiene por';
	@override String expiresIn({required Object seconds}) => 'La cotización expira en ${seconds}s';
	@override String get expiredTitle => 'La cotización expiró';
	@override String get expiredBody => 'El tipo de cambio pudo haber cambiado — vuelve a cotizar para continuar.';
	@override String get backToQuote => 'Volver a cotizar';
	@override String get confirmCta => 'Confirmar y enviar';
	@override String get sending => 'Enviando…';
}

// Path: result
class _Translations$result$es implements Translations$result$en {
	_Translations$result$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get sentTitle => '¡Enviado!';
	@override String get recipientWillReceive => 'El destinatario recibirá';
	@override String get availableIn => 'Disponible en ~2 minutos';
	@override String get reference => 'Folio';
	@override String get youSent => 'Enviaste';
	@override String get date => 'Fecha';
	@override String get sendAnother => 'Enviar otro';
	@override String get failureTitle => 'La transferencia falló';
	@override String get retryCta => 'Reintentar';
	@override String get doneCta => 'Listo';
}

// Path: errors
class _Translations$errors$es implements Translations$errors$en {
	_Translations$errors$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get network => 'Sin conexión. Revisa tu internet e intenta de nuevo.';
	@override String get rateUnavailable => 'El tipo de cambio no está disponible por ahora.';
	@override String get amountNotNumeric => 'Ingresa un monto válido.';
	@override String get amountNotPositive => 'Ingresa un monto mayor a cero.';
	@override String get amountTooLow => 'El monto es menor al mínimo.';
	@override String get amountTooHigh => 'El monto supera el máximo.';
	@override String get amountBelowFee => 'El monto debe ser mayor a la comisión.';
	@override String get quoteExpired => 'Esta cotización expiró. Solicita una nueva.';
	@override String get unexpected => 'Algo salió mal. Intenta de nuevo.';
}

// Path: feeInfo
class _Translations$feeInfo$es implements Translations$feeInfo$en {
	_Translations$feeInfo$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String fixedOnly({required Object fixed}) => 'Tarifa fija de ${fixed}.';
	@override String combined({required Object fixed, required Object percent, required Object variable, required Object threshold}) => '${fixed} fija + ${percent}% (${variable}) por superar ${threshold}.';
}

// Path: common
class _Translations$common$es implements Translations$common$en {
	_Translations$common$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get retry => 'Reintentar';
	@override String rateValue({required Object rate}) => '1 MXN ≈ ${rate} USD';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'BMONI',
			'tagline' => 'Envía dinero de México a Estados Unidos',
			'amountEntry.title' => 'Enviar dinero',
			'amountEntry.recipientTo' => 'Para',
			'amountEntry.recipientAccount' => 'Cuenta ···· 4821',
			'amountEntry.recipientChange' => 'Cambiar',
			'amountEntry.heroLabel' => 'TÚ ENVÍAS · MXN',
			'amountEntry.amountLabel' => 'Envías (MXN)',
			'amountEntry.amountHint' => '0.00',
			'amountEntry.youReceive' => 'El destinatario recibe',
			'amountEntry.rate' => 'Tipo de cambio',
			'amountEntry.fee' => 'Comisión',
			'amountEntry.emptyHint' => 'Escribe un monto para ver cuánto recibe en dólares.',
			'amountEntry.continueCta' => 'Continuar',
			'confirmation.title' => 'Confirma tu envío',
			'confirmation.heroLabel' => 'VAS A ENVIAR',
			'confirmation.youSend' => 'Envías',
			'confirmation.fee' => 'Comisión',
			'confirmation.converted' => 'Se convierten',
			'confirmation.rate' => 'Tipo de cambio',
			'confirmation.youReceive' => 'El destinatario recibe',
			'confirmation.rateHold' => 'Este tipo de cambio se mantiene por',
			'confirmation.expiresIn' => ({required Object seconds}) => 'La cotización expira en ${seconds}s',
			'confirmation.expiredTitle' => 'La cotización expiró',
			'confirmation.expiredBody' => 'El tipo de cambio pudo haber cambiado — vuelve a cotizar para continuar.',
			'confirmation.backToQuote' => 'Volver a cotizar',
			'confirmation.confirmCta' => 'Confirmar y enviar',
			'confirmation.sending' => 'Enviando…',
			'result.sentTitle' => '¡Enviado!',
			'result.recipientWillReceive' => 'El destinatario recibirá',
			'result.availableIn' => 'Disponible en ~2 minutos',
			'result.reference' => 'Folio',
			'result.youSent' => 'Enviaste',
			'result.date' => 'Fecha',
			'result.sendAnother' => 'Enviar otro',
			'result.failureTitle' => 'La transferencia falló',
			'result.retryCta' => 'Reintentar',
			'result.doneCta' => 'Listo',
			'errors.network' => 'Sin conexión. Revisa tu internet e intenta de nuevo.',
			'errors.rateUnavailable' => 'El tipo de cambio no está disponible por ahora.',
			'errors.amountNotNumeric' => 'Ingresa un monto válido.',
			'errors.amountNotPositive' => 'Ingresa un monto mayor a cero.',
			'errors.amountTooLow' => 'El monto es menor al mínimo.',
			'errors.amountTooHigh' => 'El monto supera el máximo.',
			'errors.amountBelowFee' => 'El monto debe ser mayor a la comisión.',
			'errors.quoteExpired' => 'Esta cotización expiró. Solicita una nueva.',
			'errors.unexpected' => 'Algo salió mal. Intenta de nuevo.',
			'feeInfo.fixedOnly' => ({required Object fixed}) => 'Tarifa fija de ${fixed}.',
			'feeInfo.combined' => ({required Object fixed, required Object percent, required Object variable, required Object threshold}) => '${fixed} fija + ${percent}% (${variable}) por superar ${threshold}.',
			'common.retry' => 'Reintentar',
			'common.rateValue' => ({required Object rate}) => '1 MXN ≈ ${rate} USD',
			_ => null,
		};
	}
}
