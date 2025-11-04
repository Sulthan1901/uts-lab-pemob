import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../models/quiz_state.dart';
import '../widgets/custom_button.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (_formKey.currentState!.validate()) {
      final quizState = Provider.of<QuizState>(context, listen: false);
      quizState.setUserName(_nameController.text.trim());
      quizState.resetQuiz();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QuizScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? screenSize.width * 0.2 : 24.0,
                vertical: 24.0,
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.quiz,
                      size: isTablet ? 120 : 100,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: isTablet ? 32 : 24),
                    Text(
                      'Selamat Datang!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isTablet ? 36 : 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                      ),
                    ),
                    SizedBox(height: isTablet ? 16 : 12),
                    Text(
                      'Uji pengetahuan Anda dengan kuis interaktif kami',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isTablet ? 18 : 16,
                        color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: isTablet ? 48 : 40),
                    Form(
                      key: _formKey,
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(isTablet ? 32.0 : 24.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Nama Anda',
                                  hintText: 'Masukkan nama lengkap',
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                                ),
                                style: TextStyle(fontSize: isTablet ? 18 : 16),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Nama tidak boleh kosong';
                                  }
                                  if (value.trim().length < 3) {
                                    return 'Nama minimal 3 karakter';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: isTablet ? 32 : 24),
                              CustomButton(
                                text: 'Mulai Kuis',
                                icon: Icons.play_arrow,
                                onPressed: _startQuiz,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: isTablet ? 32 : 24),
                    _buildInfoCard(
                      context,
                      icon: Icons.help_outline,
                      title: 'Total Pertanyaan',
                      value: '10 Soal',
                      isTablet: isTablet,
                    ),
                    SizedBox(height: isTablet ? 16 : 12),
                    _buildInfoCard(
                      context,
                      icon: Icons.timer_outlined,
                      title: 'Durasi',
                      value: 'Tidak Terbatas',
                      isTablet: isTablet,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required bool isTablet,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 20.0 : 16.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: isTablet ? 32 : 28,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(width: isTablet ? 16 : 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isTablet ? 16 : 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}