import 'package:chat_stream/pages/ChannelView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_stream/model.dart';
import 'package:chat_stream/pages/MyHome.dart';



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




