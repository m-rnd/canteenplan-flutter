// {"id":1,"name":"Mensa UniCampus Magdeburg","city":"Magdeburg","address":"Pfälzer Str. 1, 39106 Magdeburg","coordinates":[52.139618827301895,11.647599935531616]},

class CanteenSearchResult {
  final int id;
  final String name;
  final String city;
  final String address;

  CanteenSearchResult(this.id, this.name, this.city, this.address);

  CanteenSearchResult.fromJSON(Map json)
      : id = json["id"] as int,
        name = json["name"],
        city = json["city"],
        address = json["address"];
}
