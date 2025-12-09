import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/feed_item.dart';

/// 피드 상태 + 좋아요/저장/필터 담당
class FeedProvider extends ChangeNotifier {
  FeedProvider() {
    _items = FeedItem.sample();
  }

  late List<FeedItem> _items;
  final Set<String> _likedIds = {};
  final List<FeedItem> _saved = [];

  List<FeedItem> get items => _items;
  List<FeedItem> get saved => List.unmodifiable(_saved);

  /// 카테고리별 필터 목록 반환
  List<FeedItem> byCategory(String category) {
    return _items.where((e) => e.category == category).toList();
  }

  bool isLiked(String id) => _likedIds.contains(id);

  /// 더블탭 좋아요 토글 + 카운트 증가
  void toggleLike(int index) {
    final item = _items[index % _items.length];
    if (_likedIds.contains(item.id)) {
      _likedIds.remove(item.id);
      item.likes = (item.likes - 1).clamp(0, 1 << 31);
    } else {
      _likedIds.add(item.id);
      item.likes += 1;
    }
    notifyListeners();
  }

  /// 오른쪽 스와이프 시 갤러리 저장
  Future<void> saveToGallery(BuildContext context, FeedItem item) async {
    final status = await Permission.photos.request();
    if (!status.isGranted) {
      Fluttertoast.showToast(msg: '갤러리 접근 권한이 필요합니다.');
      return;
    }

    final ok = await GallerySaver.saveImage(item.url, albumName: '스치다');
    if (ok == true) {
      _saved.add(item);
      notifyListeners();
      Fluttertoast.showToast(msg: '갤러리에 저장되었습니다.');
    } else {
      Fluttertoast.showToast(msg: '저장에 실패했습니다.');
    }
  }
}
