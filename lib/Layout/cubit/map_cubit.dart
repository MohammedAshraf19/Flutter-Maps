import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map/model/locations_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());
  static MapCubit get(context)=>BlocProvider.of(context);

  double lon = 30.79999999967497;
  double lat = 31.8;

  bool isGetLocation = false;
  final Completer<GoogleMapController> completer = Completer();

  // My Market To My Loaction
  var myMarket = HashSet<Marker>();

  // Give Permission and Access to my Location
  Future<Position> getCurrentPosition() async{
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable)
    {
      return Future.error("Location service are disabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied)
    {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied){
        return Future.error('Location permission are denied');
      }
    }

    if (permission == LocationPermission.deniedForever)
    {
      return Future.error('Location permission are denied, we can not request');
    }
    return await Geolocator.getCurrentPosition();
  }

  void getMyPosition(){
    getCurrentPosition().then((value) async {
      myMarket.add(
        Marker(
            markerId: const MarkerId('My Position'),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: const InfoWindow(
                title: 'My Location'
            )
        ),
      );
      lon = value.longitude;
      lat = value.latitude;
      isGetLocation = true;
      // Remove Camera To My Location
      GoogleMapController controller = await completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(lat, lon),
            zoom: 10
        ),
      ));
      saveLocation(latitude: value.latitude, longitude: value.longitude);
    });
  }

  // Save Location In Firebase
  void saveLocation({
    required double latitude,
    required double longitude,
}){
    LocationsModel locationsModel = LocationsModel(
      latitude: latitude,
      longitude: longitude
    );
    emit(SaveLocationsLoad());
    FirebaseFirestore.instance
        .collection('users')
        .doc("Locations")
        .set(locationsModel.toMap())
        .then((value){
      emit(SaveLocationsSuccess());
    }).catchError((error){
      emit(SaveLocationsError());
    });
  }
}
