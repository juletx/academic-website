---
title: 100Iragarki
summary: Your digital showcase Network Services and Applications 2019-2020
tags:
- Web
date: ""

# Optional external URL for project (replaces project detail page).
external_link: ""

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
image:
  caption: ""
  focal_point: ""
  preview_only: false
  alt_text: "100Iragarki"

links:
- name: Web
  url: https://iragarkiak.000webhostapp.com/
url_code: https://github.com/juletx/iragarkiak
url_pdf: ""
url_slides: ""
url_video: ""
---

# 100Iragarki: Zure erakusleiho digitala

## Irakasgaia: Sare Zerbitzuak eta Aplikazioak 2019-2020

## Egileak: T07: Markel Azpeitia, Julen Etxaniz, Jokin Irastorza eta Aitor Zubillaga

## Fitxategiak

- ```dokumentazioa.pdf```: Web aplikazioaren dokumentazioa. Erabilera-gida eta garapenaren azalpenak ditu.

- ```index.php```: Proiektuaren erro-direktorioan dago, eta webgunea atzitzean lehenetsitako fitxategia da. ```Layout.php```-ra birbidalketa egiten du.

- ```html```
    - ```Head.html```: Orrialde guztietan head-en jarri beharrekoak: Izenburua, meta etiketak, css estilo orriak eta JavaScript-eko fitxategi batzuk.
    - ```Footer.html```: Orrialde guztietan agertzen den oina.

- ```images```
    - ```ads```: Iragarkien argazkiak gordetzeko karpeta. Iragarki bakoitzak bere azpikarpeta bat du bere id-aren izenarekin, eta bertan bere argazkiak gordetzen dira image1-5 izenekin.
    - ```users```: Erabiltzaileen argazkiak gordetzeko karpeta. Erabiltzaileen epostaren izenarekin gordetzen da erabiltzaile bakoitzaren argazkia.

- ```js```
    - ```ChangeStateAjax.js```: Erabiltzaileak kudeatzeko taulan erabiltzailearen egoera aldatzeaz arduratzen da. Sakonago azalduko da funtzionalitate gehigarrietan.
    - ```ClientGeolocationAjax.js```: Kredituetan bezeroaren geolokalizazioa erakusten du, web zerbitzuak erabiliz. Sakonago azalduko da funtzionalitate gehigarrietan.
    - ```GetFullDescription.js```: Iragarkien deskribapen osoa eskuratu.
    - ```jquery-3.4.1.min.js```: JQuery liburutegia, JS-ko gainerako fitxategi gehienetan erabili duguna.
    - ```RemoveUserAjax.js```: Erabiltzaileak kudeatzeko taulan erabiltzaileak ezabatzeaz arduratzen da. Sakonago azalduko da funtzionalitate gehigarrietan.
    - ```ShowActiveMenu.js```: Menuak momentuko orriaren esteka nabarmentzeko orriaren url-a begiratzen da eta kointziditzen duen estekan active klasea gehitzen da.
    - ```ShowImageInForm.js```: Erregistratzeko formularioan argazkia aukeratutakoan orrian bertan erakusten du, eta reset botoiari emandakoan ezabatu.
    - ```UpdateAccountAjax.js```: Kontuko datuak datu-basean eguneratzen dituen ```ManageAccount.php```-ri deitzeaz arduratzen da.
    - ```VerifyPassAjax.js```: Erregistratzerakoan pasahitzak egiaztatzen dituen web zerbitzuari deitu eta emaitza pantailaratzeaz arduratzen da.

- ```lib```: Pasahitzaren baliozkatzearen web zerbitzuaren bezeroa eta zerbitzaria garatzeko beharrezkoak diren SOAP liburutegiak dauzka.

- ```php```
    - ```Ad.php```: Iragarki jakin bati buruzko informazioa erakusteko: prezioa, irudiak, izenburua, deskribapena...
    AddAdvertisement.php: Iragarki berriak sortzeko. Sesioa irekia eduki behar du erabiltzaileak, bestela ezin da atzitu.
    - ```ChangeState.php```: Erabiltzaile bati sarrera debekatu/baimentzeko. Administratzaileentzat bakarrik.
    - ```ClientGeolocation.php```: Erabiltzailearen bezeroari buruzko informazioa
    - ```ClienVerifyPass.php```: Erabiltzaile berri bat sortzerakoan sarturiko pasahitza
    baliozkoa den ala ez zehazten du. Horretarako ```VerifyPassWS.php```-taz baliatzen da.
    - ```Credits.php```: Proiektuaren egileak, babesleak eta zerbitzariari naiz bezeroari buruzko informazioa
    - ```DbConfig.php```: Datu-basearen konfigurazioako datuak gordetzen dituen fitxategia. Lokaleko eta 000webhost-eko datu-baseekin konektatzeko zerbitzaria, erabiltzailea, gakoa eta izena gordetzen dira. Datu-basea erabili behar denean include egiten ta eta aldagai horiek erabiltzen dira. Horrela aldaketak egitea errazten da, leku bakar batean aldatzea nahikoa baita.
    - ```DeleteAdvertisement.php```: Erabiltzaile jakin bat ezabatzeko. Administratzaileentzat  soilik.
    - ```EditAdvertisement.php```: Iragarki jakin baten datuak aldatzeko: kategoria, izenburua, prezioa, deskribapena, argazkiak, ubikazioa...
    - ```GetAdDescription.php```: Iragarki jakin baten deskribapena eskuratzeko. “... Gehiago erakutsi[+]” deskribapenetako botoia sakatzean AJAX bidezko eskaera egiteko erabiltzen da.
    - ```HandlingAccounts.php```: Administratzaileek erabiltzaileak kudeatzeko (Datuak ikusi, erabiltzaileari sarrera eragotzi, erabiltzailea ezabatu...)
    - ```Layout.php```: Iragarkiak lista moduan ikustean erabiltzen den orriaren diseinu orokorra.
    - ```LogIn.php```: Erabiltzaileek sesioa irekitzeko kontrolagailua.
    - ```LogOut.php```: Erabiltzaileek sesioa ixteko kontrolagailua.
    - ```ManageAccount.php```: Erabiltzaile bakoitzak norberaren datuak ikusi eta aldatzeko.
    - ```Menus.php```: Web-orrian zehar goian agertzen den nabigazio barra.
    - ```RemoveUser.php```: Erabiltzaile jakin bat eta bere iragarki guztiak datubasetik ezabatzeko. Administratzaileentzat bakarrik.
    - ```SaveChanges.php```: Erabiltzaile batek ```HandlingAccounts.php``` orriaren bidez eginiko aldaketak egiaztatu eta datubasean eguneratzen ditu.
    - ```SecurityAdmin.php```: Sesioko emaila begiratuta hutsa ez dagoela eta administratzailearena dela egiaztatzen du, administratzaileari bakarrik sartzen uzteko.
    - ```SecurityLoggedIn.php```: Sesioko emaila hutsa ez dagoela egiaztatzen du, erabiltzaile kautotuei bakarrik sartzen uzteko.
    - ```SecurityLoggedOut.php```: Sesioko emaila hutsa dagoela egiaztatzen du erabiltzaile anonimoei bakarriksartzen uzteko.
    - ```SecurityUsers.php```: Sesioko emaila begiratuta hutsa ez dagoela eta administratzailearena ez dela egiaztatzen du, erabiltzaile arruntei bakarrik sartzen uzteko.
    - ```ShowAdvertisementsFilter.php```: Iragazki bat aplikatu (prezioa, kategoria, izenburua, data...) eta dagozkion iragarkiak erakusten ditu.
    - ```ShowAdvertisementsUser.php```: Erabiltzaile jakin batek sortu dituen iragarkiak erakusten ditu.
    - ```SignUp.php```: Erabiltzaile berri bat sortu ahal izateko formularioa.
    - ```VerifyPassWS.php```: Jasotzen dituen pasahitzak baliozkoak diren hala ez determinatzen du. Horretarako ```toppasswords.txt``` fitxategiaz baliatzen da. Bertan munduan zehar gehien erabiltzen edota asmatzeko errazegiak diren pasahitzak daude gordeta. Jasotako pasahitza textu dokumentuan badago, ez baliozkotzat joko da.

- ```sql```
    - ```db.sql```: Erabili dugun datu-basea. Sakonago azalduko da datu-egituraren azalpena atalean.

- ```styles```
    - ```Style.css```: Erabili dugun estilo orria. Hainbat elementuri estiloa emateko erabili dugu: taulak, iragarkiak, formularioetako inputak, argazkiak...

- ```txt```
    - ```toppasswords.txt```: Pasahitzaren baliozkatzearen web zerbitzuaren zerbitzaria garatzeko erabiltzen den pasahitz arrunten hiztegia.
