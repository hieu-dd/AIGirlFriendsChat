import 'package:ai_girl_friends/domain/user/model/user.dart';
import 'package:ai_girl_friends/ext/list_ext.dart';
import 'package:ai_girl_friends/ext/string_ext.dart';
import 'package:ai_girl_friends/screen/widget/icon.dart';
import 'package:ai_girl_friends/screen/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  static const direction = '/register';

  @override
  ConsumerState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  Gender _selectedGender = Gender.other;
  int currentStep = 0;

  void onContinue() {
    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 66,
            ),
            Row(
              children: [0, 1, 2, 3].mapTo((step) => Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: currentStep > step
                          ? () {
                              setState(() {
                                currentStep = step;
                              });
                            }
                          : null,
                      child: Container(
                        margin: EdgeInsets.only(right: step == 3 ? 0 : 14),
                        height: 7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(
                                step <= currentStep ? 0xFFF86054 : 0xFF262626)),
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              _titles[currentStep],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              _descriptions[currentStep],
              style: const TextStyle(fontSize: 14, color: Color(0xFFAFB0B9)),
            ),
            const SizedBox(
              height: 48,
            ),
            if (currentStep == 0) _step1(),
            if (currentStep == 1) ..._step2(context),
            if (currentStep == 2) _step3(),
            if (currentStep == 3) _step4(),
            const Spacer(),
            InkWell(
              onTap: onContinue,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFB341),
                        Color(0xFFFEB441),
                        Color(0xFFEFCB4D),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    const Text("Continue"),
                    IconContinue(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _step1() {
    return RoundedTextField(
      textEditingController: _nameController,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      background: Colors.white.withOpacity(0.1),
      height: 47,
      hintText: "Enter your name",
    );
  }

  List<Widget> _step2(BuildContext context) {
    return Gender.values.mapTo((gender) => InkWell(
          onTap: () {
            setState(() {
              _selectedGender = gender;
            });
          },
          child: Container(
            height: 44,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.outline,
                ),
                color: Colors.white.withOpacity(0.1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  gender.name.capitalize(),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                _selectedGender == gender
                    ? Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    : const Icon(Icons.circle_outlined)
              ],
            ),
          ),
        ));
  }

  Widget _step3() {
    return Container(
      height: 47,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.outline,
          ),
          color: Colors.white.withOpacity(0.1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _birthDayTextField(_dayController),
          const Text(
            "/",
            style: TextStyle(fontSize: 20),
          ),
          _birthDayTextField(_monthController),
          const Text(
            "/",
            style: TextStyle(fontSize: 20),
          ),
          _birthDayTextField(_yearController),
        ],
      ),
    );
  }

  Widget _birthDayTextField(TextEditingController controller) {
    return Flexible(
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget _step4() {
    return RoundedTextField(
      textEditingController: _jobController,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      background: Colors.white.withOpacity(0.1),
      height: 47,
      hintText: "Enter your job",
    );
  }
}

const List<String> _titles = [
  "What’ your first name?",
  "What’s your gender?",
  "What’s your birthday?",
  "What’s your job?,"
];

const List<String> _descriptions = [
  "Everyone will call you by this name",
  "Choose your gender to hihihi",
  "You will not be able to change it later on",
  "Let’s see if we share the same profession",
];
