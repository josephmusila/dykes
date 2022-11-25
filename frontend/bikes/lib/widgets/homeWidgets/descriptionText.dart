import 'package:bikes/widgets/homeWidgets/serviceWidget.dart';
import 'package:flutter/material.dart';

class QuickLinks extends StatelessWidget {
  const QuickLinks({Key? key}) : super(key: key);

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
              ServiceWidget(
                Icons.pedal_bike,
                text: "Bike Renting",
                color: Colors.blue,
              ),
              ServiceWidget(
                Icons.tire_repair_outlined,
                text: "Bike Repairs",
                color: Color.fromARGB(255, 183, 3, 238),
              ),
              ServiceWidget(
                Icons.category_sharp,
                text: "Bikes Management",
                color: Color.fromARGB(255, 248, 143, 6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
