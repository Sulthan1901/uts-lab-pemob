import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/score_card.dart';
import '../models/question.dart';
import 'home_screen.dart';

class ResultScreen extends StatefulWidget {
  final String userName;
  final int score;
  final int totalQuestions;
  final Map<int, int> userAnswers;

  const ResultScreen({
    Key? key,
    required this.userName,
    required this.score,
    required this.totalQuestions,
    required this.userAnswers,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getResultMessage() {
    final percentage = (widget.score / widget.totalQuestions) * 100;
    if (percentage >= 80) return 'Luar Biasa! 🎉';
    if (percentage >= 60) return 'Bagus Sekali! 👍';
    if (percentage >= 40) return 'Cukup Baik! 💪';
    return 'Tetap Semangat! 📚';
  }

  Color _getResultColor() {
    final percentage = (widget.score / widget.totalQuestions) * 100;
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.blue;
    if (percentage >= 40) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final percentage = (widget.score / widget.totalQuestions * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Kuis'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 32.0 : 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: isTablet ? 120 : 100,
                        color: _getResultColor(),
                      ),
                      SizedBox(height: isTablet ? 24 : 16),
                      Text(
                        _getResultMessage(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isTablet ? 32 : 28,
                          fontWeight: FontWeight.bold,
                          color: _getResultColor(),
                        ),
                      ),
                      SizedBox(height: isTablet ? 12 : 8),
                      Text(
                        widget.userName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isTablet ? 24 : 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isTablet ? 40 : 32),

                // Score Cards
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (isTablet) {
                      return Row(
                        children: [
                          Expanded(
                            child: ScoreCard(
                              title: 'Nilai Anda',
                              value: '$percentage%',
                              icon: Icons.grade,
                              color: _getResultColor(),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ScoreCard(
                              title: 'Benar',
                              value: '${widget.score}/${widget.totalQuestions}',
                              icon: Icons.check_circle,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          ScoreCard(
                            title: 'Nilai Anda',
                            value: '$percentage%',
                            icon: Icons.grade,
                            color: _getResultColor(),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ScoreCard(
                                  title: 'Benar',
                                  value: '${widget.score}',
                                  icon: Icons.check_circle,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ScoreCard(
                                  title: 'Salah',
                                  value: '${widget.totalQuestions - widget.score}',
                                  icon: Icons.cancel,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: isTablet ? 32 : 24),

                // Review Answers
                Card(
                  child: ExpansionTile(
                    title: Text(
                      'Lihat Pembahasan',
                      style: TextStyle(
                        fontSize: isTablet ? 18 : 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    leading: const Icon(Icons.list_alt),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(isTablet ? 20.0 : 16.0),
                        child: Column(
                          children: List.generate(
                            widget.totalQuestions,
                            (index) {
                              final question = quizQuestions[index];
                              final userAnswer = widget.userAnswers[index];
                              final isCorrect = userAnswer == question.correctAnswerIndex;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: EdgeInsets.all(isTablet ? 16.0 : 12.0),
                                decoration: BoxDecoration(
                                  color: isCorrect
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isCorrect ? Colors.green : Colors.red,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          isCorrect ? Icons.check_circle : Icons.cancel,
                                          color: isCorrect ? Colors.green : Colors.red,
                                          size: isTablet ? 24 : 20,
                                        ),
                                        SizedBox(width: isTablet ? 12 : 8),
                                        Expanded(
                                          child: Text(
                                            'Soal ${index + 1}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: isTablet ? 16 : 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: isTablet ? 12 : 8),
                                    Text(
                                      question.question,
                                      style: TextStyle(
                                        fontSize: isTablet ? 16 : 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: isTablet ? 8 : 6),
                                    if (userAnswer != null) ...[
                                      Text(
                                        'Jawaban Anda: ${question.options[userAnswer]}',
                                        style: TextStyle(
                                          color: isCorrect ? Colors.green : Colors.red,
                                          fontSize: isTablet ? 15 : 13,
                                        ),
                                      ),
                                      if (!isCorrect) ...[
                                        SizedBox(height: isTablet ? 4 : 2),
                                        Text(
                                          'Jawaban Benar: ${question.options[question.correctAnswerIndex]}',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w600,
                                            fontSize: isTablet ? 15 : 13,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isTablet ? 32 : 24),

                // Action Buttons
                CustomButton(
                  text: 'Kembali ke Beranda',
                  icon: Icons.home,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}