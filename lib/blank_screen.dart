import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BlankScreen extends StatelessWidget {
  final Map<String, dynamic> vendorInfo;

  const BlankScreen({Key? key, required this.vendorInfo}) : super(key: key);

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(vendorInfo['user']['profilePic']),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'ID: ${vendorInfo['user']['_id']}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'First Name: ${vendorInfo['user']['fname']}',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Middle Name: ${vendorInfo['user']['mname']}',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Last Name: ${vendorInfo['user']['lname']}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'Date of Birth: ${vendorInfo['user']['dob']}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'Mobile: ${vendorInfo['user']['mobile']}',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Aadhar: ${vendorInfo['user']['aadhar']}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'Police Verification Date From: ${vendorInfo['user']['policeVarificationDateFrom']}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'Police Verification Date To: ${vendorInfo['user']['policeVarificationDateTo']}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'Medical Validity Date From: ${vendorInfo['user']['medicalValidityDateFrom']}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'Medical Validity Date To: ${vendorInfo['user']['medicalValidityDateTo']}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'Validity Authority: ${vendorInfo['user']['validityAuthority']}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _launchURL(vendorInfo['user']['aadharCardImg']),
                child: Text(
                  'Aadhar Card Image: ${vendorInfo['user']['aadharCardImg']}',
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _launchURL(vendorInfo['user']['policeVarificationDocument']),
                child: Text(
                  'Police Verification Document: ${vendorInfo['user']['policeVarificationDocument']}',
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
