import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sp2bidespus/components/constant.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final dBRef = FirebaseDatabase.instance.reference().child('login');
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String nama;
  String usr;
  String pwd; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight(context),
            width: screenWidth(context),
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              height: screenHeight(context)*(1/2),
              width: screenWidth(context)*(7/8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AutoSizeText(
                    'DAFTAR',
                    maxLines: 1,
                    minFontSize: 30,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                    if (value.isEmpty){
                                      return 'Harap diisi';
                                    }
                                    return null;
                                  },
                                onChanged: (value) => nama = value,
                                controller: controllerNama,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  isDense: true,
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  hintText: 'Nama lengkap',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              TextFormField(
                                validator: (value) {
                                    if (value.isEmpty){
                                      return 'Harap diisi';
                                    }
                                    return null;
                                  },
                                onChanged: (value) => usr = value,
                                controller: controllerUsername,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  isDense: true,
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  hintText: 'Username',
                                  border: OutlineInputBorder(
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              TextFormField(
                                validator: (value) {
                                    if (value.isEmpty){
                                      return 'Harap diisi';
                                    }
                                    return null;
                                  },
                                onChanged: (value) => pwd = value,
                                controller: controllerPassword,
                                obscureText: true,
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  isDense: true,
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  hintText: 'Password (NRPTT)',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                  ),
                                prefixIcon: Icon(
                                    Icons.security,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: screenHeight(context)*(1/15),
                        left: screenWidth(context)*(0.65),
                        child: FlatButton(
                          onPressed: (){
                            try{
                              if (_formKey.currentState.validate()){
                                dBRef.push().set({
                                  'nama':controllerNama.text,
                                  'username':controllerUsername.text,
                                  'password':controllerPassword.text,
                                });
                              }
                              Fluttertoast.showToast(
                                msg: 'Pendaftaran berhasil, silahkan masuk melalui menu login',
                                gravity: ToastGravity.CENTER,
                                toastLength: Toast.LENGTH_LONG,
                              );
                            }
                            catch(e){
                              Fluttertoast.showToast(
                                msg: 'Sepertinya ada masalah, coba lagi nanti'
                              );
                            }
                          },
                          child: Container(
                            height: screenHeight(context)*(1/10),
                            width: screenHeight(context)*(1/10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.red[300],
                            ),
                            child: Icon(
                              Icons.call_made,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  AutoSizeText(
                    'HARAP PASTIKAN ANDA TERKONEKSI KE INTERNET',
                    style: TextStyle(
                      letterSpacing: 2.0,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: screenWidth(context)*(2/3),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sudah punya akun? ',
                            style: TextStyle(
                              fontSize: screenWidth(context)*(1/25),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Silahkan login',
                            style: TextStyle(
                              fontSize: screenWidth(context)*(1/25),
                              color: Colors.white,
                            ),
                          ),
                        ],
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
}
