import 'package:flutter/material.dart';

import '../models/userModel.dart';
import '../screens/accounts/customerAccount.dart';
import '../screens/accounts/renterAccount.dart';
import '../screens/loginPage.dart';
import '../screens/registerPage.dart';

class NavDrawer extends StatelessWidget {
  UserDataModel? user;

  NavDrawer(this.user);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Colors.red,
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            width: 100,
            child: Center(
              child: user == null
                  ? const Text("No User Logged In")
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(user?.user.avatar as String)),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("Register"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return RegisterScreen();
                    },
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text(user == null ? "Login" : "Logout"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("Account"),
              onTap: () {
                Navigator.of(context).pop();
                user == null
                    ? ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("You need to Login First"),
                          backgroundColor: Colors.red,
                          dismissDirection: DismissDirection.up,
                          behavior: SnackBarBehavior.floating,
                        ),
                      )
                    : Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return user?.user.accountType == "Renter"? RenterAccount(user: user!) : CustomerAccount();
                          },
                        ),
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
