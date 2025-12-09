import 'dart:developer';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'env.dart';

/// RevenueCat 연동 래퍼
class RevenueCatService {
  RevenueCatService._();
  static final RevenueCatService instance = RevenueCatService._();

  bool _initialized = false;
  CustomerInfo? _customerInfo;

  Future<void> initialize() async {
    if (_initialized) return;
    await Purchases.configure(PurchasesConfiguration(Env.revenueCatApiKey));
    _customerInfo = await Purchases.getCustomerInfo();
    _initialized = true;
  }

  Future<bool> isPremium() async {
    _customerInfo ??= await Purchases.getCustomerInfo();
    final entitlements = _customerInfo?.entitlements.active;
    return entitlements != null && entitlements.containsKey(Env.entitlementId);
  }

  Future<bool> purchasePremium() async {
    try {
      final offerings = await Purchases.getOfferings();
      final pkg = offerings.current?.availablePackages.first;
      if (pkg == null) return false;
      _customerInfo = await Purchases.purchasePackage(pkg);
      return await isPremium();
    } catch (e) {
      log('Purchase failed: $e');
      return false;
    }
  }

  Future<void> restore() async {
    _customerInfo = await Purchases.restorePurchases();
  }
}
