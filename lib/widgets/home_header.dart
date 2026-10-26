import 'package:flutter/material.dart';

import '../models/store_title.dart';
import '../services/home_page_service.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final HomePageService _service = HomePageService();

  late Future<StoreTitle> _storeTitleFuture;

  @override
  void initState() {
    super.initState();
    _storeTitleFuture = _service.fetchStoreTitle();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Centered store name.
            FutureBuilder<StoreTitle>(
              future: _storeTitleFuture,
              builder: (context, snapshot) {
                String title;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  title = 'Loading';
                } else if (snapshot.hasError) {
                  title = 'Could not load name';
                } else if (snapshot.hasData) {
                  title = snapshot.data!.title;
                } else {
                  title = '';
                }

                return Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: -0.5,
                    ),
                  ),
                );
              },
            ),

            // Header actions.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    // TODO: Open navigation drawer.
                  },
                  icon: const Icon(
                    Icons.menu_rounded,
                    size: 27,
                    color: Color(0xFF222222),
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 40,
                  ),
                  tooltip: 'Open menu',
                ),

                IconButton(
                  onPressed: () {
                    // TODO: Open notifications.
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 40,
                  ),
                  tooltip: 'Notifications',
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(
                        Icons.notifications_none_outlined,
                        size: 27,
                        color: Color(0xFF222222),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF4267),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
