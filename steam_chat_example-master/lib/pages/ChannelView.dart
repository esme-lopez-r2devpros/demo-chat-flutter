import 'package:chat_stream/pages/ContactosPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:chat_stream/model.dart';
import 'package:chat_stream/utils.dart';
import 'package:intl/intl.dart';
import 'package:chat_stream/Class/sesion.dart';


class ChannelView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final channels = List<Channel>();
  List<Resident> residents =List<Resident>();
  final user;


  Future<List<Channel>> getChannels(StreamChatState state, User user ) async {
    final filter = {
      "type": "mobile",
    // "members": [user],
    };

    final sort = [
      SortOption(
        "last_message_at",
        direction: SortOption.DESC,
      ),
    ];

    return await state.client.queryChannels(
      filter: filter,
      sort: sort,
    );
  }
  ChannelView({@required this.residents, @required this.user });
  @override
  Widget build(BuildContext context) {
    final streamchat = StreamChat.of(context);
    final user =streamchat.user;
    final client = streamchat.client;
    final provider = Provider.of<ChatModel>(context);

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
        actions:[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                Route route =MaterialPageRoute(builder: (bc) => ContactosPage(context: context, residents: this.residents, user: user, ));
                Navigator.of(context).pushReplacement(route);
              }
          )
        ],
      ),
      body: Column(
        //padding: EdgeInsets.only(top: 150.0),
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: getChannels(streamchat, user),
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
