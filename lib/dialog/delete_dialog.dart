import 'package:flutter/material.dart';
import 'package:flutter_application_1/dialog/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context){
  return showGenericDialog<bool>(context: context, title: 'Delete', content: 'Are you sure you want to Delete this item?', optionsBuilder:() =>{
    'Cancel':false,
    'Delete':true,
  },).then((value) => value ?? false);
}