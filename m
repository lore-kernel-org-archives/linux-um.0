Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By7vR-0001dj-P2 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 04:51:17 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1By7vP-0002Eh-38 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 04:51:17 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: handle_trap - failed to wait at end of syscall [was Re:
	[uml-devel] debugging UML cores]
References: <200408120541.i7C5faJd010923@ccure.user-mode-linux.org>
	<411CE23C.4070903@nortelnetworks.com>
	<200408132147.i7DLlB2o003883@ccure.user-mode-linux.org>
In-Reply-To: <200408132147.i7DLlB2o003883@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200408201346.53688.blaisorblade_spam@yahoo.it>
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
Date: Fri, 20 Aug 2004 13:46:53 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Joe Marzot <gmarzot@nortelnetworks.com>

Alle 23:47, venerd=EC 13 agosto 2004, Jeff Dike ha scritto:
> gmarzot@nortelnetworks.com said:
> > WSTOPSIG(err) =3D SIGHUP
> > does this give any clues...any ideas of what else to look at?
>
> Do you have any idea how you're making this happen?  The userspace process
> is getting a SIGHUP in the middle of having a system call nullified.  This
> is OK since a SIGHUP can happen any time if you log out on it or somethin=
g,
> but I'd like to know exactly what's going on so I can decide what the rig=
ht
> reaction to it is.
I'm getting a similar problem, in another situation. With my current tree (=
but=20
also any 2.6.7-bb should do; but you can test it on -bb4, to be sure), on a=
=20
2.6.7 host with host-skas3-2.6.7-v2.patch (notice -v2, it contains SYSEMU) =

(never got this on 2.4 host, but I'll retest), if I do "echo 0=20
> /proc/sysemu" I get the same failure, but with 2943 as status (i.e.=20
WSTOPSIG=3DSIGSEGV) and EINTR as errno (but I think that's from a previous =

loop, since I've applied the catch-EINTR patch; i.e. probably it did the=20
syscall, it was interrupted, and did the syscall again which returned SIGSE=
GV=20
as stop status). And this is definitely reproducible with echo 0=20
> /proc/sysemu. But when booting with nosysemu, it works, and I can even=20
reenable it with echo 1 > /proc/sysemu; but if I try disabling it again, I =

get the same problem.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
