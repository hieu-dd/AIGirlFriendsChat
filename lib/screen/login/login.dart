import 'package:ai_girl_friends/domain/user/model/user.dart';
import 'package:ai_girl_friends/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const direction = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String? _gender = Gender.other.name;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Name *',
                        hintText: 'What do people call you?',
                        icon: Icon(Icons.person),
                      ),
                    ),
                    TextFormField(
                      controller: _ageController,
                      enabled: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Age *',
                        hintText: 'How old are you?',
                        icon: Icon(Icons.timer),
                      ),
                    ),
                    DropdownButton(
                        value: _gender,
                        items: Gender.values
                            .map<DropdownMenuItem<String>>(
                                (e) => DropdownMenuItem(
                                      value: e.name,
                                      child: Text(e.name),
                                    ))
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _gender = newValue;
                          });
                        }),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ref.read(authProvider.notifier).loginWithUser(
                                  name: _nameController.text,
                                  age: int.parse(_ageController.text),
                                  genderValue: _gender!,
                                );
                          }
                        },
                        child: Text('Login'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
