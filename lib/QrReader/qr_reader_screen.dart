import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

String password = 'PASSWORD${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}';

class QrReader extends StatefulWidget {
  const QrReader({Key? key}) : super(key: key);

  @override
  State<QrReader> createState() => _QrReaderState();
}

class _QrReaderState extends State<QrReader> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  bool success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: (_controller) {
                  controller = _controller;
                  controller!.scannedDataStream.listen((event) async {
                    result = event;
                    String resultCode = event.code ?? '';
                    if (!success) {
                      if (resultCode == password) {
                        success = true;
                        print('success');
                        await FirebaseDatabase.instance.ref().child('sessions').child('session').set('Iphone 11 Pro Max');
                        // await Future.delayed(Duration(seconds: 3));
                        // await FirebaseDatabase.instance.ref().child('sessions').child('session').set(null);
                      }
                    }
                  });
                },
              ),
              flex: 5),
          Expanded(
              child: Container(
            child: Center(child: Text('Karekod okutun')),
          )),
        ],
      ),
    );
  }
}
