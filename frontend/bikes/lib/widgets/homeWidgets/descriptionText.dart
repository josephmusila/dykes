import 'package:bikes/cubits/data_cubits/dataLogic.dart';
import 'package:bikes/models/userModel.dart';
import 'package:bikes/screens/repairsScreen.dart';
import 'package:bikes/widgets/homeWidgets/serviceWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/data_cubits/dataCubits.dart';
import '../../logic/searchBike.dart';
import '../../screens/accounts/renterAccount.dart';
import '../../services/bikeRentService.dart';

class QuickLinks extends StatelessWidget {
  QuickLinks({required this.user});

  UserDataModel? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Container(
            height: 50,
            color: Colors.deepOrange,
            width: double.maxFinite,
            child: const Center(
              child: Text(
                "Welcome to BikesEnt",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Text(
            "Our Core Services",
            textAlign: TextAlign.center,
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: ServiceWidget(
                  callback: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return BlocProvider(
                        create: (context) => BikesDataCubits(
                          bikeRentalService: BikeRentalService(),
                        ),
                        child: SearchBikeLogic(user),
                      );
                    }));
                  },
                  Icons.pedal_bike,
                  text: "Bike Renting",
                  color: Colors.blue,
                ),
              ),
              Expanded(
                flex: 1,
                child: ServiceWidget(
                  callback: () {
                    user?.user.accountType != "Renter" || user != null
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("You need to Login as a Renter First"),
                              backgroundColor: Colors.red,
                              dismissDirection: DismissDirection.up,
                              behavior: SnackBarBehavior.floating,
                            ),
                          )
                        : Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                            return RepairsScreen(
                              user: user!,
                            );
                          }));
                  },
                  Icons.tire_repair_outlined,
                  text: "Bike Repairs",
                  color: Color.fromARGB(255, 183, 3, 238),
                ),
              ),
              Expanded(
                flex: 1,
                child: ServiceWidget(
                  callback: () {
                    user?.user.accountType == "Renter" ?Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                                 return BlocProvider(
                                create: (context) => BikesDataCubits(
                                  bikeRentalService: BikeRentalService(),
                                ),
                                child: RenterAccount(user: user!),
                              );
                                // RenterAccount(user: user!);
                            },
                          ),
                        ):ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Only Renters Can Access this Service",style: TextStyle(fontSize: 18),),
                            backgroundColor: Colors.red,
                            dismissDirection: DismissDirection.up,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                  },
                  Icons.category_sharp,
                  text: "Bikes Management",
                  color: const Color.fromARGB(255, 248, 143, 6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
