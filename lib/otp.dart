import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_authentication_app/phone.dart';
import 'package:pinput/pinput.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({Key? key}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code="";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black,),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
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
              const SizedBox(
                height: 25,
              ),


              const Text('Please Enter Your mobile Number', style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold
              ),),
               Text('code send to ${MyPhone.phoneNumber}', style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold
              ),),
              const SizedBox(
                height: 10,
              ),
              const Text('We need to register your phone before getting started!.', style: TextStyle(
                fontSize: 16 ,
              ),
                textAlign: TextAlign.center,),
              const SizedBox(
                height: 30,
              ),
          Pinput(
            length: 6,
            showCursor: true,
            onChanged: (value){
              code=value;
            } ,
          ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async{
                    try{
                      PhoneAuthCredential credential =
                      PhoneAuthProvider.credential(verificationId: MyPhone.verify, smsCode: code);

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      Navigator.pushNamed(
                          context, "home");
                    }
                    catch(e){

                    }
                },
                  child: const Text('VERIFY AND CONTINUE'),style: ElevatedButton.styleFrom(primary: Colors.green.shade600, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )
                ),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed:() {
                  Navigator.pushNamed(context, 'phone');
                }, child: const Text('Edit Phone Number ?',
                  style: TextStyle(color: Colors.black),)),
                  TextButton(onPressed:() async{
                    await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: MyPhone.phoneNumber,
                        verificationCompleted: (PhoneAuthCredential credential) {

                        },
                        verificationFailed: (FirebaseAuthException e) {
                          // phoneNumber
                          // country
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          // otp send successfully
                          MyPhone.verify=verificationId;
                          if(resendToken!=null)
                          MyPhone.forceIdToken=resendToken;
                          Navigator.pushNamed(context, "otp");
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {

                        }, forceResendingToken: MyPhone.forceIdToken);
                  }, child: const Text('Resend code',
                    style: TextStyle(color: Colors.black),)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
