import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/def_text_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage(name: "PaymentRoute")
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: BackButton(
              style: CustomBoxDecoration.backButtonStyle(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                spacing: 20,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    decoration: CustomBoxDecoration(),
                    child: Column(
                      spacing: 14,
                      children: [
                        _buildInfo(LocaleKeys.general_additional_services.tr(),
                            "Экспресс (3 рабочих дня sjkdbsjdb dsbdsbjbjd)"),
                        _buildInfo(LocaleKeys.form_weight.tr(), "1 kg"),
                        Divider(),
                        _buildInfo(
                            LocaleKeys.general_additional_service_price.tr(),
                            "300 c"),
                        _buildInfo(LocaleKeys.form_weight.tr(), "100"),
                      ],
                    ),
                  ),
                  Container(
                    decoration: CustomBoxDecoration(),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        AppText(
                          title: LocaleKeys.general_payment_method.tr(),
                          textType: TextType.body,
                          fontWeight: FontWeight.w500,
                        ),
                        TabBar(
                            padding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            indicatorPadding: EdgeInsets.zero,
                            controller: _tabController,
                            onTap: (value) {
                              setState(() {});
                            },
                            tabs: List.generate(
                                PaymentType.values.length,
                                (index) => Tab(
                                      text:
                                          PaymentType.values[index].title.tr(),
                                      icon: SvgPicture.asset(
                                        PaymentType.values[index].icon,
                                        colorFilter:
                                            _tabController.index == index
                                                ? ColorFilter.mode(
                                                    ColorConstants.primary,
                                                    BlendMode.srcIn)
                                                : null,
                                      ),
                                    ))),
                        SizedBox(
                          height: 300,
                          child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    AppText(
                                      title:
                                          LocaleKeys.general_take_change.tr(),
                                      textType: TextType.body,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    DefTextField(
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        hintText:
                                            LocaleKeys.general_write_sum.tr())
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    AppText(
                                      title: LocaleKeys.general_payment_method
                                          .tr(),
                                      textType: TextType.body,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        spacing: 10,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: List.generate(
                                          3,
                                          (index) {
                                            return ChoiceChip(
                                                selected: true,
                                                showCheckmark: false,
                                                side: BorderSide(),
                                                selectedColor: ColorConstants
                                                    .backgroundLight,
                                                backgroundColor: ColorConstants
                                                    .backgroundLight,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14)),
                                                label: AppText(
                                                    title: "MBank",
                                                    textType: TextType.body));
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(),
                                    Requisite(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 16),
                                      decoration: CustomBoxDecoration()
                                          .copyWith(
                                              color:
                                                  ColorConstants.dividerColor),
                                      child: Row(
                                        spacing: 10,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: CustomBoxDecoration
                                                    .circleDecoration()
                                                .copyWith(
                                                    color: ColorConstants
                                                        .lightGrey,
                                                    border: Border.all(
                                                        color: ColorConstants
                                                            .white,
                                                        width: 6)),
                                            child: CustomAssetImage(
                                              path: AssetConstants.upload.svg,
                                              isSvg: true,
                                            ),
                                          ),
                                          AppText(
                                            title: LocaleKeys
                                                .button_upload_check
                                                .tr(),
                                            textType: TextType.body,
                                            color: ColorConstants.darkBlue,
                                            fontWeight: FontWeight.bold,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                AppText(
                                  title: LocaleKeys.general_payment_method.tr(),
                                  textType: TextType.body,
                                  fontWeight: FontWeight.w500,
                                ),
                              ]),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Row _buildInfo(String title, String body) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          title: title,
          textType: TextType.body,
          color: ColorConstants.darkGrey,
        ),
        Flexible(
            child: AppText(
          title: body,
          textType: TextType.body,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.end,
        ))
      ],
    );
  }
}

class Requisite extends StatelessWidget {
  const Requisite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration:
          CustomBoxDecoration().copyWith(color: ColorConstants.dividerColor),
      child: Column(
        spacing: 6,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: AppText(
                  title: "MBank",
                  textType: TextType.body,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.lightBlack,
                ),
              ),
              Icon(
                Icons.copy,
                color: ColorConstants.primary,
              )
            ],
          ),
          SizedBox(),
          AppText(
            title: "+996 700 00 00 00",
            textType: TextType.body,
            fontWeight: FontWeight.w500,
            color: ColorConstants.lightBlack,
          ),
          Row(
            spacing: 10,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: CustomBoxDecoration.circleDecoration()
                    .copyWith(color: ColorConstants.grey),
                child: CustomAssetImage(
                  path: AssetConstants.profile.svg,
                  isSvg: true,
                  svgColor: ColorConstants.white,
                ),
              ),
              Flexible(
                child: AppText(
                  title: "Ase",
                  textType: TextType.body,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.lightBlack,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum PaymentType {
  cash(title: LocaleKeys.general_cash, icon: "assets/svg/cash2.svg"),
  transfer(title: LocaleKeys.general_transfer, icon: "assets/svg/transfer.svg"),
  card(title: LocaleKeys.general_card, icon: "assets/svg/card.svg"),
  ;

  final String title;
  final String icon;

  const PaymentType({required this.title, required this.icon});
}
