import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:chat_stream/model.dart';
import 'package:chat_stream/utils.dart';
import 'package:chat_stream/Class/session.dart';
import 'package:chat_stream/pages/channelListPage.dart';

//MyHomePage gets the username of every user.

class MyHome extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Chat App"),
        backgroundColor: Colors.blue[400],
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30.0),
            child: Hero(
              tag: 'logo',
              child: Container(
                width: 50.0,
                child: Image.asset("images/logo.png"),
              ),
            ),
          ),
          CustomForm(
            controller: _controller,
            formKey: _formKey,
            hintText: "Enter a username..",
          ),
          CustomButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                final userName = _controller.value.text;
                final client = provider.client;

                //region Create Residents

                final resident2 = new Resident();
                resident2.nickName = "Gina";
                resident2.userId = "idesme2";
                resident2.imageUrl =
                    "https://cdn4.iconfinder.com/data/icons/avatars-xmas-giveaway/128/grandma_elderly_nanny_avatar-512.png";

                final resident3 = new Resident();
                resident3.nickName = "Bob";
                resident3.userId = "idchris123";
                resident3.imageUrl =
                    "https://thumbs.dreamstime.com/b/grandfather-avatar-character-icon-illustration-design-84942735.jpg";

                final resident4 = new Resident();
                resident4.nickName = "Mary";
                resident4.userId = "idarturo";
                resident4.imageUrl =
                    "https://images.assetsdelivery.com/compings_v2/yupiramos/yupiramos1807/yupiramos180788706.jpg";

                final resident5 = new Resident();
                resident5.nickName = "Anne";
                resident5.userId = "idchdsz123";
                resident5.imageUrl =
                    "https://images.assetsdelivery.com/compings_v2/yupiramos/yupiramos1807/yupiramos180788706.jpg";

                final residents = List<Resident>();
                residents.add(resident2);
                residents.add(resident3);
                residents.add(resident4);
                residents.add(resident5);

                //endregion

                // User user2 = new User(id: "idDad", extraData: {
                //   "name": "Dad",
                // });

                // final currentUser = new Session();
                // currentUser.userId = "id$userName";

                final userId = "id$userName";

                await client.setUserWithProvider(
                  User(
                    id: userId,
                    extraData: {
                      "name": "$userName",
                      "image": "https://picsum.photos/100/100",
                    },
                  ),
                );

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => StreamChat(
                      child: ChannelListPage(
                        residents: residents,
                        // user2: user2,
                      ),
                      client: client,
                    ),
                  ),
                );
              }
            },
            text: "Submit",
          ),
        ],
      ),
    );
  }
}
