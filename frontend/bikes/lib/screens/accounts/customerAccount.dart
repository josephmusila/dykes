import 'package:bikes/models/userModel.dart';
import 'package:flutter/material.dart';

import '../../widgets/accountsWidget/profileCard.dart';

class CustomerAccount extends StatelessWidget {
  UserDataModel user;

  CustomerAccount(this.user);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(height: double.maxFinite,
        width: double.maxFinite,
        child: ListView(
          children: [
            ProfileCard(userDataModel: user,)
          ],
        ),
      ),
    );
  }
}
