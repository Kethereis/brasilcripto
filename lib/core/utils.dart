extension StringTruncate on String {
  String truncateWithEllipsis(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength).trimRight()}...';
  }
}

