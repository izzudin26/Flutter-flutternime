import 'dart:ui';
import 'package:flutter/material.dart';
import 'player.dart';
import 'package:flutter/services.dart';

class Anime extends StatefulWidget {
  List episode;
  String title;
  String sinopsis;
  List genre;
  String poster;
  Anime(
      {Key key,
      this.episode,
      this.title,
      this.sinopsis,
      this.genre,
      this.poster})
      : super(key: key);

  @override
  _AnimeState createState() => _AnimeState();
}

class _AnimeState extends State<Anime> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * .20,
              color: Colors.blue,
            ),
            Container(
              height: MediaQuery.of(context).size.height * .80,
              color: Colors.white,
            )
          ],
        ),
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .100,
              right: 20,
              left: 20),
          child: Container(
            height: 185,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.white,
              elevation: 6.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      widget.poster,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: Text(widget.title),
                      subtitle: Text(widget.genre
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', '')),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .350,
                left: 10,
                right: 10),
            child: Eps())
      ],
    ));
  }

  Widget Eps() {
    return ListView(
      padding: EdgeInsets.all(20),
      children: widget.episode.map((docs) {
        return InkWell(
          onTap: () {
            // print(docs['urls']);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Videoplayer(
                          url: docs['urls'],
                        )
                        ));
          },
          splashColor: Colors.lightBlue,
          child: Card(
              child: ListTile(
            title: Text(
              docs['titles'],
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          )),
        );
      }).toList(),
    );
  }
}
