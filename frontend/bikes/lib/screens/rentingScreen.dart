import 'dart:convert';

import 'package:bikes/cubits/data_cubits/dataStates.dart';
import 'package:bikes/services/bikeRentService.dart';
import 'package:bikes/services/paymentService.dart';
import 'package:flutter/material.dart';

import '../models/bikesDataModel.dart';
import '../models/userModel.dart';
import 'package:intl/intl.dart';


class RentingScreen extends StatefulWidget {
  BikesDataModel bikes;
  UserDataModel? user;

  RentingScreen(this.bikes,this.user);

  @override
  State<RentingScreen> createState() => _RentingScreenState();
}

class _RentingScreenState extends State<RentingScreen> {
  
  @override
  void initState() {
    payable=double.parse(widget.bikes.price);
    print(widget.user?.user.phone);
    super.initState();
  }

  int days=1;
  double payable=0.0;
  PaymentService paymentService=PaymentService();
  BikeRentalService bikeRentalService=BikeRentalService();
  final DateFormat format = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: ListView(
          children: [
            Container(
              height: 50,
              child: Center(
                child: Text(
                  widget.bikes.name,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(widget.bikes.image))),
            ),
            Text(
              widget.bikes.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Ksh${widget.bikes.price}/ day",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.black,),
            Container(
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Pick Up Point:",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    widget.bikes.owner.location,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.black,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.phone,
                    size: 30,
                    color: Colors.deepOrange,
                  ),
                  Text(
                    widget.bikes.owner.phone,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                   Text(
                    "Duration in Days: $days",
                    style: TextStyle(fontSize: 18),
                  ),
                  Slider(

                      value: double.parse(days.toString()),
                      inactiveColor: Colors.black26,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          days=value.round();
                          payable=days* double.parse(widget.bikes.price);

                        });
                      })
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Payable Amount",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Ksh${double.parse(widget.bikes.price) * days}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              child: Center(
                child: ElevatedButton(
                  child: Text("Proceed to Pay Ksh ${payable.toString()}"),
                  onPressed: () async{

                    if(widget.user == null){
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Payment process not initiated \n Login First"),
                        backgroundColor: Colors.redAccent,
                        dismissDirection: DismissDirection.up,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    }else {
                      var response = await paymentService.pay(
                          payable.toString(), widget.user?.user.phone as String,
                          widget.bikes.id.toString());
                      print(response);


                          if( response != null) {

                            await bikeRentalService.newRental(

                                customer: widget.user?.user.id.toString() as String,
                                bike_id: widget.bikes.id.toString(),
                                rent_status: "Pending",
                                date_of_return: format.format(DateTime.now().add(Duration(days: days))),
                                paid: "True",
                                owner: widget.bikes.owner.id.toString()
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Payment Process Initiated"),
                                backgroundColor: Colors.blue,
                                dismissDirection: DismissDirection.up,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );

                            Navigator.of(context).pop();
                          }else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "An error occurred please try again later"),
                                backgroundColor: Colors.redAccent,
                                dismissDirection: DismissDirection.up,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }


                    }
                },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
