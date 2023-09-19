// import 'dart:math';

class log{
   int? id;
   late String name;
   late String password;
   late String College;

   log({required this.name,required this.password,required this.College,this.id});
   static log fromMap(Map<String,Object?> map){
    final id = map['id'] as int;
    final name = map['name'] as String;
    final password = map['password'] as String;
    final college = map['college'] as String;

    return log(name: name, password: password, College: college,id: id);

   }
    }

   
class Subject{
  final String subjName;
  final String subId;
  final String days;
  final int id;
  final int p;
  final int a;

  Subject({ required this.id,required this.subjName,required this.days,required this.subId,required this.p,required this.a});

  static Subject fromMap(Map<String, dynamic>map){
    final subId = map['subId'] as String ;
    final subjName = map['subName'] as String;
    final days = map['days'] as String;
    final id = map['id'] as int;
    final p=map['present'] as int;
    final a=map['absent'] as int;

    return Subject(id: id, subjName: subjName, days: days, subId: subId,p: p,a: a);

  }

  // void forEach(Null Function(dynamic map) param0) {}

  // void forEach(Null Function(dynamic map) param0) {}
}

  class Attend{
    final int id;
    final String subId;
    final String day;
    final String status;

    Attend({required this.id,required this.subId,required this.day,required this.status});

    static Attend fromMap(Map<String,Object?>map){
      final id = map['id'] as int;
      final subId = map['subId'] as String ;
      final day = map['day'] as String ;
      final status = map['status'] as String ;

      return Attend(id: id, subId: subId, day: day, status: status);
    }
  }
 