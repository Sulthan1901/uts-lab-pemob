import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;
  final bool isDarkMode;

  const BackgroundImage({
    Key? key,
    required this.child,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.network(
            'https://i.imgur.com/your-image-url.jpg', // Ganti dengan URL gambar
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Fallback jika gambar tidak load
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDarkMode
                        ? [
                            const Color(0xFF0F172A),
                            const Color(0xFF1E293B),
                          ]
                        : [
                            const Color(0xFFF8FAFC),
                            const Color(0xFFE2E8F0),
                          ],
                  ),
                ),
              );
            },
          ),
        ),
        // Gradient Overlay untuk readability
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDarkMode
                    ? [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.7),
                      ]
                    : [
                        Colors.white.withOpacity(0.7),
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.7),
                      ],
              ),
            ),
          ),
        ),
        // Content
        child,
      ],
    );
  }
}