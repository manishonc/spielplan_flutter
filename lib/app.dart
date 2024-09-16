import 'package:flutter/material.dart';
import 'package:spielplan/screens/auth/auth_screen.dart';
import 'package:spielplan/screens/home_screen.dart';
import 'package:spielplan/screens/create_event_screen.dart';
import 'package:spielplan/screens/my_events_screen.dart';
import 'package:spielplan/screens/profile_screen.dart';
import 'package:spielplan/components/bottom_nav_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    const CreateEventScreen(),
    const MyEventsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spielplan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final authState = snapshot.data!;
            if (authState.event == AuthChangeEvent.signedIn) {
              return Scaffold(
                body: _screens[_currentIndex],
                bottomNavigationBar: BottomNavBar(
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              );
            }
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
