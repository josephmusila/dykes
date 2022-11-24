import 'package:flutter/material.dart';

import '../../models/userModel.dart';
import 'addBike.dart';

class RenterAccount extends StatefulWidget {
 UserDataModel user;

 RenterAccount({required this.user});

 @override
  State<RenterAccount> createState() => _RenterAccountState();
}

class _RenterAccountState extends State<RenterAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(height: double.maxFinite,
      width: double.maxFinite,
      child: ListView(
        children: [
          Container(height: 100,),
          ElevatedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return AddBike(widget.user.user.id.toString());
            }));
          },child: const Text("Add Bike"),)
        ],
      ),
      ),
    );
  }
}
