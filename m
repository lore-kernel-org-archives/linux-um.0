Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWNYb-00054b-LS for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 15:25:17 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CWNYa-0002va-Mj for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 15:25:17 -0800
Message-ID: <002d01c4d0eb$9d829810$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <000901c4d0e1$e7f998d0$0201a8c0@hawk>
	<200411222346.36960.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: 2.6.9-bb3 creates zombie threads in SKAS
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
Date: Mon, 22 Nov 2004 17:33:03 -0600
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

> On Monday 22 November 2004 23:23, Christopher S. Aker wrote:
> > Hello,
> Btw, question: what about your I/O token limiter? Actively using it? Could
> start being worked on for merge (there is at least one bug-report on it by
> "roland" on a strange but valid test-case).

Yes, I use it in all my kernels -- it's invaluable.to me for stopping swap-thrashing
UMLs from taking down the entire host.  What bug did Roland find?   If you want to
merge it, you probably want to add some way to turn it off completely (perhaps by
default).  I'm sure there are other improvements to be made...

> > I thought I'd give 2.6.9-bb3 a shot, and I had a bunch of users report the
> > accumulation of zombies.
> What the hell! This should *not* happen. What did we (I mean developers) do?
> > This is on a 2.6.7 host, using your
> > host-skas3-2.6.7-v1 patch.
> ??? There is a ton of bugs in that patch (see the changelogs on my site).
> Actually, it's likely you're not going to be hurt by them if you're using
> NPTL on the host (it is *hard* to get them in that case), but you'd better
> upgrade.

No doubt... I've been getting ready for The Great Reboot (38 hosts), but it takes
careful planning with that many hosts.  I've been testing a SKAS-V7 based host kernel
and things look very good.  All the weird bugs have gone away (mysql instability,
Gentoo not able to complete emerges, this is all on either V1 or V6 skas patches).
Looking forward to the upgrade to V7, and the latest CFQ changes.

> I have been releasing tons of updates, and even too quickly (most times I was
> not introducing new bugs, just fixing the ones I and Bodo Stroesser was
> finding) but -V1 is "a bit" old. That said, this should not happen.

Changes have been coming so quickly, it's hard to keep up :)

> > I'm not sure if it happened on newer host
> > kernels, since I had to revert it back quickly.
>
> Back to what? To 2.6.9-bb2 or to 2.6.9?

Vanilla 2.6.9-um

> I'll check in these days what's going on... it was hyper-tested on 2.6.9 host
> (not by me, but I trust Bodo Stroesser normally), but not on other hosts, I
> guess.

Thanks,
-Chris



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
