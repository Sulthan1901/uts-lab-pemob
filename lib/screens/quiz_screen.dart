import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_state.dart';
import '../models/question.dart';
import '../widgets/answer_card.dart';
import '../widgets/custom_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return const QuizScreenContent();
  }
}

class QuizScreenContent extends StatelessWidget {
  const QuizScreenContent({Key? key}) : super(key: key);

  void _submitQuiz(BuildContext context, QuizState quizState) {
    final correctAnswers = quizQuestions
        .map((q) => q.correctAnswerIndex)
        .toList();
    quizState.calculateScore(quizQuestions.length, correctAnswers);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          userName: quizState.userName,
          score: quizState.score,
          totalQuestions: quizQuestions.length,
          userAnswers: quizState.userAnswers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final quizState = Provider.of<QuizState>(context);
    final currentQuestion = quizQuestions[quizState.currentQuestionIndex];
    final isLastQuestion =
        quizState.currentQuestionIndex == quizQuestions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pertanyaan ${quizState.currentQuestionIndex + 1}/${quizQuestions.length}',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Keluar dari Kuis?'),
                content: const Text(
                  'Progress Anda akan hilang. Apakah Anda yakin?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.pop(context);
                    },
                    child: const Text('Keluar'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.all(isTablet ? 32.0 : 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Progress Indicator
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value:
                              (quizState.currentQuestionIndex + 1) /
                              quizQuestions.length,
                          minHeight: isTablet ? 12 : 10,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surfaceVariant,
                        ),
                      ),
                      SizedBox(height: isTablet ? 32 : 24),

                      // Question Card
                      Card(
                        elevation: 3,
                        child: Padding(
                          padding: EdgeInsets.all(isTablet ? 32.0 : 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isTablet ? 16 : 12,
                                      vertical: isTablet ? 8 : 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primaryContainer,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Soal ${quizState.currentQuestionIndex + 1}',
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimaryContainer,
                                        fontWeight: FontWeight.bold,
                                        fontSize: isTablet ? 16 : 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: isTablet ? 24 : 20),
                              Text(
                                currentQuestion.question,
                                style: TextStyle(
                                  fontSize: isTablet ? 24 : 20,
                                  fontWeight: FontWeight.w600,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: isTablet ? 32 : 24),

                      // Answer Options
                      ...List.generate(
                        currentQuestion.options.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                            bottom: isTablet ? 16.0 : 12.0,
                          ),
                          child: AnswerCard(
                            answer: currentQuestion.options[index],
                            isSelected:
                                quizState.getAnswerForQuestion(
                                  quizState.currentQuestionIndex,
                                ) ==
                                index,
                            onTap: () {
                              quizState.answerQuestion(
                                quizState.currentQuestionIndex,
                                index,
                              );
                            },
                            optionLabel: String.fromCharCode(65 + index),
                          ),
                        ),
                      ),
                      SizedBox(height: isTablet ? 32 : 24),

                      // Navigation Buttons
                      Row(
                        children: [
                          if (quizState.currentQuestionIndex > 0)
                            Expanded(
                              child: CustomButton(
                                text: 'Sebelumnya',
                                icon: Icons.arrow_back,
                                onPressed: quizState.previousQuestion,
                                isOutlined: true,
                              ),
                            ),
                          if (quizState.currentQuestionIndex > 0)
                            SizedBox(width: isTablet ? 16 : 12),
                          Expanded(
                            flex: quizState.currentQuestionIndex > 0 ? 1 : 1,
                            child: CustomButton(
                              text: isLastQuestion ? 'Selesai' : 'Selanjutnya',
                              icon: isLastQuestion
                                  ? Icons.check
                                  : Icons.arrow_forward,
                              onPressed: () {
                                if (!quizState.hasAnsweredQuestion(
                                  quizState.currentQuestionIndex,
                                )) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                        'Silakan pilih jawaban terlebih dahulu',
                                      ),
                                      backgroundColor: Colors.orange,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                if (isLastQuestion) {
                                  _submitQuiz(context, quizState);
                                } else {
                                  quizState.nextQuestion();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
