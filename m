Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtscL-0003uy-1H
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 10:09:45 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AtsOr-0002Kh-RD
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 09:55:49 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: 2.6.3-rc2 failure - was: Re: [uml-devel] Kernel idles in loop after loading IPv4
References: <1bf401c3f3eb$c35704f0$2000000a@schlepptopp> <200402182001.44243.blaisorblade_spam@yahoo.it> <021601c3f680$7d13eb10$2000000a@schlepptopp>
In-Reply-To: <021601c3f680$7d13eb10$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Disposition: inline
Message-Id: <200402191906.56217.blaisorblade_spam@yahoo.it>
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
Date: Thu, 19 Feb 2004 19:06:56 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 01:36, gioved=EC 19 febbraio 2004, roland ha scritto:
> hi !
>
> >If I guessed right, the attached patch will solve everything.
>
> yep - maybe - but it doesn`t seem to fix the "hang after NET: Registered
> protocol family 2" ! i applied the patch and recompiled - same effect.

Sorry - your bug is probably related to mine one, in fact the patch does no=
t=20
solve neither one. When I wrote that I didn't yet finished compiling the ne=
w=20
kernel.
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
