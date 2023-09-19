import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class settings1 extends StatefulWidget {
   settings1({super.key});
  late bool flag=true;
  

  @override
  State<settings1> createState() => _settings1State();
}

class _settings1State extends State<settings1> {
  Future<SharedPreferences> _pref= SharedPreferences.getInstance(); 
// Future<SharedPreferences> _prefR = SharedPreferences.getInstance();

  TextEditingController textEditingController=TextEditingController();
  late int rqattend = 65;
  initState(){

    super.initState();
    if(widget.flag==false){
      rqattend=0;
    }

   getatt(0,0).then((value){
    print(value);
    setState(() {

    rqattend=value>0?value:75;
      widget.flag=value>0?true:false;
    });
  });
  }
  @override
  Widget build(BuildContext context) {
    double Mwidth=MediaQuery.of(context).size.width*.88;
    return Scaffold(
      appBar: AppBar(actions: [],),
      body:SafeArea(
        child:Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                InkWell(
                  child:Column(
                    children: [
                      Card(
                        shadowColor: Colors.grey,
                        elevation: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))
                        ),
                        // color:Colors.black38 ,
                        child:Container(
                        height: 90,
                        width: Mwidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        color:Colors.grey,
                        ),
                        // Column(
                        //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                      child:Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Required Attendance\n$rqattend %",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          // Container(
                            // child: 
                            CupertinoSwitch(value:widget.flag, 
                            trackColor: Colors.black.withAlpha(100),
                            activeColor: const Color.fromARGB(255, 1, 255, 10),
                            onChanged:(value){
                              setState(() {
                                widget.flag==false?dialog():widget.flag=false;
                                if(widget.flag==false)
                                  getatt(1, 0);
                                // widget.flag=widget.flag==true?false:true;
                              });
                            },),
                            // decoration: BoxDecoration(
                            //   shape: BoxShape.circle,
                            //   boxShadow: [
                            //     BoxShadow(
                            //       color: Colors.black.withOpacity(.51),
                            //       spreadRadius: 5,
                            //       blurRadius: 10,
                            //       offset: Offset(0, 1)
                            //     )
                            //   ]
                            // ),
                          // )
                        // IconButton(
                        //   onPressed: (){
                        //     setState(() {
                        //       widget.flag=widget.flag==1?0:1;
                        //       rqattend=widget.flag;
                        //     });
                  
                        //   },
                        //   icon:widget.flag ==0? Icon(Icons.toggle_off_outlined,size: 45,color:Color.fromARGB(255, 0, 0, 0),shadows: [
                        //     Shadow(color: Colors.black26,blurRadius: 8)
                        //   ],):Icon(Icons.toggle_on_rounded,size: 45,color: Color.fromARGB(255, 2, 135, 236),fill: .5,shadows: [
                        //     Shadow(color: Colors.black,blurRadius: 8)
                        //   ])
                          
                        //   ),
                          
                      ],),
                        )
                        //   Text(rqattend.toString()+"%")
                        // ],),
                      )
                  
                    ],
                  ),
                  onTap: (){
                    dialog();
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> dialog()));
                  },
          
                ),
              ],
            ),
          ),
        ) 
      )
    ) ;
  }

  Future<void> dialog() async{
    return showDialog(
      context: context,
       builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Required Attendance"),
          content: SingleChildScrollView(
            child: ListBody(children: [
              TextField(
                controller: textEditingController,
                maxLength: 2,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Percentage',
                  hintText:'Number Between 1-99',
                  labelStyle: TextStyle(color: Colors.cyan, fontSize: 20),
                ),
                keyboardType: TextInputType.number,
                // inputFormatters: [
                //   NumericRangeFormatter(min:1,max:100)
                // ],
              )
            ]),
          ),
          backgroundColor: Colors.white,
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Close')),
                TextButton(onPressed: (){
                  setState(() {
                    widget.flag=true;
                    rqattend=int.parse(textEditingController.text.trim());
                    Navigator.of(context).pop();
                  });
                  getatt(1,rqattend);
                }, child: Text("Ok")),
              ],
            ),
          ],
        );
       }
       );
  }

  Future<int>getatt(int type,int val)async{
    final SharedPreferences ShP=await _pref;
    int attend;
    if(type==0){

     attend = ShP.getInt('attendance')!=null? ShP.getInt('attendance')!:0;
    }else if(val==0){
      ShP.setInt('attendance',100);
      attend=val;
    }else{
      ShP.setInt('attendance', rqattend);
      attend=rqattend;
    }
    return attend;
  }
}