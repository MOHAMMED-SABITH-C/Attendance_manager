import 'package:attendance/login.dart';
import 'package:attendance/todayClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:shared_preferences/shared_preferences.dart';



class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _firstState();
}

class _firstState extends State<First> {
  Future<SharedPreferences> _shp = SharedPreferences.getInstance();
  @override
  void initState(){
      First1();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(actions: [],title: Text('welcome '),),
      body: Center(
        child:
         Image.asset('lib/images/load.gif',height: 200,),
      ),
    );
  }
  
  Future<void>First1()async{
    final SharedPreferences sp=await _shp;
    if(sp.getInt('id')!=null){
      Navigator.of(context ).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>Today(id: sp.getInt('id')!)));
    }else{
      Navigator.of( context ).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>loginPage()));
    }
  }
}