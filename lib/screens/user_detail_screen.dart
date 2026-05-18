import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const SizedBox(height: 30),

            CircleAvatar(
              radius: 50,
              child: Text(
                user.name[0],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            _buildInfoCard(
              icon: Icons.email,
              title: "email",
              value: user.email,
            ),

            _buildInfoCard(
              icon: Icons.phone,
              title: "phone",
              value: user.phone,
            ),

            _buildInfoCard(
              icon: Icons.web,
              title: "website",
              value: user.website,
            ),

            _buildInfoCard(
              icon: Icons.apartment,
              title: "company",
              value: user.company.name,
            ),

            SizedBox(height: 15),

            _buildInfoCard(
              icon: Icons.location_on,
              title: "Address",
              value: "${user.address.street},${user.address.city}",
            ),

            _buildInfoCard(
              icon: Icons.map,
              title: "location cordinate",
              value: "lat:${user.address.geo.lat},lng:${user.address.geo.lng}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        child: ListTile(
          leading: Icon(icon, color: Colors.blue),
          title: Text(title),
          subtitle: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
