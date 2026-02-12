import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/app/app_route.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/features/category/presentation/widget/text_field_with_label.dart';
import 'package:subscription_manager/features/onboard/presentation/widgets/notification_time_picker.dart';

class UserSetup extends StatefulWidget {
  const UserSetup({super.key});

  @override
  State<UserSetup> createState() => _UserSetupState();
}

class _UserSetupState extends State<UserSetup> {
  TimeOfDay _notificationTime = const TimeOfDay(hour: 12, minute: 0);

  String get _timeLabel {
    final hour = _notificationTime.hourOfPeriod == 0
        ? 12
        : _notificationTime.hourOfPeriod;
    final minute = _notificationTime.minute.toString().padLeft(2, '0');
    final period = _notificationTime.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour : $minute $period';
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _notificationTime,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
          ),
          textTheme: Theme.of(context).textTheme.copyWith(
            bodyMedium: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.onSecondary,
            ),
          ),
          timePickerTheme: TimePickerThemeData(
            dayPeriodColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.primary;
              }
              return AppColors.onPrimary;
            }),
            dayPeriodTextStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.onPrimary,
            ),
            dayPeriodBorderSide: BorderSide(color: AppColors.primary),
            dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.onPrimary;
              }
              return AppColors.onBackgroundLight;
            }),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              fillColor: AppColors.onPrimary,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              outlineBorder: BorderSide(color: AppColors.primary),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary),
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),

            backgroundColor: AppColors.onPrimary,
            hourMinuteColor: AppColors.primary.withOpacity(0.07),
            dialHandColor: AppColors.primary,
            dialBackgroundColor: AppColors.onPrimary,
            entryModeIconColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _notificationTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leadingWidth: 60,
        leading: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: AppColors.onPrimary,
            foregroundColor: AppColors.onSecondary,
          ),
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "Introduction",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: SafeArea(
          child: ElevatedButton(
            child: Text("Save & Go"),
            onPressed: () {
              context.go(AppRoutes.home);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            Text(
              "Welcome! Please take a moment to set up your profile.",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.fromHex("#868DA6"),
              ),
            ),
            TextFieldWithLabel(
              label: "Your Name",
              hintText: "Enter Your Name",
            ),
            NotificationTimePicker(
              question: 'When you want to get notification?',
              timeLabel: _timeLabel,
              onTimeTap: () => _pickTime(context),
            ),
          ],
        ),
      ),
    );
  }
}
