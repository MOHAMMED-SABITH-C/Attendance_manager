import 'package:attendance/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class first extends StatefulWidget {
  const first({super.key});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  @override
  void initState(){
      gotoLogin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(actions: [],title: Text('welcome '),),
      body: Center(
        child: Image.asset('lib/images/contacts.png',height: 200,),
      ),
    );
  }
  
  Future<void> gotoLogin()async{
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>loginPage()
    ));
  }
}