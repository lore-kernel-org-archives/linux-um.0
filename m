Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfNir-0008Ge-1K for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:52:49 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BfNiq-00013p-GC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:52:48 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Bug#254665: uml-utilities: uml_moo produces
	broken images (short one block)
References: <200406160822.i5G8Mba1020376@cluon.it.bond.edu.au>
	<20040628010443.GD5243@alcor.net>
In-Reply-To: <20040628010443.GD5243@alcor.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200406292044.06050.blaisorblade_spam@yahoo.it>
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
Date: Tue, 29 Jun 2004 20:44:06 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 03:04, luned=EC 28 giugno 2004, Matt Zimmerman ha scritto:
> On Wed, Jun 16, 2004 at 06:22:37PM +1000, Alexander Zangerl wrote:
> > Package: uml-utilities
> > Version: 20020415-3
SO old?
> > Severity: normal

> > i've got some ext2 fs images, normal cow-files, and the need to recombi=
ne
> > them. but the resulting file is one 1k-block shorter than the original,

One question: since that bug is repeatable, could you try updating your=20
uml-utilites? I don't have the sources for those ones (if the "2002" is=20
correct). At http://user-mode-linux.sourceforge.net/dl-ists.html you can fi=
nd=20
later ones. Note: don't replace the old ones if you have a old UML binary, =

since newer utilities could not work with it (but you're strongly suggested=
=20
to upgrade to 2.4.24-1um Uml kernel, not more since newer patches have bugs=
).

If the bug shows up again, I have one question: I need to know if, on the f=
s=20
holding the image, the block size is 1k? The size to use for COW blocks is =

read from the filesystem.

> > and doesn't work at all. the original images were sparse (but that
> > shouldn't make any difference, IMHO).
Yes, that cannot make difference.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
