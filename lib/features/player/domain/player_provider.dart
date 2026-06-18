import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/progress_repository.dart';

part 'player_provider.g.dart';

@riverpod
class PlayerNotifier extends _$PlayerNotifier {
  @override
  void build() {}

  Future<void> saveProgress(int lessonId, int secondsWatched, bool completed) async {
    try {
      await ref.read(progressRepositoryProvider).saveProgress(lessonId, secondsWatched, completed);
    } catch (e) {
      // Handle error silently or log it
    }
  }
}
