import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';

class Videoplayer extends StatefulWidget {
  String url;
  Videoplayer({Key key, this.url}) : super(key: key);
  @override
  _VideoplayerState createState() => _VideoplayerState();
}

class _VideoplayerState extends State<Videoplayer> {
  bool hasVideo = false;
  String videoUrl;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    getvideo();
  }

  getvideo() async {
    final client = http.Client();
    final response = await client.post(
        'https://sheltered-mountain-37743.herokuapp.com/getVideo',
        body: jsonEncode({'url': widget.url}),
        headers: {'content-type': 'application/json'});
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);
      print(response.body.toString());
      videoUrl = decode['videoUrl'];
      setState(() {
        hasVideo = true;
      });
    } else {
      print('error');
    }
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ShowVideo(context));
  }

  Widget ShowVideo(BuildContext context) {
    if (hasVideo) {
      return WebView(
        initialUrl: videoUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webviewcontroller) {
          _controller.complete(webviewcontroller);
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
