/// The two currencies in this slice. Mirrors the backend wire codes. Each
/// carries how to display it: locale (es_MX / en_US), a symbol, and decimals.
enum Currency {
  mxn(code: 'MXN', locale: 'es_MX', symbol: r'MX$', decimals: 2),
  usd(code: 'USD', locale: 'en_US', symbol: r'US$', decimals: 2);

  const Currency({
    required this.code,
    required this.locale,
    required this.symbol,
    required this.decimals,
  });

  final String code;
  final String locale;
  final String symbol;
  final int decimals;

  /// Minor units per major unit (100 for a 2-decimal currency).
  int get minorPerMajor {
    var scale = 1;
    for (var i = 0; i < decimals; i++) {
      scale *= 10;
    }
    return scale;
  }

  static Currency fromCode(String code) {
    return Currency.values.firstWhere(
      (currency) => currency.code == code,
      orElse: () => throw ArgumentError.value(code, 'code', 'Unknown currency'),
    );
  }
}
