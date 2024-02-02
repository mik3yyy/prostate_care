import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prostate_care/global_comonents/custom_button.dart';
import 'package:prostate_care/global_comonents/custom_messageHandler.dart';
import 'package:prostate_care/global_comonents/custom_textfield.dart';
import 'package:prostate_care/main_screens/profile/profile_function.dart';
import 'package:prostate_care/models/user.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:prostate_care/settings/print.dart';
import 'package:prostate_care/settings/validators.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  dynamic _pickedImageError;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    _emailController.text = authProvider.user!.email;
    _nameController.text = authProvider.user!.fullName;
  }

  bool isOnline = true;
  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      if (pickedImage!.path != null) {
        setState(() {
          _imageFile = pickedImage;
        });
      }
    } catch (e) {
      setState(() {
        _pickedImageError = e.toString();
      });
      MyMessageHandler.showSnackBar(scaffoldKey, _pickedImageError);
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Text(
              "Edit my profile",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Constants.gap(width: 20),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Constants.gap(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: _imageFile != null
                          ? Image.file(
                              File(_imageFile!.path),
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            )
                          : Image.network(
                              authProvider.user!.image!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Constants.gap(height: 10),
                    CustomButton(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      title: "Change Image",
                      color: Constants.teal,
                      width: 116,
                      style: TextStyle(fontSize: 12, color: Constants.white),
                      height: 34,
                    ),
                    Constants.gap(height: 30),
                    CustomTextField(
                      controller: _nameController,
                      hintText: "Enter full name, surname first",
                      onChange: () {
                        setState(() {});
                      },
                    ),
                    Constants.gap(height: 20),
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Enter email address",
                      onChange: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
                CustomButton(
                  enable: _nameController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty,
                  loading: loading,
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      if (_emailController.text.isValidEmail() == false) {
                        setState(() {
                          loading = false;
                        });
                        return MyMessageHandler.showSnackBar(
                            scaffoldKey, "Enter valid email");
                      }
                      String image = authProvider.user!.image!;
                      if (_imageFile != null) {
                        // Print("1");
                        // TaskSnapshot snapshot = await FirebaseStorage.instance
                        //     .ref('users/${authProvider.user!.id}')
                        //     .putFile(File(_imageFile!.path));
                        // Print("2");
                        // String imageUrl = await snapshot.ref.getDownloadURL();

                        // image = imageUrl;

                        final cloudinary = Constants.CloudinaryKey;

                        var response = await cloudinary.upload(
                            file: _imageFile!.path,
                            // fileBytes: file.readAsBytesSync(),
                            resourceType: CloudinaryResourceType.image,
                            folder: "Users",
                            fileName: '${_emailController.text}',
                            progressCallback: (count, total) {
                              print(
                                  'Uploading image from file with progress: $count/$total');
                            });
                        if (response.isSuccessful) {
                          image = response.url!;
                        }
                      }
                      User user = User(
                        id: authProvider.user!.id,
                        email: _emailController.text,
                        fullName: _nameController.text,
                        reference: authProvider.user!.reference,
                        image: image,
                        password: authProvider.user!.password,
                      );
                      await ProfileFunction.updateUserDocument(
                          user: user,
                          context: context,
                          scaffoldKey: scaffoldKey);
                      setState(() {
                        loading = false;
                      });
                    } catch (e) {
                      Print(e.toString());
                    }
                  },
                  title: "Update changes",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
