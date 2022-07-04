import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/screens/chat_screen.dart';
import 'package:flutter_application_1/screens/refactoring_padding.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String routeName="login_Screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  bool showspinner=false;

  String? email;
  String? password;
  final auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 71, 66, 66),
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag:'logo',
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
                decoration: kDecorationTextField.copyWith(hintText: 'Enter youre Email'),
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
                color:Colors.lightBlueAccent,
                title:'Log In',
                onTap: ()async{
                  setState(() {
                    showspinner=true;
                  });
                  try{
                    final user=await auth.signInWithEmailAndPassword(email: email!, password: password!);
                    if(user!=null)
                    {
                      Navigator.pushNamed(context, ChatScreen.routeName);
                    }
                    setState(() {
                      showspinner=false;
                    });
                  }catch(error){
                    print(error);
                  }
      
      
                },
                ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 16.0),
              //   child: Material(
              //     color: Colors.lightBlueAccent,
              //     borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              //     elevation: 5.0,
              //     child: MaterialButton(
              //       onPressed: () {
              //         //Implement login functionality.
              //       },
              //       minWidth: 200.0,
              //       height: 42.0,
              //       child: const Text(
              //         'Log In',
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
