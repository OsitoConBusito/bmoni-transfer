import 'package:flutter/material.dart';

/// A controller for accumulator-style amount fields, where every keystroke
/// reconstructs the whole number from the right (like a calculator display) —
/// there is no stable "middle" position to edit. Pins the cursor to the end
/// on every change, including a tap that would otherwise place it mid-string;
/// without this, that tap is invisible until the next edit reformats the text
/// and snaps the cursor away, which reads as a jarring jump.
class EndCursorTextEditingController extends TextEditingController {
  @override
  set selection(TextSelection newSelection) {
    super.selection = TextSelection.collapsed(offset: text.length);
  }
}
