import 'package:subscription_manager/features/settings/domain/entities/currency_item.dart';
import 'package:subscription_manager/features/settings/domain/repositories/currency_repository.dart';

/// Use case: load all available currencies (unique, sorted by name).
class GetCurrenciesUseCase {
  GetCurrenciesUseCase(this._repository);

  final CurrencyRepository _repository;

  Future<List<CurrencyItem>> call() => _repository.getCurrencies();
}
