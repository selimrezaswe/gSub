import 'package:subscription_manager/features/settings/domain/entities/currency_item.dart';

/// Data model for [CurrencyItem]; parses from JSON.
class CurrencyItemModel extends CurrencyItem {
  const CurrencyItemModel({
    required super.code,
    required super.name,
    required super.symbol,
    required super.emoji,
  });

  factory CurrencyItemModel.fromJson(Map<String, dynamic> json) {
    return CurrencyItemModel(
      code: json['currency'] as String? ?? '',
      name: json['name'] as String? ?? '',
      symbol: json['currency_symbol'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '',
    );
  }

  CurrencyItemModel copyWith({
    String? code,
    String? name,
    String? symbol,
    String? emoji,
  }) {
    return CurrencyItemModel(
      code: code ?? this.code,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      emoji: emoji ?? this.emoji,
    );
  }
}
