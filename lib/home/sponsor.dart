class SponsorsData {
  List<Sponsor> sponsors;

  SponsorsData({this.sponsors});

  SponsorsData.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      sponsors = new List<Sponsor>();
      json['result'].forEach((v) {
        sponsors.add(Sponsor.fromJson(v));
      });
    }
  }
}

class Sponsor {
  String name;
  int id;
  String desc;
  String url;
  String logo;

  Sponsor({this.name, this.id, this.desc, this.url, this.logo});

  Sponsor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    desc = json['category'];
    url = json['url'];
    logo = json['logo'];
  }
}
