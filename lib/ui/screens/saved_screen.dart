import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/feed_provider.dart';

/// 갤러리에 저장한 항목(앱 내 기록) 표시
class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final saved = context.watch<FeedProvider>().saved;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('저장됨')),
      body: saved.isEmpty
          ? const Center(
              child: Text('아직 저장된 이미지가 없습니다.',
                  style: TextStyle(color: Colors.white70)),
            )
          : ListView.builder(
              itemCount: saved.length,
              itemBuilder: (_, i) {
                final item = saved[i];
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
                          child:
                              CircularProgressIndicator(color: Colors.white54),
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
