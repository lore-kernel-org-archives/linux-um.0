Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C2u2a-0001NI-VC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Sep 2004 09:02:24 -0700
Received: from tharec.debianbase.de ([212.79.163.254] helo=mail2.debianbase.de)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C2u2a-0007Dl-60 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Sep 2004 09:02:24 -0700
Received: from mail.debianbase.de (tha.vpn.local [192.168.100.1])
	by mail2.debianbase.de (Postfix) with ESMTP id 485A7FE
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  2 Sep 2004 18:02:15 +0200 (CEST)
Received: from vaiobook.tha.local (vaiobook.tha.local [10.0.0.9])
	by mail.tha.local (Postfix) with ESMTP id C0D53AC1C01
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  2 Sep 2004 18:02:24 +0200 (CEST)
From: Ralph =?iso-8859-15?q?Pa=DFgang?= <ralph@debianbase.de>
Subject: Re: [uml-devel] Problems compiling any 2.6.x UML
References: <1094138889.26131.28.camel@localhost>
In-Reply-To: <1094138889.26131.28.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200409021802.14328.ralph@debianbase.de>
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
Date: Thu, 2 Sep 2004 18:02:14 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I have builded debian packages for 2.6 umls, or better I made the original =

debian sourcepackage include a 2.6 kernel and compile cleanly.

You can get the source-package at:
deb http://packages.debianbase.de/sources/uml-exp/ ./

and the binaries for sarge at:
deb http://packages.debianbase.de/sarge/i386/uml-exp/ ./

The last version available there is 2.6.8, but I would suggest that you tes=
t=20
the 2.6.6 package, because I know that this version works without any probl=
em=20
on more than just my machine. The 2.6.7 should be fine, too.

I have problems myself with the 2.6.8 package, but I have to take a closer =

look at this, because I don't know if its a debian packaging problem or=20
something like this or actually a uml bug. But any of these source packages=
=20
compiles cleanly without any problem.

Ah, before I forget it: with skas patch in the host kernel the umls are=20
running very smoothly... Without skas patch the umls sometimes doesn't star=
t=20
(diffrent kernel panics).  I don't know why, but I am a bit confussed becau=
se=20
the uml kernel doesn't always hang at the same point... Maybe there is=20
something broken in the uml or in the debian system...

Hope this helps a bit...

--Ralph

Am Donnerstag 02 September 2004 17:28 schrieb Dominik J=FCrgens:
> I have a problem with compiling user-mode-linux on my debian sarge
> system. Some importent package versions:
>
> Hostkernel 2.6.8.1
> gcc (GCC) 3.3.4 (Debian 1:3.3.4-6sarge1)
> GNU Make 3.80
> GNU binutils version 2.14.90.0.7 20031029 Debian GNU/Linux
>
> Problem: When I try to compile any 2.6.x UML-Kernel I get following
> message:
>
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
>   CPP     arch/um/uml.lds.s
> gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free
> -Wl,--wrap,calloc \
>         -o linux arch/um/main.o vmlinux -L/usr/lib -lutil
> /usr/bin/ld:arch/um/uml.lds.s:150: syntax error
> collect2: ld returned 1 exit status
> make: *** [linux] Fehler 1
> </--zip-->
>
> The content of the 'arch/um/uml.lds.s' file arround line 150:
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
>
> I googled for it a longer time and found nothing.
>
> Thanks for helping me :-)
> Dominik Juergens
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=3D5047&alloc_id=3D10808&op=3Dclick
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idP47&alloc_id=10808&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
