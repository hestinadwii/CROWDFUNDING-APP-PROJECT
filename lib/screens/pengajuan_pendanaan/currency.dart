import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    
  final value = int.tryParse(newValue.text.replaceAll('.', ''));
  if (value != null) {
    final formatValue = NumberFormat('#,###', 'id');
    final newFormatValue = formatValue.format(value);

    return TextEditingValue(
    // text: newText,
    text: newFormatValue.replaceAll(',', '.'),
    selection: TextSelection.collapsed(offset: newFormatValue.length)
   );
  }
  
  return newValue;
  }
}