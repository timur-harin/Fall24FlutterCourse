import 'package:neumorphic_ui/neumorphic_ui.dart';

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({
    super.key,
    required this.title,
    this.max = 15.0,
    required this.onChanged,
    this.accent,
    this.initialValue = 15,
  });

  final String title;
  final Function(int value) onChanged;
  final Color? accent;
  final double max;
  final int initialValue;

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.title),
        NeumorphicSlider(
          min: 0.0,
          max: widget.max,
          value: value.toDouble(),
          onChanged: (newValue) {
            value = newValue.round();
            setState(() {});
            widget.onChanged(value);
          },
        ),
      ],
    );
  }
}
