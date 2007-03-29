Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWido-0006PC-H7 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 17:37:24 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HWidm-0007LY-Lm
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 17:37:24 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 29 Mar 2007 02:36:43 +0200
References: <20070328020247.GA12299@c2.user-mode-linux.org>
In-Reply-To: <20070328020247.GA12299@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703290236.44324.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] UML - fix I/O hang when multiple devices
	are in use
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>

On mercoled=EC 28 marzo 2007, Jeff Dike wrote:
> [ This patch needs to get into 2.6.21, as it fixes a serious bug
> introduced soon after 2.6.20 ]
>
> Commit 62f96cb01e8de7a5daee472e540f726db2801499 introduced per-devices
> queues and locks, which was fine as far as it went, but left in place
> a global which controlled access to submitting requests to the host.
> This should have been made per-device as well, since it causes I/O
> hangs when multiple block devices are in use.
>
> This patch fixes that by replacing the global with an activity flag in
> the device structure in order to tell whether the queue is currently
> being run.
Finally that variable has a understandable name. However in a mail from Jen=
s=20
Axboe, titled:
"Re: [uml-devel] [PATCH 06/11] uml ubd driver: ubd_io_lock usage fixup" , w=
ith=20
Date: Mon, 30 Oct 2006 09:26:48 +0100, he suggested removing this flag=20
altogether, so we may explore this for the future:

> > Add some comments about requirements for ubd_io_lock and expand its use.
> >
> > When an irq signals that the "controller" (i.e. another thread on the
> > host, which does the actual requests and is the only one blocked on I/O
> > on the host) has done some work, we call again the request function
> > ourselves (do_ubd_request).
> >
> > We now do that with ubd_io_lock held - that's useful to protect against
> > concurrent calls to elv_next_request and so on.
>
> Not only useful, required, as I think I complained about a year or more
> ago :-)
>
> > XXX: Maybe we shouldn't call at all the request function. Input needed =
on
> >  this. Are we supposed to plug and unplug the queue? That code
> > "indirectly" does that by setting a flag, called do_ubd, which makes the
> > request function return (it's a residual of 2.4 block layer interface).
>
> Sometimes you need to. I'd probably just remove the do_ubd check and
> always recall the request function when handling completions, it's
> easier and safe.

Anyway, the main speedups to do on the UBD driver are:
* implement write barriers (so much less fsync) - this is performance kille=
r=20
n.1

* possibly to use the new 2.6 request layout with scatter/gather I/O, and=20
vectorized I/O on the host
* while at vectorizing I/O using async I/O

* to avoid passing requests on pipes (n.2) - on fast disk I/O becomes=20
cpu-bound.
To make a different but related example, with a SpeedScale laptop, it's=20
interesting to double CPU frequency and observe tuntap speed double too.=20
(with 1GHz I get on TCP numbers like 150 Mbit/s - 100 Mbit/s, depending=20
whether UML trasmits or receives data; with 2GHz double rates).
Update: I now get 150Mbit / 200Mbit (Uml receives/Uml sends) at 1GHz, and=20
still the double at 2Ghz.
This is a different UML though.

* using futexes instead of pipes for synchronization (required for previous=
=20
one).

--=20
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

