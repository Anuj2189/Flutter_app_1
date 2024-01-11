
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/notes_service.dart';
import 'package:flutter_application_1/routes.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService;
  String get userEmail => AuthService.firebase().currentUser!.email!;


  @override
  void initState(){
   _notesService = NotesService();
   _notesService.open();
   super.initState();   
  }
  @override
  void dispose(){
    _notesService.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Your Notes'),backgroundColor:Colors.blue[200],
      actions: [ IconButton(onPressed:() {
        Navigator.of(context).pushNamed(newNoteRoute);
      }, icon: const Icon(Icons.add)),
        PopupMenuButton<MenuAction>(onSelected: (value) async {
        final shLogout = await showLogOutDialog(context);
        if(shLogout){
          await AuthService.firebase().logOut();
           Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
        }
      },itemBuilder: (context) {
        return const  [PopupMenuItem<MenuAction>(value: MenuAction.logout,child: Text('Logout'),)];
      },)],),
      body: FutureBuilder(future: _notesService.getOrCreateUser(email: userEmail),
      builder:(context, snapshot) {
        switch(snapshot.connectionState){
          
          case ConnectionState.done:
           return StreamBuilder(stream: _notesService.allNotes, builder:(context, snapshot) {
             switch(snapshot.connectionState){
              
               case ConnectionState.waiting:
                return const Text('Waiting for all notes');
                default:
                return const CircularProgressIndicator();
             }
           });
           default:
          return const CircularProgressIndicator();
        }
      }, ),
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