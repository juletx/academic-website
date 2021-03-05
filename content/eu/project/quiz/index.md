---
title: Quiz
summary: Galderen jokoa Web Sistemak 2019-2020
tags:
- Web Development
date: ""

# Optional external URL for project (replaces project detail page).
external_link: ""

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
image:
  caption: ""
  focal_point: ""
  preview_only: false
  alt_text: "Quiz"

links:
- name: Web
  url: https://wst03.000webhostapp.com/
url_code: https://github.com/juletx/quiz
url_pdf: "https://github.com/juletx/quiz/blob/master/Laborategiak/WS%20Azken%20Praktika%20Garapen%20Kuadernoa.pdf"
url_slides: ""
url_video: ""
---

# Quiz: galderen jokoa

## Irakasgaia: Web Sistemak 2019-2020

## Egileak: T03: Julen Etxaniz eta Aitor Zubillaga

## Fitxategiak

- ```Gardenkiak```: Klaseko azalpenetarako erabilitako gardenkiak.

- ```Laborategiak```: Laborategien enuntziatuak, azken lan praktikoa eta laguntza.

- ```index.php```: Proiektuaren erro-direktorioan dago, eta webgunea atzitzean lehenetsitako fitxategia da. ```Layout.php```-ra birbidalketa egiten du.

- ```google-api-php-client-2.4.0```: Google login soziala egiteko beharreko fitxategiak.

- ```html```
    - ```Head.html```: Orrialde guztietan head-en jarri beharrekoak: Izenburua, meta etiketak, css estilo orriak eta JavaScript-eko fitxategi batzuk.
    - ```Footer.html```: Orrialde guztietan agertzen den oina.
    - ```GetUserInfo.html```: Erabiltzaileen informazioa erakusten du ```Users.xml``` fitxategitik irakurrita.

- ```images```: Erabiltzaileen eta galderen argazkiak gordetzeko karpeta.

- ```js```
    - ```AddQuestionAjax.js```: Galdera gehitzeko ajax kodea.
    - ```ChangeStateAjax.js```: Erabiltzaileak kudeatzeko taulan erabiltzailearen egoera aldatzeaz arduratzen da.
    - ```ClientGeolocationAjax.js```: Kredituetan bezeroaren geolokalizazioa erakusten du, web zerbitzuak erabiliz.
    - ```jquery-3.4.1.min.js```: JQuery liburutegia, JS-ko gainerako fitxategi gehienetan erabili duguna.
    - ```LikeOrDislike.js```: Quiz jokoan erabiltzaileak galderari like edo dislike emateko kodea.
    - ```PlayQuizAjax.js```: Quiz jokoan jolasteko kodea.
    - ```RemoveUserAjax.js```: Erabiltzaileak kudeatzeko taulan erabiltzaileak ezabatzeaz arduratzen da.
    - ```ShowActiveMenu.js```: Menuak momentuko orriaren esteka nabarmentzeko orriaren url-a begiratzen da eta kointziditzen duen estekan active klasea gehitzen da.
    - ```ShowImageInForm.js```: Erregistratzeko formularioan argazkia aukeratutakoan orrian bertan erakusten du, eta reset botoiari emandakoan ezabatu.
    - ```ShowQuestionCountAjax.js```: XML Galdera kopurua erakusten du.
    - ```ShowQuestionsAjax.js```: XML galderak erakusten ditu.
    - ```ShowUserCountAjax.js```: Erabiltzaile kopurua erakusten du.
    - ```ValidateFieldsQuestion.js```: formularioko kontrolen edukien egiaztapenerako kodea web-zerbitzarira igorri aurretik
    - ```VerifyChangePass.js```: Aldatutako pasahitza zuzena dela balioztatzen du.
    - ```VerifyEnrollment.js```: Eposta WSn matrikulatuta dagoela egiaztatzen du.
    - ```VerifyPassAjax.js```: Pasahitza baliozkoa dela egiaztatzen du.

- ```lib```: Pasahitzaren baliozkatzearen web zerbitzuaren bezeroa eta zerbitzaria garatzeko beharrezkoak diren SOAP liburutegiak dauzka.

- ```php```
    - ```AddQuestionWithImage.php```: Irudia duen galdera bat gehitzeko PHP kodea. Sesioa irekia eduki behar du erabiltzaileak, bestela ezin da atzitu.
    - ```ChangePassword.php```: Pasahitza aldatzeko kodea.
    - ```ChangeState.php```: Erabiltzaile bati sarrera debekatu/baimentzeko. Administratzaileentzat bakarrik.
    - ```ClientGeolocation.php```: Erabiltzailearen bezeroari buruzko informazioa.
    - ```ClientGetQuestion.php```: Galdera eskuratzeko bezeroa.
    - ```ClientVerifyEnrollment.php```:  Eposta WSn matrikulatuta dagoela egiaztatzeko bezeroa.
    - ```ClienVerifyPass.php```: Erabiltzaile berri bat sortzerakoan sarturiko pasahitza
    baliozkoa den ala ez zehazten du. Horretarako ```VerifyPassWS.php```-taz baliatzen da.
    - ```Config.php```: Google login sozialaren konfigurazioa.
    - ```Credits.php```: Proiektuaren egileak, babesleak eta zerbitzariari naiz bezeroari buruzko informazioa
    - ```DbConfig.php```: Datu-basearen konfigurazioako datuak gordetzen dituen fitxategia. Lokaleko eta 000webhost-eko datu-baseekin konektatzeko zerbitzaria, erabiltzailea, gakoa eta izena gordetzen dira. Datu-basea erabili behar denean include egiten ta eta aldagai horiek erabiltzen dira. Horrela aldaketak egitea errazten da, leku bakar batean aldatzea nahikoa baita.
    - ```DecreaseGlobalCounter.php```: Erabiltzaile kopurua jaisten du.
    - ```GetQuestionWS.php```: Galdera eskuratzeko web zerbitzua.
    - ```HandlingAccounts.php```: Administratzaileek erabiltzaileak kudeatzeko (Datuak ikusi, erabiltzaileari sarrera eragotzi, erabiltzailea ezabatu...)
    - ```HandlingQuizesAjax.php```: Galdetegiak kudeatzeko kodea.
    - ```Layout.php```: Iragarkiak lista moduan ikustean erabiltzen den orriaren diseinu orokorra.
    - ```LogGoogle.php```: Erabiltzaileek google login soziala egiteko kontrolagailua.
    - ```LogIn.php```: Erabiltzaileek sesioa irekitzeko kontrolagailua.
    - ```LogOut.php```: Erabiltzaileek sesioa ixteko kontrolagailua.
    - ```Menus.php```: Web-orrian zehar goian agertzen den nabigazio barra.
    - ```RemoveUser.php```: Erabiltzaile jakin bat eta bere iragarki guztiak datubasetik ezabatzeko. Administratzaileentzat bakarrik.
    - ```SecurityAdmin.php```: Sesioko emaila begiratuta hutsa ez dagoela eta administratzailearena dela egiaztatzen du, administratzaileari bakarrik sartzen uzteko.
    - ```SecurityCode.php```: Pasahitza aldatzeko segurtasun kodea.
    - ```SecurityLoggedIn.php```: Sesioko emaila hutsa ez dagoela egiaztatzen du, erabiltzaile kautotuei bakarrik sartzen uzteko.
    - ```SecurityLoggedOut.php```: Sesioko emaila hutsa dagoela egiaztatzen du erabiltzaile anonimoei bakarriksartzen uzteko.
    - ```SecurityUsers.php```: Sesioko emaila begiratuta hutsa ez dagoela eta administratzailearena ez dela egiaztatzen du, erabiltzaile arruntei bakarrik sartzen uzteko.
    - ```SendPasswordEmail.php```:
    - ```ShowQuestionsWithImage.php```: DBeko galderak taula batean erakusteko PHP kodea. Taulak DBeko irudiak ditu.
    - ```ShowResult.php```: Quiz jokoaren amaierako emaitza erakusten du.
    - ```ShowXmlQuestions.php```:
    - ```SignUp.php```: Erabiltzaile berri bat sortu ahal izateko formularioa.
    - ```VerifyPassWS.php```: Jasotzen dituen pasahitzak baliozkoak diren hala ez determinatzen du. Horretarako ```txt/toppasswords.txt ``` fitxategiaz baliatzen da. Bertan munduan zehar gehien erabiltzen edota asmatzeko errazegiak diren pasahitzak daude gordeta. Jasotako pasahitza textu dokumentuan badago, ez baliozkotzat joko da.

- ```sql```
    - ```quiz.sql```: Galderak, erabiltzaileak eta jokoaren emaitzak gordetzeko datu-basea.

- ```styles```
    - ```Style.css```: Erabili dugun estilo orria. Hainbat elementuri estiloa emateko erabili dugu: taulak, iragarkiak, formularioetako inputak, argazkiak...

- ```txt```
    - ```GetGeolocation.txt```: Geolokalizazioaren inplementazioaren azalpena.
    - ```GetQuestion.txt```: Galderen web zerbitzuaren azalpena.
    - ```ShowQuestionCountAjax.txt```: Galdera kopurua erakustearen azalpena.
    - ```ShowUserCountAjax.txt```: Erabiltzaile kopurua erakustearen azalpena.
    - ```toppasswords.txt```: Pasahitzaren baliozkatzearen web zerbitzuaren zerbitzaria garatzeko erabiltzen den pasahitz arrunten hiztegia.

- ```xml```
    - ```Counter.xml```: Konektatutako erabiltzaile kopurua gordetzen du.
    - ```Questions.xml```: Galderak gordetzen ditu.
    - ```Questions.xsd```: Galderen eskema fitxategia.
    - ```ShowXmlQuestions.xsl```: Galderak erakusteko estilo fitxategia.
    - ```Users.xml```: Erabultzaileak gordetzen ditu.
