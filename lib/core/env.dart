/// 실 서비스 키는 --dart-define 또는 --dart-define-from-file(.env)로 주입하세요.
/// 기본값은 빈 문자열이며, 미설정 시 관련 기능이 동작하지 않습니다.
class Env {
  // Unsplash / Pexels API 키
  static const unsplashKey =
      String.fromEnvironment('UNSPLASH_KEY', defaultValue: '');
  static const pexelsKey =
      String.fromEnvironment('PEXELS_KEY', defaultValue: '');

  // AdMob 단위 ID (테스트/실서비스 구분)
  static const admobAppId =
      String.fromEnvironment('ADMOB_APP_ID', defaultValue: '');
  static const admobInterstitialId =
      String.fromEnvironment('ADMOB_INTERSTITIAL_ID', defaultValue: '');
}
