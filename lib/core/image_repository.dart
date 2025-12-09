import '../models/feed_item.dart';

/// Unsplash/Pexels 연동 확장 여지를 둔 단순 리포지토리
class ImageRepository {
  /// 실제 API 연동 전까지는 로컬 샘플 리스트를 반환
  Future<List<FeedItem>> fetchInitial() async {
    return FeedItem.sample();
  }
}
