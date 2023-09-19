import 'package:attendance/db_functions.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addsubject extends StatefulWidget {

   addsubject({super.key,required this.id});
   late int id;

  @override
  State<addsubject> createState() => _addsubjectState();
}

class _addsubjectState extends State<addsubject> {
    Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  List? _myActivities;
  late String _myActivitiesResult ;
  late String days;
  final formKey = new GlobalKey<FormState>();
    final _txtName = TextEditingController();
    final _txtId = TextEditingController();
    final _txtP = TextEditingController();
    final _txtA = TextEditingController();

    void initState(){
      super.initState();
      _myActivities =[];
      _myActivitiesResult='';
    }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(actions: [],),
      body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.all(18.0),
          // child: Container(
        // child: Flexible(
          // flex: 1,
            child: Column(
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
                  sentData();
                  print(days);
                },
                 icon: Icon(Icons.add),
                  label: Text('Submit'))
              ],
            ),
          ),
        ),
      // )
      // ),
    );
  }

  sentData()async{
late int _id;
    final SharedPreferences sp = await _pref;
    String name = _txtName.text.trim();
    String subId = _txtId.text.trim();
    int p = int.parse(_txtP.text.trim());
    int A = int.parse(_txtA.text.trim());
   
        if(sp.getInt('id')!= null){

      _id= sp.getInt('id')!;
        }
        print('adding');
    addsub(name,_id,subId,days,p,A);
    

  }

}