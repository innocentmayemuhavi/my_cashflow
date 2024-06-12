double calculateProgress(double spent, double totalCash) {
  if (totalCash <= 0) {
    return 0; // Avoid division by zero and handle cases where totalCash is not positive
  }
  double progress = spent / totalCash;
  return progress.clamp(0, 1); // Ensure the progress is within the range [0, 1]
}
