import 'package:flutter/material.dart';
import '../core/revenuecat_service.dart';

/// 프리미엄 상태 관리 및 구매/복원 처리
class PremiumProvider extends ChangeNotifier {
  bool _isPremium = false;
  bool get isPremium => _isPremium;

  PremiumProvider() {
    _init();
  }

  Future<void> _init() async {
    _isPremium = await RevenueCatService.instance.isPremium();
    notifyListeners();
  }

  Future<void> purchase() async {
    final ok = await RevenueCatService.instance.purchasePremium();
    _isPremium = ok;
    notifyListeners();
  }

  Future<void> restore() async {
    await RevenueCatService.instance.restore();
    _isPremium = await RevenueCatService.instance.isPremium();
    notifyListeners();
  }
}
