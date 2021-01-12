import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetID Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'GetID Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const platform = const MethodChannel('samples.getid.dev/getid');

  /*
  In order to start using GetID SDK, you will need an SDK KEY and API URL.
  Both can be found and modified either through your GetID admin panel
  or via contacting our integration team.
  */
  static const sdkKey = '...';
  static const apiURL = '...';
  /*
  Note:
  We don't recommend to use the SDK key at the client-side in the production environment.
  Instead, use your own backend as a proxy for receiving a token.
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                try {
                  final token = await getToken();
                  await platform.invokeMethod('launchGetID', {'apiURL': apiURL, 'token': token});
                } catch (exception) {
                  print(exception);
                }
              },
              child: Text('Verify me'),
            )
          ],
        ),
      )
    );
  }

  Future<String> getToken() async {
    var headers = {
      'apikey': sdkKey,
      'Content-Type': 'application/json'
    };
    final response = await http.post('${apiURL}/sdk/v1/token', headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body['token'];
    } else {
      throw Exception('Failed to obtain a token. Make sure that you use the correct `apiURL` and `sdkKey`.');
    }
  }
}
