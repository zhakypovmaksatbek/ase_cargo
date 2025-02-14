import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'SupportRoute')
class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        title: Text("Support"),
      )
    ]));
  }
}
