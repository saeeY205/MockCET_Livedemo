import 'package:flutter/material.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1A237E);
    final List<Map<String, String>> students = [
      {'name': 'Rohan Sharma', 'email': 'rohan.s@gmail.com', 'date': '2024-04-01', 'status': 'Active'},
      {'name': 'Ankita Patil', 'email': 'ankita.p@gmail.com', 'date': '2024-04-02', 'status': 'Active'},
      {'name': 'Sumeet Deshmukh', 'email': 'sumeet.d@gmail.com', 'date': '2024-03-28', 'status': 'Inactive'},
      {'name': 'Priya More', 'email': 'priya.m@gmail.com', 'date': '2024-04-05', 'status': 'Active'},
      {'name': 'Vikram Singh', 'email': 'vikram.s@gmail.com', 'date': '2024-04-06', 'status': 'Active'},
      {'name': 'Sneha Kulkarni', 'email': 'sneha.k@gmail.com', 'date': '2024-03-15', 'status': 'Inactive'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Registered Students', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          final isActive = student['status'] == 'Active';

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                backgroundColor: primaryColor.withValues(alpha: 0.1),
                child: Text(student['name']![0], style: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
              ),
              title: Text(student['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              subtitle: Text(student['email']!, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.green.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      student['status']!,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isActive ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(student['date']!, style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
