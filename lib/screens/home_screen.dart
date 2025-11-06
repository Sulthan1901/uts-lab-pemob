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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Image dengan Character
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(
                    'assets/images/cat_bg.jpg',
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(
                      themeProvider.isDarkMode ? 0.6 : 0.3,
                    ),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: themeProvider.isDarkMode
                      ? [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.8),
                        ]
                      : [
                          Colors.white.withOpacity(0.8),
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.9),
                        ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          // Content
          SafeArea(
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
                        SizedBox(height: isTablet ? 32 : 24),
                        // Title dengan backdrop
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Selamat Datang!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isTablet ? 36 : 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: isTablet ? 16 : 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Uji pengetahuan Anda dengan kuis interaktif kami',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isTablet ? 18 : 16,
                              color: Colors.white.withOpacity(0.9),
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(1, 1),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: isTablet ? 48 : 40),
                        // Form Card dengan backdrop blur effect
                        Form(
                          key: _formKey,
                          child: Container(
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkMode
                                  ? Colors.black.withOpacity(0.6)
                                  : Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.3),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
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
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant
                                          .withOpacity(0.5),
                                    ),
                                    style: TextStyle(
                                      fontSize: isTablet ? 18 : 16,
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
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
                          isDarkMode: themeProvider.isDarkMode,
                        ),
                        SizedBox(height: isTablet ? 16 : 12),
                        _buildInfoCard(
                          context,
                          icon: Icons.timer_outlined,
                          title: 'Durasi',
                          value: 'Tidak Terbatas',
                          isTablet: isTablet,
                          isDarkMode: themeProvider.isDarkMode,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required bool isTablet,
    required bool isDarkMode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.black.withOpacity(0.5)
            : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 20.0 : 16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: isTablet ? 32 : 28,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(width: isTablet ? 16 : 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isTablet ? 16 : 14,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withOpacity(0.7),
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
