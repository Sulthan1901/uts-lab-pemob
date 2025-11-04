class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String? imageUrl;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    this.imageUrl,
  });
}

// Data dummy pertanyaan
final List<Question> quizQuestions = [
  Question(
    question: 'Apa ibu kota Indonesia?',
    options: ['Bandung', 'Jakarta', 'Surabaya', 'Medan'],
    correctAnswerIndex: 1,
  ),
  Question(
    question: 'Siapa presiden pertama Indonesia?',
    options: ['Soekarno', 'Soeharto', 'Habibie', 'Megawati'],
    correctAnswerIndex: 0,
  ),
  Question(
    question: 'Berapa hasil dari 15 + 25?',
    options: ['30', '35', '40', '45'],
    correctAnswerIndex: 2,
  ),
  Question(
    question: 'Planet terdekat dengan matahari adalah?',
    options: ['Venus', 'Mars', 'Merkurius', 'Bumi'],
    correctAnswerIndex: 2,
  ),
  Question(
    question: 'Bahasa pemrograman apa yang digunakan Flutter?',
    options: ['Java', 'Kotlin', 'Dart', 'Swift'],
    correctAnswerIndex: 2,
  ),
  Question(
    question: 'Berapa jumlah provinsi di Indonesia?',
    options: ['34', '35', '37', '38'],
    correctAnswerIndex: 3,
  ),
  Question(
    question: 'Siapa penemu lampu pijar?',
    options: ['Nikola Tesla', 'Thomas Edison', 'Albert Einstein', 'Isaac Newton'],
    correctAnswerIndex: 1,
  ),
  Question(
    question: 'Apa warna yang dihasilkan dari campuran merah dan biru?',
    options: ['Hijau', 'Oranye', 'Ungu', 'Coklat'],
    correctAnswerIndex: 2,
  ),
  Question(
    question: 'Berapa hari dalam satu tahun kabisat?',
    options: ['364', '365', '366', '367'],
    correctAnswerIndex: 2,
  ),
  Question(
    question: 'Apa satuan mata uang Jepang?',
    options: ['Won', 'Yuan', 'Yen', 'Ringgit'],
    correctAnswerIndex: 2,
  ),
];