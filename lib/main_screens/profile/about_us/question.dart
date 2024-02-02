import 'package:flutter/material.dart';
import 'package:prostate_care/global_comonents/custom_button.dart';
import 'package:prostate_care/global_comonents/custom_textfield.dart';
import 'package:prostate_care/main_screens/profile/about_us/pop_up.dart';
import 'package:prostate_care/main_screens/profile/about_us/question_function.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:provider/provider.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text(
            "Question",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Constants.gap(width: 20),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Details of your question",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Constants.gap(height: 20),
                  CustomTextField(
                    controller: _questionController,
                    hintText: "Enter question title",
                    onChange: () {
                      setState(() {});
                    },
                  ),
                  Constants.gap(height: 20),
                  CustomTextField(
                    controller: _descriptionController,
                    hintText: "Enter description of your question",
                    maxLines: 10,
                    onChange: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
              CustomButton(
                loading: loading,
                enable: _descriptionController.text.isNotEmpty &&
                    _questionController.text.isNotEmpty,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  Map<String, String> q = {
                    "title": _questionController.text,
                    "description": _descriptionController.text,
                    "email": authProvider.user!.email,
                    "id": authProvider.user!.id,
                  };
                  await QuestionFunction.updateUserDocument(q);
                  _descriptionController.clear();
                  _questionController.clear();
                  setState(() {});
                  await showDialog<void>(
                      context: context, builder: (context) => QuestionPopup());
                  setState(() {
                    loading = false;
                  });
                },
                title: "Send Question",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
