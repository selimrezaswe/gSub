import 'package:equatable/equatable.dart';
import 'package:subscription_manager/features/settings/domain/entities/currency_item.dart';

enum SelectCurrencyStatus { initial, loading, success, failure }

class SelectCurrencyState extends Equatable {
  const SelectCurrencyState({
    this.status = SelectCurrencyStatus.initial,
    this.currencies = const [],
    this.errorMessage,
    this.selectedCurrency,
    this.searchQuery = '',
  });

  final SelectCurrencyStatus status;
  final List<CurrencyItem> currencies;
  final String? errorMessage;
  final CurrencyItem? selectedCurrency;
  final String searchQuery;

  /// Currencies filtered by [searchQuery] (by code, symbol, or name).
  List<CurrencyItem> get filteredCurrencies {
    if (searchQuery.trim().isEmpty) return currencies;
    final query = searchQuery.trim().toLowerCase();
    return currencies.where((c) {
      return c.code.toLowerCase().contains(query) ||
          c.symbol.toLowerCase().contains(query) ||
          c.name.toLowerCase().contains(query);
    }).toList();
  }

  @override
  List<Object?> get props => [status, currencies, errorMessage, selectedCurrency, searchQuery];

  SelectCurrencyState copyWith({
    SelectCurrencyStatus? status,
    List<CurrencyItem>? currencies,
    String? errorMessage,
    CurrencyItem? selectedCurrency,
    String? searchQuery,
  }) {
    return SelectCurrencyState(
      status: status ?? this.status,
      currencies: currencies ?? this.currencies,
      errorMessage: errorMessage,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
