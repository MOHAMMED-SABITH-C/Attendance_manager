

// import 'package:attendance/calender.dart';
import 'package:attendance/db_functions.dart';
import 'package:attendance/db_model.dart';
import 'package:attendance/login.dart';
import 'package:attendance/settings.dart';
import 'package:attendance/subjects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
// import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flip_widget/flip_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

class Today extends StatefulWidget {
   Today({super.key,required this.id});
   late int id;
   late int prep=75;

  DateTime dates = DateTime.now();
  // String day = DateFormat('EEEE').format(dates);

  @override
  State<Today> createState() => _TodayState();
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

class _TodayState extends State<Today> {
  Future<SharedPreferences> _shrp = SharedPreferences.getInstance();
  ScrollController _Scrollcontroller = ScrollController();
  GlobalKey<FlipWidgetState> _flipKey = GlobalKey();
  Offset _oldPosition = Offset.zero;
  bool _visible = true; 
  late double percentage = 0.5624 ;
  late int p =0;
  late int a = 0;

  // List<NeatCleanCalendarEvent> todaysEvent =[ ];

  // final List<NeatCleanCalendarEvent> _eventList = [
  //   NeatCleanCalendarEvent('Present',
  //    startTime: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,10,0),
  //     endTime: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,12,0),
  //     color: Colors.green,
  //     isMultiDay: true
  //     ),
  //     NeatCleanCalendarEvent('Absent',
  //    startTime: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,14,0),
  //     endTime: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,16,0),
  //     color: Colors.green,
  //     isMultiDay: true
  //     ),
  //     NeatCleanCalendarEvent('No Class',
  //    startTime: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,10,0),
  //     endTime: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,12,0),
  //     color: Colors.green,
  //     isMultiDay: true
  //     ),
  // ];



  // late bool flag = false;
  //  EventList<Event> _markedDate = EventList<Event>(events: {
    
  // });
  late List<String> subList =[]; 
  late String suid='';
  int i=0;
  void initState(){
    super.initState();
    getSub(widget.id).then((value) {
      print(value.toString()+'i[ppo hen]');
      value.forEach((map){
        final obj = Subject.fromMap(map);
        suid +=obj.subId;
        if(i+1<value.length)
          suid +=',';
        print(suid);
        // subList[i] = obj.subId;
        // .add(obj.subId);
        i++; 
      });
  String day = DateFormat('EEEE').format(widget.dates);
  print(day+'initstate');
  getDaySub(widget.id,day);
    subList = suid.split(',');
    });
    print(i.toString()+'hayo'+subList.toString());
  }
    final Lday = (DateTime.now().toString()).split(' ')[0].split('-');

  @override
  Widget build(BuildContext context) {
  String dates = widget.dates.toString();
  final list = dates.split(' ')[0];
    Size size = Size(256,256);
  String day = DateFormat('EEEE').format(widget.dates);
  print(day);
  getDaySub(widget.id,day);
double mheight =MediaQuery.of(context).size.height;////////////781.0909090909091
   double mwidth =MediaQuery.of(context).size.width;
    return Scaffold(
        // backgroundColor :Colors.red,
       appBar: AppBar( title: Text("Today Classes"),centerTitle: true,
        actions: [IconButton(onPressed: (){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder:(context)=>loginPage() 
        ),(route)=>false);
      }, icon: Icon(Icons.exit_to_app)),
      ],
      // leading:
      // IconButton(onPressed: (){
      //   Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context)=>
      //   settings1()
      //     )
      //   );
      // }, icon: Icon(Icons.settings),
      // )

      // drawer
      ),
      // UserAccountsDrawerHeader(accountName: Text(""),),
      drawer: Drawer(backgroundColor: Colors.cyan,
      
         child: Padding(padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          // SizedBox(height: 10,),
          // ListTile(trailing:IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.close)) ,),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.close))],),
          InkWell(
              
          child:ListTile(
            // style:ListTileStyle
            // .drawer,
             tileColor: Colors.white,
            // iconColor:Colors.white,
            
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
              leading:     
             Text("Settings"),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>settings1()));
            },
          trailing: IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>settings1()));
          }, icon: Icon(Icons.settings)),
          ),
          ),
          SizedBox(height: 20,),
          InkWell(
            borderRadius: BorderRadius.circular(50),
            
            
            child:
          ListTile(
            tileColor: Colors.white,
            // iconColor:Colors.white,
            shape:RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(10)
            ),
              leading:     
             Text("All Classes"),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>subjects(id:widget.id)));
            },
          trailing: IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>subjects(id: widget.id)));
          }, icon: Icon(Icons.menu_book_sharp)),
          
          ),
          ),
        ],
      ),
          )
      )
      ,
      body:SafeArea(
        child:
        // Stack(
        //   children: [

            Visibility(
              child: GestureDetector(
                child: FlipWidget(
                  key:_flipKey,
                  textureSize: size*2,
                  child: Stack(
                    // isScrollControlled:true,
                    children: [
                      
                        
                      // SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.only(left:18,right:18,bottom: 18,top: 50),
                        child: ValueListenableBuilder(
                          valueListenable: subj,
                           builder: (BuildContext context,List<Subject> subjectsss,Widget? child) {
                            return ListView.builder(
                              itemBuilder: ((context,index){
                                
                            final data = subjectsss[index];  
                              p=data.p;
                              a=data.a;
                              // +data.p;
                              // setState(() {
                                percentage = (p/(a+p));
                              
                              // });
                              return //flag == true ? 
                              // FocusedMenuHolder(
                              //             openWithTap: true,
                              //             menuWidth: mwidth*.5, 
                              //   // height: 150,
                              //                     //      child:Icon(Icons.more_vert),
                              //           // IconButton(onPressed: (){}, icon: Icon(Icons.more_vert),),
                              //             //  onPressed: (){
                  
                              //             //  },
                              //               menuItems: [
                              //                 FocusedMenuItem(
                              //                   title: Text('Edit'),
                              //                   trailingIcon: Icon(Icons.edit),
                                               
                              //                    onPressed: (){
                              //                     showDialogField(data.subId,1,mheight*1.1,mwidth);
                              //                     // print('$mwidth haha $mheight');
                              //                    }),
                  
                              //                   //  FocusedMenuItem(
                              //                   // title: Text('Open Class'),
                              //                   // trailingIcon: Icon(Icons.open_in_new),
                              //                   // // TextField(
                              //                   // //   controller:_advisor ,
                  
                              //                   // // ),
                              //                   //  onPressed: (){
                              //                   //   // Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>BottomBar(ClassId: data1.ClassId,id:widget.id))));//subjects(classId: data1.ClassId,)))); BottomBarCircleAn())));
                              //                   //  }),
                              //                    FocusedMenuItem(
                              //                     backgroundColor: Colors.red,
                              //                   title: Text('Delete Subject',style:TextStyle(color: Colors.white)),
                              //                   trailingIcon: Icon(Icons.delete,color: Colors.white,),
                              //                   // TextField(
                              //                   //   controller:_advisor ,
                  
                              //                   // ),
                              //                    onPressed: (){
                
                              //                     //  getId();
                              //                      print('delete');
                              //                     // .whenComplete(
                                                    
                              //                     // if(data1.ClassId != null && widget.id != null){
                              //                     // deleSub(data.subId,widget.id);
                              //                     // }
                              //                     // );
                              //                    })
                  
                              //                 ],
                              //                 onPressed: (){},
                              //   child:
                                           InkWell(
                                            onTap: (){
                                              // print('hahhhahahh');
                                              // updates(widget.id, 'CD', '', '', '', '', 15.toString());
                                              // Navigator.of(context).push(
                                              //   MaterialPageRoute(builder: ((context){
                                            // getAtt(widget.id, data.subId, day, '');

                                              //     return  
                                              //     CalendarPicker(id: widget.id, subId: data.subId, p: p, a: data.a);
                                                  showEditField(data.a, p, data.subId, list, mheight, mwidth);
                                                // })
                                                // )
                                              // );
                                            },
                                             child: Card(
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
                                                      Text('Attendance: $p/${a+p}'),
                                                    // Text('Days:${data.days}'),
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
                                              child: CircularPercentIndicator(
                                                radius: 32,
                                                lineWidth: 9,
                                                percent: percentage,
                                                // rotateLinearGradient: true,
                                                // animation: true,
                                                // animationDuration: 500,
                                                center: Text('${(percentage*100).floor()}%',style:TextStyle(fontWeight:FontWeight.bold) ,),
                                                progressColor: percentage < (widget.prep)/250 ? const Color.fromARGB(255, 255, 0, 0):percentage < (widget.prep)/150 ? Color.fromARGB(255, 235, 173, 18):percentage < (widget.prep)/100  ? Color.fromARGB(255, 174, 255, 43): Color.fromARGB(255, 94, 255, 0),
                                              ),
                                                                                     ),
                                                                                   //                         ],
                                                                                   // ),
                                                                ),
                                                                // IconButton(onPressed: (){
                                                           
                                                                // }, icon: Icon(Icons.more_vert))
                                                           
                                                                               
                                                           
                                                                               ],),
                                                                             // ) 
                                                           
                                                                            
                                                                           ),
                                                // )
                                                                         ),
                                                                         
                                           );
                      
                              }),
                
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
                          i=0;
                          suid = '';
                          getSub(widget.id).then((value) {
      print(value.toString()+'i[ppo hen]');
      value.forEach((map){
        final obj = Subject.fromMap(map);
        suid +=obj.subId;
        if(i+1<value.length)
          suid +=',';
        print(suid);
        // subList[i] = obj.subId;
        // .add(obj.subId);
        i++; 
      });
    subList = suid.split(',');
    });
                              print('poda');
                                              showBottomSheet( context, mwidth,day);
                                attt.value.clear();
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(builder: (context){
                                //   return addsubject(id:widget.id);
                                // }));
                      }, icon: Icon(Icons.add), 
                      label: Text('Add Extra Class')),
                           ],
                         ),
              //  Container(decoration: BoxDecoration(color:Colors.purple), child:Text('howare you ')),

                    ],
                  ),
                  leftToRight: false,
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
              
              onHorizontalDragCancel: () {
                // Navigator.of(context).pop();//push(MaterialPageRoute(builder: (context){return subjects(id: widget.id);}));

                _flipKey.currentState?.stopFlip();
              },
            //  onHorizontalDragCancel != null ? 
             onHorizontalDragEnd: (details){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){return subjects(id: widget.id);}));
              //  Container(decoration: BoxDecoration(color:Colors.purple), child:Text('howare you '));
                _flipKey.currentState?.stopFlip();
              },
              
              // onHorizontalDragCancel != null? 
              
              ),
              visible: _visible,
            ),

        //   ],
        // )
      ),
    );
  }

  void showEditField(int a,int p,String subId,String day,double h,double w){
    getAtt(widget.id, subId, day, '');
    String dayy = DateFormat('EEEE').format(widget.dates);
  print(dayy);
  // getDaySub(widget.id,dayy);
    print(int.parse(Lday[2]));
   late String d = day+''+DateTime.now().toString().split(' ')[1];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          title:  Text('${subId}',textAlign: TextAlign.center,),
          content:Container( 
            height:h*0.3,
            width: w,
          // ListView(
            // shrinkWrap: true,
            child: Column(children: [

              Text('Set or Reset Attendance for ${subId} '),
              Container(
                // color: Colors.red,
                height: 150,
                width: w*0.42,
                child:ValueListenableBuilder(
                  valueListenable:attt ,
                   builder: (BuildContext context, List<Attend> attend,Widget? child) {
                    return ListView.separated(
                      itemBuilder: (context,index){

                    final data = attend[index];
                    return  Card(
                      color:data.status == 'Present' ? Colors.green:Colors.red,
                      child: ListTile(
                        title: Text('${data.status}'),
                        trailing: IconButton(onPressed: (){
                          setState(() {
                            if(data.status == 'Present')
                              p-=1;
                            else{
                              a-=1;
                            }
                          });
                          data.status == 'Present' ? 
                    updates(widget.id, subId, '', '', '', (p).toString(), ''):
                    updates(widget.id, subId, '', '', '', '', a.toString());

                          deleteAttend(data.id,data.subId,data.day,data.status);
                      //     _markedDate.remove(
                      // DateTime(int.parse(day.split('-')[0]),int.parse(day.split('-')[1]),int.parse(day.split('-')[2])),
                      // Event(date: DateTime(int.parse(Lday[0]),int.parse(Lday[1]),int.parse(Lday[2])),
                      // title:'Present',
                      // dot:Container(
                      //   margin:EdgeInsets.symmetric(horizontal: 1),
                      //   color:Color.fromARGB(255, 255, 0, 0),
                      //   height: 5,
                      //   width: 5,
                      // )
                      
                      // )
                      // );
                        }, icon: Icon(Icons.close)),
                      ),
                    );
                    },
                     separatorBuilder: ((context,index){
                      return Divider(height: 5,);
                     }),
                      itemCount: attend.length
                      );
                     
                   })
                   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){
                    d = day+' '+(DateTime.now().toString()).split(' ')[1];
                    print(d);
                    // setState(() {
                      
                    p +=1;
                    // });
                    updates(widget.id, subId, '', '', '', p.toString(), '');
                    addAttend(widget.id,subId,d,'Present');
                      // _markedDate.remove(date, event)
                    // _markedDate.add(
                    //   DateTime(int.parse(day.split('-')[0]),int.parse(day.split('-')[1]),int.parse(day.split('-')[2])),
                    //   Event(date: DateTime(int.parse(Lday[0]),int.parse(Lday[1]),int.parse(Lday[2])),
                    //   title:'Present',
                    //   dot:Container(
                    //     margin:EdgeInsets.symmetric(horizontal: 1),
                    //     color:Color.fromARGB(255, 255, 0, 0),
                    //     height: 5,
                    //     width: 5,
                    //   )
                      
                    //   )
                    //   );
                  //     event.forEach((map) {
                  //   final obj = Attend.fromMap(map);
                  //   attt.value.add(obj);
                  //   attt.notifyListeners();
                  // });
                    getDaySub(widget.id, dayy);
                    Navigator.of(context).pop();
                  },
                   child: Text('Present')),
                   ElevatedButton(onPressed: (){
                    d = day+' '+(DateTime.now().toString()).split(' ')[1];
                    print(d);
                    // setState(() {
                      
                    a +=1;
                    // });
                    updates(widget.id, subId, '', '', '', '', a.toString());
                    addAttend(widget.id,subId,d,'Absent');
                    // _markedDate.add(
                    //   DateTime(int.parse(day.split('-')[0]),int.parse(day.split('-')[1]),int.parse(day.split('-')[2])),
                    //   Event(date: DateTime(int.parse(day.split('-')[0]),int.parse(day.split('-')[1]),int.parse(day.split('-')[2])),
                    //   title:'Absent',
                    //   dot:Container(
                    //     margin:EdgeInsets.symmetric(horizontal: 1),
                    //     color:Colors.red,
                    //     height: 5,
                    //     width: 5,
                    //   )
                      
                    //   )
                    //   );
                    // getDaySub(widget.id, day);
                    getDaySub(widget.id,dayy);

                    Navigator.of(context).pop();

                  },
                   child: Text('Absent')),
                  //  ElevatedButton(onPressed: (){
                  //   widget.p +=1;
                  //   updates(widget.id, widget.subId, '', '', '', widget.p.toString(), '');
                  //   Navigator.of(context).pop();
                    
                  // },
                  //  child: Text('Reset')),
                ],
              )
            ]),
           
          ),
         
        );
      },
    );
  }


  Future <void> showBottomSheet(BuildContext context,double mwidth,String _day) async{
 String days = DateFormat.MMMEd().format(widget.dates);
 late String dattt = (widget.dates.toString()).split(' ')[0];
//  late int p,a;
 late String sub=' ';
 late String d = dattt+' '+DateTime.now().toString().split(' ')[1];
 print(subList);
//  late int _value;
showModalBottomSheet(
  
  isScrollControlled: true,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
  ),
    context: context, 
    builder: ((context) {
      return 
  Container(
  height:250,
    child: Padding(
      // ///////////////////////////////////////for 
      padding:  EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom,left: 18,right: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
  
          Flexible(child: Text('$days\nAdd Extra Class',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,)),
          DropdownButtonFormField(
            hint: Text('Select Subject'),
            items: 
            subList.map((e) {
              return DropdownMenuItem(
                value: e,
                
                child: Text(e)
                );
            })
            .toList(), 
          borderRadius: BorderRadius.circular(20),
            onChanged:( values){
              _Scrollcontroller.animateTo(_Scrollcontroller.position.maxScrollExtent,curve: Curves.easeOut,duration: Duration(milliseconds: 300));
              getstatus(widget.id, values!).then((data){
              setState(() {
              print(data + 'hoangane');
                // p=int.parse(data.split(',')[0]);
                // a = int.parse(data.split(',')[1]);
                sub = values;
                getAtt(widget.id, values, (widget.dates.toString()).split(' ')[0], ' ');
              // da = value!;
              });
              // print(a);
              });
            }),
           

              Text('Set or Reset Attendance for ${sub} '),
              Container(
                // color: Colors.red,
                height: 50,

                width: double.infinity,
                child:ValueListenableBuilder(
                  valueListenable:attt ,
                  
                   builder: (BuildContext context, List<Attend> attend,Widget? child) {
                    return ListView.builder(
                      controller: _Scrollcontroller,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){

                    final data = attend[index];
                    print(data);
                    return  Container(
                      width: 197,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // shape: BoxShape.circle
                      color:data.status == 'Present' ? Colors.green:Colors.red,
                  ),
                      // height: 100,
                      child: ListTile(
                        title: Text('${data.status}'),
                        trailing: IconButton(onPressed: (){
                          setState(() {
                            if(data.status == 'Present')
                              p-=1;
                            else{
                              a-=1;
                            }
                          });
                          data.status == 'Present' ? 
                    updates(widget.id, sub, '', '', '', (p).toString(), ''):
                    updates(widget.id, sub, '', '', '', '', a.toString());

                          deleteAttend(data.id,data.subId,data.day,data.status);
                      //     _markedDate.remove(
                      // DateTime(int.parse(Lday[0]),int.parse(Lday[1]),int.parse(Lday[2])),
                      // Event(date: DateTime(int.parse(Lday[0]),int.parse(Lday[1]),int.parse(Lday[2])),
                      // title:'Present',
                      // dot:Container(
                      //   margin:EdgeInsets.symmetric(horizontal: 1),
                      //   color:Color.fromARGB(255, 255, 0, 0),
                      //   height: 5,
                      //   width: 5,
                      // )
                      
                      // )
                      // );
                        }, icon: Icon(Icons.close)),
                      ),
                    );
                    },
                    //  separatorBuilder: ((context,index){
                    //   return Divider(height: 5,);
                    //  }),
                      itemCount: attend.length
                      );
                     
                   })
                   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){

                    d = dattt+' '+(DateTime.now().toString()).split(' ')[1];
                    print(d);
                    setState(() {
                      
                    p +=1;
                    });
                    updates(widget.id, sub, '', '', '', p.toString(), '').whenComplete((){

                    addAttend(widget.id,sub,d,'Present');
                    getDaySub(widget.id,_day);
                    });
                      // _markedDate.remove(date, event)
                    // _markedDate.add(
                    //   DateTime(int.parse(Lday[0]),int.parse(Lday[1]),int.parse(Lday[2])),
                    //   Event(date: DateTime(int.parse(Lday[0]),int.parse(Lday[1]),int.parse(Lday[2])),
                    //   title:'Present',
                    //   dot:Container(
                    //     margin:EdgeInsets.symmetric(horizontal: 1),
                    //     color:Color.fromARGB(255, 255, 0, 0),
                    //     height: 5,
                    //     width: 5,
                    //   )
                      
                    //   )
                    //   );
                  //     event.forEach((map) {
                  //   final obj = Attend.fromMap(map);
                  //   attt.value.add(obj);
                  //   attt.notifyListeners();
                  // });

                    // Navigator.of(context).pop();
              _Scrollcontroller.animateTo(_Scrollcontroller.position.maxScrollExtent,curve: Curves.easeOut,duration: Duration(milliseconds: 300));

                  },
                   child: Text('Present')
                   ),


                   ElevatedButton(onPressed: (){
                    d = dattt+' '+(DateTime.now().toString()).split(' ')[1];
                    print(d);
                    setState(() {
                      
                    a +=1;
                    });
                    updates(widget.id, sub, '', '', '', '', a.toString());
                    addAttend(widget.id,sub,d,'Absent');
                    // _markedDate.add(
                    //   DateTime(int.parse(Lday[0]),int.parse(Lday[1]),int.parse(Lday[2])),
                    //   Event(date: DateTime(int.parse(Lday[0]),int.parse(Lday[1]),int.parse(Lday[2])),
                    //   title:'Absent',
                    //   dot:Container(
                    //     margin:EdgeInsets.symmetric(horizontal: 1),
                    //     color:Colors.red,
                    //     height: 5,
                    //     width: 5,
                    //   )
                      
                    //   )
                    //   );
                    // Navigator.of(context).pop();
  getDaySub(widget.id,_day);

              _Scrollcontroller.animateTo(_Scrollcontroller.position.maxScrollExtent,curve: Curves.easeOut,duration: Duration(milliseconds: 300));

                  },
                   child: Text('Absent')),
                  //  ElevatedButton(onPressed: (){
                  //   widget.p +=1;
                  //   updates(widget.id, widget.subId, '', '', '', widget.p.toString(), '');
                  //   Navigator.of(context).pop();
                    
                  // },
                  //  child: Text('Reset')),
                ],
              )
            
      ],),
    ),
  );
    }
  ));
  }
   Future<void>shared()async{
     
    final SharedPreferences sp = await _shrp;
    //  int cpercent=((present/total)*100).floor();
    setState(() {
      widget.prep=sp.getInt('attendance')!=null?sp.getInt('attendance')!:100;
    });
  }
}