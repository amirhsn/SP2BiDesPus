//WIDGET BUTTON MENU DOWNLOAD

import 'package:flutter/material.dart';
import 'package:sp2bidespus/components/constant.dart';

Widget downloadMenu(BuildContext context, String judul, Function onDownload){
  return
  FlatButton(
    padding: EdgeInsets.only(bottom: 7),
    onPressed: onDownload,
    child: Container(
      width: screenWidth(context)*(6/7),
      height: screenHeight(context)*(1/13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[300],
      ),
      child: Center(
        child: Text(
          judul,
          style: TextStyle(
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    ),
  );
}