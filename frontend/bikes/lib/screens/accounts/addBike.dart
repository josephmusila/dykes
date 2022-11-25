import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/bikeRentService.dart';
import '../../widgets/formField.dart';
import 'dart:io';

class AddBike extends StatefulWidget {
  String ownerId;

  AddBike(this.ownerId);

  @override
  State<AddBike> createState() => _AddBikeState();
}

class _AddBikeState extends State<AddBike> {
  BikeRentalService bikeRentalService = BikeRentalService();
  var name = TextEditingController();
  var description = TextEditingController();
  var price = TextEditingController();
  var imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        height: double.maxFinite,
        width: double.maxFinite,
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            CustomField(
              textInputType: TextInputType.text,
              controller: name,
              hideText: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              hintText: "Bike Name",
              labelText: "Bike Name",
              onChanged: (value) {},
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              minLines: 3,
              maxLines: 4,
              keyboardType: TextInputType.text,
              controller: description,
              obscureText: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Bike Description",
                hintText: "Bike Description",
                labelStyle: TextStyle(color: Colors.white),
                hintStyle:
                    TextStyle(color: Color.fromARGB(204, 110, 101, 101)),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(211, 246, 245, 245), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(213, 3, 35, 220), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 10),
            CustomField(
              textInputType: TextInputType.text,
              controller: price,
              hideText: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              hintText: "Bike Price",
              labelText: "Bike Price",
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(color: Colors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.upload,
                        ),
                        onPressed: () {
                          _getFromGallery();
                        },
                        label: const Text("Upload bike Image"),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.camera,
                        ),
                        onPressed: () {
                          _getFromCamera();
                        },
                        label: const Text("Take Photo"),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  height: 80,
                  width: 80,
                  color: Colors.white,
                  child: imageFile == null
                      ? Center(
                          child: Text(
                            "No Image Selected",
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Image.file(
                          imageFile,
                          fit: BoxFit.cover,
                        ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(color: Colors.white),
            ElevatedButton(
                onPressed: () async {
                  try {
                    var response = await bikeRentalService.addBike(
                      owner: widget.ownerId,
                      name: name.text,
                      description: description.text,
                      price: price.text,
                      image: imageFile.path,
                    );
                    print(json.decode(response));
                  }catch (e){
                    ScaffoldMessenger.of(context).showSnackBar(
                      // ignore: prefer_const_constructors
                      SnackBar(
                        content:  Text(e.toString()),
                        backgroundColor: const Color.fromARGB(255, 253, 2, 30),
                        dismissDirection: DismissDirection.up,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },


                child: const Text("Add Bike"))
          ],
        ),
      ),
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from camera  ////

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}
