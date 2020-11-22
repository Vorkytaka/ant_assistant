import 'package:antassistant/global.dart';
import 'package:antassistant/screen/login/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UnauthenticatedScreen extends StatelessWidget {
  static const String ROUTE = "/start";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Добро пожаловать\nв ANTAssistant",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.subtitle1,
                      children: [
                        TextSpan(
                          text:
                              "Ваш карманный помощник в работе с провайдером ",
                        ),
                        TextSpan(
                          text: "«‎Альфа Нет Телеком»",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              await launch("http://a-n-t.ru/");
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () async {
                      Navigator.of(context)
                          .pushNamed(LoginScreenProvider.ROUTE);
                    },
                    child: Text(
                      "Добавить аккаунт",
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlineButton(
                    onPressed: () async {
                      await launch(URIs.SUPPORT_PHONE.toString());
                    },
                    child: Text(
                      "Звонок в службу поддержки",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
