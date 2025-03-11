// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/bloc/box/box_cubit.dart';
import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/repo/courier_repo.dart';
import 'package:ase/presentation/courier/widgets/card/c_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IHaveTabContent extends StatefulWidget {
  const IHaveTabContent({
    super.key,
  });

  @override
  State<IHaveTabContent> createState() => _IHaveTabContentState();
}

class _IHaveTabContentState extends State<IHaveTabContent> {
  late final BoxCubit boxCubit;
  @override
  void initState() {
    super.initState();
    boxCubit = BoxCubit();
    boxCubit.getBox(CourierOrderStatus.active);
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
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BoxError) {
            return Center(child: Text(state.message));
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

                return COrderCard(box: boxList[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
