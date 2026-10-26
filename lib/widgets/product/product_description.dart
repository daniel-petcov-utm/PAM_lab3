import 'package:flutter/material.dart';

class ProductDescription extends StatefulWidget {
  final String description;
  final bool initiallyExpanded;

  const ProductDescription({
    super.key,
    required this.description,
    this.initiallyExpanded = false,
  });

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          // Tappable description heading.
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF383838),
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                      color: Color(0xFF333333),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          // Expand or collapse the description text.
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(2, 22, 2, 12),
              child: Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.65,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF454545),
                ),
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
            alignment: Alignment.topCenter,
          ),
        ],
      ),
    );
  }
}
