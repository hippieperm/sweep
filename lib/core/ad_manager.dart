import 'dart:developer';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'env.dart';

/// AdMob 인터스티셜 광고 로더/관리자
class AdManager {
  AdManager._();
  static final AdManager instance = AdManager._();

  bool _initialized = false;
  InterstitialAd? _interstitialAd;
  bool _isLoading = false;

  Future<void> initialize() async {
    if (_initialized) return;
    // 광고 SDK 초기화
    await MobileAds.instance.initialize();
    _initialized = true;
    _loadInterstitial();
  }

  void _loadInterstitial() {
    if (_isLoading) return;
    _isLoading = true;
    InterstitialAd.load(
      adUnitId: Env.admobInterstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isLoading = false;
          log('Interstitial loaded');
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          _isLoading = false;
          log('Interstitial failed: $error');
        },
      ),
    );
  }

  /// 6번째 이미지마다 호출: 준비된 경우 노출, 아니면 다음 로드 시도
  Future<void> showInterstitial() async {
    if (!_initialized) return;
    if (_interstitialAd == null) {
      _loadInterstitial();
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        _loadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _interstitialAd = null;
        log('Interstitial show failed: $error');
        _loadInterstitial();
      },
    );

    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
