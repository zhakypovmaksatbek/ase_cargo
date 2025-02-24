// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/repo/product_repo.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

@RoutePage(name: "ServiceDetailRoute")
class ServiceDetailPage extends StatelessWidget {
  const ServiceDetailPage({
    super.key,
    required this.slug,
    required this.image,
  });
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
                  future: repo.getDetails(slug, type: "services"),
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
}
