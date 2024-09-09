import 'package:neumorphic_ui/neumorphic_ui.dart';

const double kShowerSessionHistoryHeight = 64.0;

class ShowerSessionHistory extends StatelessWidget {
  const ShowerSessionHistory({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kShowerSessionHistoryHeight,
      child: NeumorphicButton(
        onPressed: onPressed,
        child: const ListTile(
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Title', style: TextStyle(fontSize: 16.0)),
              Text('18:00 - 18:13', style: TextStyle(fontSize: 12.0)),
            ],
          ),
          trailing: Text('08.09.2024'),
        ),
      ),
    );
  }
}
