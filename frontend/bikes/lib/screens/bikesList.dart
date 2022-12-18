import 'package:bikes/widgets/homeWidgets/bikesDetailsWidget.dart';
import 'package:flutter/material.dart';

import '../models/bikesDataModel.dart';

class BikesListScreen extends StatelessWidget {
 List<BikesDataModel> bikes;


 BikesListScreen(this.bikes);

  @override
  Widget build(BuildContext context) {
    return Container(
     margin: const EdgeInsets.only(bottom: 50),
     height: double.maxFinite,
     width: double.maxFinite,
     child: ListView(
      children: List.generate(bikes.length, (index){
       return BikesDetailWidget(bikes[index]);
      }),
     ),
    );
  }
}
