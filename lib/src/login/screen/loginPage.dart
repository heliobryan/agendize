import 'package:agendize/src/globalConstants/appFont.dart';
import 'package:agendize/src/login/service/loginService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
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

  bool _showA = false;
  bool _showText = false;
  String _text = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _sizeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _moveController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _loginController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

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

  void _animateText() async {
    String fullText = "gendize";
    for (int i = 0; i < fullText.length; i++) {
      await Future.delayed(Duration(milliseconds: 150));
      setState(() => _text = fullText.substring(0, i + 1));
    }

    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        _moveController.forward();
        _loginController.forward();
      }
    });
  }

  // Método para login
  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Preencha todos os campos!");
      return;
    }

    User? user = await AuthService().signInWithEmail(email, password);
    if (user != null) {
      _showMessage("Login realizado com sucesso!");
      // Navegar para a próxima tela
    } else {
      _showMessage("Falha ao fazer login.");
    }
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
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(color: Color(0xFFBDC3C7)),
                                    backgroundColor: Color(0xFF3498DB),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  onPressed: _login,
                                  child: Text('ENTRAR',
                                      style: principalFont.bold(
                                          color: Colors.white, fontSize: 20)),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('Esqueceu a senha?',
                                    style: principalFont.medium(
                                        color: Color(0xFF3498DB))),
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
