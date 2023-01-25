import 'package:bikes/cubits/data_cubits/dataCubits.dart';
import 'package:bikes/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/data_cubits/dataStates.dart';
import '../widgets/homeWidgets/bikesSlider.dart';

class SliderCubitLogics extends StatefulWidget {
  UserDataModel? user;

   SliderCubitLogics(this.user);

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
            child:  Container(
              height: 100,
              child: Center(
                child: Column(
                  children: const [
                    CircularProgressIndicator(),
                     Text("Loading Bikes",style: TextStyle(fontSize: 20),)
                  ],
                ),
              ),
            ),
          );
        }
        if (state is BikesDataLoadedState) {
          return CustomImageSlider(widget.user);
        } else {
          return Container();
        }
      }),
    );
  }
}
