import 'package:antassistant/presentation/login/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UnauthenticatedWidget extends StatelessWidget {
  static final supportPhoneUri = Uri(
    scheme: "tel",
    path: "+7 495 940-92-11",
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1,
                    children: [
                      TextSpan(
                        text: "Ваш карманный помощник в работе с провайдером ",
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
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreenProvider()));
                      },
                      child: Text(
                        "Добавить аккаунт",
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                      onPressed: () async {
                        await launch(supportPhoneUri.toString());
                      },
                      child: Text(
                        "Звонок в службу поддержки",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
