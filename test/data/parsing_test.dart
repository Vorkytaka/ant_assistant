import 'package:antassistant/data/parser.dart';
import 'package:html/parser.dart';
import 'package:test/test.dart';

void main() {
  test("Parsing test", () {
    final document = parse(_TESTING_BODY);
    final userData = parseUserData(ParsingData(0, document));

    expect(userData.credentialsId, 0);
    expect(userData.accountName, "NOUA_2_187");
    expect(userData.accountId, "2000053468");
    expect(userData.dynDns, "2000053468.cl.a-n-t.ru");
    expect(userData.statusInfo.balance, 475.18);
    expect(userData.statusInfo.downloaded, 117311);
    expect(userData.statusInfo.status, "Активна");
    expect(userData.statusInfo.credit, 300);
    expect(userData.statusInfo.smsInfo, "Отключено");
    expect(userData.tariffInfo.tariffName, "VX-EXTRA");
    expect(userData.tariffInfo.downloadSpeed, "100");
    expect(userData.tariffInfo.uploadSpeed, "100");
    expect(userData.tariffInfo.pricePerMonth, 739);
  });
}

const String _TESTING_BODY = """
<?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"><head>
 <title>Информация о счете</title>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 <link rel="stylesheet" href="./themes/System/styles.css" type="text/css" /> 
</head><body><table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"><tr><td align="center">
<table width="895" border="0" cellspacing="0" cellpadding="0" align="center" height="135"><tr><td><table width="895" border="0" cellspacing="0" cellpadding="0"><tr>
<td width="271" height="88" valign="bottom" align="left"><a class="exit" href="http://www.a-n-t.ru" target="_blank"><img src="img/logo.png" width="105" height="82"></a></td>
<td width="624" height="88" valign="bottom"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="88"><tr>
<td align="right"><span class="fr1">Здравствуйте, абонент &#8212; NOUA_2_187 !</span>
<!--&nbsp;&nbsp;&nbsp; <a href="?action=orders"><img src="img/zakaz.png" align="absmiddle" /></a> <a href="?action=orders" class="exit">Мои заказы</a>--> &nbsp;&nbsp;&nbsp; <a href="?action=logout">
<img src="img/ex.png" align="absmiddle" /></a> <a href="?action=logout" class="exit">Выход</a></td></tr>
<tr><td>
<!-- <a href="http://www.a-n-t.ru/index.phtml?id=5&n=120&subaction=detail&lang="> -->
<!-- <img style="float: left; margin: 20px 0px 20px -90px;" src="img/prodli_leto_2014_2.gif"> -->
<!-- </a> -->
</td></tr>
<tr><td align="left" valign="bottom" class="fr2">Информация о счете</td></tr></table>
</td></tr></table></td></tr></table>
<table width="895" align="center"><tr><td valign="top"><table><tr><td valign="top" width="220">

<br><table width="220" border="0" cellspacing="0" cellpadding="0">
<tr><td height="4" class="m1"></td></tr>
<tr><td height="3" class="brd2"></td></tr>
<tr><td class="brd" align="left"><a class="menu" href="?action=info">Информация о счете</a></td></tr>
<tr><td class="brd" align="left"><a class="menu" href="?action=changetar">Сменить тариф</a></td></tr>
<tr><td class="brd" align="left"><a class="menu" href="?action=changecredit">Сменить кредит</a></td></tr>
<tr><td class="brd" align="left"><a class="menu" href="?action=newpayment">Оплата услуг</a></td></tr>
<!--<tr><td class="brd" align="left"><a class="menu" href="?action=orders">Список заказов</a></td></tr>-->
<tr><td class="brd" align="left"><a class="menu" href="?action=payments">Статистика платежей</a></td></tr>
<tr><td class="brd" align="left"><a class="menu" href="?action=sessions">Статистика сессий</a></td></tr>
<tr><td class="brd" align="left"><a class="menu" href="?action=pass_vg">Пароль от интернета</a></td></tr>
<tr><td class="brd" align="left"><a class="menu" href="?action=pass_cabinet">Пароль от кабинета</a></td></tr>
<tr><td class="brd" align="left"><a class="menu" href="?action=sms_inform">SMS-информирование</a></td></tr>
<tr><td class="brd" align="left"><a class="menu" href="?action=checks">Кассовые чеки</a></td></tr>
<tr><td class="brd" align="left"><a class="menu" href="?action=logout">Выход</a></td></tr>

<tr><td height="3" class="brd2"></td></tr>
<tr><td height="4" class="m2"></td></tr></table>

</td><td width="45">&nbsp;</td><td width="625" valign="top" align="left"><table width="527" height="78" border="0" cellspacing="0" cellpadding="0"><tr><td height="78" class="money" valign="top"><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td align='left' width='23%' class='money2'>Состояние счета</td><td width='56%' class='num' align='center'>475.18 руб.</td><td width='21%' align='left'><a class='img' href='?action=newpayment'><img src='img/plus.png' width='102' height='60' align='absmiddle'></a></td></tr></table></td></tr></table><br>
<table cellpadding="0" cellspacing="0" width="100%">
<tr><td align="left"></td></tr>
<tr><td align="left">
<table cellpadding="0" cellspacing="0">
<tr><td class="tables" align="left">Учетная запись</td><td class="tables" align="left">NOUA_2_187</td><td class="tables" align="left"></td></tr>
<tr><td class="tables" align="left">Статус учетной записи</td><td class="tables" align="left"><b>Активна</b></td><td class="tables" align="left"></td></tr>
<tr><td class="tables" align="left">Код плательщика<div class="fr3">Ваш уникальный код<br> для оплаты услуг</div></td><td class="tables" align="left"><span class='number'>2000053468</span></td><td class="tables" align="left"></td></tr>
<tr><td class="tables" align="left">Скачано за текущий месяц</td><td class="tables" align="left">117311 ( Мб. )</td><td class="tables" align="left"></td></tr>
<tr><td class="tables" align="left">Тариф</td><td class="tables" align="left">VX-EXTRA: 739р unlim 100/100 Мб (медиацентр = 60р; 250р) </td><td class="tables" align="left"></td></tr>
<tr><td class="tables" align="left"><font color="#D42B31"><b>Тариф будет изменен на</b></span></td><td class="tables" align="left"><font color='#D42B31'><b>IX-OPTIMA: 448р до 200 Мб (медиацентр 48р; 250р)</b></span></td><td class="tables" align="left"><a href="?action=cancelchangetar"><img src="img/smena.png" align="absmiddle" /></a> <a href="?action=cancelchangetar" class="exit">Отменить</a></td></tr>
<tr><td class="tables" align="left">Кредит доверия, руб</td><td class="tables" align="left">300</td><td class="tables" align="left"><a href="?action=changecredit"><img src="img/smena.png" align="absmiddle" /></a> <a class="exit" href="?action=changecredit">Изменить</a></td></tr>
<tr><td class="tables" align="left">Ваш DynDNS</td><td class="tables" align="left"><font color='green'><b>2000053468.cl.a-n-t.ru</b></font></td><td class="tables" align="left"><a href="?action=changecredit"><img src="img/smena.png" align="absmiddle" /></a> <a class="exit" href="?action=changedyndns">Настроить</a></td></tr>
<tr><td class="tables" align="left">SMS-информирование</td><td class="tables" align="left"><font color='red'><b>Отключено</b></font></td><td class="tables" align="left"><a href="?action=sms_inform"><img src="img/smena.png" align="absmiddle" /></a> <a class="exit" href="?action=sms_inform">Настроить</a></td></tr>
<tr><td class="tables" align="left">Отправка чеков на E-mail</td><td class="tables" align="left"><font color='red'><b>не указан e-mail</b></font></td><td class="tables" align="left"><a href="?action=sms_inform"><img src="img/smena.png" align="absmiddle" /></a> <a class="exit" href="?action=checks">Настроить</a></td></tr>
</table></td></tr><tr><td></td></tr></table></td></tr></table>
 
<br /><br /><br />
<table width="1100" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="125"><a class="img" href="?action=neworder&paymethod=Card"><img src="img/b1.jpg" width="125" height="125"></a></td><td class="bannerpad" align="left" valign="top"><a class="banner" href="?action=neworder&paymethod=Card">Оплачивайте</a><br><br>Оплачивайте картой<br> Visa и Mastercard. <br>ONLINE<br /></td><td width="8">&nbsp;</td>
<td width="125"><a class="img" href="http://www.a-n-t.ru/chastnym-litsam/uslugi/kompyuternaya-pomoshch.html" target="_blank"><img src="img/remont.jpg" width="125" height="125"></a></td><td class="bannerpad" align="left" valign="top"><a class="banner" href="http://www.a-n-t.ru/chastnym-litsam/uslugi/kompyuternaya-pomoshch.html" target="_blank">Ремонт ПК</a><br><br>Ремонт ПК, ноутбуков с<br>выездом к клиенту.<br>Установка и настройка<br>ОС, ПО, антивирусов. Удаление вирусов.<br>От 990 рублей.</td><td width="8">&nbsp;</td>
<td width="125"><a class="img" href="http://www.a-n-t.ru/abonentam/podderzhka/nastrojki/iptv.html" target="_blank"><img src="img/b2.jpg" width="125" height="125"></a></td><td class="bannerpad" align="left" valign="top"><a class="banner" href="http://www.a-n-t.ru/abonentam/podderzhka/nastrojki/iptv.html" target="_blank">Настройка ТВ</a><br><br>Узнайте подробнее<br> о настройках IPTV<br> телевидения.</td><td width="8">&nbsp;</td>
<td width="125"><a class="img" href="http://www.a-n-t.ru/abonentam/podderzhka/voprosy-i-otvety-onlajn-instruktsii.html" target="_blank"><img src="img/b3.jpg" width="125" height="125"></a></td><td class="bannerpad" align="left" valign="top"><a class="banner" href="http://www.a-n-t.ru/abonentam/podderzhka/voprosy-i-otvety-onlajn-instruktsii.html" target="_blank">Есть вопросы?</a><br><br>На нашем сайте,<br>в разделе Абонентам,<br>много<br>готовых ответов.</td>
</tr>
</table><br /><br />
 
<table width="895" border="0" cellspacing="0" cellpadding="0" align="center"><tr><td align="center" class="rt1"><img src="img/ln.png"><br /><br /><br /><b>Круглосуточная абонентская служба  +7 (495) 940-92-11</b><br /><br />ООО "Альфа Нет Телеком" © 2011</td></tr></table></td></tr></table></td></tr></table></body></html><br /><br />
""";
