import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_theme.dart';
import 'core/ad_manager.dart';
import 'core/revenuecat_service.dart';
import 'providers/feed_provider.dart';
import 'providers/premium_provider.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/meme_screen.dart';
import 'ui/screens/landscape_screen.dart';
import 'ui/screens/saved_screen.dart';
import 'ui/screens/premium_pick_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AdManager.instance.initialize();
  await RevenueCatService.instance.initialize();
  runApp(const SeuchidaApp());
}

class SeuchidaApp extends StatelessWidget {
  const SeuchidaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PremiumProvider()),
        ChangeNotifierProvider(create: (_) => FeedProvider()),
      ],
      child: Consumer<PremiumProvider>(
        builder: (_, premium, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: '스치다',
            theme: AppTheme.dark,
            home: MainTabScaffold(isPremium: premium.isPremium),
          );
        },
      ),
    );
  }
}

class MainTabScaffold extends StatefulWidget {
  final bool isPremium;
  const MainTabScaffold({super.key, required this.isPremium});

  @override
  State<MainTabScaffold> createState() => _MainTabScaffoldState();
}

class _MainTabScaffoldState extends State<MainTabScaffold> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const MemeScreen(),
      const LandscapeScreen(),
      const SavedScreen(),
      if (widget.isPremium) const PremiumPickScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: '랜덤'),
          const BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions), label: '밈'),
          const BottomNavigationBarItem(icon: Icon(Icons.landscape), label: '풍경'),
          const BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: '저장됨'),
          if (widget.isPremium)
            const BottomNavigationBarItem(icon: Icon(Icons.star), label: '프리미엄'),
        ],
      ),
    );
  }
}
