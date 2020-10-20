import 'package:auto_size_text/auto_size_text.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sp2bidespus/components/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubDownloadPage extends StatefulWidget {
  final String judulHalaman;
  final String judulCollection;

  const SubDownloadPage({Key key, this.judulHalaman, this.judulCollection}) : super(key: key);
  @override
  _SubDownloadPageState createState() => _SubDownloadPageState();
}

class _SubDownloadPageState extends State<SubDownloadPage> {
  //METHOD UNTUK MEMINTA IZIN STORAGE
  Future<void> getPermissionFix() async {
    try {
      PermissionStatus permission = await Permission.storage.status;

      if (permission != PermissionStatus.granted) {
        await Permission.storage.request();
        PermissionStatus permission = await Permission.storage.status;

        if (permission == PermissionStatus.granted) {
          downloadFile();
        } else {
          openAppSettings();
        }
      } 
      else{
        downloadFile();
      }     
    } 
    catch (e) {
      print(e);
    }
  }

  String urlDownload;
  String namaFileOut;
  String pathDownload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 138, 140, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(238, 138, 140, 1),
        title: Text(
          widget.judulHalaman,
          style: TextStyle(
            fontSize: screenWidth(context)*(1/25),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.all(4),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(widget.judulCollection).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index){
                DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                urlDownload = documentSnapshot['url'];
                namaFileOut = widget.judulHalaman+' '+documentSnapshot['tanggal']+'.docx';
                return GestureDetector(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context) => dialogDownload(context, urlDownload),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    width: double.infinity,
                    height: screenHeight(context)*(1/9),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[700],
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        documentSnapshot['tanggal'],
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 2,
                        ),
                      ),
                      subtitle: Text(
                        widget.judulHalaman,
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 2,
                          fontSize: screenWidth(context)*(1/29),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
  //==================================================================================
  
  //==================================================================================
  
  //==================================================================================
  //ALERT DIALOG UNTUK MEYAKINKAN USER MENDOWNLOAD FILE ATAU TIDAK
  Widget dialogDownload(BuildContext context, String tpp){
    return AlertDialog(
      content: AutoSizeText(
        'Apakah anda yakin ingin download file?',
        textAlign: TextAlign.center,
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            getPermissionFix();
            Navigator.pop(context);
            await Fluttertoast.showToast(
              msg: 'Silahkan cek folder Download di device anda',
              backgroundColor: Colors.red[300],
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT,
              textColor: Colors.white,
              );
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
        'Download',
        style: TextStyle(
          color: Colors.black,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  //ALERT DIALOG UNTUK MEMBUKA FILE HASIL DOWNLOAD
  Widget dialogOpenFile(BuildContext context){
    return AlertDialog(
      content: AutoSizeText(
        'Ingin buka file langsung?',
        textAlign: TextAlign.center,
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            OpenFile.open(pathDownload+'/'+namaFileOut);
            Navigator.pop(context);
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
        'Download selesai',
        style: TextStyle(
          color: Colors.black,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  //METHOD UNTUK MENDAPATKAN URL DARI FILE
  //getUrl(String tipe) async {
    //PENUNJUK ATAU POINTER MASIH KE SATU FILE SAJA
  //  String locPath = tipe+"/"+tipe+".docx";
  //  StorageReference ref = 
  //      FirebaseStorage.instance.ref().child(locPath);
  //  String url = (await ref.getDownloadURL()).toString();
  //  urlDownload = url;
  //  namaFileOut = tipe;
    //MINTA IZIN AKSES STORAGE
  //  getPermissionFix();
    //downloadFile();
  //}

  //METHOD FUTURE ASYNC MASA DEPAN UNTUK MELAKUKAN DOWNLOAD FILE BILA PERMINTAAN DISETUJUI
  void downloadFile() async{
    pathDownload = await ExtStorage.getExternalStoragePublicDirectory(
    ExtStorage.DIRECTORY_DOWNLOADS);

    //String fullPath = '$path/'+namaFileOut+'.docx';
    //downloadStart(dio, urlDownload, fullPath);
    final taskId = await FlutterDownloader.enqueue(
      url: urlDownload,
      savedDir: pathDownload,
      showNotification: false,
      openFileFromNotification: false,
      fileName: namaFileOut
    );
    await FlutterDownloader.loadTasks();
    FlutterDownloader.retry(taskId: taskId);
    showDialog(
      context: context,
      builder: (_) => dialogOpenFile(context)
    );
  }
}