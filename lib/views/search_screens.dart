import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_application/viewmodel/viewmodel.dart';
import '../model/model.dart';

class PersonDetailsDialog extends StatelessWidget {
  const PersonDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentViewModel>(
      builder: (context, vm, _) {
        final person = vm.selectedPerson!;
        return AlertDialog(
          backgroundColor: Colors.white, 
          title: Text(
            "${person.name}  ${person.surname}",
            style: const TextStyle(
              color: Colors.black87, 
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Details:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, 
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.email,
                    size: 20,
                    color: Colors.black54,
                  ), // Dark icon
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      person.email,
                      style: const TextStyle(
                        color: Colors.black87,
                      ), // Dark text
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 20,
                    color: Colors.black54,
                  ), // Dark icon
                  const SizedBox(width: 8),
                  Text(
                    person.stdNo,
                    style: const TextStyle(color: Colors.black87), // Dark text
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: Colors.black54,
                  ), // Dark icon
                  const SizedBox(width: 8),
                  Text(
                    person.yearOfStudy,
                    style: const TextStyle(color: Colors.black87), // Dark text
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.school,
                    size: 20,
                    color: Colors.black54,
                  ), // Dark icon
                  const SizedBox(width: 8),
                  Text(
                    person.course,
                    style: const TextStyle(color: Colors.black87), // Dark text
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.book,
                    size: 20,
                    color: Colors.black54,
                  ), // Dark icon
                  const SizedBox(width: 8),
                  Text(
                    person.module1,
                    style: const TextStyle(color: Colors.black87), // Dark text
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.book,
                    size: 20,
                    color: Colors.black54,
                  ), // Dark icon
                  const SizedBox(width: 8),
                  Text(
                    person.module2,
                    style: const TextStyle(color: Colors.black87), // Dark text
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.blue), // Blue for visibility
              ),
            ),
          ],
        );
      },
    );
  }
}

class SearchDialog extends StatelessWidget {
  const SearchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white, // White background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ChangeNotifierProvider(
        create: (_) =>
            StudentViewModel()
              ..loadPersons(_getMockData(context).cast<StudentApplication>()),
        child: Consumer<StudentViewModel>(
          builder: (context, viewModel, child) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Header
                  const Row(
                    children: [
                      Icon(Icons.search, size: 24, color: Colors.black87),
                      SizedBox(width: 8),
                      Text(
                        'Search Person',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Search Input Field
                  TextField(
                    autofocus:
                        true, //as soon as keywords are on the screen its gets to working on the search
                    style: const TextStyle(color: Colors.black87), // Dark text
                    decoration: InputDecoration(
                      hintText: 'Name, email, or student number...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                      ), // Visible hint
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                      suffixIcon: viewModel.isSearching
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                viewModel.clearSearch();
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50, // Light gray background
                    ),
                    onChanged: viewModel.search,
                  ),
                  const SizedBox(height: 16),

                  // Results count
                  if (viewModel.isSearching)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${viewModel.searchResults.length} result${viewModel.searchResults.length != 1 ? 's' : ''} found',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors
                              .grey
                              .shade700, // Darker gray for visibility
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  const SizedBox(height: 12),

                  // Results List
                  Expanded(child: _buildResults(viewModel, context)),

                  const SizedBox(height: 12),

                  // Close button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Close',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildResults(StudentViewModel viewModel, BuildContext context) {
    // if you are Not searching
    if (!viewModel.isSearching) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 48, color: Colors.black45),
            SizedBox(height: 8),
            Text(
              'Start typing to search',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      );
    }

    // when there's No results
    if (viewModel.searchResults.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_off, size: 48, color: Colors.black45),
            SizedBox(height: 8),
            Text(
              'No persons found',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      );
    }

    //if there is results
    return ListView.builder(
      itemCount: viewModel.searchResults.length,
      itemBuilder: (context, index) {
        final person = viewModel.searchResults[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text(
                person.name,
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              person.name, //casting
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              person.email,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.black54),
            onTap: () {
              viewModel.selectPerson(person);
              showDialog(
                context: context,
                builder: (_) => ChangeNotifierProvider.value(
                  value: viewModel,
                  child: const PersonDetailsDialog(),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Mock data - will be repaced with database
  List<StudentApplication> _getMockData(BuildContext context) {
    return [
      StudentApplication(
        stdNo: '223672435',
        name: 'John',
        email: '223672435@gmailcom',
        surname: 'Johns',
        yearOfStudy: '2023',
        course: 'IT',
        module1: 'SOD',
        module2: 'TPG',
      ),
      StudentApplication(
        stdNo: '224067592',
        name: 'Jane ',
        email: 'jane@example.com',
        surname: 'Smith',
        yearOfStudy: '2024',
        course: 'CMN',
        module1: 'SOD',
        module2: 'TPG',
      ),
      StudentApplication(
        stdNo: '225673421',
        name: 'Bob ',
        email: 'bob@example.com',
        surname: 'Johnson',
        yearOfStudy: '2025',
        course: 'CMN',
        module1: 'CMN',
        module2: 'TPG',
      ),
      StudentApplication(
        stdNo: '222786902',
        name: 'Alice ',
        email: 'alice@example.com',
        surname: 'Brown',
        yearOfStudy: '2025',
        course: 'IT',
        module1: 'SSE',
        module2: 'TPG',
      ),
      StudentApplication(
        stdNo: '224675893',
        name: 'Charlie ',
        email: 'charlie@example.com',
        surname: 'Wilson',
        yearOfStudy: '2026',
        course: 'IT',
        module1: 'SOD',
        module2: 'TPG',
      ),
      StudentApplication(
        stdNo: '224674011',
        name: 'Diana ',
        email: 'diana@example.com',
        surname: 'Prince',
        yearOfStudy: '2026',
        course: 'IT',
        module1: 'SOD',
        module2: 'SOE',
      ),
    ];
  }
}
