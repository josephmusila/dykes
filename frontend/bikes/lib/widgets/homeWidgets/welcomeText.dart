import 'package:flutter/material.dart';

import '../../config/themeColors.dart';
import '../../screens/loginPage.dart';
import '../../screens/registerPage.dart';

class WelcomeText extends StatelessWidget {
  String username;
  WelcomeText({required this.username});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        // color: Colors.grey,
        height: 40,
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                username == null ? "Hello" : "Hello $username",
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.mainColor
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
