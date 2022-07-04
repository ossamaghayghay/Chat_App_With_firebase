import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/refactoring_padding.dart';
import 'package:flutter_application_1/screens/registration_screen.dart';
import '/screens/login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static String routeName="welecome_Screen";
 
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  AnimationController? controller;
  Animation? animation;
  @override
  void initState() {
    super.initState();
    controller=AnimationController(duration: const Duration(seconds: 1),vsync:this,);
    // animation=CurvedAnimation(parent: controller!,curve: Curves.decelerate);
    animation=ColorTween(begin: const Color.fromARGB(255, 6, 56, 113),end:  Colors.lightBlue).animate(controller!);
    // controller!.reverse(from: 1.0);
    controller!.forward();
    // animation!.addStatusListener((status) {
    //   if(status==AnimationStatus.completed)
    //   {
    //    controller!.reverse(from: 1.0);
    //   }else if(status==AnimationStatus.dismissed)
    //   {
    //     controller!.forward();
    //   }
    // });
    controller!.addListener(() { 
      setState(() {});
      // print(animation!.value);
    });
  }
  
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                    height:60,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                       textStyle: const TextStyle(
                       fontSize: 45.0,
                       fontWeight: FontWeight.w900,
                       color: Colors.black
                      ),
                     ),
                   ],
                  pause: const Duration(seconds: 1),
                  )
               
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (ctx)=>const LoginScreen()));
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            //   RoundedButton(
            //   color: Colors.blueAccent ,
            //   title:'Log In',
            //   onTap: (){
            //     Navigator.push(context,MaterialPageRoute(builder: (ctx)=>const LoginScreen()));              },
            //   ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (ctx)=>const RegistrationScreen()));
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Register',
                  ),
                ),
              ),
            ),
               // RoundedButton(
            //   color: Colors.lightBlueAccent ,
            //   title:'Register',
            //   onTap: (){
            //      Navigator.push(context,MaterialPageRoute(builder: (ctx)=>const RegistrationScreen()));
            //   },
            //   ),
            
          ],
        ),
      ),
    );
  }
}
