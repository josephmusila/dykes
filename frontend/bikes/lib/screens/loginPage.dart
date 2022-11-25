// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/authService.dart';

import '../widgets/customWidgets.dart';
import '../widgets/formField.dart';
import 'homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();

}
class _LoginPageState extends State<LoginPage> {
  var email = TextEditingController();

  var password = TextEditingController();

  final AuthService authService = AuthService();
  // CurrentUserService currentUserService = CurrentUserService();
  bool _load = false;

  ///persistent authentication
  ///
  // final _storage = const FlutterSecureStorage();
  // Future<void> _readFromStorage() async {
  //   email.text = await _storage.read(key: "KEY_EMAIL") ?? '';
  //   password.text = await _storage.read(key: "KEY_PASSWORD") ?? '';
  //   await authService.login(
  //     email: email.text,
  //     password: password.text,
  //   );
  // }
  @override
  void initState() {
    super.initState();
    // _readFromStorage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          " Log In",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("img/login.jpg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  shadowColor: const Color.fromARGB(255, 1, 95, 236),
                  color: Colors.transparent,
                  child: Container(
                    color: const Color.fromARGB(95, 246, 239, 239),
                    padding: const EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                          hintText: "example@gmail.com",
                          labelText: "Email",
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        CustomField(
                          textInputType: TextInputType.visiblePassword,
                          controller: password,
                          hideText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          hintText: "",
                          labelText: "Password",
                          onChanged: (value) {

                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50, right: 50),
                  // ignore: deprecated_member_use
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    onPressed: () async {
                      setState(() {
                        _load = true;
                      });
                      try {
                        var response = await authService.login(
                          email: email.text,
                          password: password.text,
                        );

                          setState(() {
                            _load = false;
                          });
                          print(response);
                          // BlocProvider(
                          //     create: (context) => AccountCubit(
                          //       currentUserService: CurrentUserService(),
                          //       email: email.text,
                          //     ),
                          //     child: AccountLogicScreen(
                          //       email: email.text,
                          //     ));
                          // SharedPreferences prefs =
                          // await SharedPreferences.getInstance();
                          // prefs.setString(
                          //   'email',
                          //   email.text,
                          // );

                          // await _storage.write(
                          //     key: "KEY_EMAIL", value: email.text);
                          // await _storage.write(
                          //     key: "KEY_PASSWORD", value: password.text);

                          ScaffoldMessenger.of(context).showSnackBar(
                            // ignore: prefer_const_constructors
                            SnackBar(
                              content: const Text("Welcome"),
                              backgroundColor: const Color.fromARGB(255, 24, 93, 13),
                              dismissDirection: DismissDirection.up,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return HomePage( response,);
                          }));

                      }  catch (e){
                        setState(() {
                          _load = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          // ignore: prefer_const_constructors
                          SnackBar(
                            content:  Text(e.toString()),
                            backgroundColor: const Color.fromARGB(
                                255, 246, 7, 7),
                            dismissDirection: DismissDirection.up,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );


                      }
                    },
                    child: Text("Log In"),
                    textColor: Colors.white,
                    color: Colors.blue,
                  ),
                ),
              ],
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
                        const CircularProgressIndicator(),
                        const Text("Just A Second ..")
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}