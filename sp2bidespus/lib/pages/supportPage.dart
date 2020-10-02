
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';


class SupportPage extends StatefulWidget{
  _SupportPageState createState() => new _SupportPageState();
}

class _SupportPageState extends State<SupportPage>{

  String isi;
  String emailnya;
  String namanya;
  String objeknya;
  TextEditingController nama = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController objek = new TextEditingController();
  TextEditingController keluhan = new TextEditingController();

  mail(String isinya, String emailnya1, String namanya1, String objeknya1) async
  {
    String username = 'dammuria3@gmail.com';
    String password = 'vanadam11';

    final smtpServer = gmail(username,password);

    final message = Message()
    ..from = Address(username)
    ..recipients.add("gunmanblack@gmail.com")//ini email abi, ke gentos wen ku email khusus nampung
    ..subject = "${objeknya1}"//ini masih ggal parsing argumen
    ..html = "<h3>${isinya} Email Saya\n ${emailnya1}\n Nama Saya ${namanya1}</h3>";//masih belum masuk mir ieu abi ggal wae parsing argumentna


    try{
      final sendReport = await send(message,smtpServer);
      AlertDialog alertDialog = new AlertDialog(
        content: new Container(
          height: 90,
          child: new Column(
            children: <Widget>[
              new Text("Pesan Terkirim"),
              new Padding(padding: new EdgeInsets.only(top: 20.0),),
              new RaisedButton(
                  color: Colors.black26,
                  child: new Text("Oke"),
                  onPressed : () => Navigator.pop(context))
            ],
          ),
        ),
      );
      showDialog(context: context, child: alertDialog);
    }
    on MailerException catch(e) {
      Fluttertoast.showToast(
          msg: "Pesan Tidak Terkirim",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black12,
          textColor: Colors.pinkAccent,
          fontSize: 16.0);
      for (var p in e.problems){
        print("Masalah ${p.code} : ${p.msg}");
      }
    }
  }

  void submitData()
  {
    AlertDialog alertDialog = new AlertDialog(
      content: new Container(
        height: 80.0,
        child: new Column(
          children: <Widget>[
            new Text("Data Telah Disubmit"),
            new Padding(padding: new EdgeInsets.only(top: 10.0)),
            new RaisedButton(
                color: Colors.black12,
                child: new Text("Ok!"),
                onPressed: ()=>Navigator.pop(context)
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        leading: new Icon(Icons.home),
        title: new Text("Bantuan Kami"),
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
                    Text("Isi Form Bantuan Kami",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
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
                  controller: nama,
                  decoration : new InputDecoration(
                    hintText: "Masukan nama",
                    labelText: "Nama",
                    border : new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                  onSaved: (String value){
                    namanya = value;
                  },
                ),
                new Padding(padding: new EdgeInsets.only(top: 10.0),),
                new TextFormField(
                  controller: email,
                  decoration : new InputDecoration(
                    hintText: "Masukan Alamat Email",
                    labelText: "Email",
                    border : new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                  onSaved: (String value)
                  {
                    emailnya = value;
                  },
                ),
                new Padding(padding: new EdgeInsets.only(top: 10.0),),
                new TextFormField(
                  controller: objek,
                  decoration: new InputDecoration(
                    hintText: "Subjek",
                    labelText: "Masukan Subjek",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                  onSaved: (String value)
                  {
                    objeknya = value;
                  },
                ),
                new Padding(padding: new EdgeInsets.only(top: 10.0),),
                new TextFormField(
                  controller: keluhan,
                  maxLines: 5,
                  decoration: new InputDecoration(
                    hintText: "Masukan Keluhan Anda",
                    labelText: "Keluhan Anda",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                  onSaved: (String value){
                    isi = value;
                  },
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
                  onPressed: () {mail(isi, emailnya,namanya,objeknya);},
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}