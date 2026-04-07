import 'package:flutter/material.dart';

class MockDataProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userRole;

  bool get isLoggedIn => _isLoggedIn;
  String? get userRole => _userRole;

  void login(String email, String password) {
    if (email == 'admin@gmail.com' && password == '123456') {
      _isLoggedIn = true;
      _userRole = 'admin';
    } else {
      _isLoggedIn = true;
      _userRole = 'student';
    }
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userRole = null;
    notifyListeners();
  }

  List<Map<String, String>> get availableTests => [
        {
          'id': 'pcm_mock_11',
          'title': 'PCM Full Mock Test 11',
          'duration': '180 Min',
          'questions': '150',
          'isRandom': 'true',
        },
        {
          'id': 'pcm_mock_12',
          'title': 'PCM Practice Test 05',
          'duration': '90 Min',
          'questions': '75',
          'isRandom': 'false',
        },
      ];

  final Map<int, int> _answers = {};
  final Set<int> _markedForReview = {};
  final Set<int> _visited = {0};

  Map<int, int> get answers => _answers;
  Set<int> get markedForReview => _markedForReview;
  Set<int> get visited => _visited;

  void setAnswer(int qIdx, int optionIdx) {
    _answers[qIdx] = optionIdx;
    notifyListeners();
  }

  void clearAnswer(int qIdx) {
    _answers.remove(qIdx);
    notifyListeners();
  }

  void toggleMarkForReview(int qIdx) {
    if (_markedForReview.contains(qIdx)) {
      _markedForReview.remove(qIdx);
    } else {
      _markedForReview.add(qIdx);
    }
    notifyListeners();
  }

  void markVisited(int qIdx) {
    _visited.add(qIdx);
    notifyListeners();
  }

  void resetTest() {
    _answers.clear();
    _markedForReview.clear();
    _visited.clear();
    _visited.add(0);
    notifyListeners();
  }
}

class Question {
  final String text;
  final List<String> options;
  final int correctAnswer;
  final String subject;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
    required this.subject,
  });
}

final List<Question> demoQuestions = [
  Question(
    text: "A rectangular block of mass 'm' and cross-sectional area A, floats on a liquid of density 'ρ'. It is given a small vertical displacement from equilibrium, it starts oscillating with frequency 'n' equal to (g = acceleration due to gravity)",
    options: ["2π √(m/Aρg)", "2π √(Aρg/m)", "(1/2π) √(m/Aρg)", "(1/2π) √(Aρg/m)"],
    correctAnswer: 3,
    subject: "Physics",
  ),
  Question(
    text: "A solenoid 2 m long and 4 cm in diameter has 4 layers of windings of 1000 turns each and carries a current of 5 A. What is the magnetic field at its centre along the axis? [μ₀ = 4π × 10⁻⁷ Wb/Am]",
    options: ["2π × 10⁻³ T", "4π × 10⁻³ T", "10⁻³ T", "8π × 10⁻³ T"],
    correctAnswer: 3,
    subject: "Physics",
  ),
  Question(
    text: "If f(x) = log(sin x), then f'(π/4) is equal to",
    options: ["1", "0", "√2", "-1"],
    correctAnswer: 0,
    subject: "Mathematics",
  ),
];
