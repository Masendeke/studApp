class StudentApplication {//model class for the student application form and also used to parse the data from the database and also to convert the data to json format
  final String id;
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
//constructor for the student application form and also used to parse the data from the database and also to convert the data to json format
  StudentApplication({//the id is required because it is used to identify the application and also to update the application and also to delete the application
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

  //  TO JSON 

  Map<String, dynamic> toJson() => {//used to convert the data to json format and also used to insert the data to the database
        'std_no': stdNo,
        'name': name,
        'surname': surname,
        'email': email,
        'course': course,
        'year_of_study': yearOfStudy,
        'module1': module1,
        'module2': module2,
        'status': status,
        'phone': phone,
        'id':id,
       
      };

  // FROM JSON 

  factory StudentApplication.fromJson(
    Map<String, dynamic> json,
  ) {//used to parse the data from the database and also used to convert the data to json format and also used to fetch the data from the database
    return StudentApplication(//the id is required because it is used to identify the application and also to update the application and also to delete the application
      id: json['id'].toString(),
      stdNo: json['std_no'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      yearOfStudy: json['year_of_study'] ?? '',
      module1: json['module1'] ?? '',
      module2: json['module2'] ?? '',
      course: json['course'] ?? '',
      status: json['status'] ?? 'Pending',
      phone: json['phone'] ?? '',
      createdAt: json['created_at'] != null// If created_at is not null, parse it to DateTime, otherwise use the current time as a fallback
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null// If updated_at is not null, parse it to DateTime, otherwise use the current time as a fallback
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }
}