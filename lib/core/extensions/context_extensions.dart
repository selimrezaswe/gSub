import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';

extension DatePickerContextExtension on BuildContext {
  /// Shows the app's styled date picker dialog.
  /// Returns the selected [DateTime] or `null` if cancelled.
  ///
  /// [initialDate] - The date to show as initially selected. Defaults to today.
  /// [minDate] - The earliest selectable date. Defaults to 5 years ago.
  /// [maxDate] - The latest selectable date. Defaults to 5 years from now.
  Future<DateTime?> showAppDatePicker({
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
  }) async {
    final now = DateTime.now();
    final selectedDate = initialDate ?? now;
    final min = minDate ?? now.subtract(const Duration(days: 365 * 5));
    final max = maxDate ?? now.add(const Duration(days: 365 * 5));

    return showDatePickerDialog(
      context: this,
      centerLeadingDate: true,
      useSafeArea: true,
      selectedDate: selectedDate,
      initialDate: selectedDate,
      minDate: min,
      maxDate: max,
      initialPickerType: PickerType.days,
      currentDate: now,
      barrierColor: Colors.black.withOpacity(0.4),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 32,
      ),
      enabledCellsDecoration: BoxDecoration(
        color: AppColors.onPrimary,
        shape: BoxShape.circle,
      ),
      selectedCellDecoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      currentDateDecoration: BoxDecoration(
        border: Border.all(color: AppColors.primary, width: 2),
        shape: BoxShape.circle,
      ),
      daysOfTheWeekTextStyle: Theme.of(this).textTheme.labelSmall?.copyWith(
            color: AppColors.outline,
            fontWeight: FontWeight.w500,
          ),
      enabledCellsTextStyle: Theme.of(this).textTheme.bodyMedium?.copyWith(
            color: AppColors.backgroundDark,
            fontWeight: FontWeight.w500,
          ),
      selectedCellTextStyle: Theme.of(this).textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
      currentDateTextStyle: Theme.of(this).textTheme.bodyMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
