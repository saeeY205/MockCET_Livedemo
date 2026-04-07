import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/mock_provider.dart';

class TestResultScreen extends StatelessWidget {
  const TestResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockData = context.watch<MockDataProvider>();
    const primaryColor = Color(0xFF1A237E);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            mockData.resetTest();
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          },
        ),
        title: const Text('Test Result', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFFE8F5E9),
              child: Icon(Icons.emoji_events_outlined, size: 40, color: Color(0xFF4CAF50)),
            ),
            const SizedBox(height: 16),
            const Text('Great Job!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('You have successfully completed the mock test.', style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 32),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard('Total Score', '142/200', primaryColor, const Color(0xFFE8EAF6)),
                _buildStatCard('Correct', '71', Colors.green, const Color(0xFFE8F5E9)),
                _buildStatCard('Incorrect', '14', Colors.red, const Color(0xFFFFEBEE)),
                _buildStatCard('Time', '2h 15m', Colors.blue, const Color(0xFFE3F2FD)),
              ],
            ),
            const SizedBox(height: 40),
            _buildSubjectBreakdown(primaryColor),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: () {
                  mockData.resetTest();
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                },
                icon: const Icon(Icons.refresh),
                label: const Text('RETAKE DEMO'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildSubjectBreakdown(Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('SUBJECT WISE ACCURACY', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 20),
          _subjectProgress('Physics', 0.78, color),
          const SizedBox(height: 16),
          _subjectProgress('Chemistry', 0.85, Colors.teal),
          const SizedBox(height: 16),
          _subjectProgress('Mathematics', 0.92, Colors.blue),
        ],
      ),
    );
  }

  Widget _subjectProgress(String name, double val, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            Text('${(val * 100).toInt()}%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: val,
          backgroundColor: Colors.grey.shade200,
          color: color,
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
    );
  }
}
