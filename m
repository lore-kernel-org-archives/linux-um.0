Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfNKa-0006ge-C1 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:27:44 -0700
Received: from mta13.mail.adelphia.net ([68.168.78.44] helo=mta13.adelphia.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BfNKZ-0005xt-TU for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:27:44 -0700
Received: from mizar.alcor.net ([69.167.148.207]) by mta13.adelphia.net
	(InterMail vM.6.01.03.02 201-2131-111-104-20040324) with ESMTP
	id <20040629182735.GBFV14365.mta13.adelphia.net@mizar.alcor.net>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 29 Jun 2004 14:27:35 -0400
Received: from mdz by mizar.alcor.net with local (Exim 4.34)
	id 1BfNKR-0004Jo-Nw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:27:35 -0700
Resent-Message-ID: <20040629182735.GN5243@alcor.net>
Resent-To: user-mode-linux-devel@lists.sourceforge.net
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] Re: Bug#254665: uml-utilities: uml_moo produces
	broken images (short one block)
Message-ID: <20040629182314.GL5243@alcor.net>
References: <200406160822.i5G8Mba1020376@cluon.it.bond.edu.au>
	<20040628010443.GD5243@alcor.net>
	<200406291741.47115.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <200406291741.47115.blaisorblade_spam@yahoo.it>
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
Date: Tue, 29 Jun 2004 11:23:14 -0700
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux@lists.sourceforge.net, Alexander Zangerl <az@debian.org>, 254665-forwarded@bugs.debian.org

On Tue, Jun 29, 2004 at 05:41:47PM +0200, BlaisorBlade wrote:

> Alle 03:04, luned=EC 28 giugno 2004, Matt Zimmerman ha scritto:
> > On Wed, Jun 16, 2004 at 06:22:37PM +1000, Alexander Zangerl wrote:
> > > Package: uml-utilities
> > > Version: 20020415-3
> SO old?
> > > Severity: normal
>=20
> > > i've got some ext2 fs images, normal cow-files, and the need to recom=
bine
> > > them. but the resulting file is one 1k-block shorter than the origina=
l,
>=20
> One question: since that bug is repeatable, could you try updating your=20
> uml-utilites? I don't have the sources for those ones (if the "2002" is=20
> correct). At http://user-mode-linux.sourceforge.net/dl-ists.html you can =
find=20
> later ones.

Version 20040406 is available in Debian testing and unstable.  20020415 is
from Debian stable (woody), released July 2002.

--=20
 - mdz


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
