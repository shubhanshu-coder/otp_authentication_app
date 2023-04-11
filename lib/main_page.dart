import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({Key? key}) : super(key: key);

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.image , size: 100,),
          SizedBox(
            height: 10,
          ),
          Text('Please Select your Language', style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(
            height: 20,
          ),

          Text('You can change the language at any time'),
        SizedBox(
          height: 20,
        ),
        Center(
          child: DropdownMenu(dropdownMenuEntries: [DropdownMenuEntry(value: "English", label: "English"),DropdownMenuEntry(value: "English-1", label: "English-1")],

              width: 250,
          hintText: "--Select Language--"),
        ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
            width: 250,
            child: ElevatedButton(child: Text ('NEXT',),onPressed: (){
              Navigator.pushNamed(context, 'phone');
            },
    style:ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10) , )
          )))
      ],),
    );
  }
}
