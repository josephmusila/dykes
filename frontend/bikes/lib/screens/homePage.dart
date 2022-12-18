import 'package:bikes/cubits/dataLogic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/dataCubits.dart';
import '../logic/searchBike.dart';
import '../logic/sliderLogic.dart';
import '../models/userModel.dart';
import '../services/bikeRentService.dart';
import '../widgets/drawer.dart';
import '../widgets/homeWidgets/descriptionText.dart';
import '../widgets/homeWidgets/welcomeText.dart';

enum CurrentScreen { home, search }

class HomePage extends StatefulWidget {
  UserDataModel? user;

  HomePage([this.user]);

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
                username: widget.user == null
                    ? ""
                    : widget.user?.user.lastName as String,
              ),
              const QuickLinks(),

              // SearchBikeLogic(),
              BlocProvider(
                create: (context) => BikesDataCubits(
                  bikeRentalService: BikeRentalService(),
                ),
                child: Column(
                  children: const [
                    Text(
                      "Featured Bikes",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange,
                      ),
                    ),
                    SliderCubitLogics(),
                  ],
                ),
              ),
              Container(
                height: 50,
                child: Stack(
                  children: [
                    Positioned(
                      right: 10,
                      top: 10,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context){
                              return BlocProvider(
                                create: (context)=>BikesDataCubits(bikeRentalService: BikeRentalService(),),
                                child:  SearchBikeLogic(),
                              );
                            })
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white24,
                        ),
                        child: Row(
                          children: const [
                            Text(
                              "See More",
                              style: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.deepOrange,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.black12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
