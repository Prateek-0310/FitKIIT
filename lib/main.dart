import 'package:flutter/material.dart';
import 'screens/home_pass_screen.dart';
import 'screens/announcements_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const KIITFitPassApp());
}

class KIITFitPassApp extends StatelessWidget {
  const KIITFitPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KIITFit Pass',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F1216),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00C853), // KIIT Green
          secondary: Color(0xFF00E676),
          surface: Color(0xFF1B2028),
          surfaceContainerHighest: Color(0xFF262D38),
          onSurface: Colors.white,
        ),
        cardTheme: const CardThemeData(color: Color(0xFF1B2028), elevation: 0),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomePassScreen(),
    AnnouncementsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        backgroundColor: const Color(0xFF14181F),
        indicatorColor: const Color(0xFF00C853).withValues(alpha: 0.2),
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.qr_code_2_outlined),
            selectedIcon: Icon(Icons.qr_code_2, color: Color(0xFF00C853)),
            label: 'Pass',
          ),
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined),
            selectedIcon: Icon(Icons.campaign, color: Color(0xFF00C853)),
            label: 'Notices',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: Color(0xFF00C853)),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
