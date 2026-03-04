import 'package:intl/intl.dart';

String formatPopulation(int population) {
  if (population >= 1000000000) {
    final v = population / 1000000000;
    return '${v.toStringAsFixed(v >= 10 ? 0 : 2)}B';
  }
  if (population >= 1000000) {
    final v = population / 1000000;
    return '${v.toStringAsFixed(v >= 10 ? 1 : 2)}M';
  }
  if (population >= 1000) {
    final v = population / 1000;
    return '${v.toStringAsFixed(v >= 10 ? 0 : 1)}K';
  }
  return population.toString();
}






String formatArea(double area) {
  final formatter = NumberFormat('#,###', 'en_US');
  return '${formatter.format(area)} sq km';
}












String timeZoneFormat(String timezone) {
  String clean = timezone.replaceAll('UTC', '').replaceAll(' ', '');
  final regex = RegExp(r'([+-])(\d{1,2})(?::(\d{2}))?');
  final match = regex.firstMatch(clean);

  if (match != null) {
    final sign = match.group(1); // + or -
    
    // Parse hours to int then back to string to handle "1" vs "01"
    final hoursInt = int.parse(match.group(2)!);
    final hours = hoursInt.toString().padLeft(2, '0');
    
    // Default minutes to 00 if not provided
    final minutes = match.group(3) ?? '00';

    // omit minutes if zero
    if (minutes == '00') {
      return 'UTC $sign$hours';
    }
    return 'UTC $sign$hours:$minutes';
  }

  // Fallback: If it's totally weird, return as is
  return timezone;
}