Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba7Os-0005Qc-45 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 23:26:26 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Ba7E2-0003rO-Qj for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 23:15:14 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: The SKAS4 patch?? + ideas for 0 context-switch
References: <200406071949.04220.blaisorblade_spam@yahoo.it>
	<200406080455.i584tad2023374@ccure.user-mode-linux.org>
In-Reply-To: <200406080455.i584tad2023374@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200406142010.31954.blaisorblade_spam@yahoo.it>
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
Date: Mon, 14 Jun 2004 20:10:31 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 06:55, marted=EC 8 giugno 2004, Jeff Dike ha scritto:
> blaisorblade_spam@yahoo.it said:

> > In detail (skip this if you got what I mean): to do a syscall, without
> > SYSEMU  there is a CS to the guest kernel (which invalidates tons of
> > TLBs, i.e. is  the heavier of all ones) + a few instruction + the two
> > useless CS's deleted  by SYSEMU, which invalidate a very few TLB
> > entries (I think that only 1-2  pages of code + data will have be
> > accessed) + the syscall execution (using a  lot of memory) + the final
> > context switch to the userspace program, which  will now take a lot of
> > time to refill its TLB.
>
> On x86, which doesn't have tagged TLBs IIRC, there has to be a full tlb
> flush no matter how large the processes involved in the switch.

Sorry, what are tagged TLBs? x86 can flush, on some processors, just some=20
TLBs, but for process switch you must flush everything.

Or better, if "tagged TLBs" means that the processor knows with which proce=
ss=20
a TLB is associated, then I understand what you mean and agree with you.

>  What I'm
> not clear on is whether small full flushes are faster than big ones.

Ok, something more definite on this:

http://kerneltrap.org/node/view/2891

the 4G/4G patch creates a situation similar to the current one (without my =

approach) for UML - but they here speak about number-crunching, i.e. only=20
about the cost of the interrupt handler, which is ran HZ (=3D 1000) times p=
er=20
second:

"> [*] a nitpick: you keep saying '2000 tlb flushes per second'. This is
>     misleading, there's one flush of the userspace TLBs every 1 msec
>     (i.e. 1000 per second), and one flush of the kernel TLBs - but
>     the kernel TLBs are small at this point, especially with 4MB pages.

I'm saying 2000 tlb flushes only because I'd be wrong saying there are only
1000, but I obviously agree the cost of half of them is not significant (the
footprint of the irq handler is tiny)."

I.e. they (Andrea Arcangeli and Ingo Molnar) agree that the cost of a TLB=20
flush changes depending on the number of filled TLBs. And they seem to also=
=20
agree that there is a "secondary cost", the cost of the TLB misses (which i=
s=20
IMHO the one which changes depending on how much entries you flush).

See also the benchmark I post (host vs UML with SYSEMU), which show that th=
ere=20
is an doubling in user time due to executing getpid() vs non executing it, =

while looping over 64 pages (64 pages should mean that the TLB never faults=
):=20
the increase in user time, which is spent mostly by looping onto pages, is =

due to the TLB misses.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
