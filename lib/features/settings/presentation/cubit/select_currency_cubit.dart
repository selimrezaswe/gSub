import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/features/settings/domain/entities/currency_item.dart';
import 'package:subscription_manager/features/settings/domain/usecases/get_currencies_usecase.dart';
import 'package:subscription_manager/features/settings/presentation/cubit/select_currency_state.dart';

class SelectCurrencyCubit extends Cubit<SelectCurrencyState> {
  SelectCurrencyCubit(this._getCurrenciesUseCase)
      : super(const SelectCurrencyState());

  final GetCurrenciesUseCase _getCurrenciesUseCase;

  Future<void> loadCurrencies() async {
    emit(state.copyWith(status: SelectCurrencyStatus.loading));
    try {
      final list = await _getCurrenciesUseCase();
      emit(state.copyWith(
        status: SelectCurrencyStatus.success,
        currencies: list,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SelectCurrencyStatus.failure,
        errorMessage: e.toString(),
        currencies: [],
      ));
    }
  }


  void searchCurrencies(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  Future<void> selectCurrency(CurrencyItem currency, BuildContext context) async {
    emit(state.copyWith(selectedCurrency: currency));
    context.pop();
  }
}
