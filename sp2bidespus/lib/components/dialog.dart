import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

//DIALOG PENGEMBANGAN DI HALAMAN UPLOAD
Widget dialogPengembangan(BuildContext context){
  return AlertDialog(
    content: AutoSizeText(
      'Fitur ini masih dalam tahap pengembangan, mohon tunggu informasi selanjutnya.',
      textAlign: TextAlign.center,
    ),
    actions: [
      FlatButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: Text(
          'OK',
          style: TextStyle(
            color: Color.fromRGBO(171, 14, 21, 1),
            letterSpacing: 1.0,
          ),
        ),
      ),
    ],
    backgroundColor: Colors.white,
    title: Text(
      'Pemberitahuan',
      style: TextStyle(
        color: Colors.black,
        letterSpacing: 1.0,
      ),
    ),
  );
}