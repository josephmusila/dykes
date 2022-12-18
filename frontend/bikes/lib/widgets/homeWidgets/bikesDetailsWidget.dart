import 'package:bikes/models/bikesDataModel.dart';
import 'package:flutter/material.dart';

class BikesDetailWidget extends StatelessWidget {
  BikesDataModel bike;

  BikesDetailWidget(this.bike);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.maxFinite,
      margin: const EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        shadowColor: Colors.blue,
        child: Column(
          children: [
            Container(
              height: 150,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(bike.image))),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Text(
                      bike.name,
                      style: const TextStyle(
                        fontSize: 20,
                        backgroundColor: Colors.white60,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Text(
                      "Ksh ${bike.price}/day",
                      style: const TextStyle(
                        fontSize: 20,
                        backgroundColor: Colors.white60,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          bike.description,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Location: ${bike.owner.location}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      ElevatedButton(onPressed: (){}, child: const Text("Book Now"),),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
