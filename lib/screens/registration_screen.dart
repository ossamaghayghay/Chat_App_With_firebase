import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '/screens/chat_screen.dart';
import '/screens/refactoring_padding.dart';
import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static String routeName="registration_Screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  
  CollectionReference users=FirebaseFirestore.instance.collection('users');
  CollectionReference messages=FirebaseFirestore.instance.collection('messages');

  Future<void> addUser()async{
    return users.add({
      'email':email,
      'password':password,
    }).then((value) => print('User Added Successfully'))
    .catchError((onError)=>print('Failed to add user: $onError'));

  }
  /*::::::::::::::::::::Cretae Collectio  Of Messaging::::::::*/
  // Future<void> createCollection()async{
  //   return messages.add({
  //     'message':,
  //     'date':DateTime.now(),
  //   }).then((value) => print('collection has been Create Successfully!'))
  //   .catchError((onError)=>print('Failed to add user: $onError'));

  // }

  bool showspinner=false;
  final auth=FirebaseAuth.instance;
  String? email;
  String? password; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 71, 66, 66),
      body:
        
         ModalProgressHUD(
          inAsyncCall: showspinner,
           child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email=value;
                  },
                  decoration:kDecorationTextField.copyWith(hintText: 'Enter youre Email'), 
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password=value;
                  },
                  decoration: kDecorationTextField.copyWith(hintText: 'Enter youre Password'),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  onTap: ()async{
                    setState(() {
                      showspinner=true;
                    });
                    try{
                      final new_user=await auth.createUserWithEmailAndPassword(email: email!, password: password!);
                      if(new_user!=null)
                      {
                        Navigator.pushNamed(context, ChatScreen.routeName);
                      }
                      setState(() {
                        showspinner=false;
                      });
                      addUser();
                      // createCollection();
                    }catch(e){
                        print(e);
                    }
                  },
                  color:Colors.blueAccent,
                  title:'Register',
                  ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                //   child: Material(
                //     color: Colors.blueAccent,
                //     borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                //     elevation: 5.0,
                //     child: MaterialButton(
                //       onPressed: () {
                //         //Implement registration functionality.
                //       },
                //       minWidth: 200.0,
                //       height: 42.0,
                //       child: const Text(
                //         'Register',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
                 ),
         ),
      
    );
  }
}
