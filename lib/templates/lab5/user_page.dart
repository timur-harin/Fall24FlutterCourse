import 'package:flutter/material.dart';
import 'user.dart'; // Your User class and fetchUsers function

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late Future<List<User>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading users'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailPage(user: user),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class UserDetailPage extends StatelessWidget {
  final User user;

  const UserDetailPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${user.username}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Phone: ${user.phone}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Website: ${user.website}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text('Company:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Name: ${user.company.name}', style: const TextStyle(fontSize: 16)),
            Text('CatchPhrase: ${user.company.catchPhrase}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text('Address:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Street: ${user.address.street}', style: const TextStyle(fontSize: 16)),
            Text('City: ${user.address.city}', style: const TextStyle(fontSize: 16)),
            Text('Geo: (${user.address.geo.lat}, ${user.address.geo.lng})', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
