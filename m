Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ANcBh-0000Vs-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 22 Nov 2003 10:08:53 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1ANcBg-0004pB-P3
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 22 Nov 2003 10:08:52 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Host panic when UML reads host /dev/shm
References: <200311201915.29188.blaisorblade_spam@yahoo.it> <200311202332.56549.Frank.dekervel@student.kuleuven.ac.Be> <200311202347.37312.Frank.dekervel@student.kuleuven.ac.Be>
In-Reply-To: <200311202347.37312.Frank.dekervel@student.kuleuven.ac.Be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200311221911.58773.blaisorblade_spam@yahoo.it>
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
Date: Sat, 22 Nov 2003 19:11:58 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 23:47, gioved=EC 20 novembre 2003, Frank Dekervel ha scritto:
> Op Thursday 20 November 2003 23:32, schreef Frank Dekervel:
> > > Only an oops on linux or the same oops? If the second, it's useful ne=
ws
> >
> > the second ... exactly the same backtrace iirc. i'll try to find the
> > oops, but i'm almost sure. i've posted here to uml-devel once (subject
> > hostfs-crash i believe) but google cannot find it.
> >
> > > In fact, I'm seeing now 4:40, the time the oops happens, is when the
> > > slackware every day runs updatedb.
> >
> > a-ha ! exactly the same, my oops also happent when doing updatedb...
>
> my original post was here
> http://sourceforge.net/mailarchive/forum.php?thread_id=3D2984656&forum_id=
=3D364
>8
By the way, try the archive at http://marc.theaimsgroup.com/, it's commonly=
=20
believed to be better than the sourceforge one... However don't worry, I=20
found the post.
>
> but contrary to what i tought, it is not exactly the same oops.
There is also a filldir64 trace, or better EIP points into it. But then=20
filldir64 should also appear in the trace.
>  Trace; c0149048 <sys_getdents+90/98>
>  Trace; c0139ea4 <sys_read+5c/100>
>  Trace; c01089f3 <system_call+33/38>
> if ksymoops is right. i also sent it to lkml, without response. And i was
> also using tmpfs then (for uml memory as described in howto)
I.e. your /tmp was under tmpfs? That may explain the fact that the oops is =

different.

However, I think the call trace is wrong, (below I explain why), so if you =
are=20
able to reproduce the bug, this would be great.
Thanks!

However, I've looked at 2.4.22 sources, and either the related functions we=
re=20
almost rewritten, or the ksymoops output is bodged. sys_getdents doesn't ca=
ll=20
filldir64; it calls vfs_readdir(and this could actually be inlined, but it =

wouldn't get at the 90/98 position inside sys_getdents), but then it does a=
=20
call to a readdir "method"(i.e. through a function pointer, so this can't b=
e=20
inlined and must appear in the trace) and then it does another call, which =

could be to filldir64, through a function pointer. You said maybe you didn'=
t=20
copy all the output of ksymoops, but the stack trace is never more than 3=20
calls. I'll maybe check by disassembly if the output makes sense in that=20
point, though this is not very meaningful if not done on the original vmlin=
ux=20
file.
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
