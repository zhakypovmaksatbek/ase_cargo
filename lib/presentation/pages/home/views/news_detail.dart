import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "NewsDetailRoute")
class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 380,
            leading: BackButton(
              style: CustomBoxDecoration.backButtonStyle(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background:
                  CashedImages(imageUrl: "https://picsum.photos/200/300"),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(title: title, textType: TextType.title20),
                  AppText(title: description, textType: TextType.body),
                  SizedBox(height: 90)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  static const String title =
      "Доставка экспресс-отправлений, посылок и грузов по городам Кыргызстана, включая области и поселки";
  static const String description = """• Выезд курьера для приема отправлений.
• Прием отправлений в офисе, на складе отправителя и/или по поручению отправителя со склада поставщика.
• Предоставление накладной для оформления и отслеживания отправлений.
• Стандартная упаковка: фирменные картонные конверты и пластиковые пакеты.
• Автоматическое страхование в рамках Закона о почте, ограничивающее ответственность компании установленными пределами.
• Персональный консультант для поддержки и консультаций по всем вопросам.
• Консультации по таможенному оформлению для международных отправлений.
• Подтверждение доставки: отчет по электронной почте или устно предоставляется бесплатно. Официальное письмо-уведомление доступно за дополнительную плату.""";
}
