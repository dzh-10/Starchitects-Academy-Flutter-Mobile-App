import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../auth/domain/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(authNotifierProvider);
    final user = userState.valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.kGoldDark,
                  child: Text(
                    user?.name.isNotEmpty == true ? user!.name.substring(0, 1).toUpperCase() : 'U',
                    style: const TextStyle(fontSize: 40, color: AppColors.kBgPrimary),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(user?.name ?? 'المستخدم', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 8),
              Text(user?.email ?? '', style: const TextStyle(color: AppColors.kTextSecondary)),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard('الدورات المسجلة', '3'),
                  _buildStatCard('الدورات المكتملة', '1'),
                  _buildStatCard('الشهادات', '1'),
                ],
              ),
              const SizedBox(height: 32),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.library_books, color: AppColors.kGold),
                      title: const Text('دوراتي'),
                      onTap: () {},
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.workspace_premium, color: AppColors.kGold),
                      title: const Text('شهاداتي'),
                      onTap: () => context.push('/certificates'),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.notifications, color: AppColors.kGold),
                      title: const Text('الإشعارات'),
                      onTap: () {},
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
                      onTap: () async {
                        await ref.read(authNotifierProvider.notifier).logout();
                        context.go('/login');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.kGold)),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(color: AppColors.kTextSecondary)),
      ],
    );
  }
}
