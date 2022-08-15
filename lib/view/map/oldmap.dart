import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class oldMap extends ConsumerWidget {
  String statusText = "Start Server";
  String _basePath = "";

  startServer() async {
    statusText = "Starting server on Port : 8080";

    var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
    print("Server running on IP : " +
        server.address.toString() +
        " On Port : " +
        server.port.toString());

    await for (var request in server) {
      final String stringPath =
          request.uri.path == '/' ? '/index.html' : request.uri.path;
      final File file = new File(path.join(_basePath, stringPath));
      file.exists().then((bool found) {
        if (found) {
          file.openRead().pipe(request.response).catchError((e) {});
        } else {
          //_sendNotFound(request.response);
        }
      });

      request.response
        ..headers.set("Content-Type", "text/html; charset=utf-8")
        ..write('Hello, world')
        ..close();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // `ref.watch` を使用して Providerを読み取ります。
    //final String value = ref.watch(appNameProvider);

    // サーバー開始
    startServer();
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Example1')),
          body: Center(
            child: const WebView(
              initialUrl: 'http://127.0.0.1:8080',
            ),
          ),
        )
    );
  }
}
