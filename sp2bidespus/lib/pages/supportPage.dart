import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';
import 'package:sp2bidespus/components/constant.dart';


class SupportPage extends StatefulWidget{
  _SupportPageState createState() => new _SupportPageState();
}

class _SupportPageState extends State<SupportPage>{
  TextEditingController namaController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController subjekController = new TextEditingController();
  TextEditingController isiController = new TextEditingController();

  mail(String isiPesan, String emailPesan, String namaPesan, String subjekPesan) async
  {
    String username = 'dammurib7@gmail.com';
    String password = 'vanadam11';

    final smtpServer = gmail(username,password);

    final message = Message()
    ..from = Address(username)
    ..recipients.add("sorayuhu7@gmail.com")//ini email abi, ke gentos wen ku email khusus nampung
    ..subject = subjekPesan
    ..html = "<h3>Keluhan dari "+namaPesan+" dengan alamat email "+emailPesan+"</h3>\n\n<p>"+isiPesan+"</p>";


    try{
      final sendReport = await send(message,smtpServer);
      Fluttertoast.showToast(
        msg: 'Pesan Terkirim',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
      );
      print('Message sent: '+sendReport.toString());
    }
    on MailerException catch(e) {
      Fluttertoast.showToast(
          msg: "Pesan tidak terkirim, harap periksa kembali jaringan atau alamat email anda!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          );
      print('Message not sent: '+e.toString());
    }
  }

  kirimPesan() async{
    if(isiController.text == "" || emailController.text == "" || namaController.text == "" || subjekController.text == ""){
      Fluttertoast.showToast(
        msg: 'Harap isi semua form yag disediakan!',
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    else{
      mail(isiController.text, emailController.text, namaController.text, subjekController.text);
    }
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(icon:Icon(Icons.arrow_back), onPressed: (){Navigator.pop(context);},),
        title: new AutoSizeText("Bantuan Kami"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),

      body:
      new ListView(
        children: <Widget>[
          new Container(
            padding : new EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Isi Form Bantuan Kami",
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth(context)*(1/25),
                      color: Colors.pinkAccent,
                    ),)
                  ],
                ),
                new Padding(padding: new EdgeInsets.only(bottom: 10.0),),
                new Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: new Container(
                          height: 3,
                          color: Colors.pink,
                        ),
                      ),
                    )
                  ],
                ),
                new Padding(padding: new EdgeInsets.only(top:10,bottom: 10),),
                new Padding(padding: new EdgeInsets.only(top: 10.0),),
                new TextFormField(
                  controller: namaController,
                  decoration : new InputDecoration(
                    hintText: "Masukan nama",
                    labelText: "Nama",
                    border : new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                new Padding(padding: new EdgeInsets.only(top: 10.0),),
                new TextFormField(
                  controller: emailController,
                  decoration : new InputDecoration(
                    hintText: "Masukan Alamat Email",
                    labelText: "Email",
                    border : new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                new Padding(padding: new EdgeInsets.only(top: 10.0),),
                new TextFormField(
                  controller: subjekController,
                  decoration: new InputDecoration(
                    hintText: "Subjek",
                    labelText: "Masukan Subjek",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                new Padding(padding: new EdgeInsets.only(top: 10.0),),
                new TextFormField(
                  controller: isiController,
                  maxLines: 5,
                  decoration: new InputDecoration(
                    hintText: "Masukan Keluhan Anda",
                    labelText: "Keluhan Anda",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                new Padding(padding: new EdgeInsets.only(top: 10.0),),
                new RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  child : new Text("Submit",style: new TextStyle
                    (color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: Colors.black,
                          blurRadius: 5.0)]),),
                  color: Colors.pinkAccent,
                  onPressed: () {
                    kirimPesan();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}