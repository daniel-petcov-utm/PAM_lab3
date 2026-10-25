import 'package:flutter/material.dart';

import 'widgets/hero_banner_slider.dart';
import 'widgets/featured_products.dart';
import 'widgets/new_collection_banner.dart';
import 'widgets/recommended_products.dart';
import 'widgets/top_collections.dart';
import 'widgets/category_promos.dart';
import 'widgets/category_selector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GemStore',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF34343B)),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CategorySelector(),
              SizedBox(height: 8),
              HeroBannerSlider(),
              SizedBox(height: 32),
              FeaturedProducts(),
              SizedBox(height: 28),
              NewCollectionBanner(),
              SizedBox(height: 28),
              RecommendedProducts(),
              SizedBox(height: 28),
              TopCollections(),
              SizedBox(height: 16),
              CategoryPromos(),
            ],
          ),
        ),
      ),
    );
  }
}
