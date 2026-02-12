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
      builder: (context, child) => child!,
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
