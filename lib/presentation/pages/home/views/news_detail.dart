import 'package:ase/data/repo/product_repo.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

@RoutePage(name: "NewsDetailRoute")
class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key, required this.slug, required this.image});
  final String slug;
  final String image;
  static final repo = ProductRepo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            leading: BackButton(
              style: CustomBoxDecoration.backButtonStyle(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: CashedImages(imageUrl: image),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
              child: FutureBuilder(
                  future: repo.getDetails(slug, type: "articles"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String pageData = snapshot.data.toString();
                      return HtmlWidget(
                        pageData,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'EuclidCircular',
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: LoadingWidget());
                    }
                    return SizedBox();
                  }),
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
