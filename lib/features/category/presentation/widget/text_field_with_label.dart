import 'package:flutter/material.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';

class TextFieldWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final int? minLines;

  const TextFieldWithLabel({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.maxLines,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0).copyWith(left: 3),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.fromHex("#868DA6"),
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
