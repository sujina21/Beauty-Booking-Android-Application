import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../view_model/signup/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _gap = const SizedBox(height: 8);
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Sujina Shrestha');
  final _phoneController = TextEditingController(text: '9846031459');
  final _emailController = TextEditingController(text: 'sujinasht@gmail.com');
  final _passwordController = TextEditingController(text: 'sujina123');
  final _confirmPasswordController = TextEditingController(text: 'sujina123');

  bool _isPasswordVisible = false;

  // Checking for Runtime Camera Permissions
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;

  Future _browseImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo != null) {
        setState(() {
          _img = File(photo.path);

          // Send File to server
          context.read<RegisterBloc>().add(LoadImage(file: _img!));
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          // Listener for Image Upload
          BlocListener<RegisterBloc, RegisterState>(
            listenWhen: (previous, current) =>
                previous.isImageLoading != current.isImageLoading ||
                previous.isImageSuccess != current.isImageSuccess,
            listener: (context, state) {
              if (state.isImageLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Uploading image..'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else if (state.isImageSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image uploaded successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (!state.isImageLoading &&
                  !state.isImageSuccess &&
                  state.imageName == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to upload image. Please try again.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
          // Listener for Student Registration
          BlocListener<RegisterBloc, RegisterState>(
            listenWhen: (previous, current) =>
                previous.isLoading != current.isLoading ||
                previous.isSuccess != current.isSuccess,
            listener: (context, state) {
              if (state.isLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Registering user...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else if (state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User registered successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );

                // Navigate back to the login page after registration success
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pop(context);
                });
              } else if (!state.isLoading && !state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to register user. Try again.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.grey[300],
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    checkCameraPermission();
                                    _browseImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.camera),
                                  label: const Text('Camera'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    checkCameraPermission();
                                    _browseImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.image),
                                  label: const Text('Gallery'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 180,
                        width: 180,
                        child: Container(
                          alignment: Alignment.center,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                radius: 100,
                                backgroundColor: Colors.white,
                                backgroundImage: _img != null
                                    ? FileImage(_img!)
                                    : const AssetImage(
                                        'assets/images/profile-placeholder.png',
                                      ) as ImageProvider,
                              ),
                              Positioned(
                                bottom: 5,
                                right: 20,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 24,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter full name';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    _gap,
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    _gap,
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            context.read<RegisterBloc>().add(RegisterUser(
                                  _img!,
                                  name: _nameController.text,
                                  phone: _phoneController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ));
                          }
                        },
                        child: const Text('Register'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
