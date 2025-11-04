import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const ScoreCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final iconSize = isTablet ? 48.0 : 40.0;
    final titleFontSize = isTablet ? 16.0 : 14.0;
    final valueFontSize = isTablet ? 32.0 : 28.0;
    final padding = isTablet ? 24.0 : 20.0;

    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.1),
              color.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: color,
            ),
            SizedBox(height: isTablet ? 16 : 12),
            Text(
              title,
              style: TextStyle(
                fontSize: titleFontSize,
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: isTablet ? 8 : 4),
            Text(
              value,
              style: TextStyle(
                fontSize: valueFontSize,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}