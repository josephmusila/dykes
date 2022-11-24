import 'package:flutter/material.dart';

class CustomWidgets{
  
 




  Widget box(double customheight){
    return SizedBox(
      height: customheight,
    );
  }

  Widget fieldRow({required String title,required TextEditingController controller,required bool hideText}){
    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      child: Row(
        children: [
         Expanded(
           flex: 1,
           child: Text(title,style: TextStyle(
             fontSize: 16,
           ),),
         ),
          Expanded(
            flex: 3,
            child: TextFormField(
              obscureText: hideText,
             controller: controller,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              decoration: InputDecoration(

                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue
                      )
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
  

  
}