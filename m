Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuHAw-0004rJ-A8 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 12:23:06 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AuH4u-0006Nu-Hs for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 12:16:52 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] socket in UML
References: <20040219211908.21858.qmail@web60803.mail.yahoo.com>
In-Reply-To: <20040219211908.21858.qmail@web60803.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402201914.45064.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 20 Feb 2004 19:14:45 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: seba b <niakoz@yahoo.com.ar>

Alle 22:19, gioved=EC 19 febbraio 2004, seba b ha scritto:
> (Espa=F1ol)
> Necesito programar un socket que me comunique con el host desde dentro de
> UML. Que funciones y librerias necesitaria para comenzar a trabajar en es=
te
> proyecto?.Agradeceria una respuesta.Muchas Gracias.
>
> (My english is so bad,sory).
> I need to create a socket to comunicate with the host from inside UML. Wh=
at
> function and libraries I need to program?  Thank.

Espanol: (Mi espanolo no es muy bueno)
Tu quieres un IPV4 socket or uno "Unix domain socket"? Si tu problema es cr=
ear=20
comunicacion entre el host y UML, tu puedes utilizar ("to use") las normale=
s=20
funciones que se pueden utilizar en Linux por eso: los BSD sockets. Pregunt=
a=20
por como se usen su qualquier newsgroup or utiliza Google para revenirlos=20
("to find them"). Nota que tu debes haber in tu UML una conectividad IPv4=20
funcionante (eth0 debe ser activa; mira aqu=EC:=20
http://user-mode-linux.sourceforge.net/networking.html).

Ellos son usados para conecter dos differentes ordenadores atraverso Intern=
et=20
o atraverso una "local net": entre el host y el UML hay una "local net", y =

por eso tu habes la misma situacion que entre dos differentes ordenadores.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
