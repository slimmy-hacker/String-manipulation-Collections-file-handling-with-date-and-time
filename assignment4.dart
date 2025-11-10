import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:characters/characters.dart';


/// CHARACTER PROCESSOR CLASS
class CharacterProcessor {
  final String input;
  late final Characters chars;

  CharacterProcessor(this.input) {
    chars = input.characters;
  }

  String concatenate(String extra) => '$input $extra';
  String interpolate() => 'You entered: $input';
  
  String substringFirst(int count) =>
      chars.length >= count ? chars.take(count).toString() : chars.toString();

  String toUpper() => input.toUpperCase();

  String toLower() => input.toLowerCase();

  String reverse() => chars.toList().reversed.join();

  int visibleLength() => chars.length;
}


/// MAIN PROGRAM

Future<void> main() async {
  await initializeDateFormatting();

  stdout.write('Enter a string: ');
  String input = stdin.readLineSync(encoding: utf8) ?? '';

  // Use our Character Processor class
  CharacterProcessor cp = CharacterProcessor(input);

  // Compute string values
  String concatenated = cp.concatenate('Dart Programming');
  String interpolated = cp.interpolate();
  String substring = cp.substringFirst(3);
  String upper = cp.toUpper();
  String lower = cp.toLower();
  String reversed = cp.reverse();
  int visibleLength = cp.visibleLength();

  print('\n--- String Manipulation ---');
  print('Concatenated: $concatenated');
  print('Interpolated: $interpolated');
  print('Substring (first 3): $substring');
  print('Uppercase: $upper');
  print('Lowercase: $lower');
  print('Reversed: $reversed');
  print('Visible Length: $visibleLength');

  // COLLECTIONS
  List<String> list = [input, reversed, upper, lower];
  Set<String> set = list.toSet();
  Map<String, dynamic> map = {
    'original': input,
    'reversed': reversed,
    'length': visibleLength,
    'timestamp': DateTime.now().toIso8601String(),
  };

  print('\n--- Collections ---');
  print('List: $list');
  print('Set: $set');
  print('Map: $map');

  // Modify collections
  list.add('New String');
  set.add('Unique Element');
  map['newKey'] = 'New Value';

  print('\nUpdated List: $list');
  print('Updated Set: $set');
  print('Updated Map: $map');

  // Iteration Samples
  print('\nIterating over list:');
  for (var item in list) {
    print(' $item');
  }

  print('\nIterating over map:');
  map.forEach((key, value) {
    print('$key: $value');
  });

  // DATE & TIME
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  String formattedDate = formatter.format(now);

  DateTime parsedDate;
  try {
    parsedDate = DateFormat('yyyy-MM-dd').parse('2025-11-08');
  } catch (e) {
    stderr.writeln('Date parse error: $e');
    parsedDate = DateTime.now();
  }

  DateTime futureDate = now.add(Duration(days: 7));
  Duration difference = futureDate.difference(now);

  print('\n--- Date & Time ---');
  print('Current Date: $formattedDate');
  print('Parsed Date: $parsedDate');
  print('Future Date (+7 days): $futureDate');
  print('Difference (days): ${difference.inDays}');

  // FILE HANDLING
  final inputFile = File('input.txt');
  final outputFile = File('output.txt');

  try {
    await inputFile.writeAsString(
      'User input: $input\nTimestamp: $formattedDate\n',
      encoding: utf8,
    );

    String content = await inputFile.readAsString(encoding: utf8);
    print('\n--- File Handling ---');
    print('Content of input.txt:\n$content');

    await outputFile.writeAsString(
      'Output Data\n'
      'Concatenated: $concatenated\n'
      'Reversed: $reversed\n'
      'Length: $visibleLength\n'
      'Stored on: $formattedDate\n'
      'List Data: $list\n'
      'Set Data: $set\n'
      'Map Data: $map\n',
      encoding: utf8,
    );

    print('Data successfully written to output.txt');
  } catch (e) {
    stderr.writeln('Error during file operations: $e');
  }

  print('\n--- Final Application Summary ---');
  print('User input: $input');
  print('Processed on: $formattedDate');
  print('Results saved to: output.txt');
}
