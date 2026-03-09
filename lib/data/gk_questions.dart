class GkQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  GkQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
    };
  }

  factory GkQuestion.fromMap(Map<String, dynamic> map) {
    return GkQuestion(
      id: map['id'],
      question: map['question'],
      options: List<String>.from(map['options']),
      correctOptionIndex: map['correctOptionIndex'],
    );
  }
}

final List<GkQuestion> generalKnowledgeQuestions = [
  GkQuestion(
    id: "gk_1",
    question: "What is the capital of France?",
    options: ["Berlin", "Madrid", "Paris", "Rome"],
    correctOptionIndex: 2,
  ),
  GkQuestion(
    id: "gk_2",
    question: "Which planet is known as the Red Planet?",
    options: ["Earth", "Mars", "Jupiter", "Saturn"],
    correctOptionIndex: 1,
  ),
  GkQuestion(
    id: "gk_3",
    question: "Who wrote 'Hamlet'?",
    options: [
      "Charles Dickens",
      "William Shakespeare",
      "Mark Twain",
      "Leo Tolstoy",
    ],
    correctOptionIndex: 1,
  ),
  GkQuestion(
    id: "gk_4",
    question: "What is the largest ocean on Earth?",
    options: [
      "Atlantic Ocean",
      "Indian Ocean",
      "Arctic Ocean",
      "Pacific Ocean",
    ],
    correctOptionIndex: 3,
  ),
  GkQuestion(
    id: "gk_5",
    question: "Which element has the chemical symbol 'O'?",
    options: ["Gold", "Oxygen", "Osmium", "Oganesson"],
    correctOptionIndex: 1,
  ),
  GkQuestion(
    id: "gk_6",
    question: "In what year did the Titanic sink?",
    options: ["1912", "1905", "1898", "1923"],
    correctOptionIndex: 0,
  ),
  GkQuestion(
    id: "gk_7",
    question: "What is the hardest natural substance on Earth?",
    options: ["Gold", "Iron", "Diamond", "Quartz"],
    correctOptionIndex: 2,
  ),
  GkQuestion(
    id: "gk_8",
    question: "How many continents are there?",
    options: ["5", "6", "7", "8"],
    correctOptionIndex: 2,
  ),
  GkQuestion(
    id: "gk_9",
    question: "Who painted the Mona Lisa?",
    options: [
      "Vincent van Gogh",
      "Pablo Picasso",
      "Leonardo da Vinci",
      "Claude Monet",
    ],
    correctOptionIndex: 2,
  ),
  GkQuestion(
    id: "gk_10",
    question: "What is the smallest country in the world?",
    options: ["Monaco", "Vatican City", "San Marino", "Liechtenstein"],
    correctOptionIndex: 1,
  ),
];

final List<GkQuestion> scienceQuestions = [
  GkQuestion(
    id: "sci_1",
    question: "What is the powerhouse of the cell?",
    options: ["Nucleus", "Ribosome", "Mitochondria", "Endoplasmic Reticulum"],
    correctOptionIndex: 2,
  ),
  GkQuestion(
    id: "sci_2",
    question: "What gas do plants primarily absorb from the atmosphere?",
    options: ["Oxygen", "Carbon Dioxide", "Nitrogen", "Hydrogen"],
    correctOptionIndex: 1,
  ),
  GkQuestion(
    id: "sci_3",
    question: "What is the chemical formula for water?",
    options: ["H2O", "CO2", "NaCl", "CH4"],
    correctOptionIndex: 0,
  ),
  GkQuestion(
    id: "sci_4",
    question: "Who developed the theory of relativity?",
    options: [
      "Isaac Newton",
      "Albert Einstein",
      "Galileo Galilei",
      "Nikola Tesla",
    ],
    correctOptionIndex: 1,
  ),
  GkQuestion(
    id: "sci_5",
    question: "At what temperature does water boil (in Celsius)?",
    options: ["50", "90", "100", "120"],
    correctOptionIndex: 2,
  ),
];

final List<GkQuestion> historyQuestions = [
  GkQuestion(
    id: "hst_1",
    question: "Who was the first President of the United States?",
    options: [
      "Abraham Lincoln",
      "Thomas Jefferson",
      "John Adams",
      "George Washington",
    ],
    correctOptionIndex: 3,
  ),
  GkQuestion(
    id: "hst_2",
    question: "In which year did World War II end?",
    options: ["1941", "1945", "1950", "1939"],
    correctOptionIndex: 1,
  ),
  GkQuestion(
    id: "hst_3",
    question: "Who discovered America in 1492?",
    options: [
      "Ferdinand Magellan",
      "Christopher Columbus",
      "Marco Polo",
      "Vasco da Gama",
    ],
    correctOptionIndex: 1,
  ),
  GkQuestion(
    id: "hst_4",
    question: "Which ancient civilization built the pyramids of Giza?",
    options: ["Romans", "Greeks", "Egyptians", "Mayans"],
    correctOptionIndex: 2,
  ),
  GkQuestion(
    id: "hst_5",
    question: "Who was the British Prime Minister during most of World War II?",
    options: [
      "Neville Chamberlain",
      "Clement Attlee",
      "Winston Churchill",
      "Tony Blair",
    ],
    correctOptionIndex: 2,
  ),
];

final List<GkQuestion> geographyQuestions = [
  GkQuestion(
    id: "geo_1",
    question: "Which is the longest river in the world?",
    options: [
      "Amazon River",
      "Nile River",
      "Yangtze River",
      "Mississippi River",
    ],
    correctOptionIndex: 1,
  ),
  GkQuestion(
    id: "geo_2",
    question: "What is the capital of Japan?",
    options: ["Seoul", "Beijing", "Tokyo", "Kyoto"],
    correctOptionIndex: 2,
  ),
  GkQuestion(
    id: "geo_3",
    question: "Which desert is the largest in the world?",
    options: ["Gobi", "Kalahari", "Sahara", "Antarctica"],
    correctOptionIndex: 3,
  ),
  GkQuestion(
    id: "geo_4",
    question: "Mount Everest is located in which mountain range?",
    options: ["Andes", "Rockies", "Alps", "Himalayas"],
    correctOptionIndex: 3,
  ),
  GkQuestion(
    id: "geo_5",
    question: "Which country has the most population?",
    options: ["USA", "India", "China", "Russia"],
    correctOptionIndex: 1, // Currently India holds the title
  ),
];

final List<GkQuestion> sportsQuestions = [
  GkQuestion(
    id: "spt_1",
    question: "In which sport is the term 'Home Run' used?",
    options: ["Basketball", "Cricket", "Baseball", "Tennis"],
    correctOptionIndex: 2,
  ),
  GkQuestion(
    id: "spt_2",
    question: "How many players are there in a soccer team on the field?",
    options: ["9", "10", "11", "12"],
    correctOptionIndex: 2,
  ),
  GkQuestion(
    id: "spt_3",
    question: "Which country won the FIFA World Cup in 2022?",
    options: ["France", "Brazil", "Argentina", "Germany"],
    correctOptionIndex: 2,
  ),
  GkQuestion(
    id: "spt_4",
    question: "In tennis, what is a score of zero called?",
    options: ["Zero", "Love", "Nil", "Blank"],
    correctOptionIndex: 1,
  ),
  GkQuestion(
    id: "spt_5",
    question: "The Olympics are held every how many years?",
    options: ["2", "3", "4", "5"],
    correctOptionIndex: 2,
  ),
];
