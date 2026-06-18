import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../auth/domain/auth_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(authNotifierProvider);
    final userName = userState.valueOrNull?.name ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.school, color: AppColors.kGold),
            SizedBox(width: 8),
            Text('Starchitects', style: TextStyle(color: AppColors.kGold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            backgroundColor: AppColors.kGoldDark,
            child: Icon(Icons.person, color: AppColors.kBgPrimary),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحباً $userName',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 24),
              Text('الدورات المميزة', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18)),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 250,
                      margin: const EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: AppColors.kBgCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.kGold.withOpacity(0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            decoration: const BoxDecoration(
                              color: AppColors.kBgCardLight,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            ),
                            child: const Center(child: Icon(Icons.image, size: 50, color: AppColors.kTextSecondary)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('دورة تصميم معماري', style: Theme.of(context).textTheme.bodyLarge),
                                const SizedBox(height: 4),
                                const Text('مجاني', style: TextStyle(color: AppColors.kGold, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Text('أحدث الدورات', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18)),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Container(width: 60, height: 60, color: AppColors.kBgCardLight, child: const Icon(Icons.image)),
                      title: const Text('دورة أوتوكاد متقدمة'),
                      subtitle: const Text('أحمد محمد'),
                      trailing: const Text('1500 دج', style: TextStyle(color: AppColors.kGold)),
                      onTap: () => context.push('/courses/autocad-advanced'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
            if (index == 1) context.push('/courses');
            if (index == 3) context.push('/profile');
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.play_lesson), label: 'الدورات'),
            BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'دوراتي'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف'),
          ],
        ),
      ),
    );
  }
}
