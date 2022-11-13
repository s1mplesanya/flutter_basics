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
        title: Text('Login to your account'),
      ),
      body: Container(
        child: ListView(
          children: [HeaderWidget()],
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 16);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          _FormWidget(),
          SizedBox(
            height: 25,
          ),
          Text(
            'addawadjwjdandwhwadbnkadjwnjakwdnajkwdnajkwdnajkdnajwkdbnajk addawadjwjdandwhwadbnkadjwnjakwdnajkwdnajkwdnajkdnajwkdbnajk addawadjwjdandwhwadbnkadjwnjakwdnajkwdnajkwdnajkdnajwkdbnajkv',
            style: textStyle,
          ),
          TextButton(
            onPressed: () {},
            child: Text('Register'),
            style: AppButtonStyle.linkButton,
          ),
          SizedBox(
            height: 25,
          ),
          Text(
              'addawadjwjdandwhwadbnkadjwnjakwdnajkwdnajkwdnajkdnajwkdbnajk bajw dbkja bdkj ab dkjba w kaj dja',
              style: textStyle),
          TextButton(
            onPressed: () {},
            child: Text('Verify Email'),
            style: AppButtonStyle.linkButton,
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
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  String? errorText = null;

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
    final textStyle = TextStyle(color: Color(0xFF212529), fontSize: 16);
    final MainColor = Color(0xFF01B4E4);
    final textFieldDecorator = InputDecoration(
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
            style: TextStyle(color: Colors.red, fontSize: 17),
          ),
          SizedBox(
            height: 20,
          ),
        ],
        Text(
          'Username',
          style: textStyle,
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: _loginTextController,
          decoration: textFieldDecorator,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Password',
          style: textStyle,
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: _passwordTextController,
          obscureText: true,
          decoration: textFieldDecorator,
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            TextButton(
              onPressed: _auth,
              child: Text('Login'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MainColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  )),
            ),
            SizedBox(
              width: 30,
            ),
            TextButton(
              onPressed: _resetPassword,
              child: Text('Reset Password'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(MainColor),
                textStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        )
      ],
    );
  }
}
