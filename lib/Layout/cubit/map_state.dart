part of 'map_cubit.dart';
abstract class MapState {}
class MapInitial extends MapState {}
class SaveLocationsLoad extends MapState {}
class SaveLocationsSuccess extends MapState {}
class SaveLocationsError extends MapState {}
