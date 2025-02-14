import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OurServicesWidget extends StatelessWidget {
  const OurServicesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
              title: LocaleKeys.general_our_services.tr(),
              textType: TextType.title),
          ...List.generate(
            5,
            (index) => ServiceCard(),
          )
        ],
      ),
    ));
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 202,
      child: Stack(
        children: [
          CashedImages(
            imageUrl: "https://picsum.photos/200/300",
            fit: BoxFit.cover,
            width: double.infinity,
            borderRadius: BorderRadius.circular(14),
            height: 202,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 10,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          title:
                              "Экспресс доставка Экспресс доставкаЭкспресс доставка",
                          textType: TextType.header,
                          fontWeight: FontWeight.w600,
                          maxLines: 3,
                          color: ColorConstants.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppText(
                          title: "Доставка за краткие сроки Экспресс доставка",
                          textType: TextType.body,
                          color: ColorConstants.white,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorConstants.white),
                        gradient: LinearGradient(colors: [
                          ColorConstants.darkGrey,
                          ColorConstants.grey,
                          ColorConstants.lightGrey,
                        ])),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: ColorConstants.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
