import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: profileProvider.isProfileComplete
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.deepPurple[100],
                    child: const Icon(Icons.person,
                        size: 60, color: Colors.deepPurple),
                  ),
                  Align(
                    child: TextButton.icon(
                      onPressed: () =>
                          _showProfileDialog(context, isEdit: true),
                      icon: const Icon(Icons.edit, color: Colors.deepPurple),
                      label: const Text("Edit Profile"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(profileProvider.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 10),
                  Center(child: Text(profileProvider.email)),
                  const SizedBox(height: 10),
                  Center(child: Text(profileProvider.phone)),
                  const SizedBox(height: 10),
                  Center(child: Text(profileProvider.address)),
                  const Divider(height: 40),
                  ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text("Order History"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.receipt_long),
                    title: const Text("Your Transactions"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text("Your Favourites"),
                    onTap: () {},
                  ),
                ],
              ),
            )
          : Center(
              child: ElevatedButton(
                onPressed: () => _showProfileDialog(context),
                child: const Text("Complete Profile"),
              ),
            ),
    );
  }

  void _showProfileDialog(BuildContext context, {bool isEdit = false}) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    final nameController =
        TextEditingController(text: isEdit ? profileProvider.name : '');
    final emailController =
        TextEditingController(text: isEdit ? profileProvider.email : '');
    final phoneController =
        TextEditingController(text: isEdit ? profileProvider.phone : '');
    final addressController =
        TextEditingController(text: isEdit ? profileProvider.address : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? "Edit Profile" : "Complete Your Profile"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: "Phone"),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: "Address"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty &&
                    addressController.text.isNotEmpty) {
                  await profileProvider.saveProfile(
                    nameController.text,
                    emailController.text,
                    phoneController.text,
                    addressController.text,
                  );
                  await profileProvider.loadProfile();
                  if (mounted) Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
