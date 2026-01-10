---
title: Mejorando la seguridad de mi web
summary: Analizaré mi web con herramientas como Hardenize y Security Headers para
  detectar los aspectos de seguridad que se pueden mejorar.
tags:
- Web Development
- Security
date: '2021-03-05'
image:
  caption: Análisis de web con [Hardenize](https://www.hardenize.com/report/julenetxaniz.eus/1607694301)
  focal_point: ''
  preview_only: false
  alt_text: Análisis Hardenize
links:
- url: https://julenetxaniz.eus
  type: site
- type: code
  url: https://github.com/juletx/academic-website
- type: pdf
  url: https://drive.google.com/file/d/1ILdQUWD_I7pxB-7blo1TVUbBws3VMGRd/view?usp=sharing
---

##### Autor: Julen Etxaniz

##### Asignatura: Sistemas de Gestión de Seguridad de Sistemas de Información

##### Fecha: 2020-2021

{{< toc alt="Alt" caption="Caption" numbered="true" >}}

## 1. Introducción

El objetivo de este proyecto es mejorar la seguridad de mi sitio web [julenetxaniz.eus](https://julenetxaniz.eus/). El sitio web está en 3 idiomas y contiene mi biografía, intereses, educación, habilidades, experiencia, certificados, proyectos e información de contacto. El contenido de mi web tiene la licencia [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/deed.es). El dominio lo he registrado de forma gratuita a través de [dinahosting](https://dinahosting.com/) con la promoción de [domeinuak.eus](https://www.domeinuak.eus/es/promocion/universidad-del-pais-vasco/) para estudiantes de EHU. 

Esta página está construida con la plantilla [Academic Template](https://github.com/wowchemy/starter-academic) de [Wowchemy](https://wowchemy.com/). Wowchemy es un  constructor de sitios web gratuito y de [código abierto](https://github.com/wowchemy/wowchemy-hugo-modules) con licencia [MIT](https://github.com/wowchemy/wowchemy-hugo-modules/blob/master/LICENSE.md) para [Hugo](https://gohugo.io/). Hugo es un framework de [código abierto](https://github.com/gohugoio/hugo) para crear [sitios web estáticos](https://es.wikipedia.org/wiki/P%C3%A1gina_web_est%C3%A1tica). El código de la página está alojado en [GitHub](https://github.com/juletx/academic-website) y es servido por [Netlify](https://www.netlify.com/). Netlify permite alojar webs estáticas ilimitadas. Construye la web automáticamente cada vez que hacemos push en GitHub.

Analizaré mi página web con herramientas como [Hardenize](https://www.hardenize.com/) y [Security Headers](https://securityheaders.com/) para detectar los aspectos de seguridad que se pueden mejorar. Explicaré en qué consisten esos aspectos e intentaré mejorarlos cuando sea posible. También mencionaré las características que ya están implementadas y cómo lo he hecho. Cuando termine haré una valoración de los resultados obtenidos y los compararé con los de otros sitios web. A continuación contribuiré lo aprendido a Wowchemy con un Pull Request en GitHub. Para finalizar, presentaré las conclusiones de este proyecto.


## 2. Análisis y Mejoras

Se han utilizado principalmente [Hardenize](https://www.hardenize.com/) y [Security Headers](https://securityheaders.com/) para el análisis. Ambas herramientas son gratuitas y no es necesario registrarse. Solo es necesario hacerlo en Hardenize si queremos actualizar el análisis sin limitaciones. Yo me he registrado porque cada vez que realizaba algún cambio tenía que comprobar que era correcto. También se usan otras herramientas como [DNS Viz](https://dnsviz.net/) y [Report URI](https://report-uri.com/) para conseguir información más completa o para simplificar algunas tareas.

La mayoría de las mejoras se han implementado a través de [Netlify](https://www.netlify.com/). Por un lado, las que tienen que ver con DNS desde el panel de control de Netlify. Por otro lado, las que tienen que ver con headers y redirecciones desde el archivo [netlify.toml](https://github.com/juletx/academic-website/blob/master/netlify.toml). 

El análisis está estructurado igual que en Hardenize pero se han añadido más elementos relacionados con Security Headers. Utilizaré los mismos términos que Hardenize y Security Headers en inglés para que la estructura del análisis sea más clara.


### 2.1. Summary

Cuando analizo mi web con [Hardenize: julenetxaniz.eus](https://www.hardenize.com/report/julenetxaniz.eus/1609271464) lo primero que se muestra es un resumen. Con esto podemos hacernos una idea sobre cuál es el estado de seguridad de nuestra web. Se muestran dos apartados, seguridad web y seguridad de email. En cada uno de los apartados se muestra la importancia y el esfuerzo de configurar esos aspectos correctamente. Algunos están enfocados a todo tipo de sitios web y otros solo para los más importantes. La mayoría son importantes o muy importantes. Respecto al esfuerzo hay de todo, desde bajo hasta alto. También se concreta si son importantes para todos los sitios o para los sitios importantes. Se profundizará más en estas características en los siguientes apartados del análisis.


#### 2.1.1. WEB SECURITY OVERVIEW

Se muestran aspectos importantes de seguridad web. Podríamos decir que mi configuración no está mal, se cumplen las características más importantes. En general, HTTPS está configurado correctamente. La web redirecciona el tráfico HTTP a HTTPS. Además, HTTP Strict Transport Security también está activado. Se puede mejorar configurando HSTS Preloaded. Aunque no es tan importante, tampoco está configurada Content Security Policy y requiere un gran esfuerzo.

{{< figure src="images/image64.png" alt="WEB SECURITY OVERVIEW" caption="WEB SECURITY OVERVIEW" numbered="true" >}}

#### 2.1.2. EMAIL SECURITY OVERVIEW

El resultado también parece bastante bueno. Las características SPF y DMARC están configuradas correctamente pero STARTTLS muestra una advertencia porque la configuración SMTP no es correcta. Conviene solucionar la advertencia porque STARTTLS es muy importante.

{{< figure src="images/image26.png" alt="EMAIL SECURITY OVERVIEW" caption="EMAIL SECURITY OVERVIEW" numbered="true" >}}

### 2.2. Domain

La configuración de dominio parece bastante buena. Los servidores DNS y el registro CAA están configurados correctamente. DNSSEC no está configurado. A continuación analizaremos estos aspectos.

{{< figure src="images/image83.png" alt="Domain" caption="Domain" numbered="true" >}}

#### 2.2.1. Name servers

Es necesario que los servidores DNS funcionen correctamente para que el dominio funcione bien. En este caso la configuración DNS es correcta. Se pueden ver todos los registros DNS configurados. Algunos de ellos se analizarán con más detalle a continuación.

{{< figure src="images/image5.png" alt="Name servers" caption="Name servers" numbered="true" >}}

La configuración de estos registros la he hecho a través de Netlify. Para poder configurar los registros DNS desde Netlify hay que usar sus servidores DNS. El nombre de los servidores DNS nos lo proporciona Netlify.

{{< figure src="images/image131.png" alt="Name servers" caption="Name servers" numbered="true" >}}

Para poder utilizar los servidores de Netlify hay que incluirlos en el registrador de dominio, que en este caso es dinahosting.

{{< figure src="images/image72.png" alt="Name servers" caption="Name servers" numbered="true" >}}

Además, tenemos que configurar Netlify para poder utilizar nuestro dominio. En la configuración de dominios vemos que [julenetxaniz.netlify.app](https://julenetxaniz.netlify.app) es el dominio por defecto de netlify. Por otro lado, [julenetxaniz.eus](https://julenetxaniz.eus) es el dominio primario y [www.julenetxaniz.eus](https://www.julenetxaniz.eus) redirecciona a ese dominio automaticamente.

{{< figure src="images/image65.png" alt="Custom domains" caption="Custom domains" numbered="true" >}}

Algunos de los registros DNS se configuran de forma automática. Por ejemplo, los registros NS, A, AAAA y SOA se configuran automáticamente y no los podemos modificar. No aparecen en el panel de control de Netlify, sólo aparecen NETLIFY y NETLIFYv6. Estos registros se encargan de crear los registros A y AAAA con direcciones IPs que se asignan de forma dinámica. Si nos fijamos en Hardenize, veremos que cuando repetimos el análisis a veces las IPs cambian.

{{< figure src="images/image45.png" alt="DNS records" caption="DNS records" numbered="true" >}}

#### 2.2.2. DNSSEC

DNSSEC es una extensión del protocolo DNS que garantiza la autenticidad e integridad de las respuestas. Está pensado como una defensa contra los atacantes de red que manipulan los registros DNS para redirigir a sus víctimas a otros servidores. DNSSEC es controvertido, algunos piensan que es esencial y otros creen que es problemático e innecesario.

Podemos ver en [https://www.hardenize.com/dashboards/global-top-sites/](https://www.hardenize.com/dashboards/global-top-sites/) que la adopción entre los 500 dominios más populares es de solo 11%.

{{< figure src="images/image127.png" alt="Domain Name Security Overview" caption="Domain Name Security Overview" numbered="true" >}}

En nuestro caso tampoco está implementado. Hardenize no nos proporciona mucha información pero podemos utilizar las herramientas que se proponen para hacer un análisis más completo.

{{< figure src="images/image42.png" alt="DNSSEC" caption="DNSSEC" numbered="true" >}}

Primero analizaremos con [https://dnssec-analyzer.verisignlabs.com/julenetxaniz.eus](https://dnssec-analyzer.verisignlabs.com/julenetxaniz.eus). Las zonas . y eus son seguras pero julenetxaniz.eus no. Nos dice que nos faltan los registros DS, DNSKEY y RRSIG.

{{< figure src="images/image44.png" alt="DNSSEC Analyzer" caption="DNSSEC Analyzer" numbered="true" >}}

Habría que configurar esos registros para que funcione correctamente. Sin embargo, Netlify no tiene la opción de configurar DNSSEC y por lo tanto no es posible. Otros proveedores como [Cloudflare](https://www.cloudflare.com/es-es/dns/dnssec/universal-dnssec/) si que ofrecen esta posibilidad. Pero esto requeriría migrar los servidores y registros DNS.

Ahora analizaremos la web con [https://dnsviz.net/d/julenetxaniz.eus/dnssec/](https://dnsviz.net/d/julenetxaniz.eus/dnssec/), que nos enseña resultados parecidos de manera más visual. Los nodos y conexiones que se muestran en azul son seguros. Los que se muestran en negro no. Como antes, podemos ver que . y eus son seguros pero julenetxaniz.eus no.

{{< figure src="images/image50.png" alt="DNSViz" caption="DNSViz" numbered="true" >}}

#### 2.2.3. CAA

Certification Authority Authorization permite restringir qué autoridades de certificación pueden emitir certificados para el dominio. Esto puede ayudar a reducir la posibilidad de una emisión incorrecta, ya sea de forma accidental o maliciosa. 

En mi caso, la autoridad de certificación es [letsencript.org](https://letsencrypt.org/). CAA está configurado correctamente pero podría mejorarse si se activan los reportes. Hay que tener en cuenta que no está garantizado que se reciba una notificación, dado que las CA generalmente aún no admiten notificaciones.

{{< figure src="images/image40.png" alt="Certification Authority Authorization" caption="Certification Authority Authorization" numbered="true" >}}

El registro CAA es sencillo de configurar desde Netlify. Con esta configuración sólo [letsencript.org](https://letsencrypt.org/) puede emitir certificados.

{{< figure src="images/image20.png" alt="CAA DNS record" caption="CAA DNS record" numbered="true" >}}

Ahora añadiremos un registro CAA para mejorar la configuración. Mandará un aviso al correo [info@julenetxaniz.eus](mailto:info@julenetxaniz.eus) cuando la política CAA no se cumpla.

{{< figure src="images/image10.png" alt="CAA DNS record" caption="CAA DNS record" numbered="true" >}}

Si actualizamos el análisis, podremos ver que ya cumplimos el último punto.

{{< figure src="images/image66.png" alt="Certification Authority Authorization" caption="Certification Authority Authorization" numbered="true" >}}

### 2.3. Email

A primera vista, la configuración de email no parece buena. Sólo 2 de 8 características están configuradas correctamente. Hay 3 advertencias y 3 características sin implementar.

Veremos a que se deben las advertencias e intentaremos solucionarlas.

{{< figure src="images/image121.png" alt="Email" caption="Email" numbered="true" >}}

#### 2.3.1. Mail servers

Los servidores de email son necesarios para enviar y recibir email. En este caso, el servidor está funcionando correctamente y tiene STARTTLS, pero hay algunas advertencias en TLS y PKI. En la siguiente sección veremos a que se deben estas advertencias.

{{< figure src="images/image93.png" alt="Email (SMTP)" caption="Email (SMTP)" numbered="true" >}}

El servidor de email que se ha utilizado es el proporcionado por dinahosting. Nos proporciona una cuenta de correo gratuita por cada dominio. La cuenta que he elegido ha sido [info@julenetxaniz.eus](mailto:info@julenetxaniz.eus).

{{< figure src="images/image81.png" alt="Dinahosting email" caption="Dinahosting email" numbered="true" >}}

Hay que añadir a Netlify los registros que se mencionan en dinahosting.

Añadimos un registro A con mail en hostname y la dirección IP en value.

{{< figure src="images/image41.png" alt="A DNS record" caption="A DNS record" numbered="true" >}}

Añadimos un registro MX que apunta a `mail.julenetxaniz.eus`.

{{< figure src="images/image117.png" alt="MX DNS record" caption="MX DNS record" numbered="true" >}}

Aunque tengamos advertencias en los apartados TLS y PKI, si enviamos un email a [juletxara@gmail.com](mailto:juletxara@gmail.com) desde el correo [info@julenetxaniz.eus](mailto:info@julenetxaniz.eus) veremos que se ha cifrado con TLS.

{{< figure src="images/image67.png" alt="Test email" caption="Test email" numbered="true" >}}

Podemos acceder al correo desde [https://dinahosting.email/](https://dinahosting.email/) o añadirlo a Gmail para enviar y recibir correos. Eso sí, Gmail nos dará un error al añadir el correo mediante conexión segura porque el nombre del certificado no coincide. Más tarde veremos con más detalle a qué se debe.

Si intentamos conectarnos al servidor SMTP mediante TLS o SSL nos aparece este error. Eso nos obliga a configurarlo con conexión no segura si queremos añadirlo.

{{< figure src="images/image124.png" alt="Gmail SMTP" caption="Gmail SMTP" numbered="true" >}}

Si intentamos conectarnos al servidor SMTP mediante SSL recibimos este error. Solo nos queda la opción de no usar conexión segura.

{{< figure src="images/image128.png" alt="Gmail POP" caption="Gmail POP" numbered="true" >}}

Veremos si se puede hacer algo para solucionar estos problemas en la siguiente sección.

#### 2.3.2. SECURE TRANSPORT (SMTP)

##### 2.3.2.1. TLS

Transport Layer Security es el protocolo de cifrado más utilizado en Internet. En combinación con certificados válidos, los servidores pueden establecer canales de comunicación de confianza. Los atacantes de red no pueden descubrir lo que se está comunicando, incluso cuando pueden ver todo el tráfico.

TLS está configurado, pero tenemos muchas advertencias y errores. Por ejemplo, el servidor no impone su preferencia respecto al conjunto de cifrado. Se admiten suites anónimas inseguras e intercambio de claves inseguro. El conjunto de cifrado no está ordenado correctamente.

{{< figure src="images/image91.png" alt="Email TLS (SMTP)" caption="Email TLS (SMTP)" numbered="true" >}}

Esta configuración no depende de nosotros y por lo tanto no podemos hacer nada para solucionarlo. Se debe a que dinahosting no ha configurado correctamente el servidor de email. Supongo que al ser gratuito no le darán mucha importancia a la seguridad. Podríamos cambiar de proveedor de email pero será difícil encontrar una opción mejor gratuita. Como en mi caso prácticamente no usaré el email no merece la pena.

{{< figure src="images/image9.png" alt="Email TLS (SMTP)" caption="Email TLS (SMTP)" numbered="true" >}}

Si analizamos con la herramienta [Qualys SSL Labs](https://www.ssllabs.com/ssltest/analyze.html?d=mail.julenetxaniz.eus) también obtenemos una mala puntuación. Si el certificado fuera correcto obtendríamos una B, que no está tan mal.

{{< figure src="images/image2.png" alt="Qualys SSL Labs" caption="Qualys SSL Labs" numbered="true" >}}

##### 2.3.2.2. Certificates

Un certificado contiene una clave pública, información sobre la entidad asociada y una firma digital del emisor del certificado. Es un mecanismo que nos permite intercambiar, almacenar y usar claves públicas. Ser capaz de verificar de forma fiable la identidad de un servidor remoto es fundamental para lograr una comunicación cifrada segura.

{{< figure src="images/image109.png" alt="Email Certificates (SMTP)" caption="Email Certificates (SMTP)" numbered="true" >}}

En este caso, el certificado es válido y cumple con todas las características que aparecen. La clave privada y el algoritmo de firma son fuertes, el certificado no ha expirado y la cadena de certificados es correcta. Pero tiene un problema, el nombre del certificado es `*.correoseguro.dinaserver.com` y obviamente no coincide con el de nuestro servidor `mail.julenetxaniz.eus`. Dinahosting no proporciona un certificado específico para cada servidor. Como en el caso anterior, esto no depende de nosotros y no podemos arreglarlo.

{{< figure src="images/image23.png" alt="Email Certificates (SMTP)" caption="Email Certificates (SMTP)" numbered="true" >}}

##### 2.3.2.3. MTA-STS

SMTP Mail Transfer Agent Strict Transport Security permite a los proveedores de de correo declarar su capacidad para recibir conexiones SMTP seguras con TLS. Además, permite especificar si los servidores SMTP de envío deben negarse a entregar a los hosts MX que no ofrezcan TLS.

{{< figure src="images/image133.png" alt="MTA Strict Transport Security" caption="MTA Strict Transport Security" numbered="true" >}}

La implementación de MTA-STS es bastante complicada si la comparamos con otras características como CAA. Me he basado en el siguiente blog de Scott Helme [https://scotthelme.co.uk/improving-email-security-with-mta-sts/](https://scotthelme.co.uk/improving-email-security-with-mta-sts/).

Para empezar, hay que crear un archivo [mta-sts.txt](https://github.com/juletx/academic-website/blob/1230be8c4ec024df3f72bc04053fd8ec6c73020e/static/mta-sts/mta-sts.txt) con los siguientes datos. En `mx` ponemos nuestro servidor. El valor `max_age` es el número de segundos que se debe recordar esta política. Empezaremos con un valor bajo.

```
version: STSv1
mode: testing
mx: mail.julenetxaniz.eus
max_age: 300
```

Después, hay que ponerlo en [https://mta-sts.julenetxaniz.eus/.well-known/mta-sts.txt](https://mta-sts.julenetxaniz.eus/.well-known/mta-sts.txt). Esto requiere crear el subdominio [mta-sts.julenetxaniz](https://mta-sts.julenetxaniz.eus/) desde Netlify. He tenido bastantes problemas pero al final lo he conseguido usando redirecciones en [netlify.toml](https://github.com/juletx/academic-website/blob/1230be8c4ec024df3f72bc04053fd8ec6c73020e/netlify.toml). He tenido que incluir `.well-known` en la redirección porque sino Netlify ignoraba esa carpeta que empieza con un punto.

```
[[redirects]]
  from = "https://mta-sts.julenetxaniz.eus/.well-known/*"
  to = "https://julenetxaniz.eus/mta-sts/:splat"
  status = 200
```

Para terminar la configuración creamos el registro necesario desde Netlify. Usaremos [https://www.unixtimestamp.com/](https://www.unixtimestamp.com/) para conseguir un id único cada vez. Hay que cambiar el id cada vez que se cambia el archivo `mta-sts.txt`.

{{< figure src="images/image118.png" alt="MTA-STS DNS record" caption="MTA-STS DNS record" numbered="true" >}}

Podemos ver en Hardenize que funciona correctamente pero hay que aumentar `max_age` como mínimo hasta 86400 segundos (1 día).

{{< figure src="images/image115.png" alt="MTA-STS Hardenize" caption="MTA-STS Hardenize" numbered="true" >}}

```
version: STSv1
mode: testing
mx: mail.julenetxaniz.eus
max_age: 86400
```

Cambiamos el id del registro dns al nuevo timestamp.

{{< figure src="images/image33.png" alt="MTA-STS DNS record" caption="MTA-STS DNS record" numbered="true" >}}

La advertencia de Hardenize ha desaparacido.

{{< figure src="images/image111.png" alt="MTA-STS Hardenize" caption="MTA-STS Hardenize" numbered="true" >}}

También aparece correctamente el certificado y la cadena de certificados.

{{< figure src="images/image78.png" alt="MTA-STS Hardenize" caption="MTA-STS Hardenize" numbered="true" >}}

Al activar MTA-STS, veremos que los apartados Mail servers y Certificates han pasado de darnos una advertencia a un error.

{{< figure src="images/image71.png" alt="Email Hardenize" caption="Email Hardenize" numbered="true" >}}

Mail servers nos da un error en el apartado de PKI porque el certificado no coincide.

{{< figure src="images/image13.png" alt="Email (SMTP) Hardenize" caption="Email (SMTP) Hardenize" numbered="true" >}}

Certificates también nos da un error porque el certificado no coincide. Podemos ver que se menciona MTA-STS.

{{< figure src="images/image82.png" alt="Email Certificates (SMTP) Hardenize" caption="Email Certificates (SMTP) Hardenize" numbered="true" >}}

Por lo tanto, por ahora lo mejor será desactivar MTA-STS hasta que nuestro certificado coincida. Eliminaremos el registro DNS, las redirecciones y el archivo mta-sts.txt para que desaparezca el error.

{{< figure src="images/image80.png" alt="Email Hardenize" caption="Email Hardenize" numbered="true" >}}

##### 2.3.2.4. TLS-RPT

SMTP TLS Reporting describe un mecanismo de reporte para que los emisores de correo electrónico puedan compartir estadísticas e información sobre fallos. Los destinatarios pueden utilizar esta información para detectar posibles ataques y diagnosticar errores de configuración involuntarios. TLS-RPT se puede utilizar con DANE o MTA-STS. Aunque actualmente no tengamos ninguno de los dos configurados, implementaremos TLS-RPT.

{{< figure src="images/image31.png" alt="SMTP TLS Reporting Hardenize" caption="SMTP TLS Reporting Hardenize" numbered="true" >}}

Se explica en el blog [https://scotthelme.co.uk/launching-smtp-tls-reporting/](https://scotthelme.co.uk/launching-smtp-tls-reporting/). Como se menciona, enviaremos los reportes al correo que nos proporciona [Report URI](https://report-uri.com/). Report URI nos permite enviar informes de seguridad y los presenta de forma organizada y visual. También lo usaremos más adelante con otras características.

{{< figure src="images/image49.png" alt="TLS-RPT ReportURI" caption="TLS-RPT ReportURI" numbered="true" >}}

Configuramos en registro DNS desde Netlify.

{{< figure src="images/image51.png" alt="TLS-RPT DNS record" caption="TLS-RPT DNS record" numbered="true" >}}

Podemos ver en Hardenize que se ha configurado correctamente.

{{< figure src="images/image70.png" alt="SMTP TLS Reporting Hardenize" caption="SMTP TLS Reporting Hardenize" numbered="true" >}}

##### 2.3.2.5. DANE

DNS-based Authentication of Named Entities conecta DNSSEC y TLS. En un escenario posible, DANE se puede utilizar para fijar claves públicas, basándose en un certificado de confianza existente. En otro enfoque, se puede utilizar para eludir por completo el ecosistema de CA y establecer confianza utilizando solo DNSSEC.

{{< figure src="images/image12.png" alt="DNS-based Authentication of Named Entities" caption="DNS-based Authentication of Named Entities" numbered="true" >}}

No está implementado y no podemos hacerlo porque dinahosting no nos da esa opción.

#### 2.3.3. AUTHENTICATION AND POLICY

##### 2.3.3.1. SPF

Sender Policy Framework es un protocolo que permite controlar qué hosts pueden enviar correos electrónicos en su nombre. Se puede utilizar para reducir el efecto de la suplantación de correo electrónico y reducir el spam. Se explica con más detalle en [https://scotthelme.co.uk/email-security-spf/](https://scotthelme.co.uk/email-security-spf/).

Por ejemplo, en este caso permitimos enviar correos electrónicos desde nuestro servidor de correo o desde los servidores de Google.

{{< figure src="images/image104.png" alt="Sender Policy Framework Hardenize" caption="Sender Policy Framework Hardenize" numbered="true" >}}

Para añadirlo desde Netlify hay que añadir un registro TXT. Se puede utilizar una herramienta como [https://easydmarc.com/tools/spf-record-generator/](https://easydmarc.com/tools/spf-record-generator/) para generar el registro que necesitemos.

{{< figure src="images/image22.png" alt="SPF Record Generator" caption="SPF Record Generator" numbered="true" >}}

{{< figure src="images/image129.png" alt="SPF DNS record" caption="SPF DNS record" numbered="true" >}}

##### 2.3.3.2. DKIM

DomainKeys Identified Mail permite a los remitentes asociar un nombre de dominio con un mensaje de correo electrónico, garantizando así su autenticidad. Esto se hace firmando el correo electrónico con una firma digital. El destinatario puede verificar la firma DKIM, asegurando que el correo electrónico se originó en el dominio y que no se ha modificado. Se explica con más detalle en [https://scotthelme.co.uk/email-security-dkim/](https://scotthelme.co.uk/email-security-dkim/).

Para añadirlo desde Netlify hay que añadir un registro TXT. Como antes podemos usar una herramienta como [https://easydmarc.com/tools/dkim-record-generator](https://easydmarc.com/tools/dkim-record-generator) para generar el registro que necesitemos. Podemos ver que se genera un par de claves privada y pública. Tenemos que añadir el registro con la clave pública, y mantener la clave privada en secreto. La clave privada habría que configurarla en dinahosting, pero no nos da esa opción. Por lo tanto, aunque añadamos el registro DNS por ahora no servirá para nada.

{{< figure src="images/image100.png" alt="DKIM Record Generator" caption="DKIM Record Generator" numbered="true" >}}

Copiamos el registro generado para añadirlo a Netlify con el nombre dkim._domainkey.

{{< figure src="images/image69.png" alt="DKIM DNS record" caption="DKIM DNS record" numbered="true" >}}

{{< figure src="images/image77.png" alt="DKIM DNS record" caption="DKIM DNS record" numbered="true" >}}

##### 2.3.3.3. DMARC

Domain-based Message Authentication, Reporting, and Conformance permite al emisor definir políticas y preferencias para la validación y la generación de informes de mensajes. El receptor de correo puede utilizar esta información para mejorar el manejo del correo y reducir el spam. El blog [https://scotthelme.co.uk/email-security-dmarc](https://scotthelme.co.uk/email-security-dmarc) lo explica con más detalle.

Para que DMARC funcione correctamente, es necesario tener SPF o DKIM activados. No he podido configurar DKIM correctamente, pero tener SPF es suficiente.

Enviaremos los reportes al correo que nos proporciona [Report URI](https://report-uri.com/).

{{< figure src="images/image54.png" alt="DMARC Report URI" caption="DMARC Report URI" numbered="true" >}}

Para añadirlo desde Netlify hay que añadir un registro TXT. Se puede utilizar una herramienta como [https://easydmarc.com/tools/dmarc-record-generator](https://easydmarc.com/tools/dmarc-record-generator) para generar el registro que necesitemos.

{{< figure src="images/image107.png" alt="DMARC Record Generator" caption="DMARC Record Generator" numbered="true" >}}

{{< figure src="images/image90.png" alt="DMARC DNS record" caption="DMARC DNS record" numbered="true" >}}

Podemos ver que aparece correctamente en Hardenize.

{{< figure src="images/image34.png" alt="DMARC Hardenize" caption="DMARC Hardenize" numbered="true" >}}

He enviado algunos correos de prueba en diferentes momentos del análisis. He recibido un correo con un informe de Google en [info@julenetxaniz.eus](mailto:info@julenetxaniz.eus), lo que significa que DMARC está funcionando correctamente. Los he recibido en ese correo porque he hecho el cambio al otro correo de Report URI más tarde.

{{< figure src="images/image11.png" alt="DMARC Email" caption="DMARC Email" numbered="true" >}}

Contiene adjunto un archivo xml con el siguiente contenido. Al principio están los metadatos como datos de Google, id y la fecha. A continuación podemos ver los datos de la política DMARC. Al final hay dos registros con más datos. Cómo se enviaron en momentos distintos, las políticas DMARC y SPF no son las mismas porque he hecho algunos cambios. Así podemos ver las diferencias entre los dos registros. En el primero, DKIM ha fallado pero SPF ha funcionado correctamente. La política que se aplica es none, es decir, no hay ninguna acción si falla. Por lo tanto, el resultado de la autenticación es correcto. En el segundo caso, fallan DKIM y SPF y la política es quarantine. La autenticación es fallida.

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<feedback>
  <report_metadata>
    <org_name>google.com</org_name>
    <email>noreply-dmarc-support@google.com</email>
    <extra_contact_info>https://support.google.com/a/answer/2466580</extra_contact_info>
    <report_id>3935851160389800212</report_id>
    <date_range>
      <begin>1608854400</begin>
      <end>1608940799</end>
    </date_range>
  </report_metadata>
  <policy_published>
    <domain>julenetxaniz.eus</domain>
    <adkim>r</adkim>
    <aspf>r</aspf>
    <p>quarantine</p>
    <sp>quarantine</sp>
    <pct>100</pct>
  </policy_published>
  <record>
    <row>
      <source_ip>82.98.134.111</source_ip>
      <count>1</count>
      <policy_evaluated>
        <disposition>none</disposition>
        <dkim>fail</dkim>
        <spf>pass</spf>
      </policy_evaluated>
    </row>
    <identifiers>
      <header_from>julenetxaniz.eus</header_from>
    </identifiers>
    <auth_results>
      <spf>
        <domain>julenetxaniz.eus</domain>
        <result>pass</result>
      </spf>
    </auth_results>
  </record>
  <record>
    <row>
      <source_ip>82.98.134.111</source_ip>
      <count>1</count>
      <policy_evaluated>
        <disposition>quarantine</disposition>
        <dkim>fail</dkim>
        <spf>fail</spf>
      </policy_evaluated>
    </row>
    <identifiers>
      <header_from>julenetxaniz.eus</header_from>
    </identifiers>
    <auth_results>
      <spf>
        <domain>julenetxaniz.eus</domain>
        <result>softfail</result>
      </spf>
    </auth_results>
  </record>
</feedback>
```

### 2.4. WWW

La configuración de seguridad web parece buena. 8 de las 13 características están configuradas correctamente y no hay ninguna advertencia. A continuación veremos en qué consisten e implementaremos las que faltan.

{{< figure src="images/image30.png" alt="WWW Hardenize" caption="WWW Hardenize" numbered="true" >}}

#### 2.4.1. PROTOCOLS

##### 2.4.1.1. HTTP (80)

Para comprobar que funciona correctamente, se envía una solicitud a la página de inicio en el puerto 80, se siguen todas las redirecciones y se registran los encabezados HTTP devueltos. Algunos de estos encabezados serán modificados en los siguientes apartados para mejorar la seguridad. 

La redirección desde HTTP a HTTPS está funcionando correctamente.

{{< figure src="images/image14.png" alt="HTTP (80) Hardenize" caption="HTTP (80) Hardenize" numbered="true" >}}

##### 2.4.1.2. HTTPS (443)

Para comprobar que funciona correctamente, se envía una solicitud a la página de inicio en el puerto 443, se siguen todas las redirecciones y se registran los encabezados HTTP devueltos. Algunos de estos encabezados serán modificados en los siguientes apartados para mejorar la seguridad. 

{{< figure src="images/image116.png" alt="HTTPS (443) Hardenize" caption="HTTPS (443) Hardenize" numbered="true" >}}

#### 2.4.2. SECURE TRANSPORT

##### 2.4.2.1. TLS

Transport Layer Security es el protocolo de cifrado más utilizado en Internet. En combinación con certificados válidos, los servidores pueden establecer canales de comunicación de confianza. Los atacantes de red no pueden descubrir lo que se está comunicando, incluso cuando pueden ver todo el tráfico.

En este caso, parece que Netlify ha hecho un buen trabajo configurando sus servidores. Se soportan las versiones 1.2 y 1.3 y no se soportan las versiones obsoletas 1.1 y 1.0. El intercambio de claves y el cifrado es seguro.

{{< figure src="images/image32.png" alt="TLS Hardenize" caption="TLS Hardenize" numbered="true" >}}

Si analizamos con la herramienta [Qualys SSL Labs](https://www.ssllabs.com/ssltest/analyze.html?d=julenetxaniz.eus) también obtenemos una muy buena puntuación, casi perfecta.

{{< figure src="images/image18.png" alt="Qualys SSL Labs" caption="Qualys SSL Labs" numbered="true" >}}

##### 2.4.2.2. Certificates

Un certificado contiene una clave pública, información sobre la entidad asociada a él y una firma digital del emisor del certificado. Es un mecanismo que nos permite intercambiar, almacenar y usar claves públicas. Ser capaz de verificar de forma fiable la identidad de un servidor remoto es fundamental para lograr una comunicación cifrada segura.

{{< figure src="images/image75.png" alt="WWW Certificates Hardenize" caption="WWW Certificates Hardenize" numbered="true" >}}

{{< figure src="images/image16.png" alt="WWW Certificates Hardenize" caption="WWW Certificates Hardenize" numbered="true" >}}

Parece que todo está configurado correctamente. El certificado de [letsencrypt.org](https://letsencrypt.org/) se puede configurar desde Netlify y es gratuito. El certificado se renueva automáticamente antes de expirar. El único requisito es usar los servidores DNS de Netlify.

{{< figure src="images/image36.png" alt="SSL/TLS Certificate Netlify" caption="SSL/TLS Certificate Netlify" numbered="true" >}}

Si hacemos click en el candado desde un navegador, podremos ver el certificado.

{{< figure src="images/image88.png" alt="Let's Encrypt SSL/TLS Certificate" caption="Let's Encrypt SSL/TLS Certificate" numbered="true" >}}

##### 2.4.2.3. Cookies

Las cookies son pequeños textos que se envían entre el navegador y un sitio web. A menudo son esenciales para el funcionamiento del sitio y, a veces, contienen información confidencial. Las cookies de sesión enviadas desde sitios seguros deben marcarse explícitamente como seguras para evitar que los atacantes activos de la red las obtengan.

En mi caso no hay ninguna cookie y por lo tanto la configuración es correcta.

{{< figure src="images/image8.png" alt="Hardenize Cookies" caption="Hardenize Cookies" numbered="true" >}}

##### 2.4.2.4. Mixed Content

En prácticamente todos los sitios web, algunos recursos como CSS y JS llegan desde múltiples servidores externos. Para que una página esté encriptada correctamente, es necesario que todo el contenido se recupere a través de HTTPS. Si este no es el caso, se generan problemas de seguridad de contenido mixto.

En mi caso todos los recursos CSS y JS están cifrados. Y los enlaces externos llevan a páginas HTTPS.

{{< figure src="images/image130.png" alt="Hardenize Mixed Content" caption="Hardenize Mixed Content" numbered="true" >}}

#### 2.4.3. MODERN SECURITY FEATURES

La mayoría de las siguientes características de seguridad se configuran con headers http. Hay herramientas como [Security Headers](https://securityheaders.com/) que se centran solo en ese aspecto. La mayoría de los headers coinciden, pero hay algunos que solo están no están en Hardenize. Compaginamos las dos herramientas para obtener un mejor resultado en ambas. Si analizo mi web con Security Headers obtengo un mal resultado. Solo tengo 1 de 6 headers que se recomiendan. 

{{< figure src="images/image4.png" alt="Security Headers Report Summary" caption="Security Headers Report Summary" numbered="true" >}}

También podemos ver todos los encabezados. Aparecen en verde los más importantes.

{{< figure src="images/image62.png" alt="Raw Headers" caption="Raw Headers" numbered="true" >}}

Nos dice qué encabezados faltan y nos explica en qué consiste cada uno de ellos. En algunos casos incluso nos recomiendan el valor que deberíamos poner. 

{{< figure src="images/image28.png" alt="Missing, Upcoming and Additional Headers" caption="Missing, Upcoming and Additional Headers" numbered="true" >}}

##### 2.4.3.1. Strict Transport Security

HTTP Strict Transport Security mejora la seguridad de la capa de cifrado de la red. Con HSTS habilitado, los navegadores ya no permiten hacer clic en los errores de advertencia de certificados, que suelen ser triviales de explotar. Además, ya no enviarán solicitudes inseguras al sitio en cuestión, incluso si se les solicita. En este blog se explica con más detalle cómo funciona: [https://scotthelme.co.uk/hsts-the-missing-link-in-tls/](https://scotthelme.co.uk/hsts-the-missing-link-in-tls/).

Podemos ver que la configuración de HSTS es correcta, pero se puede mejorar añadiendo `includeSubDomains` y `preload`.

{{< figure src="images/image132.png" alt="Hardenize HTTP Strict Transport Security" caption="Hardenize HTTP Strict Transport Security" numbered="true" >}}

{{< figure src="images/image59.png" alt="Hardenize HTTP Strict Transport Security" caption="Hardenize HTTP Strict Transport Security" numbered="true" >}}

Empezaremos añadiendo la opción `includeSubDomains`. Siguiendo la recomendación pondremos `max-age` de solo 5 minutos para empezar. Estas configuraciones hay que hacerlas en el archivo [netlify.toml](https://github.com/juletx/academic-website/blob/master/netlify.toml) de mi web. Para poder comparar los cambios, este es el archivo [netlify.toml](https://github.com/juletx/academic-website/blob/59165bd2684ec0675c0a6c6c36a8f0620f422c6e/netlify.toml) antes de cambiarlo.

```
[[headers]]
  for = "/*"
  [headers.values]
    Strict-Transport-Security = "max-age=300; includeSubDomains"
```

Podemos ver en Hardenize que el cambio se ha realizado correctamente.

{{< figure src="images/image63.png" alt="Hardenize HTTP Strict Transport Security" caption="Hardenize HTTP Strict Transport Security" numbered="true" >}}

Para activar la opción preload, es necesario registrarse en [https://hstspreload.org/](https://hstspreload.org/). Si lo intentamos antes de añadir `includeSubDomains`, nos dice que tenemos que añadir las directivas `includeSubDomains` y `preload`.

{{< figure src="images/image17.png" alt="HSTS Preload Status" caption="HSTS Preload Status" numbered="true" >}}

Estos son los requisitos que hay que cumplir para solicitarlo:

{{< figure src="images/image105.png" alt="HSTS Preload Submission Requirements" caption="HSTS Preload Submission Requirements" numbered="true" >}}

Y estas son las recomendaciones para implantarlo:

{{< figure src="images/image48.png" alt="HSTS Preload Deployment Recommendations" caption="HSTS Preload Deployment Recommendations" numbered="true" >}}

También se nos advierte de que es difícil borrar los dominios después de que se incluyan.

{{< figure src="images/image37.png" alt="HSTS Preload Removal" caption="HSTS Preload Removal" numbered="true" >}}

En mi caso el requisito de tiempo ya se cumple porque es 1 año. Después de comprobar que la web funciona correctamente con `includeSubdomains`, podemos aumentar el tiempo a 2 años y añadir `preload`.

```
Strict-Transport-Security = "max-age=63072000; includeSubDomains; preload"
```

Podemos ver en Hardenize que el cambio se ha realizado correctamente. Nos advierte de que he incluido preload pero no está funcionando. 

{{< figure src="images/image24.png" alt="Hardenize HTTP Strict Transport Security" caption="Hardenize HTTP Strict Transport Security" numbered="true" >}}

Tenemos que registrarnos en [https://hstspreload.org/](https://hstspreload.org/). Podemos ver que ya cumplimos los requisitos para solicitarlo.

{{< figure src="images/image57.png" alt="HSTS Preload Submission" caption="HSTS Preload Submission" numbered="true" >}}

Si aceptamos las condiciones y le damos a enviar, nos aparecerá este mensaje.

{{< figure src="images/image96.png" alt="HSTS Preload Success" caption="HSTS Preload Success" numbered="true" >}}

Nos recomienda que escaneemos la web con [Qualys SSL Labs](https://www.ssllabs.com/ssltest/analyze.html) como he hecho anteriormente.

También podemos ver que la advertencia de Hardenize ha desaparecido. Nos dice que preload está pendiente de añadirse a la lista.

{{< figure src="images/image123.png" alt="Hardenize HSTS" caption="Hardenize HSTS" numbered="true" >}}

Si volvemos a mirar en [https://hstspreload.org/?domain=julenetxaniz.eus](https://hstspreload.org/?domain=julenetxaniz.eus) nos dice lo mismo. Tendremos que esperar a que nos incluyan en la lista.

{{< figure src="images/image134.png" alt="HSTS Preload Status" caption="HSTS Preload Status" numbered="true" >}}

##### 2.4.3.2. Content Security Policy

CSP es un mecanismo de seguridad que permite que los sitios web controlen cómo los navegadores procesan sus páginas. Los sitios pueden restringir qué tipos de recursos se cargan y desde dónde. Las políticas de CSP se pueden utilizar para defenderse de ataques XSS, evitar problemas de Mixed Content y denunciar infracciones para su investigación. 

Esta opción no está implementada en mi web. Para añadirla, tengo que editar el archivo [netlify.toml](https://github.com/juletx/academic-website/blob/master/netlify.toml) como antes.

{{< figure src="images/image99.png" alt="Hardenize Content Security Policy" caption="Hardenize Content Security Policy" numbered="true" >}}

En este blog de Scott Helme se explica con más detalle cómo funciona CSP: [https://scotthelme.co.uk/content-security-policy-an-introduction/](https://scotthelme.co.uk/content-security-policy-an-introduction/). A partir de ese blog he decidido registrarme en [Report URI](https://report-uri.com/) para facilitar la generación y reporte de errores. Ya no sólo para CSP, sino que también para muchas de las demás opciones que estamos configurando.

Hay que completar unos pasos antes de empezar a usarlo.

{{< figure src="images/image6.png" alt="Report URI Customize" caption="Report URI Customize" numbered="true" >}}

Después de activar el email hay que personalizar el subdominio al que se reportará.

{{< figure src="images/image92.png" alt="Report URI Custom Subdomain" caption="Report URI Custom Subdomain" numbered="true" >}}

Una vez cambiado el subdominio, nos aparecen los reportes que podemos añadir.
{{< figure src="images/image53.png" alt="Report URI Setup" caption="Report URI Setup" numbered="true" >}}

El siguiente paso es configurar filtros.

{{< figure src="images/image68.png" alt="Report URI Configure" caption="Report URI Configure" numbered="true" >}}

Añadimos nuestra web para que se reciba información.

{{< figure src="images/image98.png" alt="Report URI Filters" caption="Report URI Filters" numbered="true" >}}

Por último, aunque no es obligatorio, activamos autenticación de dos factores.

{{< figure src="images/image103.png" alt="Report URI 2FA" caption="Report URI 2FA" numbered="true" >}}

Usaremos la ayuda de Report URI para facilitar la configuración de CSP. Se explica cómo funciona esta herramienta en el blog [https://scotthelme.co.uk/report-uri-csp-wizard/](https://scotthelme.co.uk/report-uri-csp-wizard/) y en la documentación [https://docs.report-uri.com/setup/wizard/](https://docs.report-uri.com/setup/wizard/).

El Wizard nos enseñará todas las solicitudes que se hagan y nosotros decidiremos si las aceptamos o bloqueamos. Esto nos permitirá añadir poco a poco las reglas que necesitemos para ir completando la CSP. Este trabajo sería mucho más difícil si tuviéramos que pensar en todas las reglas. Aunque probablemente la lista que se genere no será la definitiva, nos sirve para tener una base sólida.

{{< figure src="images/image112.png" alt="Report URI CSP Wizard" caption="Report URI CSP Wizard" numbered="true" >}}

Empezaremos con la configuración que se recomienda de Report-Only. Esto nos permite probar nuestra CSP sin bloquear ningún elemento de nuestra página.

```
Content-Security-Policy-Report-Only = "default-src 'none'; form-action 'none'; frame-ancestors 'none'; report-uri https://julenetxaniz.report-uri.com/r/d/csp/wizard"
```

Tendremos que navegar por nuestra web para que se manden reportes al wizard. Estos son los registros que se generan navegando una vez a la página de inicio de [julenetxaniz.eus](https://julenetxaniz.eus/). En este caso aceptaremos todas las directivas porque somos los únicos que navegamos por la web. Si tuviéramos muchos usuarios, habría que pensar mejor qué directivas nos conviene aceptar. Ya que puede ser que algunos de los recursos hayan sido añadidos de forma maliciosa.

{{< figure src="images/image56.png" alt="Report URI CSP Wizard" caption="Report URI CSP Wizard" numbered="true" >}}

Veremos que se ha generado una política con todas las directivas que he seleccionado.

{{< figure src="images/image19.png" alt="Report URI CSP Wizard" caption="Report URI CSP Wizard" numbered="true" >}}

Después de navegar por más páginas de mi web, se han añadido algunas directivas más.

{{< figure src="images/image113.png" alt="Report URI CSP Wizard" caption="Report URI CSP Wizard" numbered="true" >}}

Las aceptamos para que se añadan a la política.

{{< figure src="images/image58.png" alt="Report URI CSP Wizard" caption="Report URI CSP Wizard" numbered="true" >}}

Manteniendo la opción Report-Only, cambiemos la política que tenemos por la generada, a ver qué nos dice [Hardenize](https://www.hardenize.com/).

```
Content-Security-Policy-Report-Only = "connect-src 'self' www.google-analytics.com; font-src cdnjs.cloudflare.com fonts.gstatic.com; frame-src www.google.com disqus.com; img-src 'self' a.tile.openstreetmap.org b.tile.openstreetmap.org c.tile.openstreetmap.org cdnjs.cloudflare.com www.google-analytics.com data:; manifest-src 'self'; script-src-elem 'self' 'unsafe-inline' cdnjs.cloudflare.com identity.netlify.com julenetxaniz.disqus.com www.google-analytics.com www.google.com www.googletagmanager.com www.gstatic.com cdn.jsdelivr.net; style-src-attr 'unsafe-inline'; style-src-elem 'self' 'unsafe-inline' cdnjs.cloudflare.com fonts.googleapis.com; prefetch-src 'self'; script-src 'unsafe-eval'"
```

Además, nos dice 3 aspectos que deberíamos mejorar. Nos dice que deberíamos quitar la opción `unsafe-eval`. También es conveniente añadir una de estas dos opciones: `block-all-mixed-content` o `upgrade-insecure-requests`. Nos recomienda añadir la directiva `form-action`. También me he dado cuenta de que he quitado `default-src` y `report-uri` sin querer.

{{< figure src="images/image101.png" alt="Hardenize Content Security Policy" caption="Hardenize Content Security Policy" numbered="true" >}}

Teniendo en cuenta lo anterior haremos algunos cambios para intentar solucionar algunos de estos aspectos.

```
Content-Security-Policy-Report-Only = "default-src 'self'; connect-src 'self' www.google-analytics.com; font-src cdnjs.cloudflare.com fonts.gstatic.com; frame-src www.google.com disqus.com; img-src 'self' a.tile.openstreetmap.org b.tile.openstreetmap.org c.tile.openstreetmap.org cdnjs.cloudflare.com www.google-analytics.com data: c.disquscdn.com referrer.disqus.com; manifest-src 'self'; script-src-elem 'self' 'unsafe-inline' cdnjs.cloudflare.com identity.netlify.com julenetxaniz.disqus.com www.google-analytics.com www.google.com www.googletagmanager.com www.gstatic.com cdn.jsdelivr.net; style-src-elem 'self' 'unsafe-inline' cdnjs.cloudflare.com fonts.googleapis.com; prefetch-src 'self'; block-all-mixed-content; upgrade-insecure-requests; report-uri https://julenetxaniz.report-uri.com/r/d/csp/wizard"
```

Parece que la valoración de Hardenize ha mejorado. He conseguido implementar dos de las recomendaciones correctamente.

{{< figure src="images/image119.png" alt="Hardenize Content Security Policy" caption="Hardenize Content Security Policy" numbered="true" >}}

Si miramos en Hardenize veremos que algunas de las directivas no están apareciendo, en concreto `script-src-elem`, `style-src-elem` y `style-src-attr`. Investigando en [MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy) vemos que esas opciones son experimentales. Será mejor cambiarlas por `script-src` y `style-src`. El reporte nos dice que es necesario incluir `unsafe-inline` en `style-src`. También añadiremos la directiva `form-action`. También quitaremos la directiva `block-all-mixed-content` porque es innecesaria.

```
Content-Security-Policy-Report-Only = "default-src 'self'; connect-src 'self' www.google-analytics.com; font-src cdnjs.cloudflare.com fonts.gstatic.com; frame-src www.google.com disqus.com; img-src 'self' a.tile.openstreetmap.org b.tile.openstreetmap.org c.tile.openstreetmap.org cdnjs.cloudflare.com www.google-analytics.com data: c.disquscdn.com referrer.disqus.com; manifest-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval' cdnjs.cloudflare.com identity.netlify.com julenetxaniz.disqus.com www.google-analytics.com www.google.com www.googletagmanager.com www.gstatic.com cdn.jsdelivr.net;  style-src 'self' 'unsafe-inline' cdnjs.cloudflare.com fonts.googleapis.com; prefetch-src 'self'; form-action 'none'; upgrade-insecure-requests; report-uri https://julenetxaniz.report-uri.com/r/d/csp/wizard"
```

El resultado de Hardenize ha empeorado, pero por ahora no se pueden quitar los `unsafe-inline`. 

{{< figure src="images/image38.png" alt="Hardenize Content Security Policy" caption="Hardenize Content Security Policy" numbered="true" >}}

Ahora que CSP funciona correctamente, podemos quitar `Report-Only`. Además, como `report-uri` está obsoleto según [CSP: report-uri - HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/report-uri), añadiremos `report-to`. Esta directiva se puede usar también con otros headers. Esto permite no tener que repetir la misma url en varios sitios. Se explica en [https://docs.report-uri.com/setup/reporting-api/](https://docs.report-uri.com/setup/reporting-api/). Podemos copiarlo desde [Report URI](https://report-uri.com/).

{{< figure src="images/image89.png" alt="Report URI Reporting API" caption="Report URI Reporting API" numbered="true" >}}

```
Content-Security-Policy = "default-src 'self'; connect-src 'self' www.google-analytics.com; font-src cdnjs.cloudflare.com fonts.gstatic.com; frame-src www.google.com disqus.com; img-src 'self' a.tile.openstreetmap.org b.tile.openstreetmap.org c.tile.openstreetmap.org cdnjs.cloudflare.com www.google-analytics.com data: c.disquscdn.com referrer.disqus.com; manifest-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval' cdnjs.cloudflare.com identity.netlify.com julenetxaniz.disqus.com www.google-analytics.com www.google.com www.googletagmanager.com www.gstatic.com cdn.jsdelivr.net; style-src 'self' 'unsafe-inline' cdnjs.cloudflare.com fonts.googleapis.com; prefetch-src 'self'; form-action 'none'; upgrade-insecure-requests; report-uri https://julenetxaniz.report-uri.com/r/d/csp/enforce; report-to default"
Report-To = '{"group":"default", "max_age":31536000, "endpoints":[{"url":"https://julenetxaniz.report-uri.com/a/d/g"}], "include_subdomains":true}'
```

El cambio se muestra en Hardenize.

{{< figure src="images/image15.png" alt="Hardenize Content Security Policy" caption="Hardenize Content Security Policy" numbered="true" >}}

Después de quitar Report-Only, se ha detectado un problema en Report URI.

{{< figure src="images/image7.png" alt="Report URI CSP Reports" caption="Report URI CSP Reports" numbered="true" >}}

He tenido que hacer los siguientes cambios para solucionarlo. Como `prefetch-src` es experimental según [MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy) y no está activado por defecto en Chrome, por ahora hay que añadir su contenido también en default-src.

```
Content-Security-Policy = "default-src 'self' c.disquscdn.com disqus.com; connect-src 'self' www.google-analytics.com; font-src cdnjs.cloudflare.com fonts.gstatic.com; frame-src www.google.com disqus.com; img-src 'self' a.tile.openstreetmap.org b.tile.openstreetmap.org c.tile.openstreetmap.org cdnjs.cloudflare.com www.google-analytics.com data: c.disquscdn.com referrer.disqus.com; manifest-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval' cdnjs.cloudflare.com identity.netlify.com julenetxaniz.disqus.com www.google-analytics.com www.google.com www.googletagmanager.com www.gstatic.com cdn.jsdelivr.net; style-src 'self' 'unsafe-inline' cdnjs.cloudflare.com fonts.googleapis.com; prefetch-src 'self' c.disquscdn.com disqus.com; form-action 'none'; upgrade-insecure-requests; report-uri https://julenetxaniz.report-uri.com/r/d/csp/enforce; report-to default"
```

Para terminar, podemos usar  [securityheaders.com](https://securityheaders.com/?q=julenetxaniz.eus&followRedirects=on) para ver que nuestra puntuación ha mejorado de D a C.

{{< figure src="images/image97.png" alt="Security Headers Report Summary" caption="Security Headers Report Summary" numbered="true" >}}

También aparecen todos los headers que he añadido.

{{< figure src="images/image3.png" alt="Raw Headers" caption="Raw Headers" numbered="true" >}}

Podemos ver que tenemos una advertencia por usar `unsafe-inline` y `unsafe-eval`. Para quitarlas tendríamos que cambiar el código, y esto requeriría mucho trabajo.

{{< figure src="images/image55.png" alt="Warnings, Upcoming Headers and Additional Information" caption="Warnings, Upcoming Headers and Additional Information" numbered="true" >}}

He solucionado más errores que han ido apareciendo y he hecho algunas mejoras más. He analizado la página de Scott Helme con [securityheaders.com](https://securityheaders.com/?q=https%3A%2F%2Fscotthelme.co.uk%2F&followRedirects=on) también para mejorar nuestra política viendo la suya.

```
Content-Security-Policy = '''
  default-src 'self' c.disquscdn.com disqus.com;
  connect-src 'self' www.google-analytics.com www.netlifystatus.com;
  font-src cdnjs.cloudflare.com fonts.gstatic.com;
  frame-src www.google.com disqus.com;
  img-src 'self' a.tile.openstreetmap.org b.tile.openstreetmap.org c.tile.openstreetmap.org cdnjs.cloudflare.com www.google-analytics.com data: c.disquscdn.com referrer.disqus.com wowchemy.com raw.githubusercontent.com;
  manifest-src 'self';
  script-src 'self' 'unsafe-inline' 'unsafe-eval' cdnjs.cloudflare.com identity.netlify.com julenetxaniz.disqus.com www.google-analytics.com www.google.com www.googletagmanager.com www.gstatic.com cdn.jsdelivr.net;
  style-src 'self' 'unsafe-inline' cdnjs.cloudflare.com fonts.googleapis.com;
  prefetch-src 'self' c.disquscdn.com disqus.com;
  form-action 'none';
  frame-ancestors 'none';
  object-src 'none';
  base-uri 'none';
  upgrade-insecure-requests;
  report-uri https://julenetxaniz.report-uri.com/r/d/csp/enforce;
  report-to default'''
```

##### 2.4.3.3. NEL

También podemos añadir Network Error Logging usando el Report-To que hemos definido.

{{< figure src="images/image94.png" alt="Report URI Network Error Logging" caption="Report URI Network Error Logging" numbered="true" >}}

```
NEL = '{"report_to":"default", "max_age":31536000, "include_subdomains":true}'
```

Podemos ver que está funcionando correctamente en Report URI.

{{< figure src="images/image35.png" alt="Report URI Network Error Reports" caption="Report URI Network Error Reports" numbered="true" >}}

##### 2.4.3.4. Subresource Integrity

SRI permite a los navegadores verificar la integridad de los recursos como JS y CSS cuando se cargan desde sitios web de terceros. Con SRI implementado, los recursos remotos se pueden usar de manera segura, sin temor a que sean modificados. Está implementado en la mayoría de recursos pero faltan algunos porque no es posible.

{{< figure src="images/image85.png" alt="Hardenize Subresource Integrity" caption="Hardenize Subresource Integrity" numbered="true" >}}

##### 2.4.3.5. Expect CT

Es un encabezado HTTP que los sitios web pueden usar para monitorear problemas relacionados con el cumplimiento de su Certificate Transparency (CT) . Además, también pueden indicar a los navegadores que rechacen cualquier certificado en su nombre que no sea compatible con CT.

{{< figure src="images/image60.png" alt="Hardenize Expect CT" caption="Hardenize Expect CT" numbered="true" >}}

Para configurarlo correctamente, seguiremos las recomendaciones del blog de Scott Helme  [https://scotthelme.co.uk/a-new-security-header-expect-ct/](https://scotthelme.co.uk/a-new-security-header-expect-ct/). Primero lo añadiremos en modo `reportOnly` y con `max-age=0`.

```
Expect-CT = 'max-age=0, report-uri="https://julenetxaniz.report-uri.com/r/d/ct/reportOnly"'
```

Podemos ver en Hardenize que el encabezado es válido.

{{< figure src="images/image76.png" alt="Hardenize Expect CT" caption="Hardenize Expect CT" numbered="true" >}}

Ahora podemos añadir `enforce` y aumentar `max-age=30`.

```
Expect-CT = 'enforce, max-age=30, report-uri="https://julenetxaniz.report-uri.com/r/d/ct/enforce"'
```

Se ha actualizado correctamente en Hardenize.

{{< figure src="images/image47.png" alt="Hardenize Expect CT" caption="Hardenize Expect CT" numbered="true" >}}

Para terminar, siguiendo las recomendaciones de la documentación, aumentaremos `max-age` y quitaremos `enforce`.

```
Expect-CT = 'max-age=604800, report-uri="https://julenetxaniz.report-uri.com/r/d/ct/enforce"'
```

{{< figure src="images/image106.png" alt="Hardenize Expect CT" caption="Hardenize Expect CT" numbered="true" >}}

Veremos en report-uri que he recibido correctamente los reportes de prueba enviados por Hardenize cada vez que analizamos la web.

{{< figure src="images/image95.png" alt="Report URI Expect CT Reports" caption="Report URI Expect CT Reports" numbered="true" >}}

##### 2.4.3.6. Report URI

[Report URI](https://report-uri.com/) nos muestra un resumen de todos los informes que hemos recibido. Después de 5 días funcionando con las anteriores configuraciones, este es el resumen de todos los informes que hemos recibido. Han llegado 280 informes en total, un 2% del límite de 10000 informes al mes. Han llegado 4 tipos de informes: CSP (117), Expect-CT (44), NEL (118) y Certificate Transparency (1). La gran cantidad de informes CSP coincide con la configuración de la política. Una vez configurada correctamente, el número de informes disminuye. Los informes Expect-CT son enviados por Hardenize cada vez que analizamos la web. La mayoría de informes NEL fueron generados cuando estaba intentando configurar MTA-STS.

{{< figure src="images/image102.png" alt="Report URI Summary" caption="Report URI Summary" numbered="true" >}}

#### 2.4.4. APPLICATION SECURITY

##### 2.4.4.1. Frame Options

Controla qué ocurre cuando una página se incorpora a otra página mediante frames. Si se permite, los atacantes pueden emplear trucos para hacer que las víctimas realicen acciones en tu sitio. Por ejemplo, mostrando su sitio web mientras reenvían los clics de la víctima al tuyo.

{{< figure src="images/image27.png" alt="Hardenize Frame Options" caption="Hardenize Frame Options" numbered="true" >}}

Siguiendo las recomendaciones sobre [x-frame-options](https://scotthelme.co.uk/hardening-your-http-response-headers/#x-frame-options), solo permitiremos los frames desde nuestra web.

```
X-Frame-Options = "SAMEORIGIN"
```

Podemos ver en Hardenize que la configuración es válida.

{{< figure src="images/image125.png" alt="Hardenize Frame Options" caption="Hardenize Frame Options" numbered="true" >}}

La nota en [securityheaders.com](https://securityheaders.com/?q=julenetxaniz.eus&followRedirects=on) también ha mejorado de C a B.

{{< figure src="images/image114.png" alt="Security Headers Report Summary" caption="Security Headers Report Summary" numbered="true" >}}

##### 2.4.4.2. XSS Protection

Los navegadores modernos tienen defensas integradas contra Cross-Site Scripting (XSS). Las políticas recomendadas son bloquear los ataques XSS o desactivar las defensas si es posible que se produzcan falsos positivos. El filtrado no se recomienda porque los atacantes pueden usarlo para desactivar scripts selectivamente.

{{< figure src="images/image46.png" alt="Hardenize XSS Protection" caption="Hardenize XSS Protection" numbered="true" >}}

Siguiendo la recomendación de [securityheaders.com](https://securityheaders.com/?q=julenetxaniz.eus&followRedirects=on) lo activaremos en modo bloqueo.

```
X-XSS-Protection = "1; mode=block"
```

Podemos ver que Hardenize ha detectado el cambio.

{{< figure src="images/image86.png" alt="Hardenize XSS Protection" caption="Hardenize XSS Protection" numbered="true" >}}

##### 2.4.4.3. Content Type Options

Algunos navegadores usan sniffing para anular los tipos de respuesta MIME proporcionados e interpretar las respuestas como otra cosa. Este comportamiento podría generar problemas de seguridad y debe desactivarse.

{{< figure src="images/image110.png" alt="Hardenize Content Type Options" caption="Hardenize Content Type Options" numbered="true" >}}

Siguiendo el blog sobre [x-content-type-options](https://scotthelme.co.uk/hardening-your-http-response-headers/#x-content-type-options).

```
X-Content-Type-Options = "nosniff"
```

Hardenize nos dice que está bien configurado.

{{< figure src="images/image29.png" alt="Hardenize Content Type Options" caption="Hardenize Content Type Options" numbered="true" >}}

Con esto hemos conseguido implementar correctamente todas las funcionalidades que aparecen en Hardenize.

{{< figure src="images/image87.png" alt="Hardenize WWW" caption="Hardenize WWW" numbered="true" >}}

La puntuación en [Security Headers](https://securityheaders.com/?q=julenetxaniz.eus&followRedirects=on) ha mejorado de B a A. Nos avisa que no podremos mejorar la puntuación a A+ si no solucionamos las advertencias de CSP.

{{< figure src="images/image120.png" alt="Security Headers Report Summary" caption="Security Headers Report Summary" numbered="true" >}}

Aunque no aparezcan en Hardenize, todavía faltan 2 headers por añadir. A continuación añadiremos esos headers.

##### 2.4.4.4. Referrer Policy

Cuando un usuario hace clic en un enlace en un sitio, el sitio de destino recibe información sobre el origen del usuario. Este encabezado permite controlar en qué casos no se manda esa información y cuanta información se manda. Se explica con más detalle en [https://scotthelme.co.uk/a-new-security-header-referrer-policy/](https://scotthelme.co.uk/a-new-security-header-referrer-policy/). 

Siguiendo las recomendaciones del blog, he elegido la siguiente opción. El navegador enviará la URL completa a las solicitudes al mismo origen, pero sólo enviará el origen cuando las solicitudes sean de origen distinto. Además, no permitirá que se envíe ninguna información al navegar desde HTTPS a HTTP.

```
Referrer-Policy = "strict-origin-when-cross-origin"
```

Podemos ver que se ha actualizado en [Security Headers](https://securityheaders.com/?q=julenetxaniz.eus&followRedirects=on)

{{< figure src="images/image25.png" alt="Security Headers Report Summary" caption="Security Headers Report Summary" numbered="true" >}}

##### 2.4.4.5. Feature Policy

Permite que un sitio habilite o deshabilite ciertas funciones del navegador para mejorar la seguridad y la privacidad. Incluso se pueden controlar las funciones de las páginas incrustadas.

Aunque se ha renombrado por Permissions Policy, todavía se debe incluir porque los navegadores no son compatibles. Se pueden comparar las políticas con caniuse: [https://caniuse.com/feature-policy](https://caniuse.com/feature-policy) y [https://caniuse.com/permissions-policy](https://caniuse.com/permissions-policy). Siguiendo las recomendaciones de [https://scotthelme.co.uk/a-new-security-header-feature-policy/](https://scotthelme.co.uk/a-new-security-header-feature-policy/) se ha configurado el siguiente encabezado.

```
Feature-Policy = "accelerometer 'none'; camera 'none'; geolocation 'none'; gyroscope 'none'; magnetometer 'none'; microphone 'none'; payment 'none'; usb 'none'"
```

##### 2.4.4.6. Permissions Policy

Se ha configurado una política equivalente a la anterior siguiendo las recomendaciones de 

[https://scotthelme.co.uk/goodbye-feature-policy-and-hello-permissions-policy/](https://scotthelme.co.uk/goodbye-feature-policy-and-hello-permissions-policy/).

```
Permissions-Policy = "accelerometer=(), camera=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), payment=(), usb=()"
```

Podemos ver que se ha actualizado en [Security Headers](https://securityheaders.com/?q=julenetxaniz.eus&followRedirects=on)

{{< figure src="images/image61.png" alt="Security Headers Report Summary" caption="Security Headers Report Summary" numbered="true" >}}

También nos muestra un resumen de los headers que se han añadido. También aparece Feature-Policy.

{{< figure src="images/image52.png" alt="Security Headers Additional Information" caption="Security Headers Additional Information" numbered="true" >}}

## 3. Resultados

Los resultados son buenos, he conseguido mejorar muchos aspectos de seguridad que aparecen en [Hardenize](https://www.hardenize.com/) y [Security Headers](https://securityheaders.com/). Aún y todo, todavía hay bastante margen de mejora. En Hardenize sobre todo hay que mejorar la sección de email. Habría que encontrar un proveedor que nos ofrezca email seguro con un certificado válido. Pero como hemos dicho antes no merece la pena por ahora. Por otro lado en Security Headers se puede mejorar CSP para que no tengamos advertencias. Pero esto requeriría hacer cambios en el código.

### 3.1. Hardenize

#### 3.1.1. Summary

En seguridad web he conseguido implementar las dos características que faltaban: HSTS preloaded y Content Security Policy. Además, he mejorado HTTP Strict Transport Security.

{{< figure src="images/image1.png" alt="Hardenize WEB SECURITY OVERVIEW" caption="Hardenize WEB SECURITY OVERVIEW" numbered="true" >}}

En seguridad de email no he conseguido solucionar la advertencia de STARTTLS. He mejorado un poco la configuración de DMARC.

{{< figure src="images/image26.png" alt="Hardenize EMAIL SECURITY OVERVIEW" caption="Hardenize EMAIL SECURITY OVERVIEW" numbered="true" >}}

#### 3.1.2. Domain

Respecto a la seguridad de dominio, sólo he mejorado un poco CAA. DNSSEC no se podía implementar y los servidores DNS ya estaban configurados correctamente.

{{< figure src="images/image43.png" alt="Hardenize Domain" caption="Hardenize Domain" numbered="true" >}}

#### 3.1.3. Email

La configuración de email tampoco ha mejorado mucho. No he podido solucionar las advertencias porque no estaba en mis manos. La configuración de TLS del servidor de dinahosting era mala. Y el nombre del certificado no coincidía con el de mi servidor. He conseguido implementar MTA-STS y TLS-RPT correctamente, pero he tenido que desactivar MTA-STS porque las advertencias se convertían en errores. No tenía la opción de implementar DANE. He hecho alguna mejora en DMARC y he comprobado que funcionaba correctamente recibiendo un informe.

{{< figure src="images/image80.png" alt="Hardenize Email" caption="Hardenize Email" numbered="true" >}}

#### 3.1.4. WWW

En seguridad web he conseguido implementar todas las características que faltaban. He configurado Content Security Policy, Expect CT, Frame Options, XSS Protection y Content Type Options correctamente. También he mejorado Strict Transport Security. Además, he extendido estos aspectos con los de Security Headers.

{{< figure src="images/image87.png" alt="Hardenize WWW" caption="Hardenize WWW" numbered="true" >}}

#### 3.1.5. Comparativa

Para comparar nuestros resultados de [Hardenize](https://www.hardenize.com/report/julenetxaniz.eus/1609273566) con los de otras webs, podemos consultar [Hardenize Dashboard: Global Top Sites](https://www.hardenize.com/dashboards/global-top-sites/), que contiene los resultados de los 500 dominios más populares del mundo. Sólo alrededor del 40% tienen una configuración correcta de web y email. Los resultados son muy malos teniendo en cuenta que son entidades con muchos recursos.

{{< figure src="images/image108.png" alt="Hardenize Dashboard: Global Top Sites" caption="Hardenize Dashboard: Global Top Sites" numbered="true" >}}

Más abajo se nos muestra estadísticas de características importantes de seguridad web y email. En seguridad web, sorprende ver que el 2% de sitios que no tienen HTTPS. Un 15% no redireccionan desde HTTP a HTTPS y sólo el 51% tienen HSTS. El porcentaje de HSTS Preloaded es todavía más bajo, solo un 10%. 

Respecto a seguridad de email, también hay otro 8% que ni siquiera tienen STARTTLS. El 93% usa SPF pero solo el 36% ha implementado DMARC.

{{< figure src="images/image79.png" alt="Hardenize Dashboard Security Overview" caption="Hardenize Dashboard Security Overview" numbered="true" >}}

Si vamos al apartado [https://www.hardenize.com/dashboards/global-top-sites/#/details](https://www.hardenize.com/dashboards/global-top-sites/#/details) encontraremos los detalles de cada uno de los sitios analizados. A primera vista vemos algunas funcionalidades sin implementar, pero incluso hay algunas con advertencias y errores. Podemos encontrar dominios muy conocidos como [youtube.com](https://www.youtube.com/) o [yahoo.com](https://www.yahoo.com/). 

{{< figure src="images/image39.png" alt="Hardenize Dashboard: Global Top Sites" caption="Hardenize Dashboard: Global Top Sites" numbered="true" >}}

### 3.2. Security Headers

Si comparamos el resultado inicial de [Security Headers](https://securityheaders.com/?q=julenetxaniz.eus&followRedirects=on) con el final, veremos que la diferencia es muy grande. He pasado de tener solo 1 header a tener 6. Nuestra puntuación no es perfecta, pero solo se puede mejorar hasta A+ cambiando el header CSP.

{{< figure src="images/image4.png" alt="Initial Security Headers Report Summary" caption="Initial Security Headers Report Summary" numbered="true" >}}

{{< figure src="images/image61.png" alt="Final Security Headers Report Summary" caption="Final Security Headers Report Summary" numbered="true" >}}

Si lo comparamos con los demás sitios web que se han analizado con [Security Headers](https://securityheaders.com/), el nuestro está entre los mejores. De las casi 122 millones de webs analizadas sólo el 1% tiene la nota A+ y el 10% la nota A. Aproximadamente el 74% tiene una nota menor que D, que es la nota con la que comenzamos. Osea que podríamos decir que aunque parecía mala nota no está tan mal si la comparamos con las demás. También podemos ver los escaneos recientes y los mejores y peores entre ellos.

{{< figure src="images/image126.png" alt="Security Headers Stats" caption="Security Headers Stats" numbered="true" >}}

## 4. Contribución

El resultado del proyecto ha sido bueno. La mejora más grande ha sido en los headers de seguridad. He decidido contribuir esas mejoras a la plantilla [wowchemy/starter-academic](https://github.com/wowchemy/starter-academic). Es una forma de ayudar a [Wowchemy](https://wowchemy.com/), que me ha sido muy útil para construir mi web.

La demo de [Academic](https://academic-demo.netlify.app/) obtiene malos resultados en [Security Headers](https://securityheaders.com/?q=academic-demo.netlify.app&followRedirects=on), parecidos a los que tenía yo al empezar. Con lo que he aprendido, será mucho más sencillo y rápido mejorarlos. No documentaré todo el proceso para que no sea repetitivo. Sólo enseñaré el resultado inicial,  los cambios que he hecho y el resultado final.

{{< figure src="images/image73.png" alt="Initial Security Headers Report Summary" caption="Initial Security Headers Report Summary" numbered="true" >}}

He creado un Fork en [juletx/starter-academic](https://github.com/juletx/starter-academic). He realizado los cambios necesarios en la rama [security-headers](https://github.com/juletx/starter-academic/tree/security-headers). He comprobado que todo funcionaba correctamente en mi demo  [https://academic-demo-headers.netlify.app/](https://academic-demo-headers.netlify.app/).  He creado un [Pull Request](https://github.com/wowchemy/starter-academic/pull/170) desde esa rama a master de [wowchemy/starter-academic](https://github.com/wowchemy/starter-academic). He añadido sólo los headers que se piden en [Security Headers](https://securityheaders.com/?q=academic-demo.netlify.app&followRedirects=on) para simplificar.

```
[[headers]]
  for = "/*"
  [headers.values]
    Content-Security-Policy = '''
    default-src 'self';
    connect-src 'self' api.github.com www.netlifystatus.com;
    font-src data: cdn.jsdelivr.net cdnjs.cloudflare.com fonts.gstatic.com;
    img-src 'self' data: blob: a.tile.openstreetmap.org b.tile.openstreetmap.org c.tile.openstreetmap.org cdnjs.cloudflare.com; manifest-src 'self';
    script-src 'self' 'unsafe-inline' 'unsafe-eval' buttons.github.io cdn.jsdelivr.net cdnjs.cloudflare.com identity.netlify.com cdn.mathjax.org;
    style-src 'self' 'unsafe-inline' cdnjs.cloudflare.com fonts.googleapis.com;
    form-action 'none';
    frame-ancestors 'none';
    object-src 'none';
    base-uri 'none';
    upgrade-insecure-requests;
    report-uri https://julenetxaniz.report-uri.com/r/d/csp/enforce
    '''
    X-Content-Type-Options = "nosniff"
    Referrer-Policy = "strict-origin-when-cross-origin"
    Feature-Policy = "accelerometer 'none'; camera 'none'; geolocation 'none'; gyroscope 'none'; magnetometer 'none'; microphone 'none'; payment 'none'; usb 'none'"
    Permissions-Policy = "accelerometer=(), camera=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), payment=(), usb=()"
```

El resultado final ha mejorado como en mi web.

{{< figure src="images/image21.png" alt="Final Security Headers Report Summary" caption="Final Security Headers Report Summary" numbered="true" >}}

## 5. Conclusiones

Ha sido una tarea mucho más larga de lo que pensaba. El alcance del proyecto es demasiado amplio. Un alcance más adecuado habría sido por ejemplo centrarse solo en los headers de seguridad. Aún y todo ha merecido la pena, porque me ha servido para aprender muchas cosas nuevas. Además, que el tema del proyecto me interese ha ayudado a que se me haga más ameno.

La tarea que más tiempo me ha llevado ha sido configurar CSP. Coincide que en el resumen inicial de Hardenize está marcado como High Effort. También he tardado mucho configurando MTA-STS. Aunque parecía simple, configurar el subdominio ha sido bastante complicado.

El resultado del proyecto ha sido bueno. Aunque no he conseguido implementar todas la características, he configurado correctamente todas las que estaban en mi mano. Además, he conseguido mejorar la seguridad no solo de mi web, sino que también de la demo de Academic. Esto será útil para las demás personas que utilicen la plantilla, porque les facilitará configurar los headers para su web.

## 6. Referencias

Web de Hardenize

1. [https://www.hardenize.com/](https://www.hardenize.com/)
2. [https://www.hardenize.com/dashboards/global-top-sites/](https://www.hardenize.com/dashboards/global-top-sites/)

Documentación de Netlify

3. [https://docs.netlify.com/domains-https/netlify-dns/dns-records/](https://docs.netlify.com/domains-https/netlify-dns/dns-records/)
4. [https://docs.netlify.com/domains-https/custom-domains/](https://docs.netlify.com/domains-https/custom-domains/)
5. [https://docs.netlify.com/routing/headers/](https://docs.netlify.com/routing/headers/)
6. [https://docs.netlify.com/routing/redirects/](https://docs.netlify.com/routing/redirects/)

Documentación de Report URI

7. [https://docs.report-uri.com/](https://docs.report-uri.com/)

Documentación de MDN

8. [https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers)

Blog de Simon Hearne

9. [https://simonhearne.com/2019/http-headers-fast-and-secure](https://simonhearne.com/2019/http-headers-fast-and-secure)

Blog de Scott Helme

10. [https://scotthelme.co.uk/hardening-your-http-response-headers/](https://scotthelme.co.uk/hardening-your-http-response-headers/)
11. [https://scotthelme.co.uk/content-security-policy-an-introduction/](https://scotthelme.co.uk/content-security-policy-an-introduction/)
12. [https://scotthelme.co.uk/a-new-security-header-feature-policy/](https://scotthelme.co.uk/a-new-security-header-feature-policy/)
13. [https://scotthelme.co.uk/goodbye-feature-policy-and-hello-permissions-policy/](https://scotthelme.co.uk/goodbye-feature-policy-and-hello-permissions-policy/)
14. [https://scotthelme.co.uk/hsts-the-missing-link-in-tls/](https://scotthelme.co.uk/hsts-the-missing-link-in-tls/)
15. [https://scotthelme.co.uk/a-new-security-header-expect-ct/](https://scotthelme.co.uk/a-new-security-header-expect-ct/)
16. [https://scotthelme.co.uk/a-new-security-header-referrer-policy/](https://scotthelme.co.uk/a-new-security-header-referrer-policy/)
17. [https://scotthelme.co.uk/email-security-spf/](https://scotthelme.co.uk/email-security-spf/)
18. [https://scotthelme.co.uk/email-security-dkim/](https://scotthelme.co.uk/email-security-dkim/)
19. [https://scotthelme.co.uk/email-security-dmarc/](https://scotthelme.co.uk/email-security-dmarc/)
