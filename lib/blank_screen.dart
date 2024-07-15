import 'dart:convert';

import 'package:flutter/material.dart';

class BlankScreen extends StatelessWidget {
  final String data;

  const BlankScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? vendorInfo;
    String errorMessage = '';

    // Attempt to parse JSON
    try {
      vendorInfo = jsonDecode(data);
    } catch (e) {
      errorMessage = 'Error decoding JSON: $e';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Information'),
      ),
      body: Center(
        child: errorMessage.isNotEmpty
            ? Text(errorMessage)
            : vendorInfo != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'ID: ${vendorInfo['id']}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Name: ${vendorInfo['name']}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Address: ${vendorInfo['address']}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Contact: ${vendorInfo['contact']}',
              style: TextStyle(fontSize: 24),
            ),
            // Add more fields as needed
          ],
        )
            : CircularProgressIndicator(), // Placeholder for loading state
      ),
    );
  }
}
