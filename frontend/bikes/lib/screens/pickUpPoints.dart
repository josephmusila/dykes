import 'package:flutter/material.dart';

import '../widgets/homeWidgets/searchWidget.dart';

class PickUpPoint extends StatefulWidget {
  List locations;

  PickUpPoint(this.locations);

  @override
  State<PickUpPoint> createState() => _PickUpPointState();
}

class _PickUpPointState extends State<PickUpPoint> {
  var searchLoc = TextEditingController();

  // List mylocations=[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Wrap(
            // shrinkWrap: true,
            // padding: const EdgeInsets.only(top: 10),
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: searchLoc,
                  decoration: const InputDecoration(
                    label: Text("Search for location here.."),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchBike(value);
                      // widget.locations=searchBike(value);
                    });
                  },
                ),
              ),
              Wrap(
                children: List.generate(
                  widget.locations.length,
                  (index) {
                    return ListTile(
                      leading: Text((index + 1).toString()),
                      title: Text(widget.locations[index]),
                      onTap: (){
                        // Navigator.of(context).
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchBike(String query) {
    final mylocation = widget.locations.where((location) {
      final loc = location.toLowerCase();
      final input = query.toLowerCase();
      return loc.contains(input);
    }).toList();
    print(query);
    widget.locations = mylocation;
    setState(() {});
    // return mylocation;
  }
}
