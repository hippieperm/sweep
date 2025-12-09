import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../providers/feed_provider.dart';
import '../../core/ad_manager.dart';
import '../widgets/report_sheet.dart';
import '../widgets/like_heart_overlay.dart';

/// 홈: 세로 무한 스와이프 + 더블탭 좋아요 + 좌우 스와이프 액션
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feed = context.watch<FeedProvider>();

    if (feed.items.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.white));
    }

    return GestureDetector(
      onDoubleTap: () => feed.toggleLike(_currentIndex),
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemBuilder: (ctx, index) {
          final itemIndex = index % feed.items.length;
          final item = feed.items[itemIndex];

          // 6번째마다 광고 노출
          if (index != 0 && index % 6 == 0) {
            AdManager.instance.showInterstitial();
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: item.url,
                fit: BoxFit.cover,
                placeholder: (_, __) => const Center(
                  child: CircularProgressIndicator(color: Colors.white54),
                ),
                errorWidget: (_, __, ___) => const Center(
                  child: Icon(Icons.error, color: Colors.white),
                ),
              ),
              LikeHeartOverlay(isVisible: feed.isLiked(item.id)),
              Positioned(
                top: 40,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text(item.category,
                          style: const TextStyle(color: Colors.white)),
                      backgroundColor: Colors.black54,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.favorite,
                            color: Colors.pink, size: 18),
                        const SizedBox(width: 4),
                        Text('${item.likes}',
                            style: const TextStyle(color: Colors.white)),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onPanEnd: (details) {
                  final vx = details.velocity.pixelsPerSecond.dx;
                  if (vx > 400) {
                    feed.saveToGallery(context, item);
                  } else if (vx < -400) {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.black87,
                      builder: (_) => ReportSheet(itemId: item.id),
                    );
                  }
                },
                child: const SizedBox.expand(),
              ),
            ],
          );
        },
        onPageChanged: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
