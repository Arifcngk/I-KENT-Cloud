import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_belediyecilik/misc/colors.dart';
import 'package:e_belediyecilik/provider/auth_provider.dart';
import 'package:e_belediyecilik/screens/home_page.dart';
import 'package:e_belediyecilik/screens/auth/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as x;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _logo(context),
                _inputField(context),
                _forgotPassword(context),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo(BuildContext context) {
    return Container(
      child: Image.asset("img/logo.png"),
    );
  }

  Widget _header(BuildContext context) {
    return const Column(
      children: [
        Text(
          "E-Belediyecilik",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Devam Etmek için Lütfen Giriş Yapınız"),
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          onTap: () {},
          controller: _emailController,
          decoration: InputDecoration(
              hintText: "Kullanıcı Adı:",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.blueGrey.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Parola",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.blueGrey.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Burada DashboardPage'e geçiş yapılacak sayfayı belirtmeniz gerekiyor
            authProvider
                .loginWithEmail(_emailController.text, _passwordController.text)
                .then((value) {
              if (value != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              }else {
                    // Diğer hatalar için genel bir hata mesajı göster
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.topSlide,
                      showCloseIcon: true,
                      title: "Lütfen Kayıt Olun !",
                      desc:
                          "Uygulamayı kullanabilmeniz için önce kayıt olmanız gerekmektetir.!",
                      btnOkOnPress: () {
                         Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupPage(),
                    ));
                      },
                    ).show();
                  }
            });
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: AppColors.blueColor,
          ),
          child: const Text(
            "Giriş",
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Şifremi Unuttum?",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Hesabın Yok mu? "),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupPage(),
                  ));
            },
            child: const Text(
              "Kayıt Ol",
              style: TextStyle(color: Colors.black),
            ))
      ],
    );
  }
}
