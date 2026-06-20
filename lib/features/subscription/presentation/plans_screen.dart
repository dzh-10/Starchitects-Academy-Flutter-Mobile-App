import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/glass_card.dart';
import '../domain/subscription_provider.dart';

class PlansScreen extends ConsumerWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(checkoutNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (url) {
          if (url != null) {
            context.push('/checkout?url=$url');
          }
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('خطأ في الدفع: $error')),
          );
        },
      );
    });

    final isLoading = ref.watch(checkoutNotifierProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('الاشتراكات')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildPlanCard(context, 'شهري', '10,000 دج', false, ref, isLoading),
            const SizedBox(height: 16),
            _buildPlanCard(context, 'فصلي', '15,000 دج', true, ref, isLoading),
            const SizedBox(height: 16),
            _buildPlanCard(context, 'سنوي', '20,000 دج', false, ref, isLoading),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: AppColors.textPrimary,
                  child: const Text('Baridimob', style: TextStyle(color: AppColors.textOnPrimary, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: AppColors.textPrimary,
                  child: const Text('CIB', style: TextStyle(color: AppColors.textOnPrimary, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, String title, String price, bool isPopular, WidgetRef ref, bool isLoading) {
    return GlassCard(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            if (isPopular)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.kGold,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text('الأكثر شعبية', style: TextStyle(color: AppColors.kBgPrimary, fontWeight: FontWeight.bold)),
              ),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 8),
            Text(price, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.kGold)),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(Icons.check, color: AppColors.kGold),
                SizedBox(width: 8),
                Text('الوصول لجميع الدورات'),
              ],
            ),
            const Row(
              children: [
                Icon(Icons.check, color: AppColors.kGold),
                SizedBox(width: 8),
                Text('شهادات معتمدة'),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : () {
                  ref.read(checkoutNotifierProvider.notifier).createCheckout();
                },
                child: const Text('اشترك الآن'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
