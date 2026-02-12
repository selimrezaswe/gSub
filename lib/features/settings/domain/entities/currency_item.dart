import 'package:equatable/equatable.dart';

/// Domain entity for a single currency (from currencies data).
class CurrencyItem extends Equatable {
  const CurrencyItem({
    required this.code,
    required this.name,
    required this.symbol,
    required this.emoji,
  });

  final String code;
  final String name;
  final String symbol;
  final String emoji;

  @override
  List<Object?> get props => [code, name, symbol, emoji];
}
