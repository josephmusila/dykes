import 'package:bikes/cubits/dataStates.dart';
import "package:flutter_bloc/flutter_bloc.dart";

import '../services/bikeRentService.dart';

class BikesDataCubits extends Cubit<BikesData>{


  BikeRentalService bikeRentalService;

  BikesDataCubits({required this.bikeRentalService}) : super(BikesDataInitialState()){
    emit(BikesDataLoadingState());
  }

  late final bikesData;

  void getAllBikesData() async{
    try{
      emit(BikesDataLoadingState());
      bikesData=await bikeRentalService.listAllBikes();
      print(bikesData);
      emit(BikesDataLoadedState(data: bikesData));

    }catch(exception){
      print(exception);
      emit(BikesDataErrorState());
    }
  }
}
