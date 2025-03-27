// formatters.dart

class Formatters {
  static String formatCurrency(double value) {
    return "\$${value.toStringAsFixed(2)}";
  }
}
