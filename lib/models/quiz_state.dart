import 'package:flutter/foundation.dart';

class QuizState extends ChangeNotifier {
  String _userName = '';
  int _currentQuestionIndex = 0;
  final Map<int, int> _userAnswers = {};
  int _score = 0;

  String get userName => _userName;
  int get currentQuestionIndex => _currentQuestionIndex;
  Map<int, int> get userAnswers => _userAnswers;
  int get score => _score;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void answerQuestion(int questionIndex, int answerIndex) {
    _userAnswers[questionIndex] = answerIndex;
    notifyListeners();
  }

  void nextQuestion() {
    _currentQuestionIndex++;
    notifyListeners();
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  void calculateScore(int totalQuestions, List<int> correctAnswers) {
    _score = 0;
    for (int i = 0; i < totalQuestions; i++) {
      if (_userAnswers[i] == correctAnswers[i]) {
        _score++;
      }
    }
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _userAnswers.clear();
    _score = 0;
    notifyListeners();
  }

  bool hasAnsweredQuestion(int questionIndex) {
    return _userAnswers.containsKey(questionIndex);
  }

  int? getAnswerForQuestion(int questionIndex) {
    return _userAnswers[questionIndex];
  }
}