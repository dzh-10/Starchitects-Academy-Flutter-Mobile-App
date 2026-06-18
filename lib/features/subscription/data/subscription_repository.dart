import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_service.dart';

final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  return SubscriptionRepository(ref.watch(apiServiceProvider));
});

class SubscriptionRepository {
  final ApiService _apiService;

  SubscriptionRepository(this._apiService);

  Future<dynamic> getSubscriptionPlans() {
    return _apiService.getSubscriptionPlans();
  }

  Future<dynamic> createCheckout() {
    return _apiService.createCheckout();
  }
}
