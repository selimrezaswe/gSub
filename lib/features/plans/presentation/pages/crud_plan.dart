import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/core/extensions/context_extensions.dart';
import 'package:subscription_manager/features/category/domain/entities/category.dart';
import 'package:subscription_manager/features/category/presentation/widget/text_field_with_label.dart';
import 'package:subscription_manager/features/plans/domain/entites/app.dart';
import 'package:subscription_manager/features/plans/domain/entites/plan.dart';
import 'package:subscription_manager/features/plans/presentation/widget/add_new_app_bottom_sheet.dart';
import 'package:subscription_manager/features/plans/presentation/widget/dropdown_with_label.dart';

class CrudPlanScreen extends StatefulWidget {
  final Plan? plan;
  const CrudPlanScreen({super.key, this.plan});

  @override
  State<CrudPlanScreen> createState() => _CrudPlanScreenState();
}

class _CrudPlanScreenState extends State<CrudPlanScreen> {
  late TextEditingController detailsController;
  late TextEditingController searchController;
  late TextEditingController subscriptionDateController;
  late TextEditingController subscriptionCostController;

  String? selectedCategory;
  String? selectedPaymentCycle;
  String? selectedSubscriptionReminder;
  AppEntity? selectedApp;

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  final categories = [
    Category(
      name: 'Workspace',
      amount: '\$160.00',
      subscriptions: '10 Subscriptions',
      icon: "icon_money_in",
      details: "Details",
    ),
    Category(
      name: 'Productivity',
      amount: '\$100.00',
      subscriptions: '10 Subscriptions',
      icon: "icon_document_text_1",
      details: "Details",
    ),
    Category(
      name: 'Entertainment',
      amount: '\$60.99',
      subscriptions: '10 Subscriptions',
      icon: "icon_music_list",
      details: "Details",
    ),
    Category(
      name: 'Ai tools',
      amount: '\$160.00',
      subscriptions: '10 Subscriptions',
      icon: "icon_music_list",
      details: "Details",
    ),
  ];
  @override
  void initState() {
    super.initState();
    detailsController = TextEditingController(
      text: widget.plan?.details ?? "",
    );
    searchController = TextEditingController();
    subscriptionDateController = TextEditingController(
      text: widget.plan?.subscriptionDate != null
          ? _formatDate(
              DateTime.fromMillisecondsSinceEpoch(
                widget.plan!.subscriptionDate,
              ),
            )
          : "",
    );
    selectedPaymentCycle =
        widget.plan?.paymentCycle.toShortString() ??
        PaymentCycle.monthly.toShortString();
    selectedSubscriptionReminder =
        widget.plan?.subscriptionReminder.toShortString() ??
        SubscriptionReminder.none.toShortString();
    subscriptionCostController = TextEditingController(
      text: widget.plan?.subscriptionCost != null
          ? widget.plan!.subscriptionCost.toString()
          : "",
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchController.addListener(() {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    detailsController.dispose();
    searchController.dispose();
    subscriptionDateController.dispose();
    super.dispose();
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
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          widget.plan == null ? "Add Plan" : "Edit Plan",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ).copyWith(bottom: 18),
          children: [
            Column(
              spacing: 15,
              children: [
                if (selectedApp != null)
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your App",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.onSecondary,
                        ),
                      ),

                      Container(
                        height: 58,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          spacing: 10,
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: AppColors.fromHex("#ECF0F6"),
                              child: Image.memory(
                                base64Decode(selectedApp!.icon),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              selectedApp!.name,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.onBackgroundLight,
                                  ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedApp = null;
                                });
                              },
                              child: Icon(Icons.close),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  TextFieldWithLabel(
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    controller: searchController,
                    label: "Add your apps",
                    prefixIcon: Icon(
                      Iconsax.search_normal_1,
                      color: AppColors.outline,
                    ),
                    hintText: "Search for apps",
                    suffixIcon: searchController.text.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              searchController.clear();
                            },
                            child: Icon(
                              Icons.close_rounded,
                              color: AppColors.outline,
                            ),
                          )
                        : null,
                    searchPad: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.only(
                        top: searchController.text.isEmpty ? 0 : 5,
                      ),
                      height: searchController.text.isEmpty ? 0 : 170,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: searchController.text.isEmpty
                          ? null
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                spacing: 20,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "No app or website found",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.onSecondary,
                                        ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.onPrimary,
                                      foregroundColor: AppColors.primary,
                                      elevation: 0,
                                      minimumSize: Size(double.infinity, 50),
                                      maximumSize: Size(double.infinity, 50),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      final AppEntity? app =
                                          await showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return AddNewAppBottomSheet();
                                            },
                                          );
                                      if (app != null) {
                                        setState(() {
                                          selectedApp = app;
                                          searchController.clear();
                                        });
                                      }
                                    },
                                    child: Text("Add app"),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),

                TextFieldWithLabel(
                  controller: detailsController,
                  label: "Details",
                  maxLines: 5,
                  minLines: 5,
                  hintText: "Enter the details of the plan",
                ),

                DropdownWithLabel<String>(
                  label: "Category",
                  hintText: "Select the category of the plan",
                  value: selectedCategory,
                  prefixIcon: Icon(
                    Iconsax.driver,
                    color: AppColors.outline,
                    size: 18,
                  ),
                  maxDropdownHeight: 280,
                  horizontalContentPadding: 12,
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category.id,
                      child: Text(
                        category.name,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  validator: (value) =>
                      value == null || value.isEmpty
                          ? "Please select a category"
                          : null,
                ),
                TextFieldWithLabel(
                  controller: subscriptionDateController,
                  ontap: () async {
                    DateTime? initialSelectedDate;

                    // Try parsing the date from the controller, which uses "dd/MM/yyyy"
                    if (subscriptionDateController.text.isNotEmpty) {
                      try {
                        final parts =
                            subscriptionDateController.text.split('/');
                        if (parts.length == 3) {
                          final day = int.tryParse(parts[0]);
                          final month = int.tryParse(parts[1]);
                          final year = int.tryParse(parts[2]);
                          if (day != null && month != null && year != null) {
                            initialSelectedDate = DateTime(year, month, day);
                          } else {
                            initialSelectedDate = DateTime.now();
                          }
                        } else if (widget.plan?.subscriptionDate != null) {
                          initialSelectedDate =
                              DateTime.fromMillisecondsSinceEpoch(
                                widget.plan!.subscriptionDate,
                              );
                        } else {
                          initialSelectedDate = DateTime.now();
                        }
                      } catch (_) {
                        initialSelectedDate = DateTime.now();
                      }
                    } else {
                      initialSelectedDate = DateTime.now();
                    }

                    final date = await context.showAppDatePicker(
                      initialDate: initialSelectedDate,
                    );
                    if (date != null && mounted) {
                      setState(() {
                        subscriptionDateController.text = _formatDate(date);
                      });
                    }
                    await Future.delayed(const Duration(milliseconds: 100));
                    if (context.mounted) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  label: "Subscription Date",
                  hintText: "DD/MM/YYYY",
                  isReadOnly: true,
                  prefixIcon: Icon(
                    Iconsax.calendar_1,
                    color: AppColors.outline,
                    size: 18,
                  ),
                ),
                DropdownWithLabel<String>(
                  label: "Payment Cycle",
                  hintText: "Select the payment cycle",
                  value: selectedPaymentCycle,
                  prefixIcon: Icon(
                    Iconsax.box_time,
                    color: AppColors.outline,
                    size: 24,
                  ),
                  items: PaymentCycle.values.map((cycle) {
                    return DropdownMenuItem<String>(
                      value: cycle.toShortString(),
                      child: Text(
                        cycle.capitalize(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentCycle = value;
                    });
                  },
                  validator: (value) =>
                      value == null || value.isEmpty
                          ? "Please select a payment cycle"
                          : null,
                ),
                TextFieldWithLabel(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  keyboardType: TextInputType.number,
                  label: "Subscription Cost",
                  hintText: "Enter the cost of the plan",
                  prefixIcon: Icon(
                    Iconsax.money_send,
                    color: AppColors.outline,
                    size: 18,
                  ),
                  controller: subscriptionCostController,
                ),

                DropdownWithLabel<String>(
                  label: "Remind me",
                  hintText: "Select the remind me",
                  value: selectedSubscriptionReminder,
                  prefixIcon: Icon(
                    Iconsax.clock_1,
                    color: AppColors.outline,
                    size: 24,
                  ),
                  items: SubscriptionReminder.values.map((reminder) {
                    return DropdownMenuItem<String>(
                      value: reminder.toShortString(),
                      child: Text(
                        reminder.toShortString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSubscriptionReminder = value;
                    });
                  },
                  validator: (value) =>
                      value == null || value.isEmpty
                          ? "Please select a reminder"
                          : null,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              elevation: 0,
              minimumSize: Size(double.infinity, 50),
              maximumSize: Size(double.infinity, 50),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: Text(
              "Save",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
