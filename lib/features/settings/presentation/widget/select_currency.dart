
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/features/settings/presentation/widget/currency_tile.dart';
import 'package:subscription_manager/injection_container.dart';
import 'package:subscription_manager/features/settings/presentation/cubit/select_currency_cubit.dart';
import 'package:subscription_manager/features/settings/presentation/cubit/select_currency_state.dart';

/// Currency picker bottom sheet; cubit is provided via [sl] with [BuildContext].
class SelectCurrency extends StatelessWidget {
  const SelectCurrency({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SelectCurrencyCubit>(param1: context)..loadCurrencies(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xffEFF3F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 16),
            Text(
              "Select Currency",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<SelectCurrencyCubit, SelectCurrencyState>(
              buildWhen: (prev, next) =>
                  prev.status != next.status || prev.searchQuery != next.searchQuery,
              builder: (context, state) {
                if (state.status != SelectCurrencyStatus.loading &&
                    state.status != SelectCurrencyStatus.failure) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TextField(
                      onChanged: (value) =>
                          context.read<SelectCurrencyCubit>().searchCurrencies(value),
                      decoration: InputDecoration(
                        hintText: 'Search by code, symbol or name',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Flexible(
              child: BlocBuilder<SelectCurrencyCubit, SelectCurrencyState>(
                builder: (context, state) {
                  if (state.status == SelectCurrencyStatus.loading) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state.status == SelectCurrencyStatus.failure) {
                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          state.errorMessage ?? 'Failed to load currencies',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.error,
                              ),
                        ),
                      ),
                    );
                  }
                  final items = state.filteredCurrencies;
                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        state.searchQuery.trim().isEmpty
                            ? 'No currencies available'
                            : 'No results for "${state.searchQuery}"',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isSelected =
                          state.selectedCurrency?.code == item.code;
                      return CurrencyTile(
                        isSelected: isSelected,
                        item: item,
                        onTap: () => context
                            .read<SelectCurrencyCubit>()
                            .selectCurrency(item, context),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
