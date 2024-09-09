import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:bottom_picker/bottom_picker.dart';

class DefaultSliderWidget extends StatefulWidget {
  const DefaultSliderWidget({
    super.key,
    required this.onChanged,
    required this.title,
    this.accent,
    this.min,
    this.max,
    this.initialValue,
  });

  final Function(int) onChanged;
  final Color? accent;
  final String title;
  final double? min;
  final double? max;
  final int? initialValue;

  @override
  State<DefaultSliderWidget> createState() => _DefaultSliderWidgetState();
}

class _DefaultSliderWidgetState extends State<DefaultSliderWidget> {
  late int currentValue;

  @override
  void initState() {
    super.initState();

    currentValue = widget.initialValue ?? 5;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        Bounceable(
          onTap: () => _showPicker(context),
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Text(currentValue.toStringAsFixed(0)),
          ),
        ),
      ],
    );
  }

  void _showPicker(BuildContext context) => BottomPicker.time(
        pickerTitle: Text(widget.title),
        initialTime: Time(),
        onChange: _onTimeChanged,
        onClose: _onPickerClosed,
      ).show(context);

  void _onTimeChanged(dynamic value) {
    currentValue = value.minute;
  }

  void _onPickerClosed() {
    widget.onChanged(currentValue);
    setState(() {});
  }
}
