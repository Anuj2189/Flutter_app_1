

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/login_view.dart';
import 'package:flutter_application_1/register_view.dart';
import 'firebase_options.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomePage(),
  ));
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        backgroundColor: Colors.blue[100],
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            //final user = FirebaseAuth.instance.currentUser;
            //print(user);
            //if(user?.emailVerified??false){
           // return const Text('Done');
            //}else{
              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const VerifyEmailView(),));
              return const RegisterView();
            //}
            
             
            default:
              return const Text('Loading');
          }
        },
      ),
    );
  }
}
class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body : Column(
        children: [const Text('Please verify your email address'),
        TextButton(onPressed:() async {
          final user = FirebaseAuth.instance.currentUser;
          await user?.sendEmailVerification();

        }, child: const Text('Send Email Verification'))],
        
      )
    );
  }
}
