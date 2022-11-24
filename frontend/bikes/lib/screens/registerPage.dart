// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, duplicate_ignore

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../services/authService.dart';
import '../widgets/customWidgets.dart';
import '../widgets/formField.dart';
import 'loginPage.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var email = TextEditingController();
  var username = TextEditingController();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var password = TextEditingController();
  var phone = TextEditingController();
  var location = TextEditingController();
  var password2 = TextEditingController();

  var accounntType = ["Customer", "Renter"];
  String currentSelectedValue = "Customer";

  var imageFile;
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _load = false;
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Registration",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        // margin: const EdgeInsets.all(10),
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("img/login.jpg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Card(
                color: Colors.transparent,
                elevation: 5,
                shadowColor: Color.fromARGB(255, 1, 95, 236),
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  color: Color.fromARGB(95, 246, 239, 239),
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomField(
                        textInputType: TextInputType.text,
                        controller: firstname,
                        hideText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        hintText: "First Name",
                        labelText: "First Name",
                        onChanged: (value) {},
                      ),
                      CustomWidgets().box(10),
                      CustomField(
                        textInputType: TextInputType.text,
                        controller: lastname,
                        hideText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        hintText: "Last Name",
                        labelText: "Last Name",
                        onChanged: (value) {},
                      ),
                      CustomWidgets().box(10),
                      CustomField(
                        textInputType: TextInputType.text,
                        controller: location,
                        hideText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        hintText: "Umoja 1",
                        labelText: "Location",
                        onChanged: (value) {},
                      ),
                      CustomWidgets().box(10),
                      CustomField(
                        textInputType: TextInputType.emailAddress,
                        controller: email,
                        hideText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        hintText: "Fexample@gmail.com",
                        labelText: "Email",
                        onChanged: (value) {},
                      ),
                      CustomWidgets().box(10),
                      CustomField(
                        textInputType: TextInputType.phone,
                        controller: phone,
                        hideText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        hintText: "0712345678",
                        labelText: "Phone Number",
                        onChanged: (value) {},
                      ),
                      CustomWidgets().box(10),
                      CustomField(
                        textInputType: TextInputType.text,
                        controller: password,
                        hideText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (password.text != password2.text) {
                            return "Passwords do not Match";
                          }
                          return null;
                        },
                        hintText: "MyStrongPassword12",
                        labelText: "Password",
                        onChanged: (value) {},
                      ),
                      CustomWidgets().box(10),
                      CustomField(
                        textInputType: TextInputType.text,
                        controller: password2,
                        hideText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (password.text != password2.text) {
                            return "Passwords do not Match";
                          }
                          return null;
                        },
                        hintText: "MyStrongPassword12",
                        labelText: "Confirm Password",
                        onChanged: (value) {},
                      ),
                      CustomWidgets().box(10),
                      FormField(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: const InputDecoration(
                              labelText: "Account Type",
                              // hintText: widget.hintText,
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(204, 110, 101, 101)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(211, 246, 245, 245),
                                    width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(213, 3, 35, 220),
                                    width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                              ),
                            ),
                            isEmpty: currentSelectedValue == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: currentSelectedValue,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    currentSelectedValue = newValue!;
                                    state.didChange(newValue);
                                  });
                                },
                                items: accounntType.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                      CustomWidgets().box(10),
                      const Divider(
                        color: Colors.white,
                      ),
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
                                  label: const Text("Upload Passport"),
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
                      const Divider(
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 50, right: 50),
                        // ignore: deprecated_member_use
                        child: ElevatedButton(
                          onPressed: () async {
                            if(imageFile==null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("Please upload a profile photo"),
                                  ),
                                );
                            }
                            else if (_formKey.currentState!.validate()) {
                              setState(() {
                                _load = true;
                              });

                              var response = await authService.registration(
                                email: email.text,
                                location: location.text,
                                firstName: firstname.text,
                                lastName: lastname.text,
                                password: password.text,
                                phone: phone.text,
                                file: imageFile.path,
                                accountType: currentSelectedValue,
                              );
                              print(response);

                              if (jsonDecode(response)["email"] != null) {
                                print(
                                  response,
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      jsonDecode(response)["email"][0],
                                    ),
                                  ),
                                );
                                setState(() {
                                  _load = false;
                                });
                              } else {
                                setState(() {
                                  _load = false;
                                });
                                print(response);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text(jsonDecode(response)["message"]),
                                  ),
                                );
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return LoginPage();
                                  }),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Correct the shown errors')),
                              );
                            }
                          },
                          child: Text(
                            "Register",
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.purple,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            textStyle: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_load)
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.4,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.white,
                      height: 200,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          CircularProgressIndicator(),
                          const Text(
                            "Just A Second ..",
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Get from gallery
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
