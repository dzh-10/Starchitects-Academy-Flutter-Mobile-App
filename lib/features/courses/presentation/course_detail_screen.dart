import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../domain/courses_provider.dart';

class CourseDetailScreen extends ConsumerWidget {
  final String slug;
  const CourseDetailScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseDetailAsync = ref.watch(courseDetailProvider(slug));

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: courseDetailAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('خطأ: $error')),
          data: (course) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(course.title, style: const TextStyle(color: AppColors.kTextPrimary)),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(color: AppColors.kBgCardLight, child: const Icon(Icons.image, size: 100)),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, AppColors.kBgPrimary.withOpacity(0.8)],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColors.kGoldDark,
                              child: Icon(Icons.person),
                            ),
                            const SizedBox(width: 12),
                            Text(course.instructorName, style: Theme.of(context).textTheme.displayMedium),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.kGold.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                course.isFree ? 'مجاني' : '${course.price} دج',
                                style: const TextStyle(color: AppColors.kGold, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.star, color: AppColors.kGold),
                            const SizedBox(width: 4),
                            Text('${course.rating ?? 0}'),
                            const SizedBox(width: 16),
                            const Icon(Icons.people, color: AppColors.kTextSecondary),
                            const SizedBox(width: 4),
                            Text('${course.enrolledCount ?? 0} طالب'),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text('المحتوى', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.play_circle_fill, color: AppColors.kGold),
                            title: const Text('الدرس الأول'),
                            trailing: const Text('10:00'),
                            onTap: () => context.push('/player/${course.id}'), // Dummy lesson id
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('اشترك الآن', style: TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ),
    );
  }
}
