import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;
  final String optionLabel;

  const AnswerCard({
    Key? key,
    required this.answer,
    required this.isSelected,
    required this.onTap,
    required this.optionLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final fontSize = isTablet ? 18.0 : 16.0;
    final padding = isTablet ? 20.0 : 16.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).dividerColor.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: isTablet ? 48 : 40,
              height: isTablet ? 48 : 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  optionLabel,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
            SizedBox(width: isTablet ? 16 : 12),
            Expanded(
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
                size: isTablet ? 28 : 24,
              ),
          ],
        ),
      ),
    );
  }
}