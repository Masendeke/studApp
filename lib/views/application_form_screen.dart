//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/model.dart';
import '../viewmodel/viewmodel.dart';
import 'detail_screen.dart';

class Applicationformscreen extends StatefulWidget {
  const Applicationformscreen({super.key});

  @override
  State<Applicationformscreen> createState() =>
      _ApplicationformscreenState();
}

<<<<<<< HEAD
class _ApplicationformscreenState extends State<Applicationformscreen> {
=======
class _ApplicationformscreenState extends State<Applicationformscreen> {// The _ApplicationformscreenState class manages the state of the Applicationformscreen, including the form key for validation, text controllers for the input fields, and the logic for submitting the application form to the database through the StudentViewModel. It also defines the available years of study and modules for selection in the application form, ensuring that students can only select valid options based on their level of study when filling out the application form.
// The _ApplicationformscreenState class manages the state of the Applicationformscreen, including the form key for validation, text controllers for the input fields, and the logic for submitting the application form to the database through the StudentViewModel. It also defines the available years of study and modules for selection in the application form, ensuring that students can only select valid options based on their level of study when filling out the application form.
>>>>>>> main
  final _formKey = GlobalKey<FormState>();
// The _formKey is used to validate the form fields when the user clicks the submit button, ensuring that all required fields are filled out correctly before allowing the application submission process to proceed
  final TextEditingController stdNo = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController surname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController course = TextEditingController();
// The text controllers for the student number, name, surname, email, phone, and course fields are used to manage the input from the user for each respective field in the application form, allowing us to access the values entered by the user when validating the form and submitting the application details to the database through the StudentViewModel
  String? selectedYear;

  String? module1Level;
  String? module1Name;

  String? module2Level;
  String? module2Name;

  bool secondModuleEnabled = false;
  String? selectedFileName;
  bool eligibilityConfirmed = false;
<<<<<<< HEAD

  Future<void> pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFileName = result.files.single.name;
      });
    }
  }

=======
// The years list defines the available years of study for the application form, allowing students to select their current year of study when filling out the application form, which is essential for determining their eligibility and the appropriate modules they can select based on their level of study
>>>>>>> main
  final List<String> years = [
    'First Year',
    'Second Year',
    'Third Year'
  ];

  final List<String> academicLevels = [
    'First Year',
    'Second Year',
    'Third Year',
  ];
// The modulesByLevel map defines the available modules for each year of study, allowing the application form to dynamically display the appropriate module options based on the selected year, ensuring that students can only select modules that are relevant to their level of study when filling out the application form
  final Map<String, List<String>> modulesByLevel = {
    'First Year': ['ICT101', 'TPG111', 'MAT101'],
    'Second Year': ['TPG211', 'DBS210', 'WPR221'],
    'Third Year': ['TPG316C', 'PRJ300', 'SEC310'],
  };

  @override
  void dispose() {// The dispose method is overridden to clean up the text controllers when the screen is disposed, preventing memory leaks and ensuring that resources are properly released when the user navigates away from the application form screen
    stdNo.dispose();
    name.dispose();
    surname.dispose();
    email.dispose();
    phone.dispose();
    course.dispose();
    super.dispose();
  }

  InputDecoration buildInputDecoration({
    required String label,
    String? hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon != null ? Icon(icon) : null,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide:
            const BorderSide(color: Color(0xFF0B1F8F), width: 2),
      ),
    );
  }

  Widget buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      // ignore: deprecated_member_use
      value: value,
      decoration: buildInputDecoration(label: label),
      items: items
          .map((item) =>
              DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final vm = context.watch<StudentViewModel>();
    final user = Supabase.instance.client.auth.currentUser;
=======
// The build method builds the UI for the application form screen, including the form fields for student number, name, surname, email, phone, course, year of study, and module selection. It also includes a submit button that triggers the validation and submission logic when pressed, allowing students to fill out the application form and submit their details to the database through the StudentViewModel.
    final vm = context.read<StudentViewModel>();// The StudentViewModel is accessed using context.read to allow us to call the addStudent method when the user submits the application form, enabling us to manage the state of the application and handle the logic for adding a new student application to the database when the form is submitted successfully.
>>>>>>> main

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1F8F),
        title: const Text(
          'Student Assistant Application Form',
          style: TextStyle(color: Colors.white),
        ),
       leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
<<<<<<< HEAD
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B1F8F),
              Color(0xFF1976D2),
              Colors.white
=======

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              TextFormField(
                controller: stdNo,
                decoration: const InputDecoration(labelText: "Student No"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),

              TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: "Name"),
              ),

              TextFormField(
                controller: surname,
                decoration: const InputDecoration(labelText: "Surname"),
              ),

              TextFormField(
                controller: email,
                decoration: const InputDecoration(labelText: "Email"),
              ),

              TextFormField(
                controller: phone,
                decoration: const InputDecoration(labelText: "Phone"),
              ),

              TextFormField(
                controller: course,
                decoration: const InputDecoration(labelText: "Course"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(// The ElevatedButton is used to trigger the submission of the application form when pressed. It validates the form fields using the _formKey, checks if the eligibility is confirmed, and if everything is valid, it creates a new StudentApplication object with the details entered by the user and submits it to the database through the StudentViewModel's addStudent method. If the submission is successful, it navigates to the DetailScreen, passing the newly created student application as an argument for further review and tracking of the application status.
                onPressed: vm.isLoading
                    ? null
                    : () async {// When the submit button is pressed, the form is validated using the _formKey. If the validation passes (i.e., all required fields are filled out correctly), and the eligibility is confirmed, a new StudentApplication object is created with the details entered by the user in the form fields. This object is then submitted to the database through the StudentViewModel's addStudent method, which handles the logic for adding the new application to the database and updating the UI accordingly.

                        if (!_formKey.currentState!.validate()) return;

                        if (!eligibilityConfirmed) return;

                        final student = StudentApplication(// When the submit button is pressed, the form is validated using the _formKey. If the validation passes (i.e., all required fields are filled out correctly), and the eligibility is confirmed, a new StudentApplication object is created with the details entered by the user in the form fields. This object is then submitted to the database through the StudentViewModel's addStudent method, which handles the logic for adding the new application to the database and updating the UI accordingly.
                          id: '',
                          stdNo: stdNo.text,
                          name: name.text,
                          surname: surname.text,
                          email: email.text,
                          phone: phone.text,
                          course: course.text,
                          yearOfStudy: selectedYear ?? '',
                          module1: module1Name ?? '',
                          module2: module2Name ?? '',
                          status: 'Pending',
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );// The StudentApplication object is created with the details entered by the user in the form fields, including the student number, name, surname, email, phone, course, selected year of study, and selected modules. The status is set to 'Pending' by default, and the createdAt and updatedAt fields are set to the current date and time.

                        final success =
                            await vm.addStudent(student);// The addStudent method of the StudentViewModel is called to submit the new student application to the database. It returns a boolean indicating whether the submission was successful or not, allowing us to provide feedback to the user and navigate to the DetailScreen if the submission is successful, passing the newly created student application as an argument for further review and tracking of the application status.

                        if (!context.mounted) return;

                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(// If the application submission is successful, the user is navigated to the DetailScreen, passing the newly created student application as an argument, allowing them to view the details of their submitted application and track its status in the future.
                              builder: (_) => DetailScreen(
                                application: student,
                              ),
                            ),
                          );
                        }
                      },

                child: const Text("Submit"),
              ),
>>>>>>> main
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Personal Information',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: stdNo,
                  decoration: buildInputDecoration(
                    label: 'Student Number',
                    icon: Icons.badge,
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: name,
                  decoration: buildInputDecoration(
                    label: 'First Name',
                    icon: Icons.person,
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: surname,
                  decoration: buildInputDecoration(
                    label: 'Surname',
                    icon: Icons.person_outline,
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: email,
                  decoration: buildInputDecoration(
                    label: 'Email',
                    icon: Icons.email,
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: phone,
                  decoration: buildInputDecoration(
                    label: 'Phone',
                    icon: Icons.phone,
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: course,
                  decoration: buildInputDecoration(
                    label: 'Course',
                    icon: Icons.school,
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Academic Information',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                buildDropdownField(
                  label: 'Year of Study',
                  value: selectedYear,
                  items: years,
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                ),

                const SizedBox(height: 20),
            
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.upload_file,
                      color: Color(0xFF0B1F8F),
                    ),
                    title: Text(
                      selectedFileName ?? "No file selected",
                    ),
                    trailing: ElevatedButton(
                      onPressed: pickFile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B1F8F),
                      ),
                      child: const Text("Upload"),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                CheckboxListTile(
                  activeColor: const Color(0xFF0B1F8F),
                  value: eligibilityConfirmed,
                  onChanged: (value) {
                    setState(() {
                      eligibilityConfirmed = value ?? false;
                    });
                  },
                  title: const Text(
                    'I confirm eligibility',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B1F8F),
                    ),
                    onPressed: vm.isLoading
                        ? null
                        : () async {
                            if (user == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text("User not logged in"),
                                ),
                              );
                              return;
                            }

                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            final student = StudentApplication(
                              id: null,
                              userId: user.id,
                              stdNo: stdNo.text.trim(),
                              name: name.text.trim(),
                              surname: surname.text.trim(),
                              email: email.text.trim(),
                              phone: phone.text.trim(),
                              course: course.text.trim(),
                              yearOfStudy: selectedYear ?? '',
                              module1: module1Name ?? '',
                              module2: module2Name ?? '',
                              status: 'Pending',
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );

                            final success =
                                await vm.addStudent(student);

                            if (!context.mounted) return;

                            if (success) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailScreen(application: student),
                                ),
                              );
                            }
                          },
                    child: const Text(
                      "Submit Application",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}