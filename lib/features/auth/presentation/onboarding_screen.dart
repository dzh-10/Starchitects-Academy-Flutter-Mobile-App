import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'تعلم بطريقة ممتعة',
      'icon': 'school'
    },
    {
      'title': 'دورات احترافية',
      'icon': 'play_lesson'
    },
    {
      'title': 'شهادات معتمدة',
      'icon': 'workspace_premium'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => context.go('/login'),
            child: const Text('تخطي', style: TextStyle(color: AppColors.kTextSecondary)),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  IconData iconData = Icons.school;
                  if (slide['icon'] == 'play_lesson') iconData = Icons.play_lesson;
                  if (slide['icon'] == 'workspace_premium') iconData = Icons.workspace_premium;
                  
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(iconData, size: 100, color: AppColors.kGold),
                      const SizedBox(height: 32),
                      Text(
                        slide['title']!,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentIndex == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? AppColors.kGold : AppColors.kTextSecondary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentIndex == _slides.length - 1) {
                      context.go('/login');
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(_currentIndex == _slides.length - 1 ? 'ابدأ الآن' : 'التالي'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
