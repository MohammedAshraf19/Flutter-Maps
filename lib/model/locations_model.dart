class LocationsModel{
  double? latitude;
  double? longitude;

  LocationsModel({
     this.latitude,
     this.longitude
  });

  LocationsModel.fromJson(Map<String,dynamic>json){
    latitude=json['latitude'];
    longitude=json['longitude'];

  }
  Map<String,dynamic>toMap(){
    return{
      'latitude':latitude,
      'longitude':longitude,
    };
  }
}