Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By6Le-00053j-L7 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 03:10:14 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1By6Ld-0000gr-OV for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 03:10:14 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <20040504205709.GE31641@peach.ece.utexas.edu>
In-Reply-To: <20040504205709.GE31641@peach.ece.utexas.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200408051824.12958.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] kernel memory leak?
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
Date: Thu, 5 Aug 2004 18:24:12 +0200
Content-Transfer-Encoding: quoted-printable
To: Tom Brown <tdbrown@uiuc.edu>, Michael Ihde <ihde@uiuc.edu>, Peter Joanes <pjoanes@hotmail.com>, Riccardo Losselli <riccardo@e4a.it>, Nicolas <linux@1g6.biz>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

Answering to various people, all experiencing kernel memory leaks or possib=
ly=20
related problem. I'm mailing all of you to inform about the updates to the =

SKAS patch, for both 2.4 and 2.6.

I've experienced the same problem with the UML skas patch, which turned out=
 to=20
be buggy; the bug was introduced when porting it from 2.4.19 to 2.6 (and th=
is=20
patch went into the 2.4.25 version) because a micro-change in the kernel we=
nt=20
unseen. The bug happens reliably, but only in some unusual situations. So=20
when you see this email I should have uploaded the new patch to

 http://www.user-mode-linux.org/~blaisorblade/

For me the most common trigger is when starting UML from inside KDE, and I =

guess that any multi-threaded process using Thread Local Storage, TLS, woul=
d=20
suffice (I guess that GNOME is one of these); but only if you are not using=
=20
NPTL on the host; since I can find only these 4 reports, what I guess is th=
at=20
almost nobody runs UML from inside KDE.

In the first and third case(i.e. Tom Brown and Nicolas), I am sure that the=
=20
update addresses the problem (it should also solve it, report either succes=
s=20
or failure). In the other cases, I'm not sure (especially for Riccardo=20
Losselli), but anyway the update increases stability.

Alle 22:57, marted=EC 4 maggio 2004, Tom Brown ha scritto:
> I am stopping and starting a UML kernel many times and seem to observe a
> decrease in free memory space on the host as reported by top running on
> the host. There are no processes on the host showing lots of memory
> use and ps -e looks normal.

Alle 23:54, sabato 17 luglio 2004, Peter Joanes ha scritto:

> I made both host and uml use 2.6.7, using Paolo's patches (thanks again).
> The host is Gentoo, gcc version 3.3.3, and only the host kernel would
> compile, so I had to compile the uml kernel on (Mandrake 9) gcc 3.2.
>
> The problem: I've been running this setup for a while but today, four
> times, the host crashed. The last time I noticed that memory was leaking
> and acted quickly enough to shut down. I use the system every day, so the
> differences today were:

Alle 17:08, sabato 22 maggio 2004, Nicolas ha scritto:
> Hello,
>
> Here is my hostos config :
>
> fresh 2.6.6 kernel with :
>
> uml-patch-2.6.6-02
> patch-2.6.6-v2
> host+Uml-skas3-2.6.6-v1.patch
>
> I noticed a memory leak each time starting/stopping
> an uml os. (approx 7mo).

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
