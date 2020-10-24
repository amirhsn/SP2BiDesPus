import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sp2bidespus/components/constant.dart';
import 'package:sp2bidespus/components/dialogInfoUpload.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File file;
  String fileName = 'File belum dipilih';
  bool isLoading = false;
  String desc = '*Perhatikan saat ingin mengupload sebuah dokumen, '
  'pastikan ukuran dokumen tidak lebih dari 5MB dan ekstensi '
  'dari file tersebut merupakan .docx, .pdf atau .rar (lebih dari 1 dokumen). Perhatikan juga '
  'KONEKSI INTERNET agar tidak terjadi error saat proses upload.';

  //METHOD UNTUK MEMINTA IZIN STORAGE
  Future<void> getPermissionFix() async {
    try {
      PermissionStatus permission = await Permission.storage.status;

      if (permission != PermissionStatus.granted) {
        await Permission.storage.request();
        PermissionStatus permission = await Permission.storage.status;

        if (permission == PermissionStatus.granted) {
          //uploadFile();
        } else {
          openAppSettings();
        }
      } 
      else{
        //uploadFile();
      }     
    } 
    catch (e) {
      print(e);
    }
  }

  Widget uploadButton(){
    if (isLoading == false){
      return Text(
        'UPLOAD',
        style: TextStyle(
          letterSpacing: 3.0,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(238, 138, 140, 1),
        ),
      );   
    }
    else{
      return CircularProgressIndicator(
        backgroundColor: Color.fromRGBO(238, 138, 140, 1),
        strokeWidth: 3,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 138, 140, 1),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.grey[700],
            ),
            onPressed: (){
              showDialog(
                context: context,
                builder: (_) => dialogInfoUpload(context),
              );
            }
          )
        ],
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
            height: screenHeight(context)*(1/(2.5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Image.asset(
                    'assets/doki.png',
                    width: screenWidth(context)*(1/(3)),
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
                        getFile();
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
                              letterSpacing: 3.0,
                              fontSize: screenWidth(context)*(1/25),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          )
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth(context)*(0.05),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isLoading = true;
                        });
                        saveFile(
                          file
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
                          child: uploadButton()
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'File dipilih: ',
                style: TextStyle(
                  letterSpacing: 2.0,
                  fontSize: screenWidth(context)*(1/25),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              SizedBox(
                height: screenHeight(context)*(1/30),
              ),
              Container(
                width: screenWidth(context)*(7/8),
                child: Text(
                  fileName,
                  style: TextStyle(
                    letterSpacing: 2.0,
                    fontSize: screenWidth(context)*(1/25),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ),
            ],
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

  Future getFile() async{
    file = await FilePicker.getFile(type: FileType.custom);
    if(file != null){
        setState(() {
        fileName = file.path.split('/').last;
      });
    }
    else{
      return null;
    }
  }

  saveFile(File asset) async{
    String username = 'dammurib7@gmail.com';
    String password = 'vanadam11';

    final smtpServer = gmail(username,password);

    final message = Message()
    ..from = Address(username)
    ..recipients.add("sorayuhu7@gmail.com")//ini email abi, ke gentos wen ku email khusus nampung
    ..subject = 'PERMINTAAN UPLOAD'
    ..attachments.add(FileAttachment(asset))
    ..html = "UPLOAD REQUEST";

    try{
      final sendReport = await send(message,smtpServer);
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: 'UPLOAD BERHASIL\nFile anda sudah masuk antrian review oleh admin',
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      print('Message sent: '+sendReport.toString());
    }
    on MailerException catch(e) {
      isLoading = false;
      Fluttertoast.showToast(
          msg: "Terjadi masalah, upload gagal. Harap periksa kembali jaringan anda.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          );
      print('Message not sent: '+e.toString());
    }
  }
}