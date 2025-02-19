import 'dart:developer';
import 'package:agendize/src/globalConstants/appFont.dart';
import 'package:agendize/src/home/screen/homeScreen.dart';
import 'package:agendize/src/login/service/loginService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late AnimationController _moveController;
  late AnimationController _loginController;
  late Animation<double> _sizeAnimation;
  late Animation<Offset> _moveAnimation;
  late Animation<double> _loginOpacity;
  late AnimationController _buttonController;
  late Animation<double> _buttonWidthAnimation;

  bool _showA = false;
  bool _showText = false;
  String _text = "";
  bool _isLoading = false;
  bool _isSuccess = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    _sizeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _moveController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _loginController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _buttonController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _sizeAnimation = Tween<double>(begin: 300, end: 60).animate(
      CurvedAnimation(parent: _sizeController, curve: Curves.easeInOut),
    );

    _moveAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(0, -0.3)).animate(
      CurvedAnimation(parent: _moveController, curve: Curves.easeInOut),
    );

    _loginOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _loginController, curve: Curves.easeInOut),
    );

    _buttonWidthAnimation = Tween<double>(
      begin: 200,
      end: 60,
    ).animate(
        CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut));

    _checkLoginStatus();

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() => _showA = true);
      Future.delayed(Duration(milliseconds: 500), () {
        _sizeController.forward().then((_) {
          setState(() => _showText = true);
          _animateText();
        });
      });
    });
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    if (userToken != null) {
      setState(() {
        _isLoggedIn = true;
      });
      _navigateToHome();
    }
  }

  void _animateText() async {
    String fullText = "gendize";
    for (int i = 0; i < fullText.length; i++) {
      await Future.delayed(Duration(milliseconds: 150));
      setState(() => _text = fullText.substring(0, i + 1));
    }

    Future.delayed(Duration(seconds: 1), () {
      if (mounted && !_isLoggedIn) {
        debugPrint("Ativando animação do login...");
        _moveController.forward();
        _loginController.forward();
      }
    });
  }

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    FocusScope.of(context).unfocus();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Preencha todos os campos!");
      return;
    }

    setState(() {
      _isLoading = true;
      _isSuccess = false;
    });

    _buttonController.forward();

    try {
      User? user = await AuthService().signInWithEmail(email, password);
      if (user != null) {
        log("Login bem-sucedido: ${user.email}");

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userToken', user.uid);

        setState(() {
          _isSuccess = true;
        });

        await Future.delayed(Duration(seconds: 2));
        _navigateToHome();
      } else {
        _showMessage("Usuário não encontrado.");
      }
    } catch (e) {
      log("Erro no login: $e");
      _showMessage("Erro ao fazer login: ${e.toString()}");
    } finally {
      setState(() => _isLoading = false);
      _buttonController.reverse();
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isLoggedIn)
              SlideTransition(
                position: _moveAnimation,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 800),
                  opacity: _showA ? 1.0 : 0.0,
                  child: AnimatedBuilder(
                    animation: _sizeController,
                    builder: (context, child) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "A",
                                style: principalFont.bold(
                                  color: Color(0xFF3498DB),
                                  fontSize: _sizeAnimation.value,
                                ),
                              ),
                              if (_showText)
                                AnimatedOpacity(
                                  duration: Duration(milliseconds: 500),
                                  opacity: _text.isNotEmpty ? 1.0 : 0.0,
                                  child: Text(
                                    _text,
                                    style: principalFont.bold(
                                      color: Color(0xFF3498DB),
                                      fontSize: _sizeAnimation.value,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 20),
                          FadeTransition(
                            opacity: _loginOpacity,
                            child: Column(
                              children: [
                                _buildTextField("Email", Icons.email,
                                    _emailController, false),
                                SizedBox(height: 10),
                                _buildTextField("Senha", Icons.lock,
                                    _passwordController, true),
                                SizedBox(height: 10),
                                AnimatedBuilder(
                                  animation: _buttonWidthAnimation,
                                  builder: (context, child) {
                                    return SizedBox(
                                      width: 330,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          side: BorderSide(
                                              color: Color(0xFFBDC3C7)),
                                          backgroundColor: _isSuccess
                                              ? Colors.green
                                              : Color(0xFF3498DB),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: _isLoading ? null : _login,
                                        child: _isLoading
                                            ? CircularProgressIndicator(
                                                color: Colors.white)
                                            : _isSuccess
                                                ? Icon(Icons.check,
                                                    color: Colors.white)
                                                : Text(
                                                    'ENTRAR',
                                                    style: principalFont.bold(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                      ),
                                    );
                                  },
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Esqueceu a senha?',
                                    style: principalFont.medium(
                                      color: Color(0xFF3498DB),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon,
      TextEditingController controller, bool obscure) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Color(0xFF3498DB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(color: Colors.white),
        obscureText: obscure,
      ),
    );
  }

  @override
  void dispose() {
    _sizeController.dispose();
    _moveController.dispose();
    _loginController.dispose();
    _buttonController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
