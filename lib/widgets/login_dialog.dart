import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/providers/favorite_provider.dart';
import 'package:iq101/service/product_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screen/cap.dart';
import '../model/pref_status.dart';
import '../model/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/past_order_provider.dart';
import '../service/user_service.dart';
import '../shared_prefs.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  AuthProvider? authProvider;
  FavoriteProvider? favoriteProvider;
  bool register = false;
  bool isProcessing = false;
  bool? isEmailidvalid;

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: const EdgeInsets.all(8),
      // insetPadding: EdgeInsets.all(0.0.s),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      content: IntrinsicHeight(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: const TextStyle(
                  color: Color(0xFFDAEE01),
                ),
                cursorColor: const Color(0xFFDAEE01),
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              if (isEmailidvalid == false)
                Text(
                  'Email id not valid',
                  style: GoogleFonts.oswald(color: Colors.red, fontSize: 10),
                ),
              if (register == true) const SizedBox(height: 16.0),
              register == true
                  ? TextField(
                      style: const TextStyle(
                        color: Color(0xFFDAEE01),
                      ),
                      controller: usernameController,
                      cursorColor: const Color(0xFFDAEE01),
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 16.0),
              TextField(
                style: const TextStyle(
                  color: Color(0xFFDAEE01),
                ),
                controller: _passwordController,
                cursorColor: const Color(0xFFDAEE01),
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 16.0),
              register == true
                  ? TextField(
                      style: const TextStyle(
                        color: Color(0xFFDAEE01),
                      ),
                      controller: _repasswordController,
                      cursorColor: const Color(0xFFDAEE01),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Re-Enter Password',
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 16.0),
              register == false
                  ? ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isProcessing = true;
                        });
                        User? user = (await UserService().loginSys(context,
                            _emailController.text, _passwordController.text));

                        setState(() {
                          isProcessing = false;
                        });
                        await SharedPrefs().addMapPrefs(
                          'userdetails',
                          user!.toJson(),
                        );
                        authProvider?.setUserDetails(user);
                        favoriteProvider?.favoriteData = await ProductService()
                            .getFavorites(authProvider!.userDetails!.id!);
                        Provider.of<PastOrderProvider>(context, listen: false)
                                .pastOrderData =
                            await ProductService().getProductsForUser(user.id);
                        final usa = await getUserDetails();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Cap(user: usa)),
                        );
                      },
                      child: isProcessing == false
                          ? Text(
                              'Login',
                              style: GoogleFonts.oswald(color: Colors.black),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.black,
                            ),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isProcessing = true;
                        });
                        var check = validateEmail(_emailController.text);
                        isEmailidvalid = check;
                        if (_passwordController.text ==
                                _repasswordController.text &&
                            _emailController.text.isNotEmpty &&
                            usernameController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            check == true) {
                          await UserService().register(
                            usernameController.text,
                            _emailController.text,
                            _passwordController.text,
                          );
                          _updateStateAfterRegistration();
                          setState(() {
                            isProcessing = false;
                          });
                        } else {
                          setState(() {
                            isProcessing = false;
                          });
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                  'Please fill all the details properly'),
                              content: const Text(
                                  'Check Passwords are matching or not'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: isProcessing == false
                          ? Text(
                              'Register & Login',
                              style: GoogleFonts.oswald(color: Colors.black),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.black,
                            ),
                    ),
              register == false
                  ? Center(
                      child: InkWell(
                      onTap: () {
                        setState(() {
                          register = true;
                        });
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Register",
                            style: GoogleFonts.oswald(
                                color: const Color(0xFFDAEE01), fontSize: 10),
                          )),
                    ))
                  : Center(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            register = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Login",
                            style: GoogleFonts.oswald(
                                color: const Color(0xFFDAEE01), fontSize: 10),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future<User?> getUserDetails() async {
    User? userData;
    PrefsStatus items = await SharedPrefs().getMapPrefs('userdetails');
    if (items.status == true) {
      userData = User.fromJson(items.value);
    }
    return userData;
  }

  void _updateStateAfterRegistration() {
    setState(() {
      register = false;
      isProcessing = false;
    });
  }

  void _processing() {
    setState(() {
      isProcessing = false;
    });
  }

  bool validateEmail(String email) {
    // Regular expression pattern for validating email addresses
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

    // Create a RegExp object using the pattern
    final regex = RegExp(pattern);

    // Use the RegExp's "hasMatch" method to check if the email matches the pattern
    return regex.hasMatch(email);
  }
}
