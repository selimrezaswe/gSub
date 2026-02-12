import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/core/constant/app_icons.dart';
import 'package:subscription_manager/features/category/domain/entities/category.dart';
import 'package:subscription_manager/features/category/presentation/widget/text_field_with_label.dart';

class CrudCategory extends StatefulWidget {
  final Category? data;
  const CrudCategory({super.key, this.data});

  @override
  State<CrudCategory> createState() => _CrudCategoryState();
}

class _CrudCategoryState extends State<CrudCategory> {
  String? selectedIcon;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final ScrollController _iconScrollController = ScrollController();
  final GlobalKey _selectedIconKey = GlobalKey();

  @override
  void dispose() {
    _iconScrollController.dispose();
    nameController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      nameController.text = widget.data!.name;
      detailsController.text = widget.data!.details;
      selectedIcon = widget.data!.icon;
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelectedIcon());
    }
  }

  void _scrollToSelectedIcon() {
    if (selectedIcon == null || !_iconScrollController.hasClients) return;
    // Next frame: selected item should be built, bring it into view
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _selectedIconKey.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          alignment: 0.5,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 60,
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
          widget.data == null ? "Add Category" : "Edit Category",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ElevatedButton(
            onPressed: () {},
            child: Text("Save"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          spacing: 15,
          children: [
            TextFieldWithLabel(
              controller: nameController,
              label: "Name",
              hintText: "Enter Category Name",
            ),
            TextFieldWithLabel(
              controller: detailsController,
              label: "Details",
              hintText: "Enter Category Details",
              maxLines: 5,
              minLines: 3,
            ),
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                  ).copyWith(left: 3),
                  child: Text(
                    "Icon",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.fromHex("#868DA6"),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.onPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GridView.builder(
                    controller: _iconScrollController,
                    padding: const EdgeInsets.all(10),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.1,
                        ),
                    itemCount: AppIcon.allIcons.length,
                    itemBuilder: (context, index) {
                      final icon = AppIcon.allIcons[index];
                      final isSelected = selectedIcon == icon.id;
                      final child = GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIcon = icon.id;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.fromHex("#EEF2FF"),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            icon.assetPath,
                            height: 24,
                            width: 24,
                            colorFilter: ColorFilter.mode(
                              isSelected
                                  ? AppColors.onPrimary
                                  : AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      );
                      return isSelected
                          ? KeyedSubtree(key: _selectedIconKey, child: child)
                          : child;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
