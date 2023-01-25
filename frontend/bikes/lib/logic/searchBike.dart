import 'package:bikes/cubits/data_cubits/dataCubits.dart';
import 'package:bikes/models/userModel.dart';

import 'package:bikes/widgets/homeWidgets/searchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/data_cubits/dataStates.dart';
import '../models/bikesDataModel.dart';
import '../screens/bikesList.dart';
import '../services/bikeRentService.dart';

enum SelectedScreen{ all, search }

class SearchBikeLogic extends StatefulWidget {
  UserDataModel? user;

  SearchBikeLogic(this.user);


  @override
  State<SearchBikeLogic> createState() => _SearchBikeLogicState();
}

class _SearchBikeLogicState extends State<SearchBikeLogic> {

  SelectedScreen selectedScreen=SelectedScreen.all;
  List<BikesDataModel> bikes = [];
  @override
  void initState() {
    BlocProvider.of<BikesDataCubits>(context).getAllBikesData();
    print(widget.user?.user.phone);
    super.initState();
  }
var search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: ListView(
          children: [

            Container(
              height: MediaQuery.of(context).size.height * 1,
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
                  return BikesListScreen(state.data,widget.user);
                }
                if (state is BikesDataErrorState) {
                  return Container(
                    height: 50,
                    child: Center(child: Text(state.message)),
                  );
                } else {
                  return Container();
                }
              })
            ),
          ],
        ),
      ),
    );
  }
}
