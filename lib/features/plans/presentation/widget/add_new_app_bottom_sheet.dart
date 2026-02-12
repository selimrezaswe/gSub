import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/features/category/presentation/widget/text_field_with_label.dart';
import 'package:subscription_manager/features/plans/domain/entites/app.dart';

class AddNewAppBottomSheet extends StatefulWidget {
  const AddNewAppBottomSheet({
    super.key,
  });

  @override
  State<AddNewAppBottomSheet> createState() => _AddNewAppBottomSheetState();
}

class _AddNewAppBottomSheetState extends State<AddNewAppBottomSheet> {
  XFile? pickedFile;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController appNameController;
  @override
  void initState() {
    super.initState();
    appNameController = TextEditingController();
  }

  @override
  void dispose() {
    appNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.fromHex("#EFF3F6")),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo picker design
            GestureDetector(
              onTap: () async {
                final XFile? pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 100,
                  maxHeight: 100,
                  imageQuality: 100,
                );
                setState(() {
                  this.pickedFile = pickedFile;
                });
              },
              child: Row(
                spacing: 10,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      // border: Border.all(color: AppColors.primary, width: 1.2),
                    ),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: pickedFile != null
                          ? Image.file(File(pickedFile!.path))
                          : Icon(
                              Iconsax.image,
                              size: 28,
                            ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pickedFile != null
                                ? pickedFile!.name
                                : "Choose icon or image",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.onSecondary,
                                ),
                          ),
                          Icon(
                            Iconsax.edit,
                            color: AppColors.outline,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 17),
            TextFieldWithLabel(
              validator: (value) => value == null || value.isEmpty
                  ? "Please enter the app or website name"
                  : null,
              label: "App or website name",
              hintText: "Ex: Google, Facebook, etc.",

              controller: appNameController,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
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
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  // Save the app or website
                  AppEntity app = AppEntity(
                    name: appNameController.text,
                    icon: base64Encode(await pickedFile!.readAsBytes()),
                  );
                  if (context.mounted) {
                    context.pop(app);
                  }
                }
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
