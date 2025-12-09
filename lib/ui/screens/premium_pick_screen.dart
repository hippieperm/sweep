import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/feed_provider.dart';

/// 프리미엄 전용 픽 (간단히 랜덤 3개 뽑기)
class PremiumPickScreen extends StatelessWidget {
  const PremiumPickScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final feed = context.watch<FeedProvider>().items;
    final picks = feed.take(3).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('프리미엄 픽')),
      body: ListView.builder(
        itemCount: picks.length,
        itemBuilder: (_, i) {
          final item = picks[i];
          return Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: CachedNetworkImage(
                  imageUrl: item.url,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(color: Colors.white54),
                  ),
                  errorWidget: (_, __, ___) => const Center(
                    child: Icon(Icons.error, color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
