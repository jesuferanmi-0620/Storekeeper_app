import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Toggle
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          const Divider(),

          // App Info Section
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('App Info'),
          ),
          const ListTile(
            title: Text('Storekeeper App'),
            subtitle: Text('Version 1.0.0'),
          ),
          const ListTile(
            title: Text('Developer'),
            subtitle: Text('Jesuferanmi Oluwasegun'),
          ),

          const SizedBox(height: 20),

          // Optional: Contact / Feedback
          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: const Text('Send Feedback'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feature coming soon!')),
              );
            },
          ),
        ],
      ),
    );
  }
}
