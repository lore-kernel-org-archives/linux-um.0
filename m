Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C68ho-0006s7-0o for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 07:18:20 -0700
Received: from tharec.debianbase.de ([212.79.163.254] helo=mail2.debianbase.de)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C68hn-0007WH-Ib for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 07:18:19 -0700
Received: from mail.debianbase.de (tha.vpn.local [192.168.100.1])
	by mail2.debianbase.de (Postfix) with ESMTP id 36D449075
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 11 Sep 2004 16:18:10 +0200 (CEST)
Received: from vaiobook.tha.local (vaiobook.tha.local [10.0.0.9])
	by mail.tha.local (Postfix) with ESMTP id 0364B1E6AF
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 11 Sep 2004 16:18:19 +0200 (CEST)
From: Ralph =?iso-8859-1?q?Pa=DFgang?= <ralph@debianbase.de>
Subject: Re: [uml-devel] Re: [PATCH] nptl/sys_clone fix for i386/ppc
References: <20040826020626.GA28471@malice.crymeariver.org>
	<200409102352.i8ANql0O004842@ccure.user-mode-linux.org>
	<4142FEC3.1040904@upb.de>
In-Reply-To: <4142FEC3.1040904@upb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200409111618.08404.ralph@debianbase.de>
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
Date: Sat, 11 Sep 2004 16:18:08 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Am Samstag 11 September 2004 15:33 schrieb Sven K=F6hler:
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

Yes... uml is running on a host with nptl. Only in the uml sessions you sho=
uld=20
disable nptl by moving /lib/tls to /lib/tls.disabled

--Ralph


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.=20
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
