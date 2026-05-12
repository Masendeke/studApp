//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L

class StudentApplication {

  final String? id;

  final String? userId;

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

  final DateTime? createdAt;

  final DateTime? updatedAt;

  StudentApplication({
    this.userId,

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

  Map<String, dynamic> toJson() => {

        // DO NOT SEND ID

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
  ) {

    return StudentApplication(

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
    );
  }
}