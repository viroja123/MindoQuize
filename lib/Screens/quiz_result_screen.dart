import 'package:flutter/material.dart';
import 'package:mindo_quize/config/app.color.dart';
import 'package:mindo_quize/Services/leaderboard_service.dart';

class QuizResultScreen extends StatefulWidget {
  final int score;
  final int totalQuestions;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveScore() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() => _isSaving = true);

    await LeaderboardService.addEntry(
      LeaderboardEntry(
        name: name,
        score: widget.score,
        totalQuestions: widget.totalQuestions,
        date: DateTime.now(),
      ),
    );

    if (!mounted) return;
    setState(() => _isSaving = false);

    // Go back to main tabs screen
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/mainTabsScreenApp',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    double finalPercentage = (widget.score / widget.totalQuestions) * 100;
    String feedbackText = "";
    Color feedbackColor = AppColors.primary;

    if (finalPercentage >= 80) {
      feedbackText = "Excellent! 🎉";
      feedbackColor = AppColors.success;
    } else if (finalPercentage >= 50) {
      feedbackText = "Good Job! 👍";
      feedbackColor = AppColors.warning;
    } else {
      feedbackText = "Keep Practicing! 💪";
      feedbackColor = AppColors.error;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Quiz Complete'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.5, end: 1.0),
                duration: const Duration(seconds: 1),
                curve: Curves.elasticOut,
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: feedbackColor.withOpacity(0.1),
                        border: Border.all(
                          color: feedbackColor.withOpacity(0.4),
                          width: 8,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: feedbackColor.withOpacity(0.3 * value),
                            blurRadius: 30 * value,
                            spreadRadius: 10 * value,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${widget.score}',
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: feedbackColor,
                              height: 1.0,
                            ),
                          ),
                          Text(
                            'out of ${widget.totalQuestions}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Text(
                feedbackText,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: feedbackColor,
                ),
              ),
              const SizedBox(height: 50),

              // Name Input for Leaderboard
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Add to Live Leaderboard',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                      textCapitalization: TextCapitalization.words,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isSaving ? null : _saveScore,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: _isSaving
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Save Score',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/mainTabsScreenApp',
                    (route) => false,
                  );
                },
                child: const Text(
                  'Skip to Home',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
