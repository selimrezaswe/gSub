
import 'package:flutter/material.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';

class CustomPageViewElement extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  const CustomPageViewElement({
    required this.title,
    required this.description,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
          height: 385,
          width: 444,
          colorBlendMode: BlendMode.dstATop,
        ),
        Spacer(),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onBackgroundLight,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.fromHex("#17161E"),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
