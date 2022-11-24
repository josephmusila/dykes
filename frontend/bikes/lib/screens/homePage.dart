import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/dataCubits.dart';
import '../logic/sliderLogic.dart';
import '../models/userModel.dart';
import '../services/bikeRentService.dart';
import '../widgets/drawer.dart';
import '../widgets/homeWidgets/bikesSlider.dart';
import '../widgets/homeWidgets/descriptionText.dart';
import '../widgets/homeWidgets/searchWidget.dart';
import '../widgets/homeWidgets/welcomeText.dart';

class HomePage extends StatefulWidget {
  UserDataModel? user;


  HomePage([ this.user]);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: NavDrawer(widget.user),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: ListView(
              padding: const EdgeInsets.only(top: 0),
              children: [
            WelcomeText(
              username: widget.user == null? "":widget.user?.user.lastName as String ,
            ),
            QuickLinks(),
            SearchBike(),
            BlocProvider(
              create: (context) => BikesDataCubits(
                bikeRentalService: BikeRentalService(),
              ),
              child: SliderCubitLogics(),
            ),
            ElevatedButton(onPressed: () async{

            }, child: Text("Dtaa"),)
          ]),
        ),
      ),
    );
  }
}
