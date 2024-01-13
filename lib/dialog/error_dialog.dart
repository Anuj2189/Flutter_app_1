import 'package:flutter/material.dart';
import 'package:flutter_application_1/dialog/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
){
return showGenericDialog<void>(context: context, title: 'An Error Occured', content: text, optionsBuilder:() => {'OK':null,},);
}