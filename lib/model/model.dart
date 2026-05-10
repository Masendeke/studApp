class StudentApplication{
  String stdNo;
  String email;
  String name;
  String surname;
  String yearOfStudy;
  String module1;
  String module2;
  String course;
  String status;

StudentApplication({
required this.stdNo,
required this.email,
required this.name,
required this.surname,
required this.yearOfStudy,
required this.module1,
required this.module2,
required this.course,
this.status = 'Pending', // This is the default status for newly created students


});
 Map<String,dynamic> toJson()=>{
    'std_no':stdNo,'name':name,'surname':surname,'email':email,
    'course':course,'year':yearOfStudy,'module1':module1,'module2':module2,
    'status': status,
  };

}
