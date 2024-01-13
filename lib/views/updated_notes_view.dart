import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/notes_service.dart';
import 'package:flutter_application_1/utilities/get_arguments.dart';

class NewNoteView extends StatefulWidget {
  const NewNoteView({super.key});

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
  DatabaseNote? _note;
  late final NotesService _notesService;
   late final TextEditingController _textController;

   void _textControllerListener() async {
      final note = _note;
      if(note == null){
        return;
      }
      final text = _textController.text;
      await _notesService.updateNote(note: note, text: text);
            
   }
   void _setupTextControllerListener(){
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
   }
   Future<DatabaseNote> createOrGetExistingNote(BuildContext context) async {
    final widgetnote = context.getArgument<DatabaseNote>();
    if(widgetnote!=null){
      _note=widgetnote;
      _textController.text = widgetnote.text;
    }
    final exisitingNote = _note;
    if(exisitingNote != null){
      return exisitingNote;
    }
   final currentUser = AuthService.firebase().currentUser!;
   final email = currentUser.email!;
   final owner = await _notesService.getUser(email: email);
   final  newNote= await _notesService.createNote(owner: owner);
   _note = newNote;
   return newNote;

   }
   void _deleteNoteIfTextIsEmpty(){
    final note = _note;
    if(_textController.text.isEmpty && note!=null){
      _notesService.deleteNote(id: note.id);
    }
   }
 void _saveNoteIfTextNotEmpty() async {
 final note = _note;
 final text =_textController.text;
 if(note != null && text.isNotEmpty){
    await _notesService.updateNote(note: note, text: text);
 }
 }
 @override
  void initState() {
    _notesService=NotesService();
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