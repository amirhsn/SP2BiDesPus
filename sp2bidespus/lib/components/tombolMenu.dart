//WIDGET HOMEPAGE YANG 3 MENU

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sp2bidespus/components/constant.dart';

Widget tombolMenu(BuildContext context, String deskripsi, IconData iconMenu, Color backColor, Function onMenuFunc){
  return
  GestureDetector(
    onTap: onMenuFunc,
    child: Container(
      height: screenHeight(context)*(2/8),
      width: screenWidth(context)*(4/(13.5)),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Container(
          height: screenHeight(context)*(1/6),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  iconMenu,
                  size: screenWidth(context)*(1/10),
                  color: Colors.white,
                ),
                AutoSizeText(
                  deskripsi,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}