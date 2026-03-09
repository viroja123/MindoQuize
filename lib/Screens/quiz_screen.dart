import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindo_quize/config/app.color.dart';
import 'package:mindo_quize/data/gk_questions.dart';
import 'package:mindo_quize/Screens/quiz_result_screen.dart';
import 'package:mindo_quize/Services/bookmark_service.dart';

class QuizScreen extends StatefulWidget {
  final List<GkQuestion> questions;
  const QuizScreen({super.key, required this.questions});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  bool _hasAnswered = false;
  int? _selectedOptionIndex;
  late Timer _timer;
  int _timeLeft = 15;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _checkBookmarkStatus();
  }

  void _checkBookmarkStatus() async {
    bool status = await BookmarkService.isBookmarked(
      widget.questions[_currentIndex].id,
    );
    if (mounted) {
      setState(() {
        _isBookmarked = status;
      });
    }
  }

  void _toggleBookmark() async {
    HapticFeedback.selectionClick();
    await BookmarkService.toggleBookmark(widget.questions[_currentIndex]);
    _checkBookmarkStatus();
  }

  void _startTimer() {
    _timeLeft = 15;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer.cancel();
          _handleTimeOut();
        }
      });
    });
  }

  void _handleTimeOut() {
    if (!_hasAnswered) {
      _selectAnswer(-1); // -1 means no selection (timeout)
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _selectAnswer(int index) {
    if (_hasAnswered) return;
    HapticFeedback.lightImpact();
    _timer.cancel();

    setState(() {
      _hasAnswered = true;
      _selectedOptionIndex = index;
      if (index == widget.questions[_currentIndex].correctOptionIndex) {
        _score++;
      }
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (_currentIndex < widget.questions.length - 1) {
        setState(() {
          _currentIndex++;
          _hasAnswered = false;
          _selectedOptionIndex = null;
        });
        _checkBookmarkStatus();
        _startTimer();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizResultScreen(
              score: _score,
              totalQuestions: widget.questions.length,
            ),
          ),
        );
      }
    });
  }

  Color _getOptionColor(int index) {
    if (!_hasAnswered) return Colors.white;
    int correctIndex = widget.questions[_currentIndex].correctOptionIndex;
    if (index == correctIndex) return AppColors.success.withOpacity(0.9);
    if (index == _selectedOptionIndex && index != correctIndex) {
      return AppColors.error.withOpacity(0.9);
    }
    return Colors.white;
  }

  Color _getOptionBorderColor(int index) {
    if (!_hasAnswered) return Colors.grey.shade300;
    int correctIndex = widget.questions[_currentIndex].correctOptionIndex;
    if (index == correctIndex) return AppColors.success;
    if (index == _selectedOptionIndex && index != correctIndex) {
      return AppColors.error;
    }
    return Colors.grey.shade300;
  }

  Color _getOptionTextColor(int index) {
    if (!_hasAnswered) return AppColors.textPrimary;
    int correctIndex = widget.questions[_currentIndex].correctOptionIndex;
    if (index == correctIndex || index == _selectedOptionIndex)
      return Colors.white;
    return AppColors.textPrimary;
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            color: AppColors.primary,
            onPressed: _toggleBookmark,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress and Timer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${_currentIndex + 1}/${widget.questions.length}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _timeLeft <= 5
                          ? AppColors.error.withOpacity(0.1)
                          : AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: _timeLeft <= 5
                              ? AppColors.error
                              : AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '00:${_timeLeft.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _timeLeft <= 5
                                ? AppColors.error
                                : AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LinearProgressIndicator(
                value: (_currentIndex + 1) / widget.questions.length,
                backgroundColor: Colors.grey.shade200,
                color: AppColors.primary,
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 40),

              // Question Card
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
                child: Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),

              // Options
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: question.options.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _selectAnswer(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: _getOptionColor(index),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _getOptionBorderColor(index),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    _getOptionTextColor(index) == Colors.white
                                    ? Colors.white.withOpacity(0.2)
                                    : Colors.grey.shade100,
                              ),
                              child: Text(
                                String.fromCharCode(65 + index), // A, B, C, D
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _getOptionTextColor(index),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                question.options[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: _getOptionTextColor(index),
                                ),
                              ),
                            ),
                            if (_hasAnswered &&
                                index == question.correctOptionIndex)
                              const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              )
                            else if (_hasAnswered &&
                                index == _selectedOptionIndex &&
                                index != question.correctOptionIndex)
                              const Icon(Icons.cancel, color: Colors.white),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
