import 'package:flutter/material.dart';
import 'package:flutter_application_1/dialog/generic_dialog.dart';

Future<void> showCannotShareEmptyDialog(BuildContext context){
return showGenericDialog(context: context, title: 'Sharing', content: 'You cannot share an empty note!', optionsBuilder:() => {
  'OK':null,
});
}