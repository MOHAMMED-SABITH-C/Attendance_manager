// import 'dart:html';

import 'package:attendance/db_functions.dart';
import 'package:attendance/forgotPassword.dart';
import 'package:attendance/register.dart';
import 'package:attendance/splash.dart';
import 'package:attendance/subjects.dart';
import 'package:attendance/todayClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';


// import 'package:flutter_timetable/db/db_classD.dart';
// import 'package:flutter_timetable/db/db_model.dart';

// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginState();
}

class _loginState extends State<loginPage> {
    bool PasswordVisible = false;
    late String password ;
    late String name1;
  void initState(){
    super.initState();
    PasswordVisible = false;
  }

Future<SharedPreferences> _prefR = SharedPreferences.getInstance();

  final _userName =TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
var Mheight = MediaQuery.of(context).size.height*0.68;
var Mwidth = MediaQuery.of(context).size.width*0.84;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,title: Text('WELCOME',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 35),),),

      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.grey.withOpacity(0.5),
          ),
          height:Mheight ,
          width: Mwidth,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller:_userName ,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    label: Text('USER NAME'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(13)))
                  ),
                ),
              ),
////////////////////////////password hiding////////////////////
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  obscureText: PasswordVisible,
                  controller: _password,

                  decoration: InputDecoration(
                  suffixIcon:IconButton(onPressed: (){
                    setState(() {
                      PasswordVisible = !PasswordVisible;
                      
                    });
                  }, icon: Icon(!PasswordVisible ? Icons.visibility :Icons.visibility_off )),
                    prefixIcon: Icon(Icons.lock),
                    label: Text('Password'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(13)))
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>forgotPass()));
                },
              child:Text('Forgot password?',style: TextStyle(color: Colors.blue),)
              ),
              SizedBox(height: 20,),
              ElevatedButton(    
                    //////////////////button shadow//////////////////////
                style:ElevatedButton.styleFrom( 
                  shadowColor: Color.fromARGB(0, 0, 0, 0),
                  elevation: 10,
                    side: BorderSide(color: Color.fromARGB(255, 57, 19, 71)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                  ////////////////////////////////
                // ButtonStyle(shape: MaterialStateProperty.all(
                  // RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(50),
                    
                  // Shadow(color: Colors.black),
                  // ),
                // )
                ),
                  
                // )
                
                onPressed: (){
                //  Navigator.of(context).push(MaterialPageRoute(builder: ((context){

                //  return subjects();
                //  }))) ;
                  sendData();
                  if(_userName.text == '' || _password.text == '')
                  {

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior:SnackBarBehavior.floating,
                  backgroundColor: Colors.cyan,
                  margin:EdgeInsets.all(10),
                  content: Text("Please Enter Password or User Name",style: TextStyle(color: Colors.red),)
                  )
                          );
                      }
                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ListClasses()));
              }, child:Text('Login') ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text('Not a member?'),
                    //////////////////////link text on anything/////////////
                  InkWell(
                    child: Text(' Register now',style: TextStyle(color: Colors.blue),),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                        return RegisterU();
                      })));
                    },
                  ),
                ],
              )

            ],
          ) 
        
        ),
      ),
    );
  }

  sendData() async{
    late List<String> values;
    late int v;
     name1 = _userName.text.trim();
    // age = _txte2.text.trim();
     password = _password.text.trim();
    
  if(name1.isNotEmpty && password.isNotEmpty){
    await searchU(name1,password).then((value) => {
      if(value != ''){
        // print('notnull'),
        values =value.split(','),
        print(values[0]),
        v=int.parse(values[0].replaceFirstMapped('{id: ', (m) => '')),
      setSP(password,name1,v).whenComplete(() {

      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: ((context) {
                         return Today(id:v);
                              // return subjects(id:v);
                              
                        }),));
      })
      }else{
        // print('nullvalue'),
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior:SnackBarBehavior.floating,
                  backgroundColor: Colors.cyan,
                  margin:EdgeInsets.all(10),
                  content: Text("Please Enter valid Password No and User Name",style: TextStyle(color: Colors.red),)
                  )
                          )
      }
    });
  }
    
  }

  Future setSP(password,name,int id) async{
    final SharedPreferences sp = await _prefR;
 
    sp.setInt('attendance',75);
    sp.setInt('id', id);
    sp.setString('paswword', password);
    sp.setString('name', name);
  }
}
