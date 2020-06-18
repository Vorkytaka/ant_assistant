import 'package:antassistant/entity/user_data.dart';
import 'package:html/dom.dart';

UserData parseUserData(Document document) {
  final balance = double.parse(
      document.querySelector("td.num").text.replaceAll(" руб.", ""));

  final tables = document.querySelectorAll("td.tables");
  String accountName;
  String userId;
  String dynDns;
  String tariffName;
  double tariffPricePerMonth;
  String downloadSpeed;
  String uploadSpeed;
  int credit;
  bool status;
  int downloaded;
  bool smsInfo;
  for (var i = 0; i < tables.length; i += 3) {
    final ch = tables[i].nodes.first.text;
    switch (ch) {
      case "Код плательщика":
        userId = tables[i + 1].text;
        break;
      case "Ваш DynDNS":
        dynDns = tables[i + 1].text;
        break;
      case "Тариф":
        final tariffStr = tables[i + 1].text;

        // название
        tariffName = tariffStr.substring(0, tariffStr.indexOf(":"));

        // цена
        final priceStr = tariffStr
            .substring(tariffStr.indexOf(":") + 1, tariffStr.indexOf("р"))
            .trim();
        tariffPricePerMonth = double.parse(priceStr);

        // скорость
        // бывает двух типов
        // 100/100 Мб
        // или
        // до 100 Мб

        final speedRE = RegExp("\\d+/\\d+");
        final speedResult = speedRE.firstMatch(tariffStr);
        if (speedResult != null) {
          final speeds = speedResult.group(0).split("/");
          downloadSpeed = speeds[0];
          uploadSpeed = speeds[1];
        } else {
          final speed = tariffStr.substring(
              tariffStr.indexOf("до ") + 3, tariffStr.indexOf("("));
          downloadSpeed = speed;
          uploadSpeed = speed;
        }

        break;

      case "Кредит доверия, руб":
        credit = int.parse(tables[i + 1].text);
        break;

      case "Статус учетной записи":
        status = tables[i + 1].text == "Активна";
        break;

      case "Скачано за текущий месяц":
        downloaded = int.parse(tables[i + 1].text.replaceAll(" ( Мб. )", ""));
        break;

      case "SMS-информирование":
        smsInfo = tables[i + 1].text != "Отключено";
        break;

      case "Учетная запись":
        accountName = tables[i + 1].text;
        break;
    }
  }

  return UserData(
      accountName,
      userId,
      dynDns,
      balance,
      downloaded,
      status,
      credit,
      smsInfo,
      tariffName,
      downloadSpeed,
      uploadSpeed,
      tariffPricePerMonth);
}
