import 'package:bikes/config/themeColors.dart';
import 'package:flutter/material.dart';

import '../../models/userModel.dart';

class ProfileCard extends StatelessWidget {
  UserDataModel userDataModel;


  ProfileCard({required this.userDataModel});
  var textStyle=const TextStyle(color: AppColors.basicColor,fontSize: 16);
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(5),
      height: 200,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      userDataModel.user.avatar,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${userDataModel.user.firstName} ${userDataModel.user.lastName}",
                    style: textStyle,
                  ),
                  Text(
                    userDataModel.user.email,
                    style: textStyle
                  ),
                  Text(
                    userDataModel.user.accountType,
                    style:textStyle
                  ),
                  Text(
                    userDataModel.user.phone,
                    style:textStyle
                  ),
                  Text(
                    userDataModel.user.location,
                    style: textStyle
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
