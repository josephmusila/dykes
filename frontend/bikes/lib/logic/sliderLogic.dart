import 'package:bikes/cubits/dataCubits.dart';
import 'package:bikes/cubits/dataStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/homeWidgets/bikesSlider.dart';

class SliderCubitLogics extends StatefulWidget {
  const SliderCubitLogics({Key? key}) : super(key: key);

  @override
  State<SliderCubitLogics> createState() => _SliderCubitLogicsState();
}

class _SliderCubitLogicsState extends State<SliderCubitLogics> {
  @override
  void initState() {
    BlocProvider.of<BikesDataCubits>(context).getAllBikesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<BikesDataCubits, BikesData>(builder: (context, state) {
        if (state is BikesDataInitialState) {
          return Container(
            height: 200,
            child: const Center(
              child: Text("Awaiting Data"),
            ),
          );
        }
        if (state is BikesDataLoadingState) {
          return Container(
            height: 100,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is BikesDataLoadedState) {
          return CustomImageSlider();
        } else {
          return Container();
        }
      }),
    );
  }
}
