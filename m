Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C42u4-0003tV-0j for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 12:42:20 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C42tz-0001Eq-Fk for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 12:42:17 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] nptl/sys_clone fix for i386/ppc
References: <20040826020626.GA28471@malice.crymeariver.org>
In-Reply-To: <20040826020626.GA28471@malice.crymeariver.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200409051735.07479.blaisorblade_spam@yahoo.it>
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
Date: Sun, 5 Sep 2004 17:35:07 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: David Jeffery <djeffery@britsys.net>

Alle 04:06, gioved=EC 26 agosto 2004, David Jeffery ha scritto:
> This is a patch against 2.6.8.1-mm4 to fix a skas UML problem with a
> nptl glibc.

> UML with an nptl enabled glibc causes process creation to fail with
> this assertion failure in nptl:

I have just one problem in understanding you: are you talking about:
- linking the Uml binary against a NPTL glibc,
or
- using NPTL inside the Uml virtual machine?
From the actual patch, it seems that you are doing the second thing, but=20
nobody has been able, so far, to use NPTL *inside* UML, and we all thought =

that since UML misses the new NPTL syscalls, that was the reason. If this=20
patch, instead, was enough for you, I'm very happy.

> The problem is caused by the incorrect implementation of sys_clone().
> sys_clone() is an ugly beast that has different arguements depending on
> the architecture.  For i386 and ppc, the child tid is passed as the
> 5th arguement instead of as the 4th arguement as as some other
> architectures (like x86-64) do.  The 4th arguement on i386 and ppc
> doesn't look to be used by the kernel.
Ok, it seems reasonable.
> With this patch I've been running several UML skas images with a Debian
> Sarge based systems for several days without problem.  The patch adds a
> sys_clone_5arg() on i386 and ppc which just raps around the current
> sys_clone() so the child tid pointer in the 5th arguement will be passed
> down correctly.  I don't get any style points for this patch so feel
> free to pretty it up.


> diff -urN linux-2.6.8.1-mm4.orig/arch/um/Makefile
> linux-2.6.8.1-mm4/arch/um/Makefile ---
> linux-2.6.8.1-mm4.orig/arch/um/Makefile	2004-08-25 20:52:56.000000000 -04=
00
> +++ linux-2.6.8.1-mm4/arch/um/Makefile	2004-08-22 16:55:52.000000000 -0400
> @@ -59,7 +59,8 @@
>
>  CFLAGS +=3D $(CFLAGS-y) -D__arch_um__ -DSUBARCH=3D\"$(SUBARCH)\" \
>  	-D_LARGEFILE64_SOURCE $(ARCH_INCLUDE) -Derrno=3Dkernel_errno \
> -	-Dsigprocmask=3Dkernel_sigprocmask $(MODE_INCLUDE)
> +	-Dsigprocmask=3Dkernel_sigprocmask $(MODE_INCLUDE) \
> +	-D__subarch_$(SUBARCH)__

Isn't enough the -DSUBARCH=3D ?
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idP47&alloc_id=10808&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
