import 'package:neumorphic_ui/neumorphic_ui.dart';

class StartSessionFloatingButton extends StatelessWidget {
  const StartSessionFloatingButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final void Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: NeumorphicStyle(
        color: Theme.of(context).primaryColor,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12.0)),
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: 36.0,
        width: 128.0,
        child: Center(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
