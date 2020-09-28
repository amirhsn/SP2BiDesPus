import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sp2bidespus/components/constant.dart';
import 'package:sp2bidespus/components/dialog.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String desc = 'FITUR UPLOAD MASIH DALAM TAHAP PENGEMBANGAN\n\n'
  '*Perhatikan saat ingin mengupload sebuah dokumen, '
  'pastikan ukuran dokumen tidak lebih dari 5MB dan ekstensi '
  'dari file tersebut merupakan .docx. Perhatikan juga '
  'KONEKSI INTERNET agar tidak terjadi error saat proses upload.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 138, 140, 1),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[700],
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: AutoSizeText(
          'UPLOAD',
          style: TextStyle(
            color: Colors.grey[700],
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: Color.fromRGBO(238, 138, 140, 1),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: screenWidth(context),
            height: screenHeight(context)*(1/(2.2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Image.asset(
                    'assets/doki.png',
                    width: screenWidth(context)*(1/(2.25)),
                  ),
                ),
                AutoSizeText(
                  'Silahkan Upload Dokumen Anda',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold
                  ),
                  minFontSize: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (_) => dialogPengembangan(context)
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        width: screenWidth(context)*(1/2),
                        height: screenHeight(context)*(1/13),
                        child: Center(
                          child: Text(
                            'PILIH FILE',
                            style: TextStyle(
                              letterSpacing: 3.0
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth(context)*(0.05),
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (_) => dialogPengembangan(context)
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white
                        ),
                        width: screenWidth(context)*(1/3),
                        height: screenHeight(context)*(1/13),
                        child: Center(
                          child: Text(
                            'UPLOAD',
                            style: TextStyle(
                              letterSpacing: 3.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(238, 138, 140, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth(context),
            height: screenHeight(context)*(1/6),
            color: Colors.white30,
            child: Center(
              child: AutoSizeText(
                desc,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}