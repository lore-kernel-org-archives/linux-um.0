Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyFFU-0006aS-Rz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 11:08:12 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AyEkp-00068f-6x for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 10:36:31 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] UNIX socket networking
References: <200402290158.54770.jdizzl@xs4all.nl>
	<200402291813.09174.petschge@gmx.de>
	<20040301201438.DE4903BCB7@home.petschge.de>
In-Reply-To: <20040301201438.DE4903BCB7@home.petschge.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200403021909.47013.blaisorblade_spam@yahoo.it>
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
Date: Tue, 2 Mar 2004 19:09:46 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Patrick Kilian <petschge@gmx.de>

Alle 21:14, luned=EC 1 marzo 2004, Patrick \ ha scritto:

> >> Problem 3.) I can only create sockets in the "anonymous" namespace.
> >> The normal namespace gives me some error which I don't rememeber
> >> right now but I could find out what th errorcode was.

Ok - I found what the anonymous namespace is (your refer to the "abstract" =

namespace described in man 7 unix).

> Well bind is returning -2 which seams to be -ENOENT. Does somebody know w=
hy
> this happens?

Hmm, I'm no expert with sockets; possibly the folder in which you create th=
e=20
socket does not exist. However, possibly code it like a normal program whic=
h=20
just opens the socket and calls bind() and try it.

However, posting the code would be *very* helpful ... do not be shy!

> >> I guess the "normal" namespace is PF_LOCAL.
> >
> >IIRC yes.
>
> I use PF_UNIX in the code. But that should be the same as PF_LOCAL.

Yes, that is true (checked /usr/include/bits/socket.h).

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
