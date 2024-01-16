import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/cloud/cloud_note.dart';
import 'package:flutter_application_1/cloud/firebase_cloud_storage.dart';
import 'package:flutter_application_1/utilities/get_arguments.dart';

class NewNoteView extends StatefulWidget {
  const NewNoteView({super.key});

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
  CloudNote? _note;
  late final FirebaseCloudStorage _notesService;
   late final TextEditingController _textController;

   void _textControllerListener() async {
      final note = _note;
      if(note == null){
        return;
      }
      final text = _textController.text;
      await _notesService.updateNote(documentId: note.documentId, text: text);
      
            
   }
   void _setupTextControllerListener(){
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
   }
   Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
    final widgetnote = context.getArgument<CloudNote>();
    if(widgetnote!=null){
      _note=widgetnote;
      _textController.text = widgetnote.text;
    }
    final exisitingNote = _note;
    if(exisitingNote != null){
      return exisitingNote;
    }
   final currentUser = AuthService.firebase().currentUser!;
   final userId = currentUser.id;
   final  newNote= await _notesService.createNewNote(ownerUserId: userId);
   _note = newNote;
   return newNote;

   }
   void _deleteNoteIfTextIsEmpty(){
    final note = _note;
    if(_textController.text.isEmpty && note!=null){
      _notesService.deleteNote(documentId: note.documentId);
    }
   }
 void _saveNoteIfTextNotEmpty() async {
 final note = _note;
 final text =_textController.text;
 if(note != null && text.isNotEmpty){
    await _notesService.updateNote(documentId: note.documentId, text: text);  
 }
 }
 @override
  void initState() {
    _notesService=FirebaseCloudStorage();
    _textController =TextEditingController();
    super.initState();
  }
 @override
 void dispose(){
  _deleteNoteIfTextIsEmpty();
  _saveNoteIfTextNotEmpty();
  _textController.dispose();
  super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Note'),backgroundColor: Colors.blue[200],),
      body: FutureBuilder(future: createOrGetExistingNote(context),builder: (context, snapshot) {
        switch(snapshot.connectionState){
          
          case ConnectionState.done:
          _setupTextControllerListener();
           return TextField(
            controller: _textController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Start typing your note here',
            ),
           );
            default:
            return const CircularProgressIndicator();
        }
      },)
    );
  }
}