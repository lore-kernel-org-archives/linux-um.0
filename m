Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3IOk-0003oq-8j for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Sep 2004 11:02:54 -0700
Received: from web54004.mail.yahoo.com ([206.190.36.228])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C3IOg-0000cm-8c for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Sep 2004 11:02:53 -0700
Message-ID: <20040903180244.42898.qmail@web54004.mail.yahoo.com>
From: =?iso-8859-1?q?p=20g?= <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Problems compiling any 2.6.x UML
In-Reply-To: <1094138889.26131.28.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Fri, 3 Sep 2004 20:02:44 +0200 (CEST)
Content-Transfer-Encoding: quoted-printable
To: dcdom@gmx.de, user-mode-linux-devel@lists.sourceforge.net

 --- Dominik J=FCrgens <dcdom@gmx.de> ha scritto:=20
> I have a problem with compiling user-mode-linux on
> my debian sarge
> system. Some importent package versions:
> =20
> Hostkernel 2.6.8.1
> gcc (GCC) 3.3.4 (Debian 1:3.3.4-6sarge1)
> GNU Make 3.80
> GNU binutils version 2.14.90.0.7 20031029 Debian
> GNU/Linux
>=20
> Problem: When I try to compile any 2.6.x UML-Kernel
> I get following
> message:
>=20
> make ARCH=3Dum linux \n
> ...
> <--zip-->
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
>   KSYM    .tmp_kallsyms1.S
>   AS      .tmp_kallsyms1.o
>   LD      .tmp_vmlinux2
>   KSYM    .tmp_kallsyms2.S
>   AS      .tmp_kallsyms2.o
>   MAIN    arch/um/main.o
>   LD      vmlinux
> /bin/sh: Syntax error: "(" unexpected
If /bin/sh is not bash, this is the problem.
Also make sure you properly configured your kernel
with make *config ARCH=3Dum
>   CPP     arch/um/uml.lds.s
> gcc -Wl,-T,arch/um/uml.lds.s -static
> -Wl,--wrap,malloc -Wl,--wrap,free
> -Wl,--wrap,calloc \
>         -o linux arch/um/main.o vmlinux -L/usr/lib
> -lutil
> /usr/bin/ld:arch/um/uml.lds.s:150: syntax error
> collect2: ld returned 1 exit status
> make: *** [linux] Fehler 1
> </--zip-->
>=20
> The content of the 'arch/um/uml.lds.s' file arround
> line 150:
> <--zip-->
> 147:  init.data : { *(init.data) }
> 148:  .data :
> 149:  {
> 150:    . =3D ALIGN(); /* init_task */
> 151:    *(.data.init_task)
> 152:    *(.data)
> 153:    *(.gnu.linkonce.d*)
> 154:    CONSTRUCTORS
> 155:  }
> </--zip-->
>=20
> I googled for it a longer time and found nothing.=20
>=20
> Thanks for helping me :-)
> Dominik Juergens
>=20
>=20
>=20
>
-------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic
> Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1
> today.
>
http://ads.osdn.com/?ad_id=3D5047&alloc_id=3D10808&op=3Dclick
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> =20


=09

=09
	=09
___________________________________
Yahoo! Companion - Scarica gratis la toolbar di Ricerca di Yahoo!=20
http://companion.yahoo.it


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=3D5047&alloc_id=3D10808&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
