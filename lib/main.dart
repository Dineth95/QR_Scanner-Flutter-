import 'package:flutter/material.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:homepage()
    );
  }
}

class homepage extends StatefulWidget{
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String result="Hey man";
  Future _scanQR() async{
    try{
      String qrResult=await BarcodeScanner.scan();
      setState(() {
          result=qrResult;
      });
    }on PlatformException catch(exp){
      if(exp.code==BarcodeScanner.CameraAccessDenied){
        setState(() {
          result="Camera Permission Denied";
        });
      }else{
        setState(() {
          result="Unknown error";
        });
      }
    }on FormatException catch(ex){
      setState(() {
        result="You must Scan";
      });
    }catch(e){
      setState(() {
        result="Unknown error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
      ),
      body:Padding(
              padding: EdgeInsets.all(25.0),
              child: Center(
                child: Text(result,style:
                new TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),),)

      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text('Scan'),
        onPressed: (){
          _scanQR();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}