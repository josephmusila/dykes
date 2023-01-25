import 'package:bikes/models/bikesDataModel.dart';
import 'package:bikes/screens/pickUpPoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/data_cubits/dataCubits.dart';
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
  BikeRentalService bikeRentalService = BikeRentalService();
  late UserDataModel currentuser;

  @override
  void initState() {
    print(widget.user?.user.firstName);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.blue),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: NavDrawer(widget.user),
        body: Container(
          height: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 0),
            children: [
              WelcomeText(
                username: widget.user == null
                    ? ""
                    : widget.user?.user.lastName as String,
              ),
              QuickLinks(user: widget.user),

              // SearchBikeLogic(),
              BlocProvider(
                create: (context) => BikesDataCubits(
                  bikeRentalService: BikeRentalService(),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Featured Bikes",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange,
                      ),
                    ),
                    SliderCubitLogics(widget.user),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: Stack(
                  children: [
                    Positioned(
                      right: 10,
                      top: 10,
                      child: TextButton(
                        onPressed: () {
                          // widget.user == null ?
                          if(widget.user == null){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Login  For More Experience"),
                                backgroundColor: Colors.blue,
                                dismissDirection: DismissDirection.up,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return BlocProvider(
                              create: (context) => BikesDataCubits(
                                bikeRentalService: BikeRentalService(),
                              ),
                              child: SearchBikeLogic(widget.user),
                            );
                          }));
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
                color: Colors.black,
              ),
              const Text(
                "Top Bike Pick Up Points",
                style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.grey,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              FutureBuilder<List>(
                future: bikeRentalService.getlocations(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List picklocations=snapshot.data!;
                    List locations = picklocations.getRange(0, 5).toList();
                    print(locations.length);
                    return SingleChildScrollView(
                      child: Wrap(
                          // shrinkWrap: true,
                          // padding: const EdgeInsets.only(top: 10),
                          children: [
                            Wrap(
                              children: List.generate(
                                locations.length,
                                (index) {
                                  return ListTile(
                                    leading: Text((index + 1).toString()),
                                    title: Text(locations[index]),
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(

                                      label: const Text("See all Pickup Points"),
                                      icon: Icon(Icons.arrow_forward),
                                      onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                          return PickUpPoint(picklocations);
                                        }));
                                      },

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    );
                  } else {
                    return Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          children: const [
                            CircularProgressIndicator(),
                            Text("Loading pick up points..")
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              Container(
                height: 100,
                color: Colors.deepOrange,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      "Terms And Conditions Apply",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Contact 1: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Email: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
