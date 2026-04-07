import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/mock_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/admin_dashboard_screen.dart';
import 'screens/student_list_screen.dart';
import 'screens/manage_questions_screen.dart';
import 'screens/send_announcement_screen.dart';
import 'screens/test_interface_screen.dart';
import 'screens/instruction_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/device_mockup.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MockDataProvider()),
      ],
      child: const MockCETDemoApp(),
    ),
  );
}

class MockCETDemoApp extends StatelessWidget {
  const MockCETDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PVP MockCET Live Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A237E)),
        useMaterial3: true,
        // Using standard font for PVP MockCET consistency
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1A237E),
          elevation: 0,
        ),
      ),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            },
          ),
          child: DeviceMockup(child: child!),
        );
      },
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/admin_dashboard': (context) => const AdminDashboardScreen(),
        '/student_list': (context) => const StudentListScreen(),
        '/manage_questions': (context) => const ManageQuestionsScreen(),
        '/send_announcement': (context) => const SendAnnouncementScreen(),
        '/instructions': (context) => const InstructionScreen(),
        '/test': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>? ?? {
            'title': 'MHT-CET Mock Test',
            'duration': '180 Min',
            'questions': '150',
          };
          return TestInterfaceScreen(test: args);
        },
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
