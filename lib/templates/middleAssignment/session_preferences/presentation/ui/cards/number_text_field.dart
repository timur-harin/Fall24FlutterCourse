import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import '../../../../ui/theme/theme.dart';

const _inputLength = 2;

class NumberTextField extends StatefulWidget {
  final String label;
  final TextEditingController textController;
  final void Function(String) onChanged;

  const NumberTextField({
    super.key,
    required this.label,
    required this.textController,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => NumberTextFieldState();
}

class NumberTextFieldState extends State<NumberTextField> {
  final _theme = GetIt.instance<AppTheme>();
  final _key = GlobalKey<FormState>();
  bool _isInputValid = true;

  @override
  void dispose() {
    widget.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
    key: _key,
    controller: widget.textController,
    decoration: _outlinedDecoration(),
    keyboardType: TextInputType.number,
    style: _theme.typography.body.copyWith(
      color: _theme.colors.text.onCard,
    ),
    maxLength: _inputLength,
    cursorColor: _theme.colors.button.primary,
    onChanged: (text) {
      setState(() => _isInputValid = _isTextValid(text));
      widget.onChanged(text);
    },
  );

  InputDecoration _outlinedDecoration() =>
      InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _theme.colors.button.primary),
          borderRadius: BorderRadius.circular(_theme.dimensions.radius.small),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _theme.colors.button.primary),
          borderRadius: BorderRadius.circular(_theme.dimensions.radius.small),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _theme.colors.error),
          borderRadius: BorderRadius.circular(_theme.dimensions.radius.small),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _theme.colors.error),
          borderRadius: BorderRadius.circular(_theme.dimensions.radius.small),
        ),
        labelText: widget.label,
        labelStyle: _theme.typography.caption.copyWith(
          color: _theme.colors.text.onCard,
        ),
        hoverColor: _theme.colors.button.primary,
        counterStyle: _theme.typography.caption.copyWith(
          color: _theme.colors.text.onCard,
        ),
        errorText: _isInputValid ? null : '',
      );

  bool _isTextValid(String text) =>
      text.isEmpty || int.tryParse(text) != null;
}
