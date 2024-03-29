// ignore_for_file: prefer_const_constructors

import 'package:bikes/cubits/data_cubits/dataCubits.dart';

import 'package:bikes/models/bikesDataModel.dart';
import 'package:bikes/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/data_cubits/dataStates.dart';
import '../../screens/rentingScreen.dart';

class CustomImageSlider extends StatefulWidget {
  UserDataModel? user;

  CustomImageSlider(this.user);
  @override
  State<CustomImageSlider> createState() => _CustomImageSliderState();
}

class _CustomImageSliderState extends State<CustomImageSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: BlocBuilder<BikesDataCubits, BikesData>(builder: (context, state) {
        if (state is BikesDataLoadedState) {
          var bikes = state.data;

          return CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: false,
            ),
            items: List.generate(
              bikes.length,
              (index) {
                return Container(
                  height: 600,
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(bikes[index].image,
                            fit: BoxFit.cover, height: 400, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: const [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              bikes[index].name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Text(
                            "Ksh ${bikes[index].price}/Day",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.white.withOpacity(0.7)),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right : 5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue.withOpacity(0.5),
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold

                              )
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return RentingScreen(bikes[index],widget.user);
                              }));
                            },
                            child: const Text("Book Now"),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
