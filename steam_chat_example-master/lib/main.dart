import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:chat_stream/model.dart';
import 'package:chat_stream/pages/MyHome.dart';
import 'package:chat_stream/utils.dart';
import 'package:intl/intl.dart';
import 'package:chat_stream/Class/sesion.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatModel>(
      create: (context) => ChatModel(),
      child: MaterialApp(
        theme: ThemeData(),
        home: MyHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}




