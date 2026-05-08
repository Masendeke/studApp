import 'package:flutter/material.dart';
//import '../viewmodel/viewmodel.dart';

class Admindashboardscreen extends StatelessWidget {
  const Admindashboardscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade300),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            _buildSummaryCards(),
            const SizedBox(height: 10),
             _searchBar(),
             const SizedBox(height: 10),
             _buildApplications(),
             const SizedBox(height: 10),
             ]
             ),
      ),
    );
  }
}

Widget _buildSummaryCards() {
  return Container(
    padding: EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //row1
        Row(
          children: [
            Expanded(
              child: Card(
                child: Column(
                  children: [
                    Icon(Icons.people, color: Colors.blue),
                    //Varible,
                    Text('TOTAL APPS'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Card(
                child: Column(
                  children: [
                    Icon(Icons.access_time, color: Colors.grey),
                    //Varible,
                    Text('PENDING'),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        //row2
        Row(
          children: [
            Expanded(
              child: Card(
                child: Column(
                  children: [
                    Icon(Icons.check, color: Colors.green),
                    //Varible,
                    Text('APPROVED'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Card(
                child: Column(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red),
                    //Varible,
                    Text('REJECTED '),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _searchBar() {
  return Column(
    children: [
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search Students...',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      const SizedBox(width: 8,),
     IconButton(
      icon: const Icon(Icons.filter_list, color: Colors.grey,),
      onPressed: () {}
      )
    ],
  );
}


Widget _buildApplications(){
  return Column(
    children: [
      Row(
        children: [
          Text('RECENT APPLICATIONS'),
          const SizedBox(width: 20,),
          Text('View All'),
        ],
      ),

/**applications
 * -
 * -
 * -
 * -
 * -
 * -
 */

    ],
  );
}//testing
