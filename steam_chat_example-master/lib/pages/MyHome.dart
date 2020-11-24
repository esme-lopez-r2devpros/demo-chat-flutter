import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:chat_stream/model.dart';
import 'package:chat_stream/utils.dart';
import 'package:chat_stream/Class/sesion.dart';
import 'package:chat_stream/pages/ChannelView.dart';

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
                final user = _controller.value.text;
                final client = provider.client;

                //FOUR RESIDENTS WERE CREATED TO MAKE EXAMPLES

                final resident1=new Resident();
                resident1.NickName="Dad";
                resident1.UserId="idesme";
                resident1.Image="https://pickaface.net/gallery/avatar/unr_grandpa_180927_0611_13iq.png";


                final resident2=new Resident();
                resident2.NickName="Gina";
                resident2.UserId="idesme";
                resident2.Image="https://cdn4.iconfinder.com/data/icons/avatars-xmas-giveaway/128/grandma_elderly_nanny_avatar-512.png";

                final resident3=new Resident();
                resident3.NickName="Bob";
                resident3.UserId="idchris";
                resident3.Image="https://thumbs.dreamstime.com/b/grandfather-avatar-character-icon-illustration-design-84942735.jpg";

                final resident4=new Resident();
                resident4.NickName="Mary";
                resident4.UserId="idarturo";
                resident4.Image="https://images.assetsdelivery.com/compings_v2/yupiramos/yupiramos1807/yupiramos180788706.jpg";

                final resident5=new Resident();
                resident5.NickName="Anne";
                resident5.UserId="idchris";
                resident5.Image="https://images.assetsdelivery.com/compings_v2/yupiramos/yupiramos1807/yupiramos180788706.jpg";

                final Residents= List<Resident>();
                Residents.add(resident1);
                Residents.add(resident2);
                Residents.add(resident3);
                Residents.add(resident4);
                Residents.add(resident5);

                final currentUser=new Sesion();
                currentUser.userId="id$user";

              final u=  await client.setUserWithProvider(
                  User(
                    id: currentUser.userId,
                    extraData: {
                      "name": "$user",
                      "image": "https://picsum.photos/100/100",
                    },
                  ),
                );

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => StreamChat(
                      child: ChannelView(residents: Residents, user: u ,),
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
