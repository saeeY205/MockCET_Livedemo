import 'package:flutter/material.dart';

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({super.key});

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  bool _isAccepted = false;
  static const Color primaryColor = Color(0xFF1A237E);
  static const Color scaffoldBg = Color(0xFFF5F7FA);

  @override
  Widget build(BuildContext context) {
    final testInfo = ModalRoute.of(context)?.settings.arguments as Map<String, String>? ??
        {
          'title': 'Mock Test',
          'duration': '180 Min',
          'questions': '150',
          'subjects': 'PCM',
        };

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Test Instructions',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  _buildTestOverviewCard(testInfo),
                  const SizedBox(height: 20),
                  _buildMarkingSchemeCard(),
                  const SizedBox(height: 20),
                  _buildGeneralInstructionsCard(),
                  const SizedBox(height: 20),
                  _buildTestStructureCard(),
                  const SizedBox(height: 20),
                  _buildTimerRulesCard(),
                  const SizedBox(height: 24),
                  _buildConfirmationCheckbox(),
                  const SizedBox(height: 80), // Extra space for buttons
                ],
              ),
            ),
          ),
          _buildBottomButtons(testInfo),
        ],
      ),
    );
  }

  Widget _buildCard({required List<Widget> children, Color? color}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 24),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTestOverviewCard(Map<String, String> testInfo) {
    final title = testInfo['title'] ?? 'Mock Test';
    final duration = testInfo['duration'] ?? '180 Min';
    final questions = testInfo['questions'] ?? '150';

    return _buildCard(
      color: Colors.white,
      children: [
        _buildSectionTitle('Test Overview', Icons.assignment_outlined),
        const SizedBox(height: 20),
        _buildOverviewRow(Icons.title, 'Test Name', title),
        const Divider(height: 20),
        _buildOverviewRow(Icons.timer_outlined, 'Duration', duration),
        const Divider(height: 20),
        _buildOverviewRow(Icons.quiz_outlined, 'Total Questions', '$questions Qs'),
        const Divider(height: 20),
        _buildOverviewRow(Icons.subject, 'Subjects', 'Physics, Chemistry, Mathematics'),
        const Divider(height: 20),
        _buildOverviewRow(Icons.score_outlined, 'Max Marks', '200 Marks'),
      ],
    );
  }

  Widget _buildOverviewRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _buildMarkingSchemeCard() {
    return _buildCard(
      children: [
        _buildSectionTitle('Marking Scheme', Icons.fact_check_outlined),
        const SizedBox(height: 16),
        _buildSchemeItem('Physics', '50 Questions × 1 Mark'),
        _buildSchemeItem('Chemistry', '50 Questions × 1 Mark'),
        _buildSchemeItem('Mathematics', '50 Questions × 2 Marks'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
          ),
          child: const Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
              SizedBox(width: 10),
              Text(
                'No negative marking',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSchemeItem(String subject, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(subject, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 14)),
          Text(detail, style: const TextStyle(color: Colors.black54, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildGeneralInstructionsCard() {
    return _buildCard(
      children: [
        _buildSectionTitle('General Instructions', Icons.info_outline),
        const SizedBox(height: 16),
        _buildInstructionItem('This is a mock test based on MHT-CET pattern'),
        _buildInstructionItem('Read each question carefully before answering'),
        _buildInstructionItem('Do not refresh or close the app during the test'),
        _buildInstructionItem('Ensure stable internet connection'),
      ],
    );
  }

  Widget _buildTestStructureCard() {
    return _buildCard(
      children: [
        _buildSectionTitle('Test Structure', Icons.grid_view_rounded),
        const SizedBox(height: 16),
        _buildInstructionItem('Questions from Physics, Chemistry, Mathematics'),
        _buildInstructionItem('Allow navigation between questions'),
        _buildInstructionItem('Review and change answers before submission'),
      ],
    );
  }

  Widget _buildTimerRulesCard() {
    return _buildCard(
      children: [
        _buildSectionTitle('Timer Rules', Icons.timer_outlined),
        const SizedBox(height: 16),
        _buildInstructionItem('Countdown timer of 180 minutes'),
        _buildInstructionItem('Test auto-submits when time expires', color: Colors.red),
        _buildInstructionItem('Test cannot be paused once started'),
      ],
    );
  }

  Widget _buildInstructionItem(String text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 6, color: color ?? Colors.grey[400]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: color ?? Colors.black87, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationCheckbox() {
    return InkWell(
      onTap: () => setState(() => _isAccepted = !_isAccepted),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isAccepted ? primaryColor.withValues(alpha: 0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _isAccepted ? primaryColor : Colors.grey.shade300, width: 1.5),
        ),
        child: Row(
          children: [
            Checkbox(
              value: _isAccepted,
              onChanged: (v) => setState(() => _isAccepted = v!),
              activeColor: primaryColor,
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'I have read and understood all instructions',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons(Map<String, String> testInfo) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -5)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: primaryColor, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Back', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _isAccepted
                  ? () {
                      Navigator.pushReplacementNamed(context, '/test', arguments: testInfo);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Start Test', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
