
import 'package:attendance/db_model.dart';
import 'package:attendance/subjects.dart';
// import 'package:attendance/main.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<Subject>> subjec = ValueNotifier([]);
ValueNotifier<List<Subject>> subj = ValueNotifier([]);
ValueNotifier<List<Attend>> attt = ValueNotifier([]);

late Database _database;

Future<void> initialize()async{
  _database = await openDatabase(
    'subjects0.db',
    version: 2,
    onCreate: (Database db, int version)async {
      await db.execute('CREATE TABLE login ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, password TEXT, college TEXT)');

      await db.execute('''CREATE TABLE subjects ( id INTEGER, subName TEXT, subId TEXT, days TEXT, present INTEGER, absent INTEGER,
      FOREIGN KEY (id) References login (id),
      primary key(id,subId)
      )''');

      await db.execute('''CREATE TABLE attendances ( id INTEGER, subId TEXT,day TEXT, status TEXT,
      FOREIGN KEY (id) references login (id),
      FOREIGN KEY (subId) references subjects (subId)
      )''');
    },

  );
  // getSub();
}

Future<int>addlog(log l)async{
  final id = await _database.rawInsert('Insert into login(name,password,college ) values (?,?,?)',[l.name,l.password,l.College]);
  return id;
}

Future<String>searchU(name,pass)async{
  final values = await _database.rawQuery('Select * from login where name = ? and password = ?',[name,pass]);
  print(values.first);
  if(values.length>0){
    print(values.first.toString());
    return '${values.first.toString()}';
  }
  else
    return '';
}
Future<String>searchpass(name,pass,college)async{
  final values;
  if(name != '')
     values = await _database.rawQuery('Select * from login where name = ? and college = ?',[name,college]);
  else{
     values = await _database.rawQuery('Select * from login where password = ? and college = ?',[pass,college]);

  }
  if(values.length>0){
  print(values.first);
    print(values.first.toString());
    return '${values.first.toString()}';
  }
  else
    return '';
}

Future getSub(id)async{
 final values = await _database.rawQuery('Select * from subjects where id = ?',[id]);
 print(values);
 subjec.value.clear();
 values.forEach((map) {
  final obj = Subject.fromMap(map);
  subjec.value.add(obj);
  subjec.notifyListeners();
 });
  return values;
}
Future<void>addsub(name,int id,subId,days,int p,int a)async{
    await _database.rawInsert('Insert into subjects( id,subId,subName,days,present,absent) values (?,?,?,?,?,?)',[id,subId,name,days,p,a]);
    getSub(id);
}

Future<void>deleSub(subId,int id)async{
await _database.rawDelete('DELETE FROM subjects where id =? and subId = ?',[id,subId]);
getSub(id);
}

Future<void>updates(int id,subId,subIdc,days,subName,String p,String a)async{
   if(subIdc != ''){
    await _database.rawUpdate('UPDATE subjects set subId = ? where id = ? and subId = ?',[subIdc,id,subId]);
    // subId=subIdc;
  getSub(id);

  }
  
  else if(days != ''){
    await _database.rawUpdate('UPDATE subjects set days = ? where id = ? and subId = ?',[days,id,subId]);
    print('days');
  getSub(id);

  }else if(subName != ''){
    await _database.rawUpdate('UPDATE subjects set subName = ? where id = ? and subId = ?',[subName,id,subId]);
  getSub(id);

  }else if(p != ''){
    await _database.rawUpdate('UPDATE subjects set present = ? where id = ? and subId = ?',[int.parse(p),id,subId]);
  getSub(id);

  }else if(a != ''){
    await _database.rawUpdate('UPDATE subjects set absent = ? where id = ? and subId = ?',[int.parse(a),id,subId]);
    print(a);

  getSub(id);
  }
  
}
Future<void>getDaySub(int id,String day)async{
 final values = await _database.rawQuery("Select * from subjects where id = ? and days like '%$day%'",[id]);
 print(values);
 subj.value.clear();
 if(values.length>0){

 values.forEach((map) {
  final obj = Subject.fromMap(map);
  subj.value.add(obj);
  subj.notifyListeners();
 });
 }else{
  
 }
 
}

Future<void>deleteAttend(int id,subId,day,status)async{
  print(day + 'from delete');
await _database.rawDelete('Delete from attendances where id = ? and subId = ? and day = ? and status = ? ',[id,subId,day,status]);
getAtt(id, subId, day.split(' ')[0],'Delete');
}

Future<void>addAttend(int id,subId,String day,status)async{
  print(day+'from add');
  await _database.rawInsert('Insert into attendances (id,subId,day,status) values(?,?,?,?)',[id,subId,day,status]);
  
  // attt.value.clear();
getAtt(id, subId, day.split(' ')[0],'Add');
// getDaySub(id, day);


}
Future getAttendance(int id,subId)async{
 final value= await _database.rawQuery('Select * from attendances where id = ? and subId= ? ',[id,subId]);
  return value;
}
Future getAtt(int id,subId,String day,String type)async{
  // attt.value.clear();
   final values = await _database.rawQuery("Select * from attendances where id = ? and subId = ? and day like '$day%'",[id,subId]);
 print(values);
 if(values.length>0 && (type=='' || type=='Add') ){
 attt.value.clear();

 values.forEach((map) {
  final obj = Attend.fromMap(map);
  attt.value.add(obj);
  attt.notifyListeners();
 });
 if(type==''){
  return values;
 }
//  
 }else if(attt.value.length > 0 && type == 'Delete'){
  // attt.value.clear();
  // print('removing');
 attt.value.removeLast();
 attt.notifyListeners();
 }else{
  attt.value.clear();
 attt.notifyListeners();

 }
}

Future<String> getstatus(int id,String subId)async{
  print(id); 
  print(subId);
  // print(day);
  late String data='';
  // final values =
   await _database.rawQuery("Select * from subjects where id = ? and subId = ? ",[id,subId]).then((values) {
    
 print(values);
 print('kittiiiiiiiii');
 subj.value.clear();
 if(values.length>0){

 values.forEach((map) {
  
  final obj = Subject.fromMap(map);
  
   data += obj.p.toString();
   data += ',';
   data +=obj.a.toString();
   print(data);
 });
 }
  },);
   return  data;
}
Future<Subject> getAttDetail(int id,String subId)async{
  late Subject sub;//Subject(id:id, subjName: '', days: '', subId: subId, p: 0, a: 0);
  await _database.rawQuery("Select * from subjects where id=? and subId = ?",[id,subId]).then((value) 
  {
    if(value.length>0){
      value.forEach((element) {
        final data = Subject.fromMap(element);
        sub =data;
        // return sub;
        // print(data.p);
      });
      
    }
  });
        return sub;

}
Future getData(DateTime date,String subId,int id)async{
  String dates = (date.toString()).split(' ')[0];
  // print(dates.substring(0,7));
  final data = _database.rawQuery('Select * from attendances where id = ? and subId = ? and day like "${dates.substring(0,7)}%" ',[id,subId]);
  // print(data);
  return data;
}