import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map/Layout/cubit/map_cubit.dart';
import 'package:google_map/Modules/location_latlng.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class HomeScreen extends StatelessWidget {
   const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = MapCubit.get(context);
    return BlocConsumer<MapCubit, MapState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:  CameraPosition(
                target:LatLng(cubit.lat, cubit.lon),

              ),
              onMapCreated: (contoler){
                cubit.completer.complete(contoler);
              },
              markers: cubit.myMarket,
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 12),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async{
                    cubit.getMyPosition();
                  },
                  child: const Text(
                    'Show My Location',
                  ),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 40),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const LocationLatLng())
                      );
                    },
                    child: const Text(
                        'My Location LatLng'
                    ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  },
);
  }
}

