Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C69iY-0005IG-KJ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 08:23:10 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C69iW-00069n-W5 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 08:23:10 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH] nptl/sys_clone fix for i386/ppc
References: <20040826020626.GA28471@malice.crymeariver.org>
	<200409102352.i8ANql0O004842@ccure.user-mode-linux.org>
	<4142FEC3.1040904@upb.de>
In-Reply-To: <4142FEC3.1040904@upb.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200409111719.44196.blaisorblade_spam@yahoo.it>
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
Date: Sat, 11 Sep 2004 17:19:44 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>

On Saturday 11 September 2004 15:33, Sven K=F6hler wrote:
> >>The problem is caused by the incorrect implementation of sys_clone().
> >> sys_clone() is an ugly beast that has different arguements depending
> >>on  the architecture.  For i386 and ppc, the child tid is passed as
> >>the  5th arguement instead of as the 4th arguement as as some other
> >>architectures (like x86-64) do.  The 4th arguement on i386 and ppc
> >>doesn't look to be used by the kernel.
> >
> > This is fixed in my tree.  It was a lot simpler than your patch, or what
> > I led you to believe.  I just moved sys_clone from syscall_kern.c to
> > arch/um/sys-i386/syscalls.c and fixed the interface.
>
> Sorry, i guess my question is stupid, but does UML now run an a
> host-system that is NPTL enabled? I didn't try that for a few months
> now, and LD_ASSUME_KERNEL=3D2.4.1 won't work with my host-system (gentoo)
> since it doesn't come with a 2nd glibc-versions.
That fix is only needed with TT mode off, SKAS mode on and Static Linking o=
n,=20
as far as I know.
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
