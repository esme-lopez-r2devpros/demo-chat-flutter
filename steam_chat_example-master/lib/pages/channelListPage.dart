import 'package:chat_stream/pages/contactsPage.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:chat_stream/utils.dart';
import 'package:chat_stream/utils/resident.dart';

class ChannelListPage extends StatelessWidget {
  static String tag = "ChannelListPage";

  // final TextEditingController _controller = TextEditingController();
  // final _formKey = GlobalKey<FormState>();

  final channels = List<Channel>();
  final List<Resident> residents;

  ChannelListPage({@required this.residents});

  @override
  Widget build(BuildContext context) {
    //final user = streamchat.user;

    // final client = streamchat.client;
    // final provider = Provider.of<ChatModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Channel List"),
        backgroundColor: Colors.blue[800],
        leading: Hero(
          tag: 'logo',
          child: Container(
            child: Image.asset("images/logo.png"),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (bc) => ContactsPage(residents: this.residents));
                Navigator.of(context).push(route);
              })
        ],
      ),
      body: Column(
        //padding: EdgeInsets.only(top: 150.0),
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: getChannels(context),
              builder: (_, AsyncSnapshot<List<Channel>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // clear list to avoid duplicates
                channels.clear();
                // repopulate list
                channels.addAll(snapshot.data);

                if (snapshot.data.length == 0) {
                  return Container();
                }

                return ListView(
                  scrollDirection: Axis.vertical,
                  children: createListOfChannels(snapshot.data, context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}


Future<List<Channel>> getChannels(BuildContext context) async {
  final streamchat = StreamChat.of(context);
  //Filter by user id

  print('_ChannelListPage_TAG: getChannel():${streamchat.user.id}');

  final filter = {
    "type": "mobile",
    "members": {
      "\$in": [streamchat.user.id]
    }
  };

  //Sort for last message at channel
  final sort = [
    SortOption(
      "last_message_at",
      direction: SortOption.DESC,
    ),
  ];

  return await streamchat.client.queryChannels(
    filter: filter,
    sort: sort,
  );
}
