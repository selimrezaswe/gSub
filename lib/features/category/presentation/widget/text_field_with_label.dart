import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';

class TextFieldWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool? isReadOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? searchPad;
  final List<TextInputFormatter>? inputFormatters;
  final Function(PointerDownEvent)? ontapOutSide;
  final VoidCallback? ontap;
  const TextFieldWithLabel({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.maxLines = 1,
    this.minLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.isReadOnly,
    this.suffixIcon,
    this.prefixIcon,
    this.searchPad,
    this.ontapOutSide,
    this.ontap, this.inputFormatters,
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
          inputFormatters: inputFormatters,
          onTap: ontap,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,

          readOnly: isReadOnly ?? false,
          onTapOutside: ontapOutSide,
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            
            hintText: hintText,
          ),
        ),
        if (searchPad != null) searchPad!,
      ],
    );
  }
}
