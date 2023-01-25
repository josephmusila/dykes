import 'package:bikes/widgets/homeWidgets/bikesDetailsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/data_cubits/dataCubits.dart';
import '../models/bikesDataModel.dart';
import '../models/userModel.dart';
import '../services/bikeRentService.dart';

class BikesListScreen extends StatefulWidget {
 List<BikesDataModel> bikes;
 UserDataModel? user;


 BikesListScreen(this.bikes,this.user);


  @override
  State<BikesListScreen> createState() => _BikesListScreenState();
}

class _BikesListScreenState extends State<BikesListScreen> {
 List bikesdata=[];
 var search=TextEditingController();
 @override
  void initState() {

  print("${widget.bikes.length} biikes");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
     margin: const EdgeInsets.only(bottom: 50),
     height: double.maxFinite,
     width: double.maxFinite,
     child: Wrap(
       children: [
        Container(
         height: MediaQuery.of(context).size.height * 0.13,
         child: BlocProvider(
          create: (context) => BikesDataCubits(
           bikeRentalService: BikeRentalService(),
          ),
          child: Container(
           padding: const EdgeInsets.symmetric(horizontal: 10),
           child: TextField(
            controller: search,
            decoration: const InputDecoration(
             label: Text("Search for location here.."),
            ),
            onChanged: (value) {
             // setState(() {
             //  BlocProvider.of<BikesDataCubits>(context).searchBike(search.text);

             // });
            },
           ),
          ),

         ),
        ),
         Container(
          height: MediaQuery.of(context).size.height * 0.85,
           child: ListView(
            children: List.generate(widget.bikes.length, (index){
             return BikesDetailWidget(widget.bikes[index],widget.user);
            }),
           ),
         ),
       ],
     ),
    );
  }
}
