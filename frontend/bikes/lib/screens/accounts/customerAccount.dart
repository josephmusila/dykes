import 'package:flutter/material.dart';

class CustomerAccount extends StatelessWidget {
  const CustomerAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(height: double.maxFinite,
        width: double.maxFinite,
        child: ListView(
          children: [
              Text("Customer")
          ],
        ),
      ),
    );
  }
}
