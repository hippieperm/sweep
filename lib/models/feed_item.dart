/// 피드에 노출될 이미지 정보
class FeedItem {
  FeedItem({
    required this.id,
    required this.url,
    required this.category,
    required this.likes,
  });

  final String id;
  final String url;
  final String category;
  int likes;

  static List<FeedItem> sample() => [
        FeedItem(
          id: 'u1',
          url:
              'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=1080&q=80',
          category: '랜덤',
          likes: 3210,
        ),
        FeedItem(
          id: 'm1',
          url:
              'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=1080&q=80',
          category: '밈',
          likes: 1204,
        ),
        FeedItem(
          id: 'l1',
          url:
              'https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=1080&q=80',
          category: '풍경',
          likes: 842,
        ),
        FeedItem(
          id: 'k1',
          url:
              'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?auto=format&fit=crop&w=1080&q=80',
          category: '랜덤',
          likes: 1999,
        ),
        FeedItem(
          id: 'm2',
          url:
              'https://images.unsplash.com/photo-1545239351-1141bd82e8a6?auto=format&fit=crop&w=1080&q=80',
          category: '밈',
          likes: 2401,
        ),
        FeedItem(
          id: 'l2',
          url:
              'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1080&q=80',
          category: '풍경',
          likes: 1560,
        ),
      ];
}
