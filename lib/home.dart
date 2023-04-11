

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:otp_authentication_app/main_page.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int selected=-1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Please select your profile', style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold
          ),),
          SizedBox(
            height: 20,
          ),
          InkWell(child: someWidget(Icons.home, "Shipper", "Lorem ipsum dolor sit amet, \nconsectetur adipiscing",selected==0),
          onTap: (){
            setState(() {
              selected=0;
            });
            // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyMainPage()));
          },), //0
          const SizedBox(height: 10,),
          InkWell(child: someWidget(Icons.bus_alert, "Transporter", "Lorem ipsum dolor sit amet, \nconsectetur adipiscing",selected==1),
          onTap: (){
            setState(() {
              selected=1;
            });
          },),
          SizedBox(
              height: 30,
              width: 250,
              child: ElevatedButton(child: Text ('CONTINUE', style: TextStyle(fontSize: 20),),onPressed: (){
                // Navigator.pushNamed(context, 'phone');
              },
                  style:ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10) , )
                  )))//1
      ],),

    );
  }
}
Widget someWidget(
  IconData icon,
  String title,
  String description,
    bool isSelected,
    )
{
  return  Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(border: Border.all(color: Colors.black),),
    child: Row(
      children: [
        Spacer(flex: 1,),
         isSelected?
         Icon(Icons.radio_button_checked):Icon(Icons.radio_button_off),
        Spacer(flex: 1,),
        Icon(icon,size: 50,),
        Spacer(flex:1),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: TextStyle(fontSize: 15),),
            const SizedBox(height: 10,),
            Text(description,style: TextStyle(fontSize: 12),),
          ],)
        ,Spacer(flex:4),
      ],),
  );
}