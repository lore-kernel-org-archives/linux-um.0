Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Azw4s-00064Z-TV for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Mar 2004 03:04:14 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Azvpe-0000tT-P3 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Mar 2004 02:48:30 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip 0x400e51a4
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<200403040216.i242G1Wo009026@ccure.user-mode-linux.org>
	<Pine.LNX.4.58.0403041007440.24549@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.58.0403041007440.24549@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200403071154.07717.blaisorblade_spam@yahoo.it>
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
Date: Sun, 7 Mar 2004 11:54:07 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Alle 03:19, gioved=EC 4 marzo 2004, Jeff Chua ha scritto:
> I'm on 2.6.3 and uml-patch-2.6.3-rc2 + 00-2.6.2-v1-host-SKAS2 no longer
> has this problem.

Better: it does not *yet* have it. That came from a patch in 2.4 not put in=
=20
2.6 that fixed the Oops on cat /dev/kmem. In the new patch that has been=20
replaced.

However, I am *sure* that this is the same thing: indeed, when I said "some=
one=20
had problems" I referred to exactly *this* ones.
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
