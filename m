Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By7fc-0008Cb-5Z for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 04:34:56 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1By7fb-0007qz-HG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 04:34:56 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] New messages at boot with 2.6.7 kernel
References: <s107d727.063@ORANGE.OUS.EDU>
In-Reply-To: <s107d727.063@ORANGE.OUS.EDU>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200408201330.54086.blaisorblade_spam@yahoo.it>
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
Date: Fri, 20 Aug 2004 13:30:54 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anthony Brock <Anthony_Brock@ous.edu>

Alle 01:40, gioved=EC 29 luglio 2004, Anthony Brock ha scritto:
> I've started seeing the following message with a newly built kernel at
> startup of SuSE 9.1 and Debian Woody images. While the kernel appears to =
be
> functioning as expected, the messages are new. I did configure this kernel
> from scratch, so it's possible that I made a significant change to cause
> these.
They come because you enabled CONFIG_DEBUG_SPINLOCK, and show a bug standin=
g=20
since 2.5.70 at least. Anyway it causes actual problems just with SMP (whic=
h=20
does not work under UML), so for now don't worry; I already noticed this=20
problem and I'm going to fix it.

Bye
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
