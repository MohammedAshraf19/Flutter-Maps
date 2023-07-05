import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map/Layout/cubit/map_cubit.dart';

class LocationLatLng extends StatelessWidget {
  const LocationLatLng({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = MapCubit.get(context);
        return  Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height /3),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                        'My Location LatLng is',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                        cubit.isGetLocation ? 'latitude : ${cubit.lat} \nlongitude : ${cubit.lon}':
                        'First Click Button Show My Location',
                      style: const TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
