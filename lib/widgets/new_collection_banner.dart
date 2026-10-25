import 'package:flutter/material.dart';

import '../models/new_collection.dart';
import '../services/home_page_service.dart';

class NewCollectionBanner extends StatefulWidget {
  const NewCollectionBanner({super.key});

  @override
  State<NewCollectionBanner> createState() => _NewCollectionBannerState();
}

class _NewCollectionBannerState extends State<NewCollectionBanner> {
  final HomePageService _service = HomePageService();

  late Future<NewCollection> _collectionFuture;

  @override
  void initState() {
    super.initState();
    _collectionFuture = _service.fetchNewCollection();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewCollection>(
      future: _collectionFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 205,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const SizedBox(
            height: 205,
            child: Center(child: Text('Could not load the collection.')),
          );
        }

        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        return _buildBanner(snapshot.data!);
      },
    );
  }

  Widget _buildBanner(NewCollection collection) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: Container(
        height: 205,
        color: const Color(0xFFF7F7F9),
        child: Row(
          children: [
            // Collection label and title.
            Expanded(
              flex: 11,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  top: 20,
                  bottom: 20,
                  right: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 1.5,
                          height: 15,
                          color: const Color(0xFF9299A8),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            collection.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.3,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF858C9B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      collection.title.replaceFirst(' & ', '\n& '),
                      style: const TextStyle(
                        fontSize: 21,
                        height: 1.5,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF373B49),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Collection image.
            Expanded(
              flex: 9,
              child: SizedBox.expand(
                child: Image.network(
                  collection.imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) {
                    return const ColoredBox(
                      color: Color(0xFFE9E9ED),
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey,
                          size: 32,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
