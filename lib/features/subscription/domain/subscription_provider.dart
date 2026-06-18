import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/subscription_repository.dart';

part 'subscription_provider.g.dart';

@riverpod
Future<dynamic> subscriptionPlans(SubscriptionPlansRef ref) {
  return ref.read(subscriptionRepositoryProvider).getSubscriptionPlans();
}

@riverpod
class CheckoutNotifier extends _$CheckoutNotifier {
  @override
  AsyncValue<String?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> createCheckout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(subscriptionRepositoryProvider).createCheckout();
      return response['checkout_url'] as String;
    });
  }
}
