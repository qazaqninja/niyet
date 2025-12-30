enum NiyyahCategory {
  ibadah,   // Worship
  akhlaq,   // Character
  family,   // Family
  charity,  // Charity
  work,     // Work
}

extension NiyyahCategoryExtension on NiyyahCategory {
  String get label {
    switch (this) {
      case NiyyahCategory.ibadah:
        return 'Worship';
      case NiyyahCategory.akhlaq:
        return 'Character';
      case NiyyahCategory.family:
        return 'Family';
      case NiyyahCategory.charity:
        return 'Charity';
      case NiyyahCategory.work:
        return 'Work';
    }
  }

  String get arabicLabel {
    switch (this) {
      case NiyyahCategory.ibadah:
        return 'عبادة';
      case NiyyahCategory.akhlaq:
        return 'أخلاق';
      case NiyyahCategory.family:
        return 'عائلة';
      case NiyyahCategory.charity:
        return 'صدقة';
      case NiyyahCategory.work:
        return 'عمل';
    }
  }
}
