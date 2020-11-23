import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';


class ChatPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final streamChannel = StreamChannel.of(context);
    final channel = streamChannel.channel;


    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Expanded(child: MessageListView()),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}