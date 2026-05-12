<<<<<<< HEAD
//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L

class StudentApplication {

  final String? id;

  final String? userId;

=======
class StudentApplication {//model class for the student application form and also used to parse the data from the database and also to convert the data to json format
  final String id;
>>>>>>> main
  final String stdNo;

  final String email;

  final String name;

  final String surname;

  final String yearOfStudy;

  final String module1;

  final String module2;

  final String course;

  final String status;

  final String phone;
// The createdAt and updatedAt fields are optional and can be null when creating a new application, but they will be populated when fetching data from the database
  final DateTime? createdAt;

  final DateTime? updatedAt;
<<<<<<< HEAD

  StudentApplication({
    this.userId,

=======
//constructor for the student application form and also used to parse the data from the database and also to convert the data to json format
  StudentApplication({//the id is required because it is used to identify the application and also to update the application and also to delete the application
>>>>>>> main
    required this.id,

    required this.phone,

    required this.stdNo,

    required this.email,

    required this.name,

    required this.surname,

    required this.yearOfStudy,

    required this.module1,

    required this.module2,

    required this.course,

    this.status = 'Pending',

    this.createdAt,

    this.updatedAt,
  });

  // TO JSON

<<<<<<< HEAD
  Map<String, dynamic> toJson() => {

        // DO NOT SEND ID

=======
  Map<String, dynamic> toJson() => {//used to convert the data to json format and also used to insert the data to the database
>>>>>>> main
        'std_no': stdNo,
        
        'user_id': userId,

        'name': name,

        'surname': surname,

        'email': email,

        'course': course,

        'year_of_study': yearOfStudy,

        'module1': module1,

        'module2': module2,

        'status': status,

        'phone': phone,

        'created_at':
            createdAt?.toIso8601String(),

        'updated_at':
            updatedAt?.toIso8601String(),
      };

  // FROM JSON

  factory StudentApplication.fromJson(
    Map<String, dynamic> json,
<<<<<<< HEAD
  ) {

    return StudentApplication(

=======
  ) {//used to parse the data from the database and also used to convert the data to json format and also used to fetch the data from the database
    return StudentApplication(//the id is required because it is used to identify the application and also to update the application and also to delete the application
>>>>>>> main
      id: json['id'].toString(),

      userId: json['user_id'],

      stdNo: json['std_no'] ?? '',

      email: json['email'] ?? '',

      name: json['name'] ?? '',

      surname: json['surname'] ?? '',

      yearOfStudy:
          json['year_of_study'] ?? '',

      module1: json['module1'] ?? '',

      module2: json['module2'] ?? '',

      course: json['course'] ?? '',

      status:
          json['status'] ?? 'Pending',

      phone: json['phone'] ?? '',
<<<<<<< HEAD

      createdAt:
          json['created_at'] != null

              ? DateTime.parse(
                  json['created_at'],
                )

              : null,

      updatedAt:
          json['updated_at'] != null

              ? DateTime.parse(
                  json['updated_at'],
                )

              : null,
=======
      createdAt: json['created_at'] != null// If created_at is not null, parse it to DateTime, otherwise use the current time as a fallback
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null// If updated_at is not null, parse it to DateTime, otherwise use the current time as a fallback
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
>>>>>>> main
    );
  }
}