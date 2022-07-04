import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/constants.dart';
import 'package:intl/intl.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  
  static String routeName="chat_screen";


  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  
  String? message;
  TextEditingController controller=TextEditingController();
  final firestore=FirebaseFirestore.instance;
  final auth=FirebaseAuth.instance;
  var loggedUser;
  
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }
  void getCurrentUser(){

    try{
    final user=auth.currentUser;
    if(user!=null)
    {
     loggedUser=user;
     print(loggedUser);
    }
    }catch(e)
    {
      print(e);
    }
  }
  //::::::::::::Create Collection of Messaging:::::::::::::::::::
  void sendMessage(){
   firestore.collection('messages').add({
    'message':message,
    'date':DateTime.now(),
   });
   controller.clear();

  }
  /*:::::::::::: Messaging Stream:::::::::::::::::::*/
  void messageStream()async{
    await for(var snapshot in firestore.collection('messages').snapshots())
    {
      for(var msg in snapshot.docs)
      {
        print(msg.data());
      }
    }
  }
  /*:::::::::::::::::::::::::::::::::::::::::::::::*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon:  Icon(Icons.logout,color: Colors.grey[700],),
              onPressed:()async{
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              }
              ),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: firestore.collection('messages').snapshots(),
              builder: (context,AsyncSnapshot snapshot){
                 
                  if(!snapshot.hasData)
                  {
                  return const Center(
                    child:  CircularProgressIndicator(
                      color: Color.fromRGBO(156, 39, 176, 1),
                      strokeWidth: 6,
                      
                      ),
                  );
                  }
                      final msg=snapshot.data.docs;
                      List<MessageBubble> msgListBubbles=[];
                      for(var messgae in msg)
                      {
                        final messageText=messgae['message'];
                        // final messageDate=messgae['date'];

                        final msgbubble=MessageBubble(message: messageText);
                        msgListBubbles.add(msgbubble);
                      }
                      return Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                          children: msgListBubbles,
                        ),
                      );
                  
              },
              ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,

                      onChanged: (value) {
                        message=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: sendMessage,
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessageBubble extends StatelessWidget {
  const MessageBubble({ Key? key ,required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(DateFormat.Hm().format(DateTime.now())),
          Material(
            borderRadius: BorderRadius.circular(30),
            color: Colors.greenAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
              child: Text(
                 message,
                 style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}