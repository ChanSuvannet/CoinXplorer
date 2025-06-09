import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String date;

  const NewsCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Explicit white background
      elevation: 2, // Reduced shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey[300]!, // Light border
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 120,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text content (70% width)
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Image (30% width)
                Expanded(
                  flex: 3,
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: _buildImageWidget(),
                  ),
                ),
              ],
            ),
            // Small rounded section at bottom-left edge
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Light gray background
                  borderRadius: BorderRadius.circular(50), // Circular radius
                ),
                constraints: const BoxConstraints(
                  minWidth: 80, // around 30% width approx for 120 height card
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.attach_money,
                      size: 16,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'BTC',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      '-2.23%',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_downward,
                      size: 16,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.grey[200], // Lighter gray for error state
        child: const Center(
          child: Icon(Icons.broken_image, size: 30, color: Colors.grey),
        ),
      ),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey[200], // Lighter gray for loading state
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
