import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/core/constant/demo.dart';

class UpcomingCardWidget extends StatelessWidget {
  const UpcomingCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.onPrimaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.memory(
                  base64Decode(demoImageBase64),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "\$16.00",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "2 Days",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff868DA6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "Spotify",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
