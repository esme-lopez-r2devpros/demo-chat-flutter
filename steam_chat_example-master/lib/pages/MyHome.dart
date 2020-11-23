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
                resident1.NickName="pa";
                resident1.UserId="idesme";


                final resident2=new Resident();
                resident2.NickName="grandma";
                resident2.UserId="idesme";

                final resident3=new Resident();
                resident3.NickName="grandpa";
                resident3.UserId="idchris";

                final resident4=new Resident();
                resident4.NickName="Tia";
                resident4.UserId="idsalma";

                final Residents= List<Resident>();
                Residents.add(resident1);
                Residents.add(resident2);
                Residents.add(resident3);
                Residents.add(resident4);

                final currentUser=new Sesion();
                currentUser.userId="id$user";

                await client.setUserWithProvider(
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
                      child: ChannelView(residents: Residents),
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
