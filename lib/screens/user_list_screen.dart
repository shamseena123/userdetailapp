import 'package:flutter/material.dart';
import 'package:user_details_app/screens/user_detail_screen.dart';
import '../models/user_model.dart';
import '../services/api_services.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<UserModel>> userFuture;

  @override
  void initState() {
    super.initState();
    userFuture = ApiServices().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('users')),

      body: FutureBuilder<List<UserModel>>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return ListTile(
                title: Text(user.name),

                subtitle: Text(user.email),

                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailScreen(user: user),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
