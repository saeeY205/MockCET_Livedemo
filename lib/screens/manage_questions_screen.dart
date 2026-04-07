import 'package:flutter/material.dart';

class ManageQuestionsScreen extends StatelessWidget {
  const ManageQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1A237E);
    final List<Map<String, String>> questions = [
      {'text': 'The dimensional formula for gravitational constant G is...', 'subject': 'Physics', 'topic': 'Units & Measurement'},
      {'text': 'Equal volumes of all gases under same conditions of temperature and pressure contain...', 'subject': 'Chemistry', 'topic': 'Some Basic Concepts of Chemistry'},
      {'text': 'If A and B are two sets such that n(A) = 15, n(B) = 20...', 'subject': 'Mathematics', 'topic': 'Sets & Functions'},
      {'text': 'The speed of light in vacuum is exactly...', 'subject': 'Physics', 'topic': 'Modern Physics'},
      {'text': 'The oxidation number of Oxygen in OF2 is...', 'subject': 'Chemistry', 'topic': 'Redox Reactions'},
      {'text': 'The derivative of sin(x) with respect to x is...', 'subject': 'Mathematics', 'topic': 'Calculus'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Manage Questions', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: primaryColor),
                hintText: 'Search questions or topics...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final q = questions[index];
                final subjectColor = q['subject'] == 'Physics' ? Colors.blue : (q['subject'] == 'Chemistry' ? Colors.orange : Colors.green);

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
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: subjectColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.description_outlined, color: subjectColor, size: 24),
                    ),
                    title: Text(q['text']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: subjectColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(q['subject']!, style: TextStyle(color: subjectColor, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              q['topic']!,
                              style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const Icon(Icons.edit_outlined, color: Colors.grey, size: 18),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
