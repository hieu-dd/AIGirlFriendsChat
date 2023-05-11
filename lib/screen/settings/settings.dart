import 'package:ai_girl_friends/screen/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: commonAppbar(
        context: context,
        title: const Text(
          'Setting',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.music_note),
            title: Text("Sound Effects"),
            trailing: Switch(
              value: true,
              onChanged: (enable) {},
            ),
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Privacy Policy"),
          ),
          ListTile(
            leading: Icon(Icons.note_add_outlined),
            title: Text("Terms of Service"),
          ),
          ListTile(
            leading: Icon(Icons.sentiment_satisfied),
            title: Text("Feedback"),
          ),
        ],
      ),
    );
  }
}
