import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text('Theme'),
            subtitle: const Text('System default'),
            onTap: () {
              // TODO: Implement theme selection
            },
          ),
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: const Text('Language'),
            subtitle: const Text('English'),
            onTap: () {
              // TODO: Implement language selection
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.mosque_outlined),
            title: const Text('Ramadan Mode'),
            subtitle: const Text('Activate during Ramadan'),
            trailing: Switch(
              value: false,
              onChanged: (value) {
                // TODO: Implement Ramadan mode toggle
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Niyet',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2024 Qazaq Ninja',
              );
            },
          ),
        ],
      ),
    );
  }
}
