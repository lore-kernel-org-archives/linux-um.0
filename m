Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6ZIU-0001Mo-N2 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 11:41:58 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C6ZIR-0002Eb-Ng for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 11:41:58 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH] nptl/sys_clone fix for i386/ppc
References: <20040826020626.GA28471@malice.crymeariver.org>
	<200409111719.44196.blaisorblade_spam@yahoo.it>
	<41435C04.3080204@upb.de>
In-Reply-To: <41435C04.3080204@upb.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200409122019.50179.blaisorblade_spam@yahoo.it>
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
Date: Sun, 12 Sep 2004 20:19:50 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>

On Saturday 11 September 2004 22:11, Sven K=F6hler wrote:
> >>Sorry, i guess my question is stupid, but does UML now run an a
> >>host-system that is NPTL enabled? I didn't try that for a few months
> >>now, and LD_ASSUME_KERNEL=3D2.4.1 won't work with my host-system (gento=
o)
> >>since it doesn't come with a 2nd glibc-versions.
> >
> > That fix is only needed with TT mode off, SKAS mode on and Static Linki=
ng
> > on, as far as I know.

> Well, i've got a NPTL-glibc here, and when starting 2.6.8.1-um1, it puts
> itself into background (however that is possible) and if i type "fg" on
> the shell, it segfaults.
Post your compilation .config, or at least the three options about TT mode,=
=20
SKAS mode and static link. What's your distro? If it's a Fedora there is a =

lot of possible problems, not NPTL related.

> Static linkage seems fails with the following error:
> gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free
> -Wl,--wrap,calloc \
>          -o linux arch/um/main.o vmlinux -L/usr/lib -lutil

> /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/../../../../i686-pc-linux-gnu/bi=
n/
>ld: BFD 2.15.90.0.1.1 20040303 assertion fail elf.c:3470
"Assertion failed" is a problem of the binutils, I think.
> /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/../../../../i686-pc-linux-gnu/bi=
n/
>ld: BFD 2.15.90.0.1.1 20040303 assertion fail elf.c:3470
> /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/../../../../i686-pc-linux-gnu/bi=
n/
>ld: BFD 2.15.90.0.1.1 20040303 assertion fail elf.c:3470
> /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/../../../../i686-pc-linux-gnu/bi=
n/
>ld: BFD 2.15.90.0.1.1 20040303 assertion fail elf.c:3470
> /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/../../../../i686-pc-linux-gnu/bi=
n/
>ld: linux: Not enough room for program headers (allocated 6, need 8)
Not enough room for headers? What the fucking sky! It's not something we ca=
n=20
easily fix. Oh, no, oh, no, oh, NOOO!
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.=20
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
