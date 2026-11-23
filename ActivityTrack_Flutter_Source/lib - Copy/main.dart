import 'package:flutter/material.dart';
import 'data/activity_data.dart';
import 'repositories/activity_repository.dart';
import 'viewmodels/activity_viewmodel.dart';
import 'views/home_view.dart';

void main() {
  final data = ActivityData();
  final repository = ActivityRepository(data);
  final viewModel = ActivityViewModel(repository);
  runApp(ActivityTrackApp(viewModel: viewModel));
}

class ActivityTrackApp extends StatelessWidget {
  final ActivityViewModel viewModel;

  const ActivityTrackApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF6750A4);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ActivityTrack',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        scaffoldBackgroundColor: const Color(0xFFF7F6FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F6FB),
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE7E3EF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: seedColor, width: 1.5),
          ),
        ),
      ),
      home: HomeView(viewModel: viewModel),
    );
  }
}
