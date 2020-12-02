import 'package:chat_stream/Class/session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:chat_stream/model.dart';
import 'package:chat_stream/pages/channelPage.dart';

class ContactsPage extends StatelessWidget {
  final List<Resident> residents;

  ContactsPage({@required this.residents});


  @override
  Widget build(BuildContext context) {
    final streamchat = StreamChat.of(context);
    final provider = Provider.of<ChatModel>(context);
    Channel channel;
    // getContacts();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
        title: Text("Contacts"),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: ListView.builder(
          itemCount: residents.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text('${residents[index].nickName}'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(residents[index].imageUrl),
                ),
                onTap: () async {
                  final channelName = residents[index].nickName;
                  /*final user2=
               User(
                 id: "id${filter[index].NickName}",
                 extraData: {
                   "name": filter[index].NickName,
                   "image": filter[index].Image,
                 },
               );*/

                  //channel.addMembers(channel.state.members, Message(user: streamchat.client.state.user, text: "hi"));

                  channel = streamchat.client.channel(
                      "mobile", extraData: {
                    "members": ["idesme", "idchdsz123"],
                  });

                  //final member = channel.state.members;

                  // match against strings where pattern = mobile:* extraData: {"members": ["esme", "chris"]}


                  final channelTitles = streamchat.channels.map((e) => e.cid)
                      .toList();
                  if (!channelTitles.contains("${channel.type}:channel$channelName")) {
                    await channel.create();
                  }

                  await channel.watch();

                  provider.currentChannel = channel;

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          StreamChannel(
                            child: ChannelPage(),
                            channel: channel,
                          ),
                    ),
                  );
                });
          }),
    );
  }
}
