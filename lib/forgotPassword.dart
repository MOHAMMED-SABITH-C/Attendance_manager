import 'package:attendance/db_functions.dart';
import 'package:flutter/material.dart';

class forgotPass extends StatefulWidget {
  const forgotPass({super.key});

  @override
  State<forgotPass> createState() => _forgotPassState();
}

class _forgotPassState extends State<forgotPass> {
  final _college = TextEditingController();
  final _userN = TextEditingController();
  late String pass = '';
  // int value = 1;
  late int groupValue =1; 
  
  late String _password = 'Password';
  late String _user = 'User Name';
  List? list;

  @override
  Widget build(BuildContext context) {
    var Mheight = MediaQuery.of(context).size.height*0.68;
    var Mwidth = MediaQuery.of(context).size.width*0.84;
    return Scaffold(
      appBar: AppBar(title: Text('Restor'),centerTitle: true,),
      body: SafeArea(
        child:Center(child: 
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
          Text('Forgot User Name or Password?',textAlign: TextAlign.center,),
        
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                  SizedBox(width: Mwidth*0.11,),
                Radio(value: 1,
                 groupValue: groupValue,
                  onChanged: (value){
                    setState(() {
                      
                      groupValue = value!;
                    });
                      
                  },
                  
                  ),
                  Text('Password'),
                  SizedBox(width: Mwidth*0.15,),
                  Radio(value: 2,
                   groupValue: groupValue,
                    onChanged: (value){
                      setState(() {
                        groupValue = 2;
                      });
                    }),
                    Text('User Name'),
                  SizedBox(width: Mwidth*0.11,),
        
              ],
            ),
            groupValue == 1 ? TextFormField(
              controller: _userN,
              decoration: InputDecoration(
                label: Text('Name'),
                hintText: 'Enter User name'
              ),
        
            ):TextFormField(
              controller: _userN,
              decoration: InputDecoration(
                label: Text('Password'),
                hintText: 'Enter Password'
              ),
        
            ),
             TextFormField(
              controller: _college,
              decoration: InputDecoration(
                label: Text('Collage'),
                hintText: 'Enter college name'
              ),
        
            ),
            SizedBox(height: 30,),
            Text(groupValue == 1 ? _password  : _user),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              String college = _college.text.trim();
              String name = _userN.text.trim();
              groupValue == 1 ? searchpass(name,'', college).then((value){
                if(value != ''){
                  list =value.split(',');
                   pass = list![2].replaceFirstMapped('password: ',(m)=>'');
                  
                  setState(() {
                    _password = pass;
                  print('$pass yes it password');
                  });
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    
                    content:Text('Wrog Collage name or User Name ') ));
                }
              }):searchpass('',name, college).then((value){
                if(value != ''){
                  list =value.split(',');
                   pass = list![1].replaceFirstMapped('name: ',(m)=>'');

                  setState(() {
                    _password = pass;
                  print(pass);
                  });
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    
                    content:Text('Wrog Collage name or Password ') ));
                }
              });
            },
            
             child:Text('Restore') 
            )
          ],),
        ),)
      ),
    );
  }
}