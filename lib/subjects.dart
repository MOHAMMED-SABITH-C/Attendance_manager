import 'package:attendance/addsubject.dart';
import 'package:attendance/calender2.dart';
// import 'package:attendance/calender.dart';
import 'package:attendance/db_functions.dart';
import 'package:attendance/db_model.dart';
import 'package:attendance/login.dart';
import 'package:flip_widget/flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

class subjects extends StatefulWidget {
     subjects({super.key,required this.id});
  late int id;
  late int prepercentage=75;
  DateTime dates = DateTime.now();
  @override
  State<subjects> createState() => _subjectsState();
}



const double _MinNumber = 0.008;
double _clampMin(double v){
  if(v<_MinNumber && v>-_MinNumber){
    if(v>=0){
      v=_MinNumber;
    }else{
      v=-_MinNumber;
    }
  }
  return v;
}

class _subjectsState extends State<subjects> {
  Future<SharedPreferences> _shrp =SharedPreferences.getInstance();
  void dispose(){
    String day = DateFormat('EEEE').format(widget.dates);
  print(day);
  getDaySub(widget.id,day);
    super.dispose();


  }
  late double percentage = 0.5624 ;
  late int perc=0;
  late int p =0;
  late int n = 0 ;
   List? _myActivities;
  late String _myActivitiesResult ;
  late String days;
  final formKey = new GlobalKey<FormState>();
    final _txtName = TextEditingController();
    final _txtId = TextEditingController();
    final _txtP = TextEditingController();
    final _txtA = TextEditingController();

    GlobalKey<FlipWidgetState> _flipKey = GlobalKey();
  Offset _oldPosition = Offset.zero;
  bool _visible = true; 
    
  void initState(){
    shared();
super.initState();
 getSub(widget.id);
  _myActivities =[];
      _myActivitiesResult='';
  }
  @override
  Widget build(BuildContext context) {
    Size size = Size(256,256);
    double mheight =MediaQuery.of(context).size.height;////////////781.0909090909091
   double mwidth =MediaQuery.of(context).size.width;/////////392.72727272727275
    return Scaffold(
      appBar: AppBar(title: Text('All Subjects'),centerTitle: true,
      actions: [IconButton(onPressed: (){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder:(context)=>loginPage() 
        ),(route)=>false);
      }, icon: Icon(Icons.exit_to_app))]),
      body:SafeArea(
        
        child:Visibility(
              child: GestureDetector(
                child: FlipWidget(
                  key:_flipKey,
                  textureSize: size*2,
        child:Stack(
          // isScrollControlled:true,
          children: [
            
              
            // SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left:18,right:18,bottom: 18,top: 50),
              child: ValueListenableBuilder(
                valueListenable: subjec,
                 builder: (BuildContext context,List<Subject> subjectsss,Widget? child) {
                  return ListView.builder(
                    itemBuilder: ((context,index){
                      
                  final data = subjectsss[index];  
                    p=data.p;
                    n=data.a+data.p;
                    // setState(() {
                      percentage = ((p/n));
                        perc=(percentage*100).floor();
                        // print('$perc  '+'  $percentage');

                        
                      if((percentage*100)>=perc+0.5)
                        perc++;
                     
                    // });
                    return FocusedMenuHolder(
                                openWithTap: true,
                                menuWidth: mwidth*.5, 
                      // height: 150,
                                        //      child:Icon(Icons.more_vert),
                              // IconButton(onPressed: (){}, icon: Icon(Icons.more_vert),),
                                //  onPressed: (){
        
                                //  },
                                  menuItems: [
                                       FocusedMenuItem(
                                      title: Text('Open Subject'),
                                      trailingIcon: Icon(Icons.open_in_new),
                                      // TextField(
                                      //   controller:_advisor ,
        
                                      // ),
                                       onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>CalendarPicker(id: widget.id, subId: data.subId, p: data.p, a: data.a))));//BottomBar(ClassId: data1.ClassId,id:widget.id))));//subjects(classId: data1.ClassId,)))); BottomBarCircleAn())));
                                       }),
                                    FocusedMenuItem(
                                      title: Text('Edit'),
                                      trailingIcon: Icon(Icons.edit),
                                     
                                       onPressed: (){
                                        showDialogField(data.subId,1,mheight*1.1,mwidth);
                                        // print('$mwidth haha $mheight');
                                       }),
        
                                       FocusedMenuItem(
                                        backgroundColor: Colors.red,
                                      title: Text('Delete Subject',style:TextStyle(color: Colors.white)),
                                      trailingIcon: Icon(Icons.delete,color: Colors.white,),
                                      // TextField(
                                      //   controller:_advisor ,
        
                                      // ),
                                       onPressed: (){

                                        //  getId();
                                         print('delete');
                                        // .whenComplete(
                                          
                                        // if(data1.ClassId != null && widget.id != null){
                                        deleSub(data.subId,widget.id);
                                        // }
                                        // );
                                       })
        
                                    ],
                                    onPressed: (){},
                      child:
                                 Card(
                        color: Colors.grey,
                        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child:Padding(
                          padding: const EdgeInsets.only(top:14.0,left:14.0,bottom: 14),
                          child: Row(children: [
                             Container(
                                  decoration: BoxDecoration(color: Color.fromARGB(255, 0, 0, 0).withAlpha(200),
                                  // backgroundBlendMode: BlendMode.color,
                                  borderRadius:BorderRadius.all(Radius.circular(8)) ),
                                  height: mheight*0.083,
                                  width: mwidth*0.19,
                                  alignment: Alignment.topCenter,
                                  child:Text('\n${data.subId}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)
                                   ),
                                   SizedBox(width: 13,),
                                    Container(
                                      // height: mheight*0.099,
                                      width: mwidth*0.41,
                                      // color: Colors.red,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(data.subjName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.black,) ,),
                                          SizedBox(height: 5,),
                                          Text('Attendance: $p/$n'),
                                        Text('Days:${data.days}'),
                                        ],
                                      ),
                                    ),
                                   SizedBox(width: 10,),
                                     Container(
                                width: 60,
                                height: 80,
                                // color:Colors.blue,
                                alignment: Alignment.center,
                                child: 
                                                    //  Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                                    //   children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom:0.0,top:1),
                                  // child: RotationTransition(
                                    // turns: AlwaysStoppedAnimation(0.25),
                                    child: CircularPercentIndicator(
                                      radius: 32,
                                      lineWidth: 9,
                                      percent: perc/100,
                                      backgroundColor: Colors.white,
                                      // rotateLinearGradient: true,
                                      circularStrokeCap: CircularStrokeCap.round,
                                      // progressColor:
                                      // linearGradient: LinearGradient(
                                      //   colors:[Colors.red,Colors.yellowAccent,Colors.greenAccent,Colors.green] 
                                        
                                      //   ),
                                      // animation: true,
                                      // animationDuration: 500,
                                      center: Text('${perc}%',style:TextStyle(fontWeight:FontWeight.bold) ,),
                                      progressColor: percentage < (widget.prepercentage)/250 ? const Color.fromARGB(255, 255, 0, 0):percentage < (widget.prepercentage)/150 ? Color.fromARGB(255, 235, 173, 18):percentage < (widget.prepercentage)/100 ? Color.fromARGB(255, 174, 255, 43): Color.fromARGB(255, 94, 255, 0),
                                    // ),
                                  ),
                                ),
                              //                         ],
                              // ),
                                                    ),
                                                    // IconButton(onPressed: (){

                                                    // }, icon: Icon(Icons.more_vert))

                          

                          ],),
                        ) 

                        // ListTile(
                        //   leading:  Container(
                        //         decoration: BoxDecoration(color: Color.fromARGB(255, 0, 0, 0).withAlpha(200),
                        //         // backgroundBlendMode: BlendMode.color,
                        //         borderRadius:BorderRadius.all(Radius.circular(8)) ),
                        //         // height: mheight*0.43,
                        //         width: mwidth*0.19,
                        //         alignment: Alignment.topCenter,
                        //         child:Text('\n${data.subId}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)
                        //          ),
                          
                        //   // Container(
                            
                        //   //   // height: 60,
                        //   //   child:
                        //   // //  Column(
                        //   // //   mainAxisAlignment: MainAxisAlignment.end,
                        //   // //   children: [
                        //   // //       // SizedBox(height: 10,),
                        //   // //       IconButton(
                        //   // //         alignment: Alignment.topLeft,
                        //   // //         onPressed: (){
                              
                        //   // //       }, icon: Icon(Icons.more_vert)),
                        //   //    Text(data.subId,textAlign: TextAlign.center,),
                        //   // //   ],
                        //   // // ),
                                
                        //   // ),
                        //   title:
                        //       Text(data.subjName),
                        //   titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                        //   textColor: Colors.black,

                        //   isThreeLine: true,
                        //   subtitle: Container(
                        //     // height: mheight*0.12,
                        //     // width: mwidth*0.01,
                        //     // color: Colors.red,
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //        Text('Attendance: $p/$n'),
                        //         Text('Days:${data.days}'),
                        //       ],
                        //     ),
                        //   ),
                        //   trailing:
                        //       Container(
                        //         width: 60,
                        //         height: 60,
                        //         color:Colors.blue,
                        //         alignment: Alignment.center,
                        //         child: 
                        //                             //  Row(
                        //                             //   mainAxisAlignment: MainAxisAlignment.end,
                        //                             //   children: [
                        //         Padding(
                        //           padding: const EdgeInsets.only(bottom:0.0,top:1),
                        //           child: CircularPercentIndicator(
                        //             radius: 30,
                        //             lineWidth: 8,
                        //             percent: percentage,
                        //             // rotateLinearGradient: true,
                        //             // animation: true,
                        //             // animationDuration: 500,
                        //             center: Text('${(percentage*100).floor()}%'),
                        //             progressColor: percentage < 0.2 ? const Color.fromARGB(255, 255, 0, 0):percentage < 0.5 ? Color.fromARGB(255, 235, 173, 18):percentage < 0.75 ? Color.fromARGB(255, 181, 251, 30): Color.fromARGB(255, 94, 255, 0),
                        //           ),
                        //         ),
                        //       //                         ],
                        //       // ),
                        //                             ),
                        // ),
                                
                      ),
                                    // )
                    );
            
                    }),
                      // separatorBuilder:((context,index){
            
                    // return Divider(height: 15,color: Colors.transparent,);
                    //   }),
                    itemCount:subjectsss.length ,
                  );
            
                  
                  
                 }
                 
                   
                 ),
            ),

               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   ElevatedButton.icon(
              onPressed: (){
                    print('poda');
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context){
                        return addsubject(id:widget.id);
                      }));
            }, icon: Icon(Icons.add), 
            label: Text('Add subject')),
                 ],
               ),
          ],
        ),
          leftToRight: true,
                ),
              onHorizontalDragStart:(details){
                _oldPosition = details.globalPosition;
                _flipKey.currentState?.startFlip();
              },
              onHorizontalDragUpdate: (details){
                Offset off = details.globalPosition - _oldPosition;
                double tilt = 1/_clampMin((-off.dy+20)/100);
                double percent = math.max(0,-off.dx/size.width*1.4);
                percent = percent - percent/2*(1-1/tilt);
                _flipKey.currentState?.flip(percent, tilt);
              },
              onHorizontalDragEnd: (details){
                Navigator.of(context).pop();//
                // push(MaterialPageRoute(builder: (context){return subjects(id: widget.id);}));
              //  Container(decoration: BoxDecoration(color:Colors.purple), child:Text('howare you '));
                _flipKey.currentState?.stopFlip();
              },
              onHorizontalDragCancel: () {
                _flipKey.currentState?.stopFlip();
              },
              ),
              visible: _visible,
            ),
           
           )
      // )
    );
  }

  void showDialogField(String _id,int a,double h,double w){
    // final _class = TextEditingController();
    // final _advisors =TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('$_id',textAlign: TextAlign.center,),
          content:Container( 
            height:h,
          // ListView(
            // shrinkWrap: true,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  
                  controller: _txtName,
                  decoration: InputDecoration(
                    
                    label: Text('Name'),
                    hintText: 'Subject Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                ),
                Flexible(flex:1,child: SizedBox(height: 30,)),
                TextFormField(
                  controller: _txtId,
                  decoration: InputDecoration(
                    label: Text('ID'),
                    hintText: 'Subject Id',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                )
                ,
                Flexible(child: SizedBox(height: 30,)),
                MultiSelectFormField(
                  // autovalidate: false ,
                  chipBackGroundColor: Color.fromARGB(195, 86, 86, 86),
                  chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Colors.blue,
                  checkBoxCheckColor: const Color.fromARGB(255, 255, 255, 255),
                  dialogShapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  title:Text('Days',style: TextStyle(fontSize: 15),),
                  dataSource: [
                    {
                      "display":'Monday',
                      "value":'Monday'
                    },
                    {
                      "display":'Tuesday',
                      "value":'Tuesday'
                    },
                    {
                      "display":'Wednesday',
                      "value":'Wednesday'
                    },
                    {
                      "display":'Thursday',
                      "value":'Thursday'
                    },
                    {
                      "display":'Friday',
                      "value":'Friday'
                    },
                    {
                      "display":'Saturday',
                      "value":'Saturday'
                    },
                    {
                      "display":'Sunday',
                      "value":'Sunday'
                    },
                    
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: Text('Choose Days'),
                  initialValue: _myActivities,
                  onSaved: (value){
                    if(value == null)return;
                      setState(() {
                        _myActivities = value;
                      });
                  },
                ),
                Flexible(child: SizedBox(height: 30,)),
                TextFormField(
                  controller: _txtP,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Present'),
                    hintText: 'Already Present',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                ),
                Flexible(child: SizedBox(height: 30,)),
                TextFormField(
                  controller: _txtA,
                  keyboardType:TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Absent'),
                    hintText: 'Already Absent',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                )
                ,
                Flexible(child: SizedBox(height: 30,)),
                ElevatedButton.icon(onPressed: (){
                  _myActivitiesResult = _myActivities.toString().replaceFirst(r'[', '');
                  String day =_myActivitiesResult.replaceAll(r' ', '');
                  days = day.replaceAll(r']','');
                  // for(int i=0;i<_myActivitiesResult.length;i++){
                  //   if(i==0)
                  //     days=+day[i].replaceFirst(r'[','');
                  //   else if(i==_myActivitiesResult.length-1)
                  //     days = + day[i].replaceFirst(']', '');
                  //   else
                  //     days = +day[i]
                    
                  // }
                  sentData(widget.id,_id).whenComplete((){
                    String day = DateFormat('EEEE').format(widget.dates);
                    getDaySub(widget.id,day);
                });
                  print(days);
                },
                 icon: Icon(Icons.add),
                  label: Text('Submit'))
              ],
            ),
           
          ),
         
        );
      },
    );
  }

  sentData(int id,subId)async{
// late int _id;
    // final SharedPreferences sp = await _pref;
    String name = _txtName.text.trim();
    String subIdc = _txtId.text.trim();
    String p = _txtP.text.trim();
    String A = _txtA.text.trim();
   
    if(subIdc != ''){
    await updates(id, subId, subIdc, '', '', '', '');
    subId=subIdc;
   } 
   if(name != ''){
    updates(id, subId, '', '', name, '', '');
   }

   if(p != ''){
    updates(id, subId, '', '', '', p, '');

   } if(A != ''){
    print(A);
    updates(id, subId, '', '', '', '', A);

   }if(days != ''){
    print(days);
    updates(id, subId, '', days, '', '', '');

   }
      //   if(sp.getInt('id')!= null){

      // _id= sp.getInt('id')!;
      //   }
        print('adding');
    // addsub(name,_id,subId,days,p,A);
    

  }
  Future<void>shared()async{
     
    final SharedPreferences sp = await _shrp;
    //  int cpercent=((present/total)*100).floor();
    setState(() {
      widget.prepercentage=sp.getInt('attendance')!=null?sp.getInt('attendance')!:100;
    });
  }
}