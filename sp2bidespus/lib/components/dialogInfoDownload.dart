import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

String desc = '1. Pastikan device anda terkoneksi internet\n\n'
'2. Pastikan perizinan untuk storage telah diaktifkan, '
'dengan cara masuk ke Setting Android - Apps - SP2BiDesPus - Permission\n\n'
"3. File hasil download disimpan di folder '/Download' pada internal device";

Widget dialogInfoDownload(BuildContext context){
  return AlertDialog(
    content: AutoSizeText(
      desc,
      textAlign: TextAlign.left,
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
      'Informasi',
      style: TextStyle(
        color: Colors.black,
        letterSpacing: 1.0,
      ),
    ),
  );
}