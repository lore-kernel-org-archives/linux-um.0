Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AO7Wa-0001si-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 23 Nov 2003 19:36:32 -0800
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AO7WZ-0007cq-Or
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 23 Nov 2003 19:36:31 -0800
From: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>
Subject: Re: [uml-devel] Host panic when UML reads host /dev/shm
References: <200311201915.29188.blaisorblade_spam@yahoo.it> <200311202347.37312.Frank.dekervel@student.kuleuven.ac.Be> <200311221911.58773.blaisorblade_spam@yahoo.it>
In-Reply-To: <200311221911.58773.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200311240436.23294.Frank.dekervel@student.kuleuven.ac.Be>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 24 Nov 2003 04:36:23 +0100
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Op Saturday 22 November 2003 19:11, schreef BlaisorBlade:
> By the way, try the archive at http://marc.theaimsgroup.com/, it's common=
ly
> believed to be better than the sourceforge one... However don't worry, I
> found the post.
>
> > but contrary to what i tought, it is not exactly the same oops.
>
> There is also a filldir64 trace, or better EIP points into it. But then
> filldir64 should also appear in the trace.
>
> > =A0Trace; c0149048 <sys_getdents+90/98>
> > =A0Trace; c0139ea4 <sys_read+5c/100>
> > =A0Trace; c01089f3 <system_call+33/38>
> > if ksymoops is right. i also sent it to lkml, without response. And i w=
as
> > also using tmpfs then (for uml memory as described in howto)
>
> I.e. your /tmp was under tmpfs? That may explain the fact that the oops is
> different.

not my /tmp, but /home/kervel/uml/memory and uml had TMPDIR=3D/home/kervel/=
uml/
memory. the crash happent when running updatedb with host:/ mounted in uml =

(so uml could access whole host filesystem).

> However, I think the call trace is wrong, (below I explain why), so if you
> are able to reproduce the bug, this would be great.
> Thanks!

that will be a bit difficult since the system is production, but i'll try t=
o=20
setup a test system ...

> However, I've looked at 2.4.22 sources, and either the related functions
> were almost rewritten, or the ksymoops output is bodged. sys_getdents
> doesn't call filldir64; it calls vfs_readdir(and this could actually be
> inlined, but it wouldn't get at the 90/98 position inside sys_getdents),
> but then it does a call to a readdir "method"(i.e. through a function
> pointer, so this can't be inlined and must appear in the trace) and then =
it
> does another call, which could be to filldir64, through a function pointe=
r.
> You said maybe you didn't copy all the output of ksymoops, but the stack
> trace is never more than 3 calls. I'll maybe check by disassembly if the
> output makes sense in that point, though this is not very meaningful if n=
ot
> done on the original vmlinux file.

greetings,
frank


--=20
Frank Dekervel
Mechelsestraat 88
3000 Leuven
frank.dekervel@student.kuleuven.ac.be, (nieuw) 0473/94.34.21


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
