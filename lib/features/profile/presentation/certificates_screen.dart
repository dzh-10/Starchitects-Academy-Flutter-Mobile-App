import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/app_colors.dart';
import '../domain/profile_provider.dart';

class CertificatesScreen extends ConsumerWidget {
  const CertificatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final certsAsync = ref.watch(userCertificatesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('شهاداتي'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: certsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('خطأ: $error')),
          data: (certs) {
            // Use dummy data if empty
            final items = certs.isEmpty ? [
              {'course_name': 'دورة تصميم معماري', 'date': '2023-10-01'},
              {'course_name': 'دورة أوتوكاد متقدمة', 'date': '2023-11-15'},
            ] : certs;

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final cert = items[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.workspace_premium, size: 50, color: AppColors.kGold),
                        const SizedBox(height: 16),
                        Text(cert['course_name'] ?? '', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(cert['date'] ?? '', style: const TextStyle(color: AppColors.kTextSecondary, fontSize: 12)),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () {
                            Share.share('لقد حصلت على شهادة في ${cert['course_name']} من Starchitects Academy!');
                          },
                          icon: const Icon(Icons.share, size: 16),
                          label: const Text('مشاركة'),
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
    );
  }
}
