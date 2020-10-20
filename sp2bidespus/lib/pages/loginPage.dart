import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:sp2bidespus/components/constant.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sp2bidespus/pages/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sp2bidespus/pages/signUpPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final dBRef = FirebaseDatabase.instance.reference();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String usr;
  String pwd; 

  SharedPreferences loginData;
  bool newUser;

  @override
  void initState() {
    super.initState();
    loginCheck();
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
                    'LOGIN',
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
                                onChanged: (value) => usr = value,
                                controller: controllerUsername,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  isDense: true,
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  hintText: 'Username',
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
                        bottom: screenHeight(context)*(1/25),
                        left: screenWidth(context)*(0.65),
                        child: FlatButton(
                          onPressed: (){
                            if (_formKey.currentState.validate()){
                              checkingData();
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
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
                            'Belum punya akun? ',
                            style: TextStyle(
                              fontSize: screenWidth(context)*(1/25),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Daftar disini',
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

  String usrDB, pwdDB, usrDBUser, pwdDBUser, nama;

  Future<void> checkingData() async{
    String usrDBAdmin = (await dBRef.child('login').child('admin').child('username').once()).value.toString();
    String pwdDBAdmin = (await dBRef.child('login').child('admin').child('password').once()).value.toString();
    var fetchingUserInfo = (await dBRef.child('login'));
    fetchingUserInfo.orderByChild('username').equalTo(usr).once().then((DataSnapshot snapshot){
      print(snapshot.value);
      snapshot.value.forEach((key, values){
        nama = values['nama'];
        usrDBUser = values['username'];
        pwdDBUser = values['password'];
        print(pwdDBUser);
      });
    });

    //Check it is admin or not?
    if(usr == usrDBAdmin){
      usrDB = usrDBAdmin;
    }
    else{
      usrDB = usrDBUser;
    }

    if(pwd == pwdDBAdmin){
      pwdDB = pwdDBAdmin;
    }
    else{
      pwdDB = pwdDBUser;
    }
    //Check if usr admin but pwd not admin
    if(usrDB == usrDBAdmin && pwdDB != pwdDBAdmin){
      pwdDB = "";
    }
    else if(usrDB != usrDBAdmin && pwdDB == pwdDBAdmin){
      pwdDB = "";
    }

    //Checking final login
    if(usr == usrDB && pwd == pwdDB){
      loginData.setBool('login', false);
      loginData.setString('username', controllerUsername.text);
      Fluttertoast.showToast(
        msg: 'Selamat Datang!',
        backgroundColor: Colors.red[300],
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => HomePage(
          namaUser: nama,
        ),
      ));

    }
    else{
      Fluttertoast.showToast(
        msg: 'Username atau password salah!',
        backgroundColor: Colors.red[300],
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
      );
    }
  }

  void loginCheck() async{
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool('login') ?? true);

    if(newUser == false){
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
    }
  }

  @override
  void dispose() {
    controllerUsername.dispose();
    controllerPassword.dispose();
    super.dispose();
  }
}
