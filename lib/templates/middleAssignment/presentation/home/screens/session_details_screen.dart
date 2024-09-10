import 'package:auto_route/auto_route.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/domain/session_entity.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

@RoutePage()
class SessionDetailsScreen extends StatelessWidget {
  const SessionDetailsScreen({super.key, required this.session});

  final SessionEntity session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session Details'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                  context,
                  label: 'Amount of Sets',
                  value: session.amountOfSets.toString(),
                ),
                _buildDetailRow(
                  context,
                  label: 'Cold Interval',
                  value: '${session.coldIntervalSeconds}s',
                ),
                _buildDetailRow(
                  context,
                  label: 'Hot Interval',
                  value: '${session.hotIntervalSeconds}s',
                ),
                _buildDetailRow(
                  context,
                  label: 'Start With',
                  value: session.startWithCold ? 'Cold' : 'Hot',
                ),
                _buildDetailRow(
                  context,
                  label: 'Date & Time',
                  value: session.dateAndTime.toString(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context,
      {required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
