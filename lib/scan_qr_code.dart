import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'blank_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class ScanQrCode extends StatefulWidget {
  const ScanQrCode({Key? key}) : super(key: key);

  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQrCode> {
  String qrResult = 'Scanned Data will appear here..';


  Future<void> scanQR() async {
    try {
      final qrcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR,);
      if (!mounted) return;
      if (qrcode != '-1') { // Check if the scan was not canceled
        setState(() {
          qrResult = qrcode; // Update the qrResult state variable
        });
        // Make an HTTP request to your server with the QR code data
        // Make an HTTP request to your server with the QR code data
        final response = await http.post(
          Uri.parse('https://railway-qbx4.onrender.com/vendor/fetchVendorDataByQR'), // Replace with your server URL
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'qrCode': qrcode}),
        );

        if (response.statusCode == 200) {
          final vendorInfo = jsonDecode(response.body);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlankScreen(data: jsonEncode(vendorInfo)),
            ),
          );
        } else {
          qrResult = 'Failed to fetch vendor info';
        }
      }else {
        qrResult = 'QR code scan canceled';
      }

    } on PlatformException {
        qrResult = 'Failed to read QR Code';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan QR Code',
          style: TextStyle(fontFamily: 'Fustat', fontSize: 18, color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(0, 199, 255, 1.0), // Set AppBar background color here
      ),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: scanQR,
      //     child: Text('Scan Code'),
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(qrResult),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: scanQR,
              child: Text('Scan Code'),
            ),
          ],
        ),
      ),
    );
  }
}
