import 'package:chat_stream/Class/sesion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:chat_stream/model.dart';
import 'package:chat_stream/pages/ChatPage.dart';


class ContactosPage extends StatelessWidget {

  final BuildContext context;
  final List<Resident> residents ;
  final List<Channel> channels ;

  ContactosPage({@required this.context, @required this.residents, @required this.user, @required this.channels});
  final user;

  List<Resident> filter =List<Resident>();
  void  getContacts()
  {
  filter.clear();
    for(var x in residents)
    {
      if(x.UserId==user.id) {
        filter.add(x);
      }
    }
  }

  @override

  Widget build(BuildContext context) {
    final streamchat = StreamChat.of(context);
    final client = streamchat.client;
    final provider = Provider.of<ChatModel>(context);
    getContacts();
   return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          }
          ),
          title: Text("Contactos"),
          actions:[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                }
            )
          ],
        ),
       body:
       ListView.builder(
       itemCount: filter.length,
       itemBuilder: (context, index)
       {
        return  ListTile(
           title: Text('${filter[index].NickName}'),
           onLongPress: () async {
             final channelName = filter[index].NickName;

              final channel =client.channel("mobile", extraData: {"members": ["esme", filter[index].NickName]});
             // match against strings where pattern = mobile:*

             final channelTitles = channels.map((e) => e.cid).toList();
             if (!channelTitles.contains(channelName)) {
               await channel.create();
             }

             await channel.watch();

             provider.currentChannel = channel;

             Navigator.of(context).push(
               MaterialPageRoute(
                 builder: (_) => StreamChannel(
                   child: ChatPage(),
                   channel: channel,
                 ),
               ),
             );
           }
        );
       }
   ),

    );



  }

}

