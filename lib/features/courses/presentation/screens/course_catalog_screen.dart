import 'dart:async';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/empty_state_widget.dart';
import 'package:starchitects_app/core/widgets/error_state_widget.dart';
import 'package:starchitects_app/core/widgets/shimmer_loading.dart';
import 'package:starchitects_app/features/courses/presentation/providers/course_provider.dart';
import 'package:starchitects_app/features/courses/presentation/widgets/course_card.dart';

/// Course catalog screen with search, category filters, and paginated grid
class CourseCatalogScreen extends ConsumerStatefulWidget {
  const CourseCatalogScreen({super.key});

  @override
  ConsumerState<CourseCatalogScreen> createState() =>
      _CourseCatalogScreenState();
}

class _CourseCatalogScreenState extends ConsumerState<CourseCatalogScreen> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(searchQueryProvider.notifier).setQuery(query.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    final filterParams = CourseFilterParams(
      category: selectedCategory,
      search: searchQuery.isNotEmpty ? searchQuery : null,
    );
    final coursesAsync = ref.watch(courseCatalogProvider(filterParams));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(courseCatalogProvider(filterParams));
            await ref.read(courseCatalogProvider(filterParams).future);
          },
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              // Title
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Text(
                    'courses.catalog_title'.tr(),
                    style: AppTextStyles.cairoBold(24),
                  ),
                ),
              ),

              // Search Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: _SearchBar(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onChanged: _onSearchChanged,
                  ),
                ),
              ),

              // Category Chips
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _CategoryChips(
                    selectedCategory: selectedCategory,
                    onCategorySelected: (category) {
                      ref.read(selectedCategoryProvider.notifier).setCategory(category);
                    },
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Course Grid
              coursesAsync.when(
                data: (courses) {
                  if (courses.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: EmptyStateWidget(
                          icon: Icons.search_off_rounded,
                          title: 'courses.no_courses_title'.tr(),
                          subtitle: 'courses.no_courses_subtitle'.tr(),
                        ),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.62,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            CourseCard(course: courses[index]),
                        childCount: courses.length,
                      ),
                    ),
                  );
                },
                loading: () => SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.62,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => const ShimmerBox(
                        width: double.infinity,
                        height: double.infinity,
                        borderRadius: AppSizes.radiusLG,
                      ),
                      childCount: 6,
                    ),
                  ),
                ),
                error: (error, _) => SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: ErrorStateWidget(
                      message: 'courses.load_error'.tr(),
                      onRetry: () {
                        ref.invalidate(
                            courseCatalogProvider(filterParams));
                      },
                    ),
                  ),
                ),
              ),

              // Bottom padding
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Premium search bar with gold focus effect
class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const _SearchBar({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: focusNode,
      builder: (context, child) {
        final hasFocus = focusNode.hasFocus;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: AppColors.glassBackground,
            borderRadius: BorderRadius.circular(AppSizes.radiusLG),
            border: Border.all(
              color: hasFocus
                  ? AppColors.primary.withOpacity(0.6)
                  : AppColors.glassBorderSubtle,
              width: hasFocus ? 1.5 : 1.0,
            ),
            boxShadow: hasFocus
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.1),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ]
                : [],
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            style: AppTextStyles.tajawalRegular(15),
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: 'courses.search_hint'.tr(),
              hintStyle: AppTextStyles.tajawalRegular(14,
                  color: AppColors.textTertiary),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: hasFocus ? AppColors.primary : AppColors.textTertiary,
                size: 22,
              ),
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        controller.clear();
                        onChanged('');
                      },
                      icon: const Icon(Icons.close_rounded,
                          color: AppColors.textTertiary, size: 20),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
            ),
          ),
        );
      },
    );
  }
}

/// Horizontal scrollable category filter chips
class _CategoryChips extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String?> onCategorySelected;

  const _CategoryChips({
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = <MapEntry<String?, String>>[
      MapEntry(null, 'courses.category_all'.tr()),
      MapEntry('BAC', 'courses.category_bac'.tr()),
      MapEntry('BEM', 'courses.category_bem'.tr()),
      MapEntry('FORMATION', 'courses.category_formation'.tr()),
    ];

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final entry = categories[index];
          final isSelected = selectedCategory == entry.key;
          return GestureDetector(
            onTap: () => onCategorySelected(entry.key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.glassBackground,
                borderRadius:
                    BorderRadius.circular(AppSizes.radiusRound),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.glassBorderSubtle,
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                entry.value,
                style: AppTextStyles.tajawalMedium(
                  13,
                  color: isSelected
                      ? AppColors.textOnPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
