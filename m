Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdaAN-0007Az-C5 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 11:13:31 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AdaAM-0005vg-Mj for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 11:13:30 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [UML combo patch] uml-combo-2.6.0-A7
References: <Pine.LNX.4.58.0312171735540.8123@earth>
	<200401021929.54997.blaisorblade_spam@yahoo.it>
	<20040105101117.GA23694@elte.hu>
In-Reply-To: <20040105101117.GA23694@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401052013.42258.blaisorblade_spam@yahoo.it>
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
Date: Mon, 5 Jan 2004 20:13:41 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 11:11, luned=EC 5 gennaio 2004, Ingo Molnar ha scritto:
> * BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
> > Two questions:
> > 1) I've added the G-03(this fixes the empty /proc/kallsyms issue), H-03
> > and H-04(for Makefiles cleanups) patches. Would you try them?
>
> i'll try these too. Your bugfixes/collections are now perfectly fine for
> 2.6.0 UML experimentation so i'll use them instead of spinning my own
> ones. (your ones are also better split up.)

Thanks, my first purpose has in fact been to make it ready for inclusion in=
=20
mainline, and I've finally replaced the A-03 and A-04 patches, which couldn=
't=20
be accepted probably.

> > 2)Have you given a look to the mm/memory.c change (what I'd split into
> > A-04)?  Do you think that change can be safe even for the host kernel?
>
> tricky stuff - hand-building vmas is fragile like hell, and the vsyscall
> stuff is far from simple too. What is the main purpose of your change?

It wasn't a change that *I* did. I just found that change inside the patch =

from Jeff Dike, and I separated it because I thought it was a bit risky for=
=20
the host, but I wasn't able to replace it. In fact I've always been warning=
=20
"apply that for UML and remove it for the host", even when I didn't=20
understand it.

In fact now I've posted the B-02 patch which replaces it; for a complete=20
description of the replacement, see the message (in this ML)"Replacement of=
=20
A-04 patch for mm/memory.c for UML/2.6".

However, I just think that while mainstream kernel changed that piece of co=
de=20
from using FIXADDR_ to using FIXADDR_USER_, Jeff simply forgot to do this; =

the patch was meant just to fix compilation (FIXADDR_USER_START is not a=20
compile-time constant for UML, so you can't compile mm/memory.c without a=20
patch).

In fact, in older UML patches, the kernel code *did* use FIXADDR_START and =
the=20
patch didn't change what the code did.

Also, for what I understand (I do want to be corrected if I'm wrong), the=20
interested piece of code allows a user-space process to execute the vsyscal=
l=20
stub code, but it must not allow anything else to go in the process address=
=20
space.

Bye and thanks for the interest!
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
