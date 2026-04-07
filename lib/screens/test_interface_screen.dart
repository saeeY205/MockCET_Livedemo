import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/mock_provider.dart';
import 'test_result_screen.dart';

class TestInterfaceScreen extends StatefulWidget {
  final Map<String, String> test;
  const TestInterfaceScreen({super.key, required this.test});

  @override
  State<TestInterfaceScreen> createState() => _TestInterfaceScreenState();
}

class _TestInterfaceScreenState extends State<TestInterfaceScreen> {
  int _currentIdx = 0;
  int _timeLeft = 10800; // 3 hours
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final h = (seconds ~/ 3600).toString().padLeft(2, '0');
    final m = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final mockData = context.watch<MockDataProvider>();
    final questions = demoQuestions;
    final question = questions[_currentIdx];
    const primaryColor = Color(0xFF1A237E);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('PVP MockCET', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(widget.test['title']!, style: const TextStyle(fontSize: 10, color: Colors.white70)),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer_outlined, size: 14),
                const SizedBox(width: 4),
                Text(_formatTime(_timeLeft), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildQuestionHeader(primaryColor),
          Expanded(child: _buildQuestionArea(question, mockData, primaryColor)),
          _buildPalette(mockData, questions.length, primaryColor),
          _buildNavigation(mockData, questions.length, primaryColor),
        ],
      ),
    );
  }

  Widget _buildQuestionHeader(Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('QUESTION ${_currentIdx + 1}', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
          ),
          const Row(
            children: [
              CircleAvatar(radius: 4, backgroundColor: Colors.indigo),
              SizedBox(width: 8),
              Text('PHYSICS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionArea(Question question, MockDataProvider mockData, Color color) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question.text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 1.6)),
          const SizedBox(height: 32),
          ...List.generate(question.options.length, (idx) {
            final isSelected = mockData.answers[_currentIdx] == idx;
            return InkWell(
              onTap: () => mockData.setAnswer(_currentIdx, idx),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? color.withValues(alpha: 0.05) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isSelected ? color : Colors.grey.shade200, width: isSelected ? 2 : 1),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? color : Colors.grey.shade100,
                      ),
                      child: Center(
                        child: Text(
                          String.fromCharCode(65 + idx),
                          style: TextStyle(color: isSelected ? Colors.white : color, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: Text(question.options[idx], style: TextStyle(fontSize: 14, color: isSelected ? color : Colors.black87))),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPalette(MockDataProvider mockData, int count, Color color) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: count,
        itemBuilder: (context, idx) {
          final isCurrent = _currentIdx == idx;
          final isAnswered = mockData.answers.containsKey(idx);
          final isMarked = mockData.markedForReview.contains(idx);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => setState(() => _currentIdx = idx),
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                  color: isAnswered ? const Color(0xFF4CAF50) : (isMarked ? Colors.orange : Colors.white),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: isCurrent ? color : Colors.grey.shade300, width: isCurrent ? 2 : 1),
                ),
                child: Center(
                  child: Text(
                    '${idx + 1}',
                    style: TextStyle(color: (isAnswered || isMarked) ? Colors.white : Colors.black54, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavigation(MockDataProvider mockData, int count, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.grey.shade100, border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () => mockData.toggleMarkForReview(_currentIdx), icon: const Icon(Icons.outlined_flag), tooltip: 'Mark'),
          IconButton(onPressed: () => mockData.clearAnswer(_currentIdx), icon: const Icon(Icons.delete_outline), tooltip: 'Clear'),
          Row(
            children: [
              OutlinedButton(
                onPressed: _currentIdx > 0 ? () => setState(() => _currentIdx--) : null,
                style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('BACK'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _currentIdx < count - 1 
                  ? () => setState(() => _currentIdx++) 
                  : () { _showResult(); },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(_currentIdx < count - 1 ? 'NEXT' : 'FINISH'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showResult() {
     _timer?.cancel();
     Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => const TestResultScreen()),
     );
  }
}
