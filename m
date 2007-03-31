Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXeOQ-0007Bk-O7 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Mar 2007 07:17:22 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HXeOL-0001GS-UO
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Mar 2007 07:17:22 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 31 Mar 2007 16:17:08 +0200
References: <20070328020247.GA12299@c2.user-mode-linux.org>
	<200703290236.44324.blaisorblade@yahoo.it>
	<20070329182920.GB8065@c2.user-mode-linux.org>
In-Reply-To: <20070329182920.GB8065@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703311617.09082.blaisorblade@yahoo.it>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On gioved=EC 29 marzo 2007, Jeff Dike wrote:
> On Thu, Mar 29, 2007 at 02:36:43AM +0200, Blaisorblade wrote:
> > > Sometimes you need to. I'd probably just remove the do_ubd check and
> > > always recall the request function when handling completions, it's
> > > easier and safe.
>
> If I'm understanding this correctly, this is what happens now.  There
> is still the flag check and return if the queue is being run, but I
> don't see the advantage of removing that.
Possibly he just didn't understood what do_ubd was for, maybe there's some =

technical reason.

> That's a lot of mapping and unmapping though.  I wonder if just
> calling mmap would cause the COWed page to be dropped...
Yes, it would.
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

