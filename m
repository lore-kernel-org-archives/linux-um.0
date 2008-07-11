Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KHEEL-0000aN-Ko for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Jul 2008 01:43:53 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1KHEEI-0003ZZ-1V
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Jul 2008 01:43:53 -0700
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Fri, 11 Jul 2008 10:43:32 +0200
References: <200807101619.54052.toralf.foerster@gmx.de>
	<200807102010.02772.toralf.foerster@gmx.de>
	<20080710193019.GA20112@c2.user-mode-linux.org>
In-Reply-To: <20080710193019.GA20112@c2.user-mode-linux.org>
MIME-Version: 1.0
Message-Id: <200807111043.39103.toralf.foerster@gmx.de>
Subject: Re: [uml-devel] UML kernel failed to start betvee 2.6.8-rc8 and
	current git sources
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2027242458=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

--===============2027242458==
Content-Type: multipart/signed; boundary="nextPart1782819.mdne5nG5nl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1782819.mdne5nG5nl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

At Thursday 10 July 2008 21:30:19 Jeff Dike wrote :
> On Thu, Jul 10, 2008 at 08:09:59PM +0200, Toralf F=F6rster wrote:
> > At Thursday 10 July 2008 18:35:15 Jeff Dike wrote :
> >=20
> > > What's the host?
> >=20
> > tfoerste@n22 ~ $ uname -a
> > Linux n22 2.6.25-gentoo-r6 #4 Thu Jul 10 19:49:36 CEST 2008 i686 Intel(=
R) Pentium(R) M processor 1700MHz GenuineIntel GNU/Linux
> >=20
> > BTW,  this works fine and shows only the config :
> > n22 ~ # linux-v2.6.26-rc8-227 --showconfig=20
> >=20
> > whereas this failed:
> >=20
> > n22 ~ # linux-v2.6.26-rc9-56 --showconfig
> > Locating the bottom of the address space ... 0x0
> > Locating the top of the address space ... 0xc0000000
>=20
> OK, I believe you're seeing the same bug as Uli saw here:
>=20
>     http://marc.info/?l=3Dlinux-kernel&m=3D121011518003727&w=3D2
>=20
> More precise symptoms are here:
>=20
>      http://marc.info/?l=3Dlinux-kernel&m=3D121011722806093&w=3D2
>=20
> I never did figure that one out.  I had the same kernel version, same
> toolchain, same everything as far as I could see, and I couldn't
> reproduce it, except with a binary that he gave me.
>=20
> You're seeing it on i386, whereas he saw it on x86_64.
>=20
> The underlying problem is that somehow the UML initcalls aren't being
> run, which is why you're seeing all zeros in the register dump.
>=20
> If you bisect this, I bet you end up at the no-unit-at-a-time patch
> that he ended up at.  And I have no idea what that has to do with
> anything.
>=20
You're right :

tfoerste@n22 ~/devel/linux-2.6 $ git bisect good
4f81c5350b44bcc501ab6f8a089b16d064b4d2f6 is first bad commit
commit 4f81c5350b44bcc501ab6f8a089b16d064b4d2f6
Author: Jeff Dike <jdike@addtoit.com>
Date:   Mon Jul 7 13:36:56 2008 -0400

    [UML] fix gcc ICEs and unresolved externs

    There are various constraints on the use of unit-at-a-time:
     - i386 uses no-unit-at-a-time for pre-4.0 (not 4.3)
     - x86_64 uses unit-at-a-time always

=2E..


=2D-=20
MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

--nextPart1782819.mdne5nG5nl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkh3HTsACgkQhyrlCH22naOJqgCbBpwKVJ50hAF0Gl809pg9FJPZ
WfsAoLbYLzivf0EDIQCg8yT7ttuUMkG2
=WDhY
-----END PGP SIGNATURE-----

--nextPart1782819.mdne5nG5nl--


--===============2027242458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============2027242458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2027242458==--

