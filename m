Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Atskh-00065Z-Tv
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 10:18:23 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AtsXE-0003Xf-K3
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 10:04:28 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] 2.6.3-rc2-uml1 Kernel mode panic
References: <Pine.LNX.4.44.0402181635060.15836-100000@sparrow>
In-Reply-To: <Pine.LNX.4.44.0402181635060.15836-100000@sparrow>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402191914.01209.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 19 Feb 2004 19:14:01 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, William Stearns <wstearns@pobox.com>

Alle 22:56, mercoled=EC 18 febbraio 2004, William Stearns ha scritto:
> Good afternoon, all,
>

>
> 	On a kernel using Jeff's patch from 2/16, which looks absolutely
> identical to yours,=20

Yes, I just reposted it to roland, but it was the same.

> 20 of these running in the background * produces:
> Kernel panic: Kernel BUG at kernel/exit.c:793
> 	or
> Kernel panic: Kernel BUG at kernel/exit.c:793

If you get this with the patch applied, then the problem is very serious. I=
=20
thought the patch would have been able to fix this second part (when I got =

this, I received two panics, first the "Kernel mode fault" and then this=20
"Kernel BUG" (for more info look where it says: comments explains what=20
happens).

> Kernel panic: Segfault with no mm
> Kernel panic: Segfault with no mm
> Kernel panic: Segfault with no mm
> 	or
> Kernel mode fault at addr 0x0, ip 0x401e643e
> Kernel mode fault at addr 0x0, ip 0x401e643e
> Kernel mode fault at addr 0x0, ip 0x401e643e
> Kernel mode fault at addr 0x0, ip 0x401e643e

You said you provide the kernel at:
http://www.stearns.org/uml/

Since I'm not able to upload a kernel while you seem to have broad band, co=
uld=20
you please (if it is not already so) provide a kernel with debugging symbol=
s=20
enabled and showing this bug to Jeff Dike, since it seems he cannot reprodu=
ce=20
the bug?
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
