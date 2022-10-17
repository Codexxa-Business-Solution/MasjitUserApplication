class Place {
  String? masjidName;
  String? street;
  String? subLocality;
  String? locality;
  String? postalCode;
  String? administrativeArea;
  String? country;
  String? lat;
  String? long;

  Place(
      {this.masjidName,
      this.street,
      this.subLocality,
      this.locality,
      this.postalCode,
      this.administrativeArea,
      this.country,
      this.lat,
      this.long});

  @override
  String toString() {
    return 'Place{masjidName: $masjidName, street: $street, subLocality: $subLocality, locality: $locality, postalCode: $postalCode, administrativeArea: $administrativeArea, country: $country, lat: $lat, long: $long}';
  }

  Place.fromJson(Map<String, dynamic> json) {
    masjidName = json['masjid_name'];
    street = json['street'];
    subLocality = json['sub_locality'];
    locality = json['locality'];
    postalCode = json['postal_code'];
    administrativeArea = json['administrative_area'];
    country = json['country'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['masjid_name'] = masjidName;
    data['street'] = street;
    data['sub_locality'] = subLocality;
    data['locality'] = locality;
    data['postal_code'] = postalCode;
    data['administrative_area'] = administrativeArea;
    data['country'] = country;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
