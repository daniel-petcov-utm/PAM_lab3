import 'package:flutter/material.dart';

import '../models/category_promo.dart';
import '../services/home_page_service.dart';

class CategoryPromos extends StatefulWidget {
  const CategoryPromos({super.key});

  @override
  State<CategoryPromos> createState() => _CategoryPromosState();
}

class _CategoryPromosState extends State<CategoryPromos> {
  final HomePageService _service = HomePageService();

  late Future<List<CategoryPromo>> _promosFuture;

  @override
  void initState() {
    super.initState();
    _promosFuture = _service.fetchCategoryPromos();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FutureBuilder<List<CategoryPromo>>(
        future: _promosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 168,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasError) {
            return const Text('Could not load category promotions.');
          }

          final promos = snapshot.data ?? [];

          if (promos.isEmpty) {
            return const SizedBox.shrink();
          }

          return SizedBox(
            height: 168,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int index = 0; index < promos.length; index++) ...[
                  if (index > 0) const SizedBox(width: 10),
                  Expanded(
                    child: _CategoryPromoCard(
                      promo: promos[index],
                      imageOnLeft: index.isEven,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryPromoCard extends StatelessWidget {
  final CategoryPromo promo;
  final bool imageOnLeft;

  const _CategoryPromoCard({required this.promo, required this.imageOnLeft});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: const Color(0xFFF7F7F9),
        child: InkWell(
          onTap: () {
            // Category navigation can be added later.
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              final imageWidth = constraints.maxWidth * 0.42;

              final image = SizedBox(
                width: imageWidth,
                height: constraints.maxHeight,
                child: Image.network(
                  promo.imageUrl,
                  fit: BoxFit.cover,
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
              );

              final text = Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        promo.category,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.3,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF737887),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        promo.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.35,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF30313A),
                        ),
                      ),
                    ],
                  ),
                ),
              );

              return Row(
                textDirection: imageOnLeft
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                children: [
                  imageOnLeft ? image : text,
                  imageOnLeft ? text : image,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
