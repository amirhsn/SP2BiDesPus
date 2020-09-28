import 'package:auto_size_text/auto_size_text.dart';
//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:sp2bidespus/components/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sp2bidespus/components/dialogInfoDownload.dart';
import 'package:sp2bidespus/components/downloadMenuButton.dart';

class DownloadPage extends StatefulWidget {
  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  
  //METHOD AWAL JALAN INITSTATE, PANGGIL INSTANCE DOWNLOAD
  //@override
  //void initState() {
  //  initializeDownload();
    //getPermission();
  //  super.initState();
  //}

  //Future<void> getPermission() async{
  //  await Permission.storage.request();
  //}

  //METHOD MEMBUAT INSTANCE DOWNLOAD, CUKUP SEKALI DOANG DI INISIALISASI
  //void initializeDownload() async{
  //  WidgetsFlutterBinding.ensureInitialized();
  //  await FlutterDownloader.initialize(
  //    debug: true // optional: set false to disable printing logs to console
  //  );
  //}

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

  //var dio = Dio();

  String anc = 'LAPORAN BULANAN ANC';
  String kb = 'LAPORAN KB';
  String imun = 'LAPORAN IMUNISASI';
  String nifas = 'LAPORAN BULANAN NIFAS';
  String kia = 'LAPORAN KIA';
  String sdm = 'LAPORAN SDM';
  String ibu = 'LAPORAN KEMATIAN IBU';
  String bayi = 'LAPORAN TUMBUH KEMBANG BAYI';
  String salin = 'LAPORAN PERSALINAN';
  String lansia = 'LAPORAN LANSIA';
  String tular = 'LAPORAN PENYAKIT TIDAK MENULAR';

  String urlDownload;
  String namaFileOut;
  String pathDownload;

  @override
  Widget build(BuildContext context) {
    //initializeDownload();
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
                builder: (_) => dialogInfoDownload(context),
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
          'DOWNLOAD',
          style: TextStyle(
            color: Colors.grey[700],
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: Color.fromRGBO(238, 138, 140, 1),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/doki.png',
              width: screenWidth(context)*(1/4),
            ),
            Container(
              width: screenWidth(context),
              height: screenHeight(context)*(2/3),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    downloadMenu(context, anc, (){
                      showDialog(
                        context: context,
                        builder: (_) => dialogDownload(context, anc),
                      );
                    }),
                    downloadMenu(context, salin, (){
                      showDialog(
                        context: context,
                        builder: (_) => dialogDownload(context, salin),
                      );
                    }),
                    downloadMenu(context, nifas, (){
                      showDialog(
                        context: context,
                        builder: (_) => dialogDownload(context, nifas),
                      );
                    }),
                    downloadMenu(context, kia, (){
                      showDialog(
                        context: context,
                        builder: (_) => dialogDownload(context, kia),
                      );
                    }),
                    downloadMenu(context, sdm, (){
                      showDialog(
                        context: context,
                        builder: (_) => dialogDownload(context, sdm),
                      );
                    }),
                    downloadMenu(context, kb, (){
                      showDialog(
                        context: context,
                        builder: (_) => dialogDownload(context, kb),
                      );
                    }),
                    downloadMenu(context, ibu, (){
                      showDialog(
                        context: context,
                        builder: (_) => dialogDownload(context, ibu),
                      );
                    }),
                    downloadMenu(context, bayi, (){
                      showDialog(
                        context: context,
                        builder: (_) => dialogDownload(context, bayi),
                      );
                    }),
                    downloadMenu(context, imun, (){
                      showDialog(
                        context: context,
                        builder: (_) => dialogDownload(context, imun),
                      );
                    }),
                    downloadMenu(context, lansia, (){
                      showDialog(
                        context: context,
                        builder: (_) => dialogDownload(context, lansia),
                      );
                    }),
                    downloadMenu(context, tular, (){
                      showDialog(
                        context: context,
                        builder: (_) => dialogDownload(context, tular),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


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
            getUrl(tpp);
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
            OpenFile.open(pathDownload+'/'+namaFileOut+'.docx');
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
  getUrl(String tipe) async {
    //PENUNJUK ATAU POINTER MASIH KE SATU FILE SAJA
    String locPath = tipe+"/"+tipe+".docx";
    StorageReference ref = 
        FirebaseStorage.instance.ref().child(locPath);
    String url = (await ref.getDownloadURL()).toString();
    urlDownload = url;
    namaFileOut = tipe;
    //MINTA IZIN AKSES STORAGE
    getPermissionFix();
    //downloadFile();
  }

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
      fileName: namaFileOut+".docx",
    );
    await FlutterDownloader.loadTasks();
    FlutterDownloader.retry(taskId: taskId);
    showDialog(
      context: context,
      builder: (_) => dialogOpenFile(context)
    );
  }

  //Future downloadStart(Dio dio, String url, String savePath) async{
  //  try{
  //    Response response = await dio.get(
  //      url,
  //      onReceiveProgress: showDownloadProgress,
  //      options: Options(
  //        responseType: ResponseType.bytes,
  //        followRedirects: false,
  //        validateStatus: (status){
  //          return status < 500;
  //        }
  //      ),
  //    );
  //    File file = File(savePath);
  //    var raf = file.openSync(mode: FileMode.write);
  //    raf.writeFromSync(response.data);
  //    await raf.close();
  //  }
  //  catch (e){
  //    print("error message:");
  //    print(e);
  //  }
  //}

  //void showDownloadProgress(received, total){
  //  if (total != -1){
  //    print((received/total*100).toStringAsFixed(0)+"%");
  //  }
  //}
}