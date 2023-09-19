import 'package:attendance/db_functions.dart';
import 'package:attendance/db_model.dart';
// import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPicker extends StatefulWidget {
   CalendarPicker({super.key,required this.id,required this.subId,required this.p,required this.a});
   late int id;
   late String subId;
   late int p;
   late int a;
   late int total=a+p;
   late int perc=((p/total)*100).floor();
   late int per=100;

      
  //  late int reqclass;
  late String text=" ";

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  Future<SharedPreferences> _shp=SharedPreferences.getInstance();
      MeetingDataSource? events;
  Meeting? _selectedAppointment;

  late DateTime dates ;
  late String dates1;
  late DateTime selectedDate = DateTime.now();
  late String DateT = DateFormat.yMMM().format(selectedDate);
  late List<Meeting> meetings=<Meeting>[];
    late DateTime _prevmonth;
  void initState(){
    print('${widget.id}  '+ ' ${widget.subId}');
     _prevmonth=DateTime.now();

    setState(() {
      _selectedAppointment=null;
     meetings = <Meeting>[];
      
      widget.perc=((widget.p/widget.total)*100).floor();
                       
    });
    // getAttendance(widget.id, widget.subId).then((value) {
    //   if(value!=null){
        
    //   value.forEach((map){
    //     final datas= Attend.fromMap(map);
    //     _addDataSource(datas.status, DateTime.parse(datas.day));
       
    // });
    //   }
    //   });
    getDatawithDate(selectedDate);
    events = MeetingDataSource(meetings); //_getCalendarDataSource();
    super.initState();
    // getDatawithDate(selectedDate);
  }
  @override
  Widget build(BuildContext context) {
   
        shared(widget.p,widget.total);
    

    final double Mheight = MediaQuery.of(context).size.height;
    final double Mwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(actions: [],title: Text('${widget.subId}'),centerTitle: true,),
      body:
      // SafeArea(
        
      //     child:
          Column(
            children: [
            Padding(
              padding: const EdgeInsets.only(left: 0,right: 0),
              child: Container(
                decoration: BoxDecoration(
                color:Colors.blue,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
                ),
                height: Mheight*0.4 ,
                width: Mwidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    SizedBox(height: 13,),
                  Row(
                    children: [
                      IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
                        Navigator.of(context).pop();
                      },alignment: Alignment.bottomLeft,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left:(Mwidth/2)-70),
                        child: Text(widget.subId,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),

                    Row(
                      children: [
                        Padding(
                                      padding: const EdgeInsets.only(bottom:0.0,top:11,left: 30),
                                      // child: RotationTransition(
                                        // turns: AlwaysStoppedAnimation(0.25),
                                        child: CircularPercentIndicator(
                                          radius: 99,
                                          lineWidth: 19,
                                          percent: widget.perc/100,
                                          backgroundColor: Colors.white,
                                          // rotateLinearGradient: true,
                                          circularStrokeCap: CircularStrokeCap.round,
                                          // progressColor:
                                          // linearGradient: LinearGradient(
                                          //   colors:[Colors.red,Colors.yellowAccent,Colors.greenAccent,Colors.green] 
                                            
                                          //   ),
                                          // animation: true,
                                          // animationDuration: 500,
                                          center: Text('${widget.perc}%',style:TextStyle(fontWeight:FontWeight.bold,fontSize: 50) ,),
                                          progressColor:  (widget.p/widget.total) < (widget.per)/250 ? const Color.fromARGB(255, 255, 0, 0):(widget.p/widget.total) < (widget.per)/150 ? Color.fromARGB(255, 235, 173, 18):(widget.p/widget.total) < (widget.per)/100  ? Color.fromARGB(255, 174, 255, 43): Color.fromARGB(255, 94, 255, 0),
                                        // ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Container(
                                        child: 
                                          Text("Present: ${widget.p}\n\nAbsent: ${widget.a}\n\nTotal: ${widget.total}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                          // Text(""),
                                          // Text("")
                                       
                                      ),
                                    )
                      ],
                    ),
                                SizedBox(height: 20,),
                  Center(child: Text(widget.text,style: TextStyle(fontSize: 18),))
                  ]
                ),
            
              ),
            ),
            // Text('${widget.subId}',textAlign: TextAlign.end,style: TextStyle(fontSize: 25),),
            Container(
              height: Mheight - Mheight*0.4 - 29,
              decoration: BoxDecoration(
                // border: 
              ),
              // child: CrCalendar(
              //   controller: _controller,
              //  initialDate: DateTime.now(),
              child:SfCalendar(
                // controller: _controller,
                view: CalendarView.month,
                showNavigationArrow: true,
                onViewChanged:(ViewChangedDetails details){
                  DateTime _currentMonth =details.visibleDates[0];
                  if(_prevmonth.month!=_currentMonth.month){
                    print('${_currentMonth} 0');
                  // setState(() {
                    meetings=[];
                 getDatawithDate(selectedDate);
    //              .whenComplete((){

    events = MeetingDataSource(meetings);
                //  });
                  _prevmonth=_currentMonth;
                  // });
                  }
                },
                dataSource: events,//MeetingDataSource(meetings),
          //       selectionDecoration: BoxDecoration(
          //   color: Colors.transparent,
          //   border: Border.all(color: Colors.red, width: 2),
          //   borderRadius: const BorderRadius.all(Radius.circular(4)),
          //   shape: BoxShape.rectangle,
          // ),
          // specialRegions: _getTimeRegions(),  ////////day details
                onTap: (calendarTapDetails) {

                  if (calendarTapDetails.targetElement == CalendarElement.agenda ||
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Meeting appointment = calendarTapDetails.appointments![0];
      _selectedAppointment = appointment;
    }
                  String days=calendarTapDetails.date.toString();
                  showEditField((days).split(' ')[0], Mheight, Mwidth,calendarTapDetails);
                  print('${(days).split(' ')[0]} ${calendarTapDetails.appointments} onn para');
                },
                monthViewSettings: MonthViewSettings(showAgenda: true,appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),
              )
              // CalendarCarousel<Event>(
              //   showHeaderButton: true,
              
              //  onDayPressed: ((date, event) {
              //   print(
              //     _markedDate
              //   .toString());
              //    String days = date.toString();
              //    setState(() {
              //      selectedDate = date;
              //    dates1 = days.split(' ')[0];
              //    });
              //   //  print(dates1+' '+DateTime.now().toString().split(' ')[1]);
              //    getAtt(widget.id, widget.subId, dates1,'check');
              //     // event.forEach((event) {
              //     //       // final obj = Attend.fromMap(map);
              //     //       attt.value.add(event.title);
              //     //       attt.notifyListeners();
              //     //     });
              //   showEditField(dates1,Mheight, Mwidth  );
              //  }),
              // //  multipleMarkedDates:  ,
              //   headerText: '${DateT}',
              //   // weekFormat: true,
              //   thisMonthDayBorderColor: Colors.grey,
              //   markedDateMoreShowTotal: true,
              //   markedDateIconMargin: 10,
              //   markedDateShowIcon: true,
              //   // markedDateIconMaxShown: 0,
              //   markedDatesMap: _markedDate,
              //   height: 340,
              //   selectedDateTime: selectedDate,
              //   // customGridViewPhysics: NeverScrollableScrollPhysics(),
              //   daysHaveCircularBorder: true,
              //   todayButtonColor: Colors.purple,
              //   todayBorderColor: Color.fromARGB(255, 0, 42, 255),
                
                // onCalendarChanged: (DateTime date){
                //   ,getDatawithDate(date)
                //   this.setState(() {
                //     DateT = DateFormat.yMMM().format(date);
                //   });
                // },

              //   showIconBehindDayText: true,
              //   markedDateWidget: _buildMarkeddateWidget(selectedDate, _markedDate), //Positioned(child: Container(color: Colors.red,height: 1,width: 2,)),
              // //  markedDatesMap: _getMarkedDateMap(),
               ),
            // )

          ]),
        
      // ),
    );
  }
  /////day details
  // List<TimeRegion> _getTimeRegions() {
  //   final List<TimeRegion> regions = <TimeRegion>[];
  //   regions.add(TimeRegion(
  //       startTime: DateTime.now(),
  //       endTime: DateTime.now().add(Duration(hours: 1)),
  //       enablePointerInteraction: false,
  //       recurrenceRule: 'FREQ=DAILY;INTERVAL=1',
  //       textStyle: TextStyle(color: Colors.black45, fontSize: 15),
  //       color: Colors.grey.withOpacity(0.2),
  //       recurrenceExceptionDates: [DateTime.now().add(Duration(days: 2))],
  //       text: 'Break'));

  //   return regions;
  // }
//   Map<DateTime, List<DataWithDate>> _getMarkedDateMap() {
//   Map<DateTime, List<DataWithDate>> markedDateMap = {};

//   for (DataWithDate data in datesWithData) {
//     DateTime date = data.date;
//     if (markedDateMap.containsKey(date)) {
//       markedDateMap[date]!.add(data);
//     } else {
//       markedDateMap[date] = [data];
//     }
//   }

//   return markedDateMap;
// }
   getDatawithDate(DateTime date){
    // final data =
    getData(date,widget.subId,widget.id).then((value) {

    value.forEach((map){
      final obj = Attend.fromMap(map);
      print('${obj.day} ${obj.status}');
        _addDataSource(obj.status, DateTime.parse(obj.day));
      ////////////////
      // DataWithDate data = DataWithDate(date, obj.status);
      // // final day = (obj.day.toString()).split(' ')[0];
      //   datesWithData.add(data);
      //   _markedDate
      //               .add(
      //                 DateTime(int.parse(day.split('-')[0]),int.parse(day.split('-')[1]),int.parse(day.split('-')[2])),
      //                 Event(date: DateTime(int.parse(day.substring(0,4)),int.parse(day.substring(5,7)),int.parse(day.substring(9))),
      //                 title:obj.status,
      //                 dot:Container(
      //                   margin:EdgeInsets.symmetric(horizontal: 1),
      //                   color:Color.fromARGB(255, 255, 0, 0),
      //                   height: 5,
      //                   width: 5,
      //                 )
                      
      //                 )
                      // );
    });
    // .whenComplete((){
    //   return meetings;
    // });
    });
  }

   void showEditField(String day,double h,double w,CalendarTapDetails caledertapD){
    // late Meeting _selectedAppointment;
    // print(day);
  //   MeetingDataSource? events;
  // // Meeting? _selectedAppointment;
  getAtt(widget.id, widget.subId, day, '');
    late DateTime date;
    final Lday = day.split('-');

    print(int.parse(Lday[2]));
   late String d = day+' '+DateTime.now().toString().split(' ')[1];
   date=DateTime.parse(d);
   print(date);
   print('$d hello');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          title:  Text('${widget.subId}',textAlign: TextAlign.center,),
          content:Container( 
            height:h*0.3,
            width: w,
          // ListView(
            // shrinkWrap: true,
            child: Column(children: [

              Text('Set or Reset Attendance for ${widget.subId} '),
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
                              {
                              widget.p-=1;
                              widget.total=widget.p+widget.a;
                              }
                            else{
                              widget.a-=1;
                              widget.total=widget.p+widget.a;

                            }
                              widget.perc=((widget.p/widget.total)*100).floor();
                          });
                          data.status == 'Present' ? 
                    updates(widget.id, widget.subId, '', '', '', (widget.p).toString(), ''):
                    updates(widget.id, widget.subId, '', '', '', '', widget.a.toString());
                    // for(int i=0;i<attend.length;i++){
                    //   final detail=attend[i];
                    //   if(detail.day==data.day)
                    //     continue;
                    //  _selectedAppointment.add(
                    //   Meeting('${detail.status}', DateTime.parse(detail.day), {detail.status}=='Present'?Color(0xFF0F8644):Color(0xFFF33446), false));

                    // }

                          deleteAttend(data.id,data.subId,data.day,data.status).whenComplete(() {
                            // setState(() {
                              // if (_selectedAppointment != null) {

                                // events!.resources!.clear();
                                setState(() {
                                // meetings=[];
                          // getDatawithDate(date);
                          // getAtt(widget.id, widget.subId, day, '');
                          print('$meetings   ${meetings.length}');
                     final  app = Meeting(data.status, DateTime.parse(data.day), DateTime.parse(data.day).add(const Duration(hours: 1)),data.status=='Present'?Color(0xFF0F8644):Color(0xFFF33446), false);
                     print('${app.eventName} ${app.background} ${app.from} ${app.to} ${app.isAllDay}');
                    //  try{

                            events!.appointments?.removeWhere((element) =>element.from==app.from );
                     print('${app.from}  ${meetings.length}');
                    //  }catch(e){
                    //   print(e);
                    //  }
                            // .indexOf(app));  
                  //           events?.notifyListeners(
                            // meetings.removeWhere((element) => element.from==(app.from));
                  // CalendarDataSourceAction.remove, <Meeting>[]);
                            events!.notifyListeners(
                              CalendarDataSourceAction.reset,meetings);
                      print('$meetings  ${meetings.length}');
                      // );
    //                       events!.notifyListeners(
    // CalendarDataSourceAction.resetResource, meetings);eer
                                });
                          // events!.resources!.addAll();

                  // events!.appointments?.removeAt(
                  //     events!.appointments!.indexOf(_selectedAppointment));
                  // events!.notifyListeners(CalendarDataSourceAction.remove,
                  //     <Meeting>[]..add(_selectedAppointment!));


                // }
                  //         if(attt.value.length>=0){
                  //           MeetingDataSource(meetings).notifyListeners(
                  //             CalendarDataSourceAction.remove,
                  //             <Meeting>[]..add(
                  //     Meeting('${attend[0].status}', DateTime.parse(attend[0].day), {attend[0].status}=='Present'?Color(0xFF0F8644):Color(0xFFF33446), false)
                  // // for(int i=0;i<attend.length;i++){
                  // //     final detail=attend[i];
                  // //     if(detail.day==data.day)
                  // //       continue;
                  // //   //  _selectedAppointment.add(
                  // //     Meeting('${detail.status}', DateTime.parse(detail.day), {detail.status}=='Present'?Color(0xFF0F8644):Color(0xFFF33446), false)

                  // //   }
                  //             )
                  //           );

                              
                  //         }
                            // });
                         /////////////// // _markedDate
                      //     .remove(
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
                          });

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
                    updates(widget.id, widget.subId, '', '', '', widget.p.toString(), '');
                    addAttend(widget.id,widget.subId,d,'Present');
                    print(meetings);

                      Meeting  app1 = Meeting('Present', date, date.add(const Duration(hours: 1)),Color(0xFF0F8644), false);
                     print('${app1.from}  ${meetings.length}');
                    setState(() {
                      
                    widget.p +=1;
                    widget.total=widget.p+widget.a;
                              widget.perc=((widget.p/widget.total)*100).floor();

                    // _addDataSource('Present', date);
              // events?.appointments?.add(app1);
              meetings.add(app1);
                     print('${app1.from}  ${meetings.length}');

            // events = MeetingDataSource(meetings); //_getCalendarDataSource();

              events?.notifyListeners(
                  CalendarDataSourceAction.add, <Meeting>[app1]);
                    });
                    print(meetings);
                     print('${app1.from}  ${meetings.length}');

                    
                    print('added $date');
                      // _markedDate.remove(date, event)
                    // ////////////////////_markedDate
                    // .add(
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

                    Navigator.of(context).pop();
                  },
                   child: Text('Present')),
                   ElevatedButton(onPressed: (){
                    d = day+' '+(DateTime.now().toString()).split(' ')[1];
                    print('$d hmmmmmmm');
                    updates(widget.id, widget.subId, '', '', '', '', widget.a.toString());
                    addAttend(widget.id,widget.subId,d,'Absent');
                     final  app2 = Meeting('Absent', date, date.add(const Duration(hours: 1)),Color(0xFFF33446) , false);
                          print(meetings);
                    
                    setState(() {
                      
                    widget.a +=1;
                    widget.total=widget.p+widget.a;
                              widget.perc=((widget.p/widget.total)*100).floor();

              // events?.appointments!.add(app2);
              meetings.add(app2);
                     print('${app2.from}  ${meetings.length}');

              events?.notifyListeners(
                  CalendarDataSourceAction.reset, meetings);

                    // _addDataSource('Absent', date);

                    });
                          print(meetings);

                 /////////////////////////   // _markedDate.
                    // add(
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
  Future<void>shared(int present,int total)async{
     double numb;
    final SharedPreferences sp = await _shp;
    //  int cpercent=((present/total)*100).floor();
    setState(() {
      widget.per=sp.getInt('attendance')!=null?sp.getInt('attendance')!:100;
     final percentage=widget.per/100;
      // widget.n=p
  // present+x/total+x=percentage
  if(widget.per==100||widget.per==0){
      widget.text='';
  }else{
  if(percentage>(present/total)){
    numb=((percentage*total)-present)/(1-percentage);
  if(numb.floor()<numb)
    numb++;
  // widget.reqclass=numb.floor();
  widget.text="You have to attend next ${numb.floor()} classes ";

  }
  else{
    numb=(present/percentage)-total;
    widget.text=numb.floor()!=0?"You can bunk next ${numb.floor()} classes":"You are on Track";
  }

  }


    });

  }

  // List<Meeting>
    _addDataSource(String event,DateTime daytime) {
    // getAttendance(, subId)
    // final DateTime today = DateTime.now();
    // final DateTime startTime = daytime;//DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = daytime.add(const Duration(hours: 1));
    meetings.add(Meeting(
        '$event', daytime, endTime,event=='Present'?Color(0xFF0F8644):Color(0xFFF33446), false));
    return meetings;
  }
  
}
 class Meeting {
   Meeting(this.eventName, this.from,this.to, this.background, this.isAllDay);

   String eventName;

   DateTime from;

   DateTime to;

  Color background;

  bool isAllDay;
}
class MeetingDataSource extends CalendarDataSource {
 
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}