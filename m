Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmHG8-0007mE-DE for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 12:23:40 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BmHG7-00083u-Qk for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 12:23:40 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: 2.6.6 compile crashing on Fed Core 2
References: <40C20E43.1090305@morpheux.org>
	<20040715060709.GA11167@neu.nirvana>
In-Reply-To: <20040715060709.GA11167@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200407182124.23827.blaisorblade_spam@yahoo.it>
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
Date: Sun, 18 Jul 2004 21:24:23 +0200
Content-Transfer-Encoding: quoted-printable
To: Axel Thimm <Axel.Thimm@ATrpms.net>, Faye Gibbins <wibble@morpheux.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 08:07, gioved=EC 15 luglio 2004, Axel Thimm ha scritto:
> Hi,
>
> On Sat, Jun 05, 2004 at 07:17:39PM +0100, Faye Gibbins wrote:
> > Just finished compiling 2.6.6 with UML patch 2.6.6-1. compile crashed
> > with:

> > snip---
> >
> > gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free
> > -Wl,--wrap,calloc \
> >         -o linux arch/um/main.o vmlinux -L/usr/lib -lutil
> > vmlinux(.text+0x605f): In function `mem_init':
> > arch/um/kernel/mem.c:71: undefined reference to `phys_page'
> > vmlinux(.init.text+0x3380): In function `kmap_init':
> > include/asm/pgtable.h:394: undefined reference to `pte_offset'
> > collect2: ld returned 1 exit status
> > make: *** [linux] Error 1
I'm not sure, but I remember that  you should probably disable CONFIG_HIGHM=
EM=20
to solve this. In any case, post the result. And yes, CONFIG_HIGHMEM should=
=20
work or be marked as not-working...

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idG21&alloc_id=10040&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
