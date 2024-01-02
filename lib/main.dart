

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/verify_email_view.dart';
import 'package:flutter_application_1/views/login_view.dart';
import 'package:flutter_application_1/views/register_view.dart';
import 'firebase_options.dart';
import 'dart:developer';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomePage(),
    routes: {
      loginRoute:(context) => const LoginView(),
      registerRoute:(context) => const RegisterView(),
      notesRoute:(context) => const NotesView(),
      '/verifyemail':(context) => const VerifyEmailView()
    },
  ));
}
enum MenuAction{
  logout
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if(user!=null){
              if(user.emailVerified){
              return const NotesView();}
            else{
              return const VerifyEmailView();
            }}
            else{
              return const LoginView();
            }
      
            default:
              return CircularProgressIndicator();
          }
        },
      );
    
  }
}
class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Main UI'),backgroundColor:Colors.blue[200],
      actions: [PopupMenuButton<MenuAction>(onSelected: (value) async {
        final shLogout = await showLogOutDialog(context);
        if(shLogout){
          await FirebaseAuth.instance.signOut();
           Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
        }
      },itemBuilder: (context) {
        return const  [PopupMenuItem<MenuAction>(value: MenuAction.logout,child: Text('Logout'),)];
      },)],),
    );
  }
}
Future<bool> showLogOutDialog(BuildContext context){
  return showDialog<bool>(context: context, builder:(context) {
    return AlertDialog(
      title: const Text('Signing Out'),
      content: const Text('Are you sure you want to sign out? '),
      actions: [
        TextButton(onPressed:() {
          Navigator.of(context).pop(false);
          
        }, child: const Text('Cancel')),
        TextButton(onPressed:() {
          Navigator.of(context).pop(true);
        }, child: const Text('Sign out'))
      ],
    );
  }).then((value) => value ?? false);
}