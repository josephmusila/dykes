import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import '../../models/bikesDataModel.dart';

abstract class BikesData extends Equatable {}

class BikesDataInitialState extends BikesData {
  @override
  List<Object?> get props => [];
}
class BikesDataLoadingState extends BikesData {
  @override
  List<Object?> get props => [];
}
class BikesDataLoadedState extends BikesData {
  final List<BikesDataModel> data;

  BikesDataLoadedState({required this.data});

  @override
  List<Object> get props => [data];
}

class BikesDataErrorState extends BikesData {
  String message;

  BikesDataErrorState(this.message);

  @override
  List<Object> get props => [message];
}
