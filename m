Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ma@SerNet.DE>) id 1NhfUG-0001LG-6N
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Feb 2010 08:42:24 +0000
Received: from mail.sernet.de ([193.175.80.2])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NhfUE-0002fl-Le
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Feb 2010 08:42:24 +0000
Date: Wed, 17 Feb 2010 09:05:48 +0100
From: Michael Adam <obnox@samba.org>
References: <20100217080359.GA2329804@sernet.de>
Mime-Version: 1.0
In-Reply-To: <20100217080359.GA2329804@sernet.de>
Message-Id: <E1Nheur-009mRU-Su@intern.SerNet.DE>
Subject: Re: [uml-devel] Patch: typofix in help message
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6241000324928475518=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


--===============6241000324928475518==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline


--uh9ZiVrAOUUm9fzH
Content-Type: multipart/mixed; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Crap, forgot the attachment... :-)

Michael Adam wrote:
> Hi,
>=20
> attached, find a patch to fix a typo in a help message of the
> linux binary.
>=20
> Thanks for considering.
>=20
> Cheers - Michael
>=20



--WhfpMioaduB5tiZL
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-uml-typofix-in-the-uml-help-text.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 6a2422829e2da17eb4aafbfe304a5513cd45d5fa Mon Sep 17 00:00:00 2001
=46rom: Michael Adam <obnox@samba.org>
Date: Tue, 16 Feb 2010 08:36:25 +0100
Subject: [PATCH] uml: typofix in the uml help text.

Signed-off-by: Michael Adam <obnox@samba.org>
---
 arch/um/drivers/ubd_kern.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 5ff5546..9acf704 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -442,7 +442,7 @@ __setup("udb", udb_setup);
 __uml_help(udb_setup,
 "udb\n"
 "    This option is here solely to catch ubd -> udb typos, which can be\n"
-"    to impossible to catch visually unless you specifically look for\n"
+"    impossible to catch visually unless you specifically look for\n"
 "    them.  The only result of any option starting with 'udb' is an error\=
n"
 "    in the boot output.\n\n"
 );
--=20
1.6.3.3


--WhfpMioaduB5tiZL--

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: comment

iD8DBQFLe6NZyU9JOBhPkDQRAipCAJ9YnIma7C4s2T4BbLRdniXkxESOPACaAsj2
w5e5QnyqEjaPtNOnG7Rz074=
=Hv8g
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--


--===============6241000324928475518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
--===============6241000324928475518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============6241000324928475518==--


