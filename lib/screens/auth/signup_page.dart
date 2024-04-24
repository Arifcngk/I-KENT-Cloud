import 'package:e_belediyecilik/misc/colors.dart';
import 'package:e_belediyecilik/provider/auth_provider.dart';
import 'package:e_belediyecilik/screens/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart' as x;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final bool status = false;
  final space = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);

    //  authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                bannerMsj(),
                Column(
                  children: <Widget>[
                    nameTxtField(), // name input alanı
                    space,
                    emailTxtField(), // email input alanı
                    const SizedBox(height: 20),
                    passwordTxtField(), // password input alanı
                  ],
                ),
                registerBtn(context),
                const Center(child: Text("Veya ")),
                googleRegisterBtn(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Zaten Bir Hesabım var?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                      child: const Text(
                        "Giriş Sayfası",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column bannerMsj() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 60.0),
        const Text(
          "Kayıt Ol",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        space,
        Text(
          "Kullanıcı Hesabı Oluştur",
          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        )
      ],
    );
  }

  Container googleRegisterBtn() {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.purple,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          authProvider.registerWithGoogle().then((value) {
            if (value != null) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.topSlide,
                showCloseIcon: true,
                title: "Kayıt İşleminiz Başarılı !",
                desc:
                    "E-belediye ailemize hoşgeldiniz hizetlerden yararlanmak için giriş yapınız !",
                btnOkOnPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                },
              ).show();
            }
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30.0,
              width: 30.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('img/google.png'), fit: BoxFit.cover),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 18),
            const Text(
              "Google ile Kayıt Ol!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container registerBtn(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
        padding: const EdgeInsets.only(top: 3, left: 3),
        child: ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              authProvider
                  .register(_emailController.text, _passwordController.text, )
                  .then((value) {
                // Kayıt işlemi başarılı oldu
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.topSlide,
                  showCloseIcon: true,
                  title: "Kayıt İşleminiz Başarılı !",
                  desc:
                      "E-belediye ailemize hoşgeldiniz hizetlerden yararlanmak için giriş yapınız !",
                  btnOkOnPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  },
                ).show();
              }).catchError((error) {
                // Kayıt işlemi başarısız oldu
                if (error is x.FirebaseAuthException) {
                  if (error.code == 'email-already-in-use') {
                    // Eğer e-posta adresi zaten kullanılıyorsa, kullanıcıya mesaj göster
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.topSlide,
                      showCloseIcon: true,
                      title: "Zaten Bir Hesabınız Var !",
                      desc:
                          " Bir Hesabınız var görünüyor. Giriş Yap Sayfasından Uygulamayı Kullanabilirsiniz. !",
                      btnOkOnPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                    ).show();
                  } else {
                    // Diğer hatalar için genel bir hata mesajı göster
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.topSlide,
                      showCloseIcon: true,
                      title: "Hata !",
                      desc:
                          "Sanırım Bir Şeyler Ters Gitti Lütfen Bizimle İletişime Geçin!",
                      btnOkOnPress: () {},
                    ).show();
                  }
                }
              });
            }
          },
          child: const Text(
            "Kayıt Ol",
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: AppColors.blueColor,
          ),
        ));
  }

  TextFormField passwordTxtField() {
    return TextFormField(
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Lütfen bir değer girin";
        } else if (value.length < 3) {
          return "En az 3 karakter giriniz";
        } else {
          return null; // Geçerli değer
        }
      },
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
    );
  }

  TextFormField emailTxtField() {
    return TextFormField(
      controller: _emailController,
      validator: (value) {
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!);
        if (!emailValid) {
          return "Lütfen geçerli bir email adresi giriniz";
        }
      },
      decoration: InputDecoration(
          hintText: "Email",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none),
          fillColor: Colors.blueGrey.withOpacity(0.1),
          filled: true,
          prefixIcon: const Icon(Icons.email)),
    );
  }

  TextFormField nameTxtField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
          hintText: " Kullanıcı Adı",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none),
          fillColor: Colors.blueGrey.withOpacity(0.1),
          filled: true,
          prefixIcon: const Icon(Icons.person)),
    );
  }
}
