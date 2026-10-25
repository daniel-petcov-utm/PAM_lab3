import 'package:flutter/material.dart';

import '../models/top_collection.dart';
import '../services/home_page_service.dart';

class TopCollections extends StatefulWidget {
  const TopCollections({super.key});

  @override
  State<TopCollections> createState() => _TopCollectionsState();
}

class _TopCollectionsState extends State<TopCollections> {
  final HomePageService _service = HomePageService();

  late Future<List<TopCollection>> _collectionsFuture;

  @override
  void initState() {
    super.initState();
    _collectionsFuture = _service.fetchTopCollections();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section heading.
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Top Collection',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Add collection listing navigation later.
                },
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
                child: const Text('Show all', style: TextStyle(fontSize: 13)),
              ),
            ],
          ),

          const SizedBox(height: 18),

          FutureBuilder<List<TopCollection>>(
            future: _collectionsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError) {
                return const Text('Could not load collections.');
              }

              final collections = snapshot.data ?? [];

              if (collections.isEmpty) {
                return const Text('No collections available.');
              }

              return Column(
                children: [
                  for (int index = 0; index < collections.length; index++) ...[
                    _TopCollectionCard(
                      collection: collections[index],
                      index: index,
                    ),
                    if (index < collections.length - 1)
                      const SizedBox(height: 16),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TopCollectionCard extends StatelessWidget {
  final TopCollection collection;
  final int index;

  const _TopCollectionCard({required this.collection, required this.index});

  @override
  Widget build(BuildContext context) {
    final isFirst = index == 0;

    return Material(
      color: const Color(0xFFF7F7F9),
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Collection navigation can be added later.
        },
        child: SizedBox(
          height: isFirst ? 144 : 212,
          width: double.infinity,
          child: Stack(
            children: [
              // Collection image.
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: isFirst ? 125 : 135,
                child: Image.network(
                  collection.imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (context, error, stackTrace) {
                    return const ColoredBox(
                      color: Color(0xFFE9E9ED),
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),

              // Text content.
              Positioned(
                left: 23,
                top: 0,
                bottom: 0,
                right: isFirst ? 125 : 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 1.5,
                          height: 13,
                          color: const Color(0xFF9299A8),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            collection.label,
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 12,
                              height: 1.4,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF858C9B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 19),
                    Text(
                      collection.title.replaceFirst(' & ', '\n& '),
                      style: TextStyle(
                        fontSize: isFirst ? 19 : 20,
                        height: 1.5,
                        fontWeight: isFirst ? FontWeight.w300 : FontWeight.w600,
                        color: const Color(0xFF373B49),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
