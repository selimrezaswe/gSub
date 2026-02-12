import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/core/constant/app_assets.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';

class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

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
          "Restore",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      //   child: SafeArea(
      //     child: ElevatedButton(
      //       child: Text("Save Change"),
      //       onPressed: () {},
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select how you want to restore your data",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.fromHex("#868DA6"),
              ),
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.images.drive),
                          Text(
                            "Back up using Google Drive",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColors.fromHex("#868DA6"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.images.mobile),
                          Text(
                            "Import from device",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColors.fromHex("#868DA6"),
                            ),
                          ),
                        ],
                      ),
                    ),
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
