// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/bloc/box/box_cubit.dart';
import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/repo/courier_repo.dart';
import 'package:ase/presentation/courier/widgets/card/c_order_card.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CanceledTabContent extends StatefulWidget {
  const CanceledTabContent({
    super.key,
  });

  @override
  State<CanceledTabContent> createState() => _CanceledTabContentState();
}

class _CanceledTabContentState extends State<CanceledTabContent> {
  late final BoxCubit boxCubit;
  @override
  void initState() {
    super.initState();
    boxCubit = BoxCubit();
    boxCubit.getBox(CourierOrderStatus.cancelled);
  }

  List<BoxModel> boxList = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: boxCubit,
      child: BlocConsumer<BoxCubit, BoxState>(
        listener: (context, state) {
          if (state is BoxLoaded) {
            boxList.addAll(state.box.results ?? []);
          }
        },
        builder: (context, state) {
          if (state is BoxLoading) {
            return Center(child: const LoadingWidget());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.separated(
              itemCount: boxList.length + 1,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                if (index == boxList.length) {
                  return SizedBox(height: 60);
                }
                final box = boxList[index];
                return COrderCard(box: box);
              },
            ),
          );
        },
      ),
    );
  }
}
