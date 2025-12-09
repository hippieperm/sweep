/// 실 서비스 키는 .env 등을 사용해 주입하고, 배포 전 교체하세요.
class Env {
  // Unsplash / Pexels API 키 (샘플)
  static const unsplashKey = 'UNSPLASH_KEY_HERE';
  static const pexelsKey = 'PEXELS_KEY_HERE';

  // AdMob 단위 ID (테스트/실서비스 구분)
  static const admobAppId = 'ca-app-pub-3940256099942544~3347511713';
  static const admobInterstitialId = 'ca-app-pub-3940256099942544/1033173712';

  // RevenueCat API Key (공용 키)
  static const revenueCatApiKey = 'REVENUECAT_PUBLIC_API_KEY';
  static const entitlementId = 'premium'; // RC 대시보드와 동일하게 설정
}
