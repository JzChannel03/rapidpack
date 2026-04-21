import 'package:intl/intl.dart';

final _fmt = DateFormat("d 'de' MMMM, yyyy", 'es');

String formatDate(DateTime date) => _fmt.format(date);

String formatDateFromString(String raw) {
  final parsed = DateTime.tryParse(raw);
  if (parsed == null) return raw;
  return formatDate(parsed);
}
