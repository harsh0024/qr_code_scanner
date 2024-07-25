import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'blank_screen.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({Key? key}) : super(key: key);

  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQrCode> {
  String qrResult = 'Scanned Data will appear here..';
  bool isLoading = false;

  Future<void> scanQR() async {
    try {
      setState(() {
        isLoading = true;
      });
      final qrcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR,
      );
      if (!mounted) return;
      if (qrcode != '-1') {
        setState(() {
          qrResult = qrcode;
        });

        final response = await http.post(
          Uri.parse('https://railway-qbx4.onrender.com/vendor/fetchVendorDataByQR'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'qrcode': qrcode}),
        );

        print('Server response: ${response.body}');

        if (response.statusCode == 200) {
          final vendorInfo = jsonDecode(response.body) as Map<String, dynamic>;
          print('Vendor info: $vendorInfo');

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlankScreen(vendorInfo: vendorInfo),
            ),
          );
        } else {
          setState(() {
            qrResult = 'Failed to fetch vendor info';
          });
          _showErrorSnackbar('Failed to fetch vendor info');
        }
      } else {
        setState(() {
          qrResult = 'QR code scan canceled';
        });
      }
    } on PlatformException {
      setState(() {
        qrResult = 'Failed to read QR Code';
      });
      _showErrorSnackbar('Failed to read QR Code');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan QR Code',
          style: TextStyle(fontFamily: 'Fustat', fontSize: 18, color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(0, 199, 255, 1.0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isLoading
                ? CircularProgressIndicator()
                : Text(
              qrResult,
              textAlign: TextAlign.center,
            ),
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
