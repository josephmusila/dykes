import 'package:bikes/models/bikesDataModel.dart';
import 'package:bikes/screens/rentingScreen.dart';
import 'package:flutter/material.dart';

import '../../models/userModel.dart';

class BikesDetailWidget extends StatefulWidget {
  BikesDataModel bike;
  UserDataModel? user;

  BikesDetailWidget(this.bike,this.user);

  @override
  State<BikesDetailWidget> createState() => _BikesDetailWidgetState();
}

class _BikesDetailWidgetState extends State<BikesDetailWidget> {
  @override
  void initState() {
    // TODO: implement initState
    print("${widget.user?.user.phone} fin");
    super.initState();
  }
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
                            image: NetworkImage(widget.bike.image))),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Text(
                      widget.bike.name,
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
                      "Ksh ${widget.bike.price}/day",
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
                          widget.bike.description,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Location: ${widget.bike.owner.location}",
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
                      ElevatedButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return RentingScreen(widget.bike,widget.user);
                        }));
                      }, child: const Text("Book Now"),),
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
