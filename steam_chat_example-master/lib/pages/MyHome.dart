import 'package:chat_stream/utils/resident.dart';
import 'package:chat_stream/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:chat_stream/model.dart';
import 'package:chat_stream/utils.dart';
import 'package:chat_stream/pages/channelListPage.dart';

//MyHomePage gets the username of every user.

class MyHome extends StatelessWidget {
  static String tag = "MyHome";

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

                final resident1 = new Resident(
                    nickName: "gina",
                    residentId: "idgina",
                    imageUrl:
                        "https://cdn4.iconfinder.com/data/icons/avatars-xmas-giveaway/128/grandma_elderly_nanny_avatar-512.png",
                    token: "asdf2");

                final resident2 = Resident(
                    nickName: "chris123",
                    residentId: "idchris123",
                    imageUrl:
                        "https://thumbs.dreamstime.com/b/grandfather-avatar-character-icon-illustration-design-84942735.jpg",
                    token: "asdf3");

                final resident3 = Resident(
                    nickName: "arturo",
                    residentId: "idarturo",
                    imageUrl:
                        "https://www.alfabetajuega.com/wp-content/uploads/2020/07/D82F405B-A283-4086-BC5C-E30A7D4DD5D2-780x405.jpeg",
                    token: "asdf4");

                final resident4 = new Resident(
                    nickName: "chdsz123",
                    residentId: "idchdsz123",
                    imageUrl:
                        "https://i.pinimg.com/236x/c8/45/d8/c845d809f5873ed29d82511e9c342ba2--film-anime-manga-anime.jpg",
                    token: "asdf5");

                final resident5 = new Resident(
                    nickName: "lauro123",
                    residentId: "idlauro123",
                    imageUrl:
                    "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__340.jpg",
                    token: "asdf6");

                // final resident6 = new Resident();
                // resident5.nickName = "lauro123";
                // resident5.residentId = "idlauro123";
                // resident5.imageUrl ="https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__340.jpg";
                // resident5.token = "asdf6";

                final residents = List<Resident>();
                residents.add(resident1);
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

                Session.userId = "id$userName";
                Session.nickname = _controller.value.text;
                Session.residents = residents;
                Session.selectedResident = Session.residents.first;

                await client.setUserWithProvider(
                  User(
                      id: userId,
                      extraData: {
                        "name": "$userName",
                        "image":
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/Sunflower_sky_backdrop.jpg/440px-Sunflower_sky_backdrop.jpg",
                      },
                      role: 'admin'),
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
