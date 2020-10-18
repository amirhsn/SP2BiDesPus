
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LaporanImun extends StatefulWidget{
  @override
  _LaporanImunState createState() => _LaporanImunState();

}

class _LaporanImunState extends State<LaporanImun>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Laporan Imunisasi"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: 1,//sesuai json data laporan mir,
            itemBuilder: (context,index) {
              return Card(
                child: Container(
                  height: 80,
                  child: ListTile(
                    onTap: (){},
                    title: Text("Sesuaikan dengan json nanti", style: TextStyle(fontSize: 20,color: Colors.deepPurple),
                    ),
                    subtitle: Text("nanti bawahna bulan gtu bisa?, jd pas sort by bulan juni, yang mncul bulannya, kalo ndk bisa bulannya wae"),
                  ),
                ),
              );
            }
        ),
      ),
    );

  }
}
