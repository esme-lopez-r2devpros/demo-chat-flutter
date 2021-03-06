import 'package:chat_stream/pages/channelPage.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:provider/provider.dart';
import 'package:chat_stream/model.dart';

import 'utils/session.dart';


class CustomForm extends StatelessWidget {
  final String hintText;
  final GlobalKey formKey;
  final TextEditingController controller;

  const CustomForm({
    Key key,
    this.hintText,
    this.formKey,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
          ),
          validator: (input) {
            if (input.isEmpty) {
              return "Enter some Text";
            }
            if (input.contains(RegExp(r"^([A-Za-z0-9]){4,20}$"))) {
              return null;
            }
            return "Can not contain special characters or spaces.";
          },
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    Key key,
    this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.lightBlue[700],
        elevation: 6.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 45.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

List<Widget> createListOfChannels(List<Channel> channels, context) {
  final provider = Provider.of<ChatModel>(context);

  // convert to list to gain access to the index and make deletion more reliable.
  return channels
      .asMap()
      .map((idx, chan) => MapEntry(
          idx,
          ListTile(
            // unique key makes it easier for the streamview to know which ListTile is which.

            key: UniqueKey(),
            title: Text(
              //"${chan.cid.replaceFirstMapped("mobile:", (match) => "")}",
              "${chan.state.members.firstWhere((element) => element.user.name != Session.nickname).user.name}",
            ),
            //${chan.state.messages.last.text}
            subtitle: Text("Last Message: No sé"),
            //trailing: Text("Peers: ${chan.state.members.length}"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  chan.extraData["image"] ?? "https://picsum.photos/100/100"),
            ),
            onLongPress: () async {
              // remove channel from list.
              channels.removeAt(idx);
              provider.currentChannel = chan;
              await chan.delete();
            },
            onTap: () async {
              // remove channel from list.
              print('_Utils_TAG: createListOfChannels: ${chan.id}');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => StreamChannel(
                    child: ChannelPage(),
                    channel: chan,
                  ),
                ),
              );
            },
          )))
      .values
      .toList();
}
