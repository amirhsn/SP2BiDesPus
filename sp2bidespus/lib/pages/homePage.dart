import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sp2bidespus/components/constant.dart';
import 'package:sp2bidespus/components/dialog.dart';
import 'package:sp2bidespus/components/tombolMenu.dart';
import 'package:sp2bidespus/pages/downloadPage.dart';
import 'package:sp2bidespus/pages/loginPage.dart';
import 'package:sp2bidespus/pages/uploadPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences loginData;
  String username;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async{
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight(context),
            width: screenWidth(context),
            child: Image.asset(
              'assets/menus.png',
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight(context)*(1/2),
              width: screenWidth(context),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: screenWidth(context)*(17/18),
                    height: screenHeight(context)*(2/8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tombolMenu(context, 'Upload Doc', Icons.cloud_upload, Color.fromRGBO(171, 14, 21, 1), (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => UploadPage(),
                          ));
                        }),
                        tombolMenu(context, 'Download Doc', Icons.cloud_download, Color.fromRGBO(226, 221, 18, 1), (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DownloadPage(),
                          ));
                        }),
                        tombolMenu(context, 'Contact', Icons.phone, Color.fromRGBO(123, 23, 244, 1), (){
                          showDialog(
                            context: context,
                            builder: (_) => dialogPengembangan(context)
                          );
                        }),
                      ],
                    ),
                  ),
                  Center(
                    child: AutoSizeText(
                      'SILAHKAN PILIH MENU',
                      maxLines: 1,
                      minFontSize: 17,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3.0,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (_) => dialogLogout(context)
                      );
                    },
                    child: Container(
                      width: screenWidth(context)*(1/3),
                      height: screenWidth(context)*(1/9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.red[600]
                      ),
                      child: Center(
                        child: Text(
                          'KELUAR',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

    Widget dialogLogout(BuildContext context){
    return AlertDialog(
      content: AutoSizeText(
        'Apakah anda yakin ingin keluar?',
        textAlign: TextAlign.center,
      ),
      actions: [
        FlatButton(
          onPressed: (){
            loginData.setBool('login', true);
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
          },
          child: Text(
            'Ya',
            style: TextStyle(
              color: Color.fromRGBO(171, 14, 21, 1),
              letterSpacing: 1.0,
            ),
          ),
        ),
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(
            'Tidak',
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
}