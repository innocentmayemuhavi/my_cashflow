String formatNumber(double num) {
  if (num >= 1000 && num < 1000000) {
    return '${(num / 1000).toStringAsFixed(1)}K';
  } else if (num >= 1000000 && num < 1000000000) {
    return '${(num / 1000000).toStringAsFixed(1)}M';
  } else if (num >= 1000000000 && num < 1000000000000) {
    return '${(num / 1000000000).toStringAsFixed(1)}B';
  } else if (num >= 1000000000000) {
    return '${(num / 1000000000000).toStringAsFixed(1)}T';
  } else {
    return num.toString();
  }
}
