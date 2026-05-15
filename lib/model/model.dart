/*
*Student Numbers:224043099, 224014647, 224125791, 224081629, 224083089
*Student Names  : Masendeke Chiedza P, Mahlangu Phindile, Khunyeli Paballo, Ntlati Thembinkosi T, Tshabane Lonwabo
*Question : StudentModel 
*/
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

  final String? documentUrl;
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
    this.documentUrl,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
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
    'document_url': documentUrl,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  factory StudentApplication.fromJson(Map<String, dynamic> json) {
    return StudentApplication(
      id: json['id'].toString(),
      userId: json['user_id'],
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
      documentUrl: json['document_url'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }
}