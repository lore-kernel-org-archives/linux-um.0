Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1WSy-000545-Dl for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Mar 2004 12:07:40 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B1VlN-0001Bz-Mj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Mar 2004 11:22:37 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML crashing-the known scheduler bug
References: <20040311185105.GA22820@speedy.schwinge.homeip.net>
In-Reply-To: <20040311185105.GA22820@speedy.schwinge.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200403112056.08200.blaisorblade_spam@yahoo.it>
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
Date: Thu, 11 Mar 2004 20:56:08 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Thomas Schwinge <schwinge-lists-sourceforge.net-user-mode-linux-devel@nic-nac-project.de>

Alle 19:51, gioved=EC 11 marzo 2004, Thomas Schwinge ha scritto:
> Hello!
>
> Since my current UML (linux-2.6.3 with uml-patch-2.6.3-rc2-1.bz2 and
> <URL:http://www.metaparadigm.com/~mclark/uml/uml-2.6.3-skas-1.patch>)
> is crashing reproducibly
I've given a look to the problem and I think that it has already been=20
discussed and that fixes were posted and included in next UML patch (not ye=
t=20
released). I do not have pointers at hand but search for "Kernel panic:=20
kernel BUG at kernel/exit.c:793!" to get probably something interesting.

Also, UML for now does not work well in SMP mode (and it does not actually =

parallelize the work): the spinlock messages at the beginning suggest you a=
re=20
using it.

If you have a SMP host, use for the host the SKAS patch found at:=20

http://www.user-mode-linux.org/~blaisorblade

since it has a critical fix for SMP mode.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
