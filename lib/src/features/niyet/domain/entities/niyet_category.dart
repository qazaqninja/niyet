enum NiyetCategory {
  ibadah,   // Worship
  akhlaq,   // Character
  family,   // Family
  charity,  // Charity
  work,     // Work
}

extension NiyetCategoryExtension on NiyetCategory {
  String get label {
    switch (this) {
      case NiyetCategory.ibadah:
        return 'Worship';
      case NiyetCategory.akhlaq:
        return 'Character';
      case NiyetCategory.family:
        return 'Family';
      case NiyetCategory.charity:
        return 'Charity';
      case NiyetCategory.work:
        return 'Work';
    }
  }

  String get arabicLabel {
    switch (this) {
      case NiyetCategory.ibadah:
        return 'عبادة';
      case NiyetCategory.akhlaq:
        return 'أخلاق';
      case NiyetCategory.family:
        return 'عائلة';
      case NiyetCategory.charity:
        return 'صدقة';
      case NiyetCategory.work:
        return 'عمل';
    }
  }
}
