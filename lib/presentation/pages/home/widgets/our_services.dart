// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/bloc/service/service_cubit.dart';
import 'package:ase/data/models/service_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OurServicesWidget extends StatefulWidget {
  const OurServicesWidget({
    super.key,
  });

  @override
  State<OurServicesWidget> createState() => _OurServicesWidgetState();
}

class _OurServicesWidgetState extends State<OurServicesWidget> {
  List<ServiceModel> services = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceState>(
      listener: (context, state) {
        if (state is ServiceSuccess) {
          services = state.services.results ?? [];
        }
      },
      builder: (context, state) {
        if (services.isEmpty) {
          return SliverToBoxAdapter();
        }
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
                services.length,
                (index) => ServiceCard(
                  service: services[index],
                ),
              )
            ],
          ),
        ));
      },
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.service,
  });
  final ServiceModel service;
  static final router = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => router.push(ServiceDetailRoute(
          image: service.image ?? "", slug: service.slug ?? "")),
      child: SizedBox(
        height: 202,
        child: Stack(
          children: [
            CashedImages(
              imageUrl: service.image ?? "",
              fit: BoxFit.cover,
              width: double.infinity,
              borderRadius: BorderRadius.circular(14),
              height: 202,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: 0.7,
                child: Container(
                  width: double.infinity,
                  height: 202,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        ColorConstants.black.withValues(alpha: .01),
                        ColorConstants.black.withValues(alpha: .3),
                        ColorConstants.black.withValues(alpha: .7),
                        ColorConstants.black.withValues(alpha: .8),
                      ])),
                ),
              ),
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
                            title: service.title ?? "",
                            textType: TextType.header,
                            fontWeight: FontWeight.w600,
                            maxLines: 3,
                            color: ColorConstants.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AppText(
                            title: service.subtitle ?? "",
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
      ),
    );
  }
}
