
import 'package:flutter/material.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/features/home/presentation/widgets/upcoming_card_widget.dart';

class Upcomings extends StatelessWidget {
  const Upcomings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Row(
                spacing: 8,
                children: [
                  Text(
                    "Upcoming",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: AppColors.yellow,
                    ),
                    child: Text(
                      "10",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text("See All"),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) => UpcomingCardWidget(),
            separatorBuilder: (context, index) => SizedBox(width: 15),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
