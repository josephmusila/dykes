import 'package:bikes/cubits/data_cubits/dataCubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/bikesDataModel.dart';
import '../../models/userModel.dart';
import '../../widgets/accountsWidget/profileCard.dart';
import 'addBike.dart';

class RenterAccount extends StatefulWidget {
  UserDataModel user;

  RenterAccount({required this.user});

  @override
  State<RenterAccount> createState() => _RenterAccountState();
}

class _RenterAccountState extends State<RenterAccount> {
  List<BikesDataModel> bikes = [];

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<BikesDataCubits>(context).getAllBikesData();
    BlocProvider.of<BikesDataCubits>(context)
        .getRentersBike(widget.user?.user.id as int);
    bikes = BlocProvider.of<BikesDataCubits>(context).searchedBike;
    print(bikes.length);
    print(bikes.length);
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
            ProfileCard(
              userDataModel: widget.user,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Update Account",
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Delete Account",
                  ),
                )
              ],
            ),
            const Divider(
              color: Colors.black,
            ),
            const Text(
              "My Bikes",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: () {
                      setState(() {

                      });
                    },
                    child: const Text(
                      "Load My Bikes",
                    ),
                  )
                ),
                Container(width: 10,),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AddBike(widget.user.user.id.toString());
                      }));
                    },
                    child: const Text("Add Bike"),
                  ),
                ),
                Container(
                  width: 20,
                ),
              ],
            ),
            Wrap(
                children: List.generate(bikes.length, (index) {
              return Card(
                elevation: 5,
                child: Container(
                  // color: Colors.deepOrange,
                  margin: const EdgeInsets.all(10),
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(bikes[index].image),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(bikes[index].name),
                            Text(bikes[index].description),
                            Text(
                                "Rent Status: ${bikes[index].rentStatus == null ? "Not Rented" : bikes[index].rentStatus as String}")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }))
          ],
        ),
      ),
    );
  }
}
