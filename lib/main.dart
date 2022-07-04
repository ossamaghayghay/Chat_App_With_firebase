import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/chat_screen.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute:WelcomeScreen.routeName,
      routes: {
        WelcomeScreen.routeName:((context) => const WelcomeScreen()),
        LoginScreen.routeName:((context) => const LoginScreen()),
        RegistrationScreen.routeName:((context) => const RegistrationScreen()),
        ChatScreen.routeName:((context) => const ChatScreen())
      },
      home: const WelcomeScreen(),
    );
  }
}
