import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'Home.dart';
import 'Stats.dart';
import 'Screen.dart'; // Ensure you import the correct SettingsScreen
import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Tracker',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calorie Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  int _currentIndex = 0;

  // Create a user instance to share across screens
  final User _user = User(weight: 70.0, height: 1.75, age: 25); // Example data

  List<Widget> _buildScreens() {
    return [
      HomeScreen(user: _user),
      StatsScreen(user: _user),
      SettingsScreen(user: _user),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.indigoAccent,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.pie_chart),
        title: ("Stats"),
        activeColorPrimary: Colors.indigoAccent,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Colors.indigoAccent,
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _buildScreens(),
      ),
      bottomNavigationBar: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: Colors.black,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        onItemSelected: _onTabTapped,
        navBarStyle: NavBarStyle.style9,
      ),
    );
  }
}
