import 'package:flutter/material.dart';
import 'package:wisata_bandung/detail_screen.dart';
//import 'package:wisata_bandung/model/cafe_place.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
Future<List<CafeData>> fetchCafe() async {
  final response =
  await http.get(Uri.parse('http://10.0.2.2:8000/api/cafe'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => CafeData.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
class CafeData {
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

  CafeData({
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

  });




  factory CafeData.fromJson(Map<String, dynamic> json) {
    return CafeData(
        id: json['id'],
        name : json['name'],
        description : json['description'],
        openhour : json['openhour'],
    address : json['address'],
    price : json['price'],
    openday : json['openday'],
    image1 : json['image1'],
    image2 : json['image2'],
    image3 : json['image3'],
    image4 : json['image4'],
      //createdAt = json['created_at'];
      //updatedAt = json['updated_at'];
    );
  }
}
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cafein'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints){
          return CafePlaceList();
        },
      ),
    );
  }
}

class CafePlaceList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      showTrackOnHover: true,
      child: FutureBuilder<List<CafeData>>(
        future: fetchCafe(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.data==null){
            return Container(
                child: Center(
                    child: Text("Loading...")
                )
            );
          } else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                final CafeData place = snapshot.data[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return DetailScreen(cafeId: place.id, place: place);
                    }));
                  },
                  child: Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Image.network(place.image1),
                        ),
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    place.name,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(place.address),
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                );

              },
            );
          }
        },
      ),
    );
  }
}
