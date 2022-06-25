import 'dart:convert';
List<CafeResponseModel> cafeResponseJson(str){
  List jsonResponse = json.decode(str);
  return jsonResponse.map((data)=>CafeResponseModel.fromJson(data)).toList();
}

class CafeResponseModel {
  CafeResponseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.openhour,
    required this.address,
    required this.price,
    required this.openday,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String name;
  late final String description;
  late final String openhour;
  late final String address;
  late final int price;
  late final String openday;
  late final String image1;
  late final String image2;
  late final String image3;
  late final String image4;
  late final String createdAt;
  late final String updatedAt;

  CafeResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    openhour = json['openhour'];
    address = json['address'];
    price = json['price'];
    openday = json['openday'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    image4 = json['image4'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['openhour'] = openhour;
    _data['address'] = address;
    _data['price'] = price;
    _data['openday'] = openday;
    _data['image1'] = image1;
    _data['image2'] = image2;
    _data['image3'] = image3;
    _data['image4'] = image4;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}