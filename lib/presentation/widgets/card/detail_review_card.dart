import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/rating/rating_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class DetailReviewCard extends StatelessWidget {
  const DetailReviewCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              CircleAvatar(
                  backgroundImage: NetworkImage("https://picsum.photos/200")),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title: "User Name Game Name Game Name",
                      textType: TextType.body,
                      fontWeight: FontWeight.w500,
                    ),
                    AppText(
                      title: "12.01.2025",
                      textType: TextType.description,
                    ),
                  ],
                ),
              ),
              StarRating(
                rating: 5,
                size: 14,
              )
            ],
          ),
          CashedImages(
              width: size.width,
              height: size.width / 2,
              imageUrl: "https://picsum.photos/300/300"),
          AppText(
            title:
                "Lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
            textType: TextType.body,
          )
        ],
      ),
    );
  }
}
