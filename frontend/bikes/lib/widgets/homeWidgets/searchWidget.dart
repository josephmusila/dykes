import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/dataCubits.dart';
import '../../models/bikesDataModel.dart';

class SearchBike extends StatefulWidget {
  const SearchBike({Key? key}) : super(key: key);

  @override
  State<SearchBike> createState() => _SearchBikeState();
}

class _SearchBikeState extends State<SearchBike> {

  List<BikesDataModel> bikes=[];

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: const EdgeInsets.all(5),
      height: 70,
      decoration:const  BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(
          20,
        )),
      ),
      width: double.maxFinite,
      //replace row with map screen
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.maxFinite,
                  child:  TextField(
                    // controller: textController,
                    textCapitalization: TextCapitalization.words,
                    // onChanged:BlocProvider.of<BikesDataCubits>(context).searchBike,

                    decoration: InputDecoration(
                      labelText: "Search bikes by name or location",
                      labelStyle: TextStyle(
                        fontSize: 16,
                      ),
                      hintText: 'e.g Umoja I',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius:
                            BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius:
                            BorderRadius.all(Radius.circular(32.0)),
                      ),
                      // suffixIcon: Center(child: Icon(Icons.search)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // void searchBike(String query){
  //   // final bikesList=bikesData.where((bike){
  //     final bikeName=bike.name.toLowerCase();
  //     final input=query.toLowerCase();
  //     return bikeName.contains(input);
  //   }).toList();
  //   print(bikesList);
  //   bikes =bikesList;
  // }

}
