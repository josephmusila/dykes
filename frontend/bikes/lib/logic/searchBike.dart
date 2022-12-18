import 'package:bikes/cubits/dataCubits.dart';
import 'package:bikes/cubits/dataStates.dart';
import 'package:bikes/widgets/homeWidgets/searchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/bikesDataModel.dart';
import '../screens/bikesList.dart';
import '../services/bikeRentService.dart';

class SearchBikeLogic extends StatefulWidget {
  @override
  State<SearchBikeLogic> createState() => _SearchBikeLogicState();
}

class _SearchBikeLogicState extends State<SearchBikeLogic> {
  List<BikesDataModel> bikes = [];
  @override
  void initState() {
    BlocProvider.of<BikesDataCubits>(context).getAllBikesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: BlocProvider(
                create: (context) => BikesDataCubits(
                  bikeRentalService: BikeRentalService(),
                ),
                // child: SearchBike(),
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<BikesDataCubits>(context).searchBike("Mountain");
                    setState(() {

                    });
                  },
                  child: Text("hello"),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              margin: const EdgeInsets.only(bottom: 20),
              child: BlocBuilder<BikesDataCubits, BikesData>(
                  builder: (context, state) {
                if (state is BikesDataErrorState) {
                  return Container(
                    height: 100,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is BikesDataLoadedState) {
                  return BikesListScreen(state.data);
                }
                if (state is BikesDataErrorState) {
                  return Container(
                    height: 50,
                    child: Center(child: Text(state.message)),
                  );
                } else {
                  return Container();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
