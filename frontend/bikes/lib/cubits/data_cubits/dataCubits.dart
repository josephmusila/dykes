
import 'package:bikes/models/bikesDataModel.dart';
import "package:flutter_bloc/flutter_bloc.dart";

import '../../services/bikeRentService.dart';
import 'dataStates.dart';

class BikesDataCubits extends Cubit<BikesData>{


  BikeRentalService bikeRentalService;

  BikesDataCubits({required this.bikeRentalService}) : super(BikesDataInitialState()){
    emit(BikesDataLoadingState());
  }

    List<BikesDataModel> bikesData=[];
  List<BikesDataModel> searchedBike=[];

  void getAllBikesData() async{
    try{
      emit(BikesDataLoadingState());
      bikesData=await bikeRentalService.listAllBikes();

      // print(bikesData);
      emit(BikesDataLoadedState(data: bikesData));

    }catch(exception){

      emit(BikesDataErrorState(exception.toString()));
    }
  }

  void searchBike(String query) async{
    try{
      emit(BikesDataLoadingState());
      bikesData=await bikeRentalService.searchBike(query);

      if(bikesData !=null){
        emit(BikesDataLoadedState(data: bikesData));
      }
      print("hello");

    }catch (e){
      emit(BikesDataErrorState(e.toString()));
    }

  }
void searchBikeList(String query){
  final bikesList=bikesData.where((bike){
    final bikeName=bike.name.toLowerCase();
    final input=query.toLowerCase();
    return bikeName.contains(input);
  }).toList();
}

void getRentersBike(int id) async {

    List<BikesDataModel> bikes= await bikeRentalService.listAllBikes();

    bikes.forEach((element) {

      if(element.owner.id == id) {
        searchedBike.add(element);
      }
    });
  print("${searchedBike.length } dvdfg");
  emit(BikesDataLoadedState(data: bikes));



}

}
