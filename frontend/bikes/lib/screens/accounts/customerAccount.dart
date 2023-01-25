import 'package:bikes/models/userModel.dart';
import 'package:bikes/services/bikeRentService.dart';
import 'package:flutter/material.dart';

import '../../models/rentingHistoryModel.dart';
import '../../widgets/accountsWidget/profileCard.dart';

class CustomerAccount extends StatefulWidget {
  UserDataModel user;

  CustomerAccount(this.user);

  @override
  State<CustomerAccount> createState() => _CustomerAccountState();
}

class _CustomerAccountState extends State<CustomerAccount> {
  BikeRentalService bikeRentalService = BikeRentalService();
  @override
  void initState() {
    // TODO: implement initState
    // getHist(widget.user.user.id);
    bikeRentalService.getRentalsHistory(widget.user.user.id);
    super.initState();
  }

  // Future<RentalHistory> getHist(int id) async {
  //   return await bikeRentalService.getRentalsHistory(id);
  // }

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
            const Divider(
              color: Colors.black,
            ),
            const Text(
              "My rentals",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            Wrap(
              children: [
                FutureBuilder<List<RentalHistory>>(
                    future: bikeRentalService
                        .getRentalsHistory(widget.user.user.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data as List<RentalHistory>;
                        print("${data.length} dttttt");
                        return Wrap(
                          children: List.generate(data?.length as int, (index) {
                            return Container(
                              height: 100,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(data[index]?.bike.image as String),
                                          )
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(),
                                  )
                                ],
                              ),
                            );
                          }),
                        );
                      } else {
                        return const SizedBox(
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
