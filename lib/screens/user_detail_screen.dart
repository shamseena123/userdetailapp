import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text('Name:${user.name}'),

            Text('Username:${user.username}'),

            Text('Email:${user.email}'),

            Text('phone:${user.phone}'),

            Text('Website:${user.website}'),

            SizedBox(height: 15),

            Text('Company name:${user.company.name}'),

            Text('Address:'),

            Text('${user.address.street}'),
            Text('${user.address.city}'),

            SizedBox(height: 15),

            Text('latitude:${user.address.geo.lat}'),
            Text('longtitude:${'user.address.geo.lng'}'),
          ],
        ),
      ),
    );
  }
}
