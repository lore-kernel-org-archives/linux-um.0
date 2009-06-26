Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sfr@canb.auug.org.au>) id 1MK2qb-0006np-Jp
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jun 2009 04:15:33 +0000
Received: from chilli.pcug.org.au ([203.10.76.44] helo=smtps.tip.net.au)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MK2qX-0003Lj-IG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jun 2009 04:15:33 +0000
Date: Fri, 26 Jun 2009 14:15:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Message-Id: <20090626141515.c45bb6bf.sfr@canb.auug.org.au>
In-Reply-To: <20090626024802.GA17655@c2.user-mode-linux.org>
References: <20090620005524.25582.69677.stgit@menage.mtv.corp.google.com>
	<4A3F4448.30502@panasas.com>
	<20090622085735.GB6499@cr0.nay.redhat.com>
	<20090622205226.fee30ba8.sfr@canb.auug.org.au>
	<20090625104901.GG6374@cr0.nay.redhat.com>
	<20090625145155.GA6383@c2.user-mode-linux.org>
	<20090626120111.ef8622ba.sfr@canb.auug.org.au>
	<20090626024802.GA17655@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH] UML: Fix some apparent bitrot
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5655212670627196091=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Amerigo Wang <xiyou.wangcong@gmail.com>, akpm@linux-foundation.org

--===============5655212670627196091==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__26_Jun_2009_14_15_15_+1000_Pj9QeQ_=DAHHBFON"

--Signature=_Fri__26_Jun_2009_14_15_15_+1000_Pj9QeQ_=DAHHBFON
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Thu, 25 Jun 2009 22:48:02 -0400 Jeff Dike <jdike@addtoit.com> wrote:
>
> defconfig is good - that's my normal test config.
>=20
> > Currently plain "make ARCH=3Dum" on PowerPC doesn't appear to work.
>=20
> No, it won't.

OK, thanks.

For reference, the result of our nightly builds (for UML) can be found
here: http://kisskb.ellerman.id.au/kisskb/compiler/26/ (we are only
building Linus' tree and linux-next).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__26_Jun_2009_14_15_15_+1000_Pj9QeQ_=DAHHBFON
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpES1MACgkQjjKRsyhoI8yraQCeKuG0jrFEhCDYQ4o/QgTKB2Ws
KB0AnAivvTrLAEdWls/QFbatWyPQjZaa
=SB9W
-----END PGP SIGNATURE-----

--Signature=_Fri__26_Jun_2009_14_15_15_+1000_Pj9QeQ_=DAHHBFON--


--===============5655212670627196091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============5655212670627196091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5655212670627196091==--


