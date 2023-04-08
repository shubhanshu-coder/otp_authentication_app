import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {

  TextEditingController countrycode= TextEditingController();
  var phone="";


  @override
  void initState() {
    // TODO: implement initState
    countrycode.text="+91";
    super.initState();
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
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (value){
                          phone = value;
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
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '+44 7123 123 456',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {},
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                  // Navigator.pushNamed(context, "otp");
                }, child: Text('Send the code'),style: ElevatedButton.styleFrom(primary: Colors.green.shade600, shape: RoundedRectangleBorder(
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
