import 'dart:ui';

import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  String text;
  IconData icon;
  Color color;
  VoidCallback callback;

  ServiceWidget(

      this.icon, {
        required this.text,
        required this.color,
        required this.callback
      });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(5),
        child: InkWell(
          onTap: callback,
          child: Column(
            children: [

              Icon(icon,color: color,size: 30,),
              const Spacer(),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}