import 'package:admin_panel/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  final String username;
  final DateTime date;
  final String feedbackText;
  const UserReviewCard(
      {super.key,
      required this.username,
      required this.date,
      required this.feedbackText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: const ShapeDecoration(
          shape: BeveledRectangleBorder(
              side: BorderSide(color: AppColor.primary, width: 0.3),
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(12)))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                username,
                style: const TextStyle(
                    color: AppColor.secondary,
                    fontFamily: 'Niradei',
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                '$date',
                style: const TextStyle(
                  color: AppColor.disable,
                  fontSize: 12,
                  fontFamily: 'Niradei',
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          ReadMoreText(
            feedbackText,
            trimLines: 2,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' show more',
            trimExpandedText: ' show less',
            moreStyle: const TextStyle(
              color: AppColor.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            lessStyle: TextStyle(
              color: AppColor.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
