double calculatePercentageSpent(double spent, double total) {
  if (total <= 0) return 0.0; // Prevent division by zero or negative total
  return ((spent / total) * 100).clamp(0.0, 100.0); // Calculate percentage, ensure it's between 0 and 100
}