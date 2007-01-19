Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H7wlG-0005tv-4U for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Jan 2007 08:38:42 -0800
Received: from nemesis.fprintf.net ([66.134.112.218])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H7wlD-0003Bh-A5
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Jan 2007 08:38:42 -0800
From: Daniel Gryniewicz <dang@gentoo.org>
In-Reply-To: <45B0EE71.5040908@nagafix.co.uk>
References: <200701171715.35504.blaisorblade@yahoo.it>
	<45AE684D.7070802@theshore.net> <45AE67C0.5080003@nagafix.co.uk>
	<45AE7DFC.9050704@nagafix.co.uk>  <45B0A4B7.7050702@nagafix.co.uk>
	<1169222858.11134.52.camel@athena.fprintf.net>
	<45B0EE71.5040908@nagafix.co.uk>
Date: Fri, 19 Jan 2007 11:38:22 -0500
Message-Id: <1169224702.11134.71.camel@athena.fprintf.net>
Mime-Version: 1.0
Subject: Re: [uml-devel] buggy UML AMD64?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1323721392=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net


--===============1323721392==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-sBWEStH1fTkS6uaOIqEN"


--=-sBWEStH1fTkS6uaOIqEN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-01-19 at 16:14 +0000, Antoine Martin wrote:
> Daniel Gryniewicz wrote:
> > I'm the gentoo usermode-sources maintainer, and I run UML almost
> > exclusively on amd64.  I have, at any given time, from 4 to 20 UMLs
> > running on my main dev box, most of them 32-bit, and I haven't had any
> > stability problems.
> Can you send me more details of your setup as I am quite experienced=20
> with UML and now completely stuck with AMD64.
>=20
> > Is your RAM OK?
> Oh yes, this has nothing to do with the hardware.
>=20
> > Which kernels do you have inside and outside?
> Host (outside):
> 2.6.19.2-skas3-v8.2

Okay, that's one big difference.  I have a stock kernel (well,
gentoo-sources) on the outside, not a SKAS3 patched kernel.  Maybe that
makes a difference on amd64?

> Inside: pick any of those (none of them work with >=3D2.6.16):
> http://uml.nagafix.co.uk/
>=20
> >  How are
> > you trying to build the 32-bit UMLs?
> These are the same as on the site above (which I maintain) and these=20
> have worked flawlessly for a long long time.
>=20
> I have downgraded the x86 boxes to 2.6.15.7 and these are up and running=20
> again. But I can't do that for all of them, and this is just not an=20
> option for some of the amd64 boxes.

My setup is:

Host boxes:
	- Dual dual-core opteron 265 with 6GB of RAM running 2.6.17-gentoo-r8
	- Turion laptop with 2GB of RAM running currently 2.6.20-rc5 (stock)
but most recently 2.6.19-ck1 (stock).
	- Athlon64 3000+ with 1GB of RAM running ck-sources-2.6.19_p2-r3
Notice, no UML related patches on the host boxes.

UML Boxes:
	- usermode-sources-2.6.16-r6 (2.6.16 with genpatches 15 and -bs2)
	- usermode-sources-2.6.18-r1 (2.6.18 with genpatches 8 and -bb2)
	- Modified usermode-sources-2.6.14-r6 (2.6.14 with -bs3 and networking
patches for work) (this one also runs on 32-bit hosts running various
gentoo kernels on workstations at work)

All of these run some form of Gentoo inside; not necessarily recent.
Each of them runs in both 32 and 64 bit versions. I have also briefly
run a UML with a fedora core 2 image, running a usermode-sources-2.6.18
kernel, on the opteron box, but that was only very briefly.  That's a
32-bit only UML.

Daniel

--=-sBWEStH1fTkS6uaOIqEN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFsPP+omPajV0RnrERAsXDAKCBS/apI/TkEPDT5Te4/9ZoBsuAGgCfbj3W
1gSN6FPVKfl4g4NZrfS1d1Y=
=SUP9
-----END PGP SIGNATURE-----

--=-sBWEStH1fTkS6uaOIqEN--



--===============1323721392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1323721392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1323721392==--

