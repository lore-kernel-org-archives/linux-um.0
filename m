Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuZTG-00019o-2m for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Feb 2004 07:55:14 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AuZMk-0006T6-JW for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Feb 2004 07:48:30 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: 2.4.24-1um - exec-shield - [PATCH][RFC] memory
	shortness fix
References: <200402162004.i1GK4isq024309@ccure.user-mode-linux.org>
	<200402201837.13918.blaisorblade_spam@yahoo.it>
	<Pine.LNX.4.58.0402202219290.23596@vega.dur.ac.uk>
In-Reply-To: <Pine.LNX.4.58.0402202219290.23596@vega.dur.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402211651.27584.blaisorblade_spam@yahoo.it>
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
Date: Sat, 21 Feb 2004 16:51:27 +0100
Content-Transfer-Encoding: quoted-printable
To: M A Young <m.a.young@durham.ac.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 23:23, venerd=EC 20 febbraio 2004, M A Young ha scritto:
> On Fri, 20 Feb 2004, BlaisorBlade wrote:
> > The simple fix would be IMHO to add in setup_physmem:
> >
> >   offset -=3D UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);
>
> You can't do that because the memory you add to the physmem area isn't
> empty, but includes memory used for other purposes, and using memory twice
> isn't good!

Yes, you are perfectly right and what I wrote is at all foolish and stupid =
- I=20
should have written len +=3D UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);=
 (or=20
something similar).

My idea was not about increasing the allocated memory by mmaping at an earl=
ier=20
offset, but about just increasing the length.

Just like increasing physmem_size but without changing how much memory thin=
ks=20
to have: IMHO, even with 256 Mega UML can crash, if it thinks to have 260=20
mega, but it won't crash if it has 32 Mega and knows it has so little (it=20
will swap or OOM, not crash). Right?

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
