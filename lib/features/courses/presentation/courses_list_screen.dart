import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../domain/courses_provider.dart';

class CoursesListScreen extends ConsumerStatefulWidget {
  const CoursesListScreen({super.key});

  @override
  ConsumerState<CoursesListScreen> createState() => _CoursesListScreenState();
}

class _CoursesListScreenState extends ConsumerState<CoursesListScreen> {
  String _selectedFilter = 'الكل';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(coursesNotifierProvider.notifier).fetchCourses());
  }

  @override
  Widget build(BuildContext context) {
    final coursesState = ref.watch(coursesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الدورات'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'ابحث عن دورة...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: AppColors.kBgCardLight,
                ),
                onSubmitted: (value) {
                  ref.read(coursesNotifierProvider.notifier).fetchCourses(search: value);
                },
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: ['الكل', 'مجاني', 'مدفوع'].map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: _selectedFilter == filter,
                      onSelected: (selected) {
                        setState(() => _selectedFilter = filter);
                        String? type;
                        if (filter == 'مجاني') type = 'free';
                        if (filter == 'مدفوع') type = 'paid';
                        ref.read(coursesNotifierProvider.notifier).fetchCourses(type: type);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: coursesState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('خطأ: $error')),
                data: (courses) {
                  if (courses.isEmpty) {
                    return const Center(child: Text('لا توجد دورات'));
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return GestureDetector(
                        onTap: () => context.push('/courses/${course.slug}'),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.kBgCardLight,
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                  ),
                                  child: const Center(child: Icon(Icons.image, size: 40)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                                    const SizedBox(height: 4),
                                    Text(course.instructorName, style: const TextStyle(color: AppColors.kTextSecondary, fontSize: 12)),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(course.isFree ? 'مجاني' : '${course.price} دج', style: const TextStyle(color: AppColors.kGold, fontWeight: FontWeight.bold)),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: AppColors.kGold, size: 14),
                                            Text('${course.rating ?? 0}', style: const TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
