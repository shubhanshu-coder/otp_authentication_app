import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  static String verify="";
  static String phoneNumber="";
  static int forceIdToken=0;
  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {

  TextEditingController countrycode= TextEditingController();
  var phone="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countrycode.text="+91";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img1.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),


              Text('Please Enter Your mobile Number', style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold
              ),),
              SizedBox(
                height: 10,
              ),
              Text('You will recieve a 4 digit code to verify next.', style: TextStyle(
                fontSize: 16 ,
              ),
              textAlign: TextAlign.center,),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 140,
                    ),
                    Image.asset(
                      'assets/india.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        enabled: false,
                        keyboardType: TextInputType.phone,
                        onChanged: (value){
                        },
                        controller: countrycode,
                        decoration: InputDecoration(
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("|", style: TextStyle(
                        fontSize: 33,color: Colors.grey
                    ),),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Phone"
                        ),
                        onChanged: (value){
                          phone=value;

                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(onPressed: () async{
                  String phoneNumber=countrycode.text+phone;
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: phoneNumber,
                    verificationCompleted: (PhoneAuthCredential credential) {

                    },
                    verificationFailed: (FirebaseAuthException e) {
                      // phoneNumber
                      // country
                    },
                    codeSent: (String verificationId, int? resendToken) {
                    // otp send successfully
                      MyPhone.verify=verificationId;
                      MyPhone.phoneNumber=phoneNumber;
                      if(resendToken!=null)
                      MyPhone.forceIdToken=resendToken;
                      Navigator.pushNamed(context, "otp");
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {

                  });
                }, child: Text('CONTINUE'),style: ElevatedButton.styleFrom(primary: Colors.green.shade600, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )
                ),),
              )

            ],
          ),
        ),
      ),
    );
  }
}
