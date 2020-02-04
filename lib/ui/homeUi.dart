import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'animeUi.dart';
import 'package:flutter/services.dart';

class AnimeModel {
  String title;
  String poster;
  String sinopsis;
  List episode;
  List genre;

  AnimeModel(
      {this.title, this.poster, this.sinopsis, this.episode, this.genre});
  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
        title: json['title'],
        poster: json['poster'],
        sinopsis: json['sinopsis'],
        episode: json['episode'],
        genre: json['genre']);
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchController = TextEditingController();
  final client = http.Client();

  Future<List<AnimeModel>> fetchdata() async {
    if (_searchController.text != "") {
      final url = "https://sheltered-mountain-37743.herokuapp.com/filter";
      final searchData = jsonEncode({"filter": _searchController.text});
      final headers = {"content-type": "application/json"};
      final res = await client.post(url, body: searchData, headers: headers);
      if (res.statusCode == 200) {
        print(res.body);
        final decode = jsonDecode(res.body);
        return (decode as List).map((f) => AnimeModel.fromJson(f)).toList();
      } else {
        print('Failed error searching');
      }
    } else {
      final url = "https://sheltered-mountain-37743.herokuapp.com/";
      final res = await client.get(url);
      if (res.statusCode == 200) {
        // print(res.body);
        final decode = jsonDecode(res.body);
        return (decode as List).map((f) => AnimeModel.fromJson(f)).toList();
      } else {
        print('Failed error');
      }
    }
  }

  void searchAnime() {
    print(_searchController.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * .2,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'FLUTTERNIME',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .8,
                )
              ],
            ),
            Positioned(
              // To take AppBar Size only
              top: 120.0,
              left: 20.0,
              right: 20.0,
              child: AppBar(
                backgroundColor: Colors.white,
                leading: Icon(
                  Icons.insert_emoticon,
                  color: Colors.blue,
                ),
                primary: false,
                title: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.blue))),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.search, color: Colors.blue),
                      onPressed: () {
                        searchAnime();
                      }),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .250),
                child: ShowAnime())
          ],
        ));
  }

  Widget ShowAnime() {
    return FutureBuilder(
      future: fetchdata(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: snapshot.data.length,
              itemBuilder: (contex, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Anime(
                                  title: snapshot.data[index].title,
                                  episode: snapshot.data[index].episode,
                                  sinopsis: snapshot.data[index].sinopsis,
                                  poster: snapshot.data[index].poster,
                                  genre: snapshot.data[index].genre,
                                )));
                  },
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Image.network(
                            snapshot.data[index].poster,
                            alignment: Alignment.topLeft,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: ListTile(
                            title: Text(
                              snapshot.data[index].title,
                              textAlign: TextAlign.left,
                            ),
                            subtitle: Text(snapshot.data[index].genre
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', '')),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
