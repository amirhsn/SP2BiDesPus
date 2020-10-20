import 'package:auto_size_text/auto_size_text.dart';
//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sp2bidespus/components/constant.dart';
import 'package:sp2bidespus/components/dialogInfoDownload.dart';
import 'package:sp2bidespus/components/downloadMenuButton.dart';
import 'package:sp2bidespus/pages/subDownloadPage.dart';

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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubDownloadPage(
                        judulHalaman: anc,
                        judulCollection: 'laporan_anc',),));
                    }),
                    downloadMenu(context, salin, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubDownloadPage(
                        judulHalaman: salin,
                        judulCollection: 'laporan_persalinan',),));
                    }),
                    downloadMenu(context, nifas, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubDownloadPage(
                        judulHalaman: nifas,
                        judulCollection: 'laporan_nifas',),));
                    }),
                    downloadMenu(context, kia, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubDownloadPage(
                        judulHalaman: kia,
                        judulCollection: 'laporan_kia',),));
                    }),
                    downloadMenu(context, sdm, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubDownloadPage(
                        judulHalaman: sdm,
                        judulCollection: 'laporan_sdm',),));
                    }),
                    downloadMenu(context, kb, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubDownloadPage(
                        judulHalaman: kb,
                        judulCollection: 'laporan_kb',),));
                    }),
                    downloadMenu(context, ibu, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubDownloadPage(
                        judulHalaman: ibu,
                        judulCollection: 'laporan_ibu',),));
                    }),
                    downloadMenu(context, bayi, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubDownloadPage(
                        judulHalaman: bayi,
                        judulCollection: 'laporan_bayi',),));
                    }),
                    downloadMenu(context, imun, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubDownloadPage(
                        judulHalaman: imun,
                        judulCollection: 'laporan_imunisasi',),));
                    }),
                    downloadMenu(context, lansia, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubDownloadPage(
                        judulHalaman: lansia,
                        judulCollection: 'laporan_lansia',),));
                    }),
                    downloadMenu(context, tular, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubDownloadPage(
                        judulHalaman: tular,
                        judulCollection: 'laporan_penyakit',),));
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