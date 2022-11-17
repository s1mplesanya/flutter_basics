import 'package:flutter/material.dart';
import 'package:lesson3/Theme/app_button_style.dart';
import 'package:lesson3/widgets/mainScreen/main_screen_widget.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to your account'),
      ),
      body: ListView(
        children: const [HeaderWidget()],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          const _FormWidget(),
          const SizedBox(
            height: 25,
          ),
          const Text(
            'addawadjwjdandwhwadbnkadjwnjakwdnajkwdnajkwdnajkdnajwkdbnajk addawadjwjdandwhwadbnkadjwnjakwdnajkwdnajkwdnajkdnajwkdbnajk addawadjwjdandwhwadbnkadjwnjakwdnajkwdnajkwdnajkdnajwkdbnajkv',
            style: textStyle,
          ),
          TextButton(
            onPressed: () {},
            style: AppButtonStyle.linkButton,
            child: const Text('Register'),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
              'addawadjwjdandwhwadbnkadjwnjakwdnajkwdnajkwdnajkdnajwkdbnajk bajw dbkja bdkj ab dkjba w kaj dja',
              style: textStyle),
          TextButton(
            onPressed: () {},
            style: AppButtonStyle.linkButton,
            child: const Text('Verify Email'),
          ),
        ],
      ),
    );
  }
}

class _FormWidget extends StatefulWidget {
  const _FormWidget({super.key});

  @override
  State<_FormWidget> createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {
  final _loginTextController = TextEditingController(text: "admin");
  final _passwordTextController = TextEditingController(text: "admin");
  String? errorText;

  void _auth() {
    final login = _loginTextController.text;
    final pass = _passwordTextController.text;
    if (login == 'admin' && pass == 'admin') {
      errorText = null;

      Navigator.of(context).pushReplacementNamed('/main_screen');
    } else {
      errorText = "неверный пароль";
    }
    setState(() {});
  }

  void _resetPassword() {
    print('reset password');
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Color(0xFF212529), fontSize: 16);
    const mainColor = Color(0xFF01B4E4);
    const textFieldDecorator = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isCollapsed: true,
    );
    final errorText = this.errorText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorText != null) ...[
          Text(
            errorText,
            style: const TextStyle(color: Colors.red, fontSize: 17),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
        const Text(
          'Username',
          style: textStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: _loginTextController,
          decoration: textFieldDecorator,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Password',
          style: textStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: _passwordTextController,
          obscureText: true,
          decoration: textFieldDecorator,
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            TextButton(
              onPressed: _auth,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(mainColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  )),
              child: const Text('Login'),
            ),
            const SizedBox(
              width: 30,
            ),
            TextButton(
              onPressed: _resetPassword,
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(mainColor),
                textStyle: MaterialStateProperty.all(
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              ),
              child: const Text('Reset Password'),
            ),
          ],
        )
      ],
    );
  }
}
