import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/favorites_cubit.dart';
import 'cubits/home_cubit.dart';
import 'services/home_page_service.dart';

import 'widgets/hero_banner_slider.dart';
import 'widgets/featured_products.dart';
import 'widgets/new_collection_banner.dart';
import 'widgets/recommended_products.dart';
import 'widgets/top_collections.dart';
import 'widgets/category_promos.dart';
import 'widgets/category_selector.dart';
import 'widgets/home_header.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavoritesCubit()),
        BlocProvider(create: (_) => HomeCubit(HomePageService())..load()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GemStore',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF34343B)),
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is HomeError) {
          return Scaffold(
            body: Center(
              child: FilledButton(
                onPressed: () => context.read<HomeCubit>().load(),
                child: const Text('Retry loading homepage'),
              ),
            ),
          );
        }
        if (state is HomeEmpty) {
          return const Scaffold(
            body: Center(child: Text('No products available.')),
          );
        }
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  HomeHeader(),
                  SizedBox(height: 16),
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
      },
    );
  }
}
