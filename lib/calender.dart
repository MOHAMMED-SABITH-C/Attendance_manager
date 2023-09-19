import 'package:attendance/db_functions.dart';
import 'package:attendance/db_model.dart';
// import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarPicker extends StatefulWidget {
   CalendarPicker({super.key,required this.id,required this.subId,required this.p,required this.a});
   late int id;
   late String subId;
   late int p;
   late int a;
   late int total=a+p;
   late int perc=((p/total)*100).floor();
   late int per;

      
  //  late int reqclass;
  late String text=" ";

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}
class DataWithDate extends Event {
  DataWithDate(DateTime date, String title) : super(date: date, title: title);
}
// {
//   final DateTime date;
//   final String title;

//   DataWithDate(this.date,this.title);
// }

class _CalendarPickerState extends State<CalendarPicker> {
  Future<SharedPreferences> _shp=SharedPreferences.getInstance();
  // EventList<DataWithDate> events = EventList<DataWithDate>(events: {

  // });
  List<DataWithDate> datesWithData = [];
  EventList<Event> _markedDate = EventList<Event>(events: {
    
  });
  late DateTime dates ;
  late String dates1;
  late DateTime selectedDate = DateTime.now();
  late String DateT = DateFormat.yMMM().format(selectedDate);
  // CrCalendarController _controller = CrCalendarController()  ;
  Widget _buildMarkeddateWidget(DateTime date,EventList<Event> events){
  if(((widget.p/widget.total)*100)>=widget.perc+0.5)
        widget.perc++;
    return Stack(
      children: [
        Container(
          width: 5,
          height: 5,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(

          color: Colors.blue,
          shape:BoxShape.circle,
          ),
          // child: Text(date.day.toString(),
          // style:TextStyle(color: Colors.white)),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(width: 5,height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 82, 54, 244)
          ),)
        )

      ],
    );
  }
  
  void initState(){
    print('${widget.id}  '+ ' ${widget.subId}');
    getAttDetail(widget.id, widget.subId).then((value) {
      if(value!=null){
        
      // value.forEach((map){
      //   final data= Subject.fromMap(map);

    setState(() {
      // widget.p=value.p;
      // widget.a=value.a;
      // widget.total = value.a+value.p;
      widget.perc=((widget.p/widget.total)*100).floor();
                        // print('$perc  '+'  $percentage');

                        
                      // if(((widget.p/widget.total)*100)>=widget.perc+0.5)
                      //   widget.perc++;
    });
        // shared(widget.p,widget.total);
    //   });
      }
    });
    super.initState();
    // getDatawithDate(selectedDate);
  }
  @override
  Widget build(BuildContext context) {
    // getAttDetail(widget.id, widget.subId).then((value) {
    //   // if(value!=null){
        
    //   // value.forEach((map){
    //     // final data= Subject.fromMap(map);

    // setState(() {
    //   widget.p=value.p;
    //   widget.a=value.a;
    //   widget.total = value.a+value.p;
        shared(widget.p,widget.total);
    // });
    //   });
      // }
    // });
    getDatawithDate(selectedDate);

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
                                          lineWidth: 9,
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
                                          center: Text('${widget.perc}%',style:TextStyle(fontWeight:FontWeight.bold) ,),
                                          progressColor:  (widget.p/widget.total) < 0.2 ? const Color.fromARGB(255, 255, 0, 0):(widget.p/widget.total) < 0.5 ? Color.fromARGB(255, 235, 173, 18):(widget.p/widget.total) < 0.75 ? Color.fromARGB(255, 181, 251, 30): Color.fromARGB(255, 94, 255, 0),
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
              child:CalendarCarousel<Event>(
                showHeaderButton: true,
              
               onDayPressed: ((date, event) {
                print(
                  _markedDate
                .toString());
                 String days = date.toString();
                 setState(() {
                   selectedDate = date;
                 dates1 = days.split(' ')[0];
                 });
                //  print(dates1+' '+DateTime.now().toString().split(' ')[1]);
                 getAtt(widget.id, widget.subId, dates1,'check');
                  // event.forEach((event) {
                  //       // final obj = Attend.fromMap(map);
                  //       attt.value.add(event.title);
                  //       attt.notifyListeners();
                  //     });
                showEditField(dates1,Mheight, Mwidth  );
               }),
              //  multipleMarkedDates:  ,
                headerText: '${DateT}',
                // weekFormat: true,
                thisMonthDayBorderColor: Colors.grey,
                markedDateMoreShowTotal: true,
                markedDateIconMargin: 10,
                markedDateShowIcon: true,
                // markedDateIconMaxShown: 0,
                markedDatesMap: _markedDate,
                height: 340,
                selectedDateTime: selectedDate,
                // customGridViewPhysics: NeverScrollableScrollPhysics(),
                daysHaveCircularBorder: true,
                todayButtonColor: Colors.purple,
                todayBorderColor: Color.fromARGB(255, 0, 42, 255),
                
                onCalendarChanged: (DateTime date){
                  getDatawithDate(date);
                  this.setState(() {
                    DateT = DateFormat.yMMM().format(date);
                  });
                },

                showIconBehindDayText: true,
                markedDateWidget: _buildMarkeddateWidget(selectedDate, _markedDate), //Positioned(child: Container(color: Colors.red,height: 1,width: 2,)),
              //  markedDatesMap: _getMarkedDateMap(),
               ),
            )

          ]),
        
      // ),
    );
  }
  Map<DateTime, List<DataWithDate>> _getMarkedDateMap() {
  Map<DateTime, List<DataWithDate>> markedDateMap = {};

  for (DataWithDate data in datesWithData) {
    DateTime date = data.date;
    if (markedDateMap.containsKey(date)) {
      markedDateMap[date]!.add(data);
    } else {
      markedDateMap[date] = [data];
    }
  }

  return markedDateMap;
}
  void getDatawithDate(DateTime date){
    // final data =
    getData(date,widget.subId,widget.id).then((value) {

    value.forEach((map){
      final obj = Attend.fromMap(map);
      
      DataWithDate data = DataWithDate(date, obj.status);
      final day = (obj.day.toString()).split(' ')[0];
        datesWithData.add(data);
        _markedDate
                    .add(
                      DateTime(int.parse(day.split('-')[0]),int.parse(day.split('-')[1]),int.parse(day.split('-')[2])),
                      Event(date: DateTime(int.parse(day.substring(0,4)),int.parse(day.substring(5,7)),int.parse(day.substring(9))),
                      title:obj.status,
                      dot:Container(
                        margin:EdgeInsets.symmetric(horizontal: 1),
                        color:Color.fromARGB(255, 255, 0, 0),
                        height: 5,
                        width: 5,
                      )
                      
                      )
                      );
    });
    });
  }

   void showEditField(String day,double h,double w){
    final Lday = day.split('-');

    print(int.parse(Lday[2]));
   late String d = day+' '+DateTime.now().toString().split(' ')[1];
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
                          });
                          data.status == 'Present' ? 
                    updates(widget.id, widget.subId, '', '', '', (widget.p).toString(), ''):
                    updates(widget.id, widget.subId, '', '', '', '', widget.a.toString());

                          deleteAttend(data.id,data.subId,data.day,data.status).whenComplete(() {

                          if(attt.value.length<=0){
                          _markedDate
                          .remove(
                      DateTime(int.parse(day.split('-')[0]),int.parse(day.split('-')[1]),int.parse(day.split('-')[2])),
                      Event(date: DateTime(int.parse(Lday[0]),int.parse(Lday[1]),int.parse(Lday[2])),
                      title:'Present',
                      dot:Container(
                        margin:EdgeInsets.symmetric(horizontal: 1),
                        color:Color.fromARGB(255, 255, 0, 0),
                        height: 5,
                        width: 5,
                      )
                      
                      )
                      );
                          }
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
                    setState(() {
                      
                    widget.p +=1;
                    widget.total=widget.p+widget.a;
                    });
                    updates(widget.id, widget.subId, '', '', '', widget.p.toString(), '');
                    addAttend(widget.id,widget.subId,d,'Present');
                      // _markedDate.remove(date, event)
                    _markedDate
                    .add(
                      DateTime(int.parse(day.split('-')[0]),int.parse(day.split('-')[1]),int.parse(day.split('-')[2])),
                      Event(date: DateTime(int.parse(Lday[0]),int.parse(Lday[1]),int.parse(Lday[2])),
                      title:'Present',
                      dot:Container(
                        margin:EdgeInsets.symmetric(horizontal: 1),
                        color:Color.fromARGB(255, 255, 0, 0),
                        height: 5,
                        width: 5,
                      )
                      
                      )
                      );
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
                    print(d);
                    setState(() {
                      
                    widget.a +=1;
                    widget.total=widget.p+widget.a;

                    });
                    updates(widget.id, widget.subId, '', '', '', '', widget.a.toString());
                    addAttend(widget.id,widget.subId,d,'Absent');
                    _markedDate.add(
                      DateTime(int.parse(day.split('-')[0]),int.parse(day.split('-')[1]),int.parse(day.split('-')[2])),
                      Event(date: DateTime(int.parse(day.split('-')[0]),int.parse(day.split('-')[1]),int.parse(day.split('-')[2])),
                      title:'Absent',
                      dot:Container(
                        margin:EdgeInsets.symmetric(horizontal: 1),
                        color:Colors.red,
                        height: 5,
                        width: 5,
                      )
                      
                      )
                      );
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
      widget.per=sp.getInt('attendance')!=null?sp.getInt('attendance')!:0;
     final percentage=widget.per/100;
      // widget.n=p
  // present+x/total+x=percentage
  if(widget.per==0){
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
  
}