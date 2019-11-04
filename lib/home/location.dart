class LocationData {
  Location location;

  LocationData({this.location});

  LocationData.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      location = Location.fromJson(json["result"]);
    }
  }
}

class Location {
  String name;
  int id;
  double lat;
  double long;
  String address;

  Location({this.name, this.id, this.lat, this.long, this.address});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    lat = json['coords']["lat"];
    long = json['coords']["long"];
    address = json['address'];
  }
}
