import 'package:flutter/material.dart';
import 'package:wisata_bandung/detail_screen.dart';
import 'package:wisata_bandung/model/cafe_place.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  Future<List<CafePlace>> getCafe() async {
    var data = await http.get(Uri.parse("http://10.0.2.2:8000/api/cafe"));
    var jsonData = json.decode(data.body);
    List<CafePlace> cafes = [];
    for(var c in jsonData){
      CafePlace cafe = CafePlace(c["name"],c["address"],c["description"],c["openday"], c['openhour'], c['price'], c['image1'], c['image2'], c['image3'], c['image4']);
      cafes.add(cafe);
    }
    print(data.body);
    return cafes;
  }
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        isAlwaysShown: true,
        showTrackOnHover: true,
        child: FutureBuilder(
          future: getCafe(),
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
                  final CafePlace place = snapshot.data[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return DetailScreen(place: place,);
                      }));
                    },
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Image.asset(place.image1),
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
                  /*return ListTile(
                    title: Text(snapshot.data[index].title),
                    onTap: (){
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) =>DetailPage(snapshot.data[index]))
                      );
                    },
                  );*/
                },
              );
            }
          },
        ),
    );
    /*return Scrollbar(
      isAlwaysShown: true,
      showTrackOnHover: true,
      child: ListView.builder(
        itemBuilder: (context, index){
          final CafePlace place = cafePlaceList[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return DetailScreen(place: place,);
              }));
            },
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.asset(place.imageAsset),
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
                            Text(place.location),
                          ],
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        },
        itemCount: cafePlaceList.length,
      ),
    );*/
  }
}
/*class CafePlaceGrid extends StatelessWidget {
  final int gridCount;
  CafePlaceGrid({required this.gridCount});
  Future<List<CafePlace>> getCafe() async {
    var data = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
    var jsonData = json.decode(data.body);
    List<CafePlace> cafes = [];
    for(var c in jsonData){
      CafePlace cafe = CafePlace(c["name"],c["address"],c["description"],c["openday"], c['openhour'], c['price'], c['image1'], c['image2'], c['image3'], c['image4']);
      cafes.add(cafe);
    }
    print(cafes.length);
    return cafes;
  }
  @override
  Widget build(BuildContext context){
    return Scrollbar(
      isAlwaysShown: true,
      showTrackOnHover: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: gridCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: cafePlaceList.map((place){
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return DetailScreen(place: place);
                }));
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.asset(
                        place.imageAsset,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        place.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 8),
                      child: Text(
                        place.location,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}*/