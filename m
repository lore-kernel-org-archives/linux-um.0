Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTG9i-0005vG-IM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 01:22:26 -0700
Received: from smtp6.wanadoo.fr ([193.252.22.25] helo=mwinf0601.wanadoo.fr)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BTG9h-0004Dj-VF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 01:22:26 -0700
Subject: Re: [uml-devel] [PATCH] host context switch reduction
From: Laurent Vivier <LaurentVivier@wanadoo.fr>
In-Reply-To: <006f01c443b2$29434290$0201a8c0@hawk>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
	<1084831251.1230.4.camel@chartreuse>
	<03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>
	<20040518175904.GB29114@ccure.user-mode-linux.org>
	<1084987654.2250.4.camel@chartreuse>
	<006f01c443b2$29434290$0201a8c0@hawk>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rK1FzZ4lYoVFRL0t0kAo"
Message-Id: <1085646154.1264.6.camel@chartreuse>
Mime-Version: 1.0
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
Date: Thu, 27 May 2004 10:22:36 +0200
To: "Christopher S. Aker" <caker@theshore.net>
Cc: user-mode-linux-devel@lists.sourceforge.net



--=-rK1FzZ4lYoVFRL0t0kAo
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Le jeu 27/05/2004 =E0 08:16, Christopher S. Aker a =E9crit :
> Hello Laurent,
>=20
> Thanks you for the performance patches.  I'm looking forwarding to testin=
g them,
> but ran into a snag while patching 2.4.24-um.
>=20
> http://perso.wanadoo.fr/laurent.vivier/UML/um-sysemu-2.4.24-1.patch
>=20
> Looks like it's against 2.4.22.  The patch is somewhat mangled, but once =
I get
> around the rejects, I still get...
>=20

It's effectively a patch for 2.4.22. Sorry. I correct the typo on the
web page.
I create a new patch for 2.4.26 (do you really want 2.4.24 ???)

> Checking syscall emulation patch for ptrace...missing
> Kernel panic: check_ptrace : child exited with status 0x100
> In idle task - not syncing
>=20
> ...on a host that doesn't have the sysemu patch.  It does run correctly o=
n a host
> with the sysemu patch.  I believe the 2.4-um sysemu patch needs updating,=
 because
> a few months back when I tried your first set of patches I received the s=
ame
> thing.
>=20
> Care to post a more recent 2.4-um sysemu patch for UML?
>=20
> Thanks!
> -Chris

--=20
                   Laurent Vivier
+------------------------------------------------+
     "Any sufficiently advanced technology is=20
indistinguishable from magic." -- Arthur C. Clarke

--=-rK1FzZ4lYoVFRL0t0kAo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAtaVKbmJwdIv5dzMRAkATAJwOfgGaFkV6CpwuLinzqZTbRLmOEACcC/Ys
VOp2SazGrYyy3BStBfMlyQE=
=GVnQ
-----END PGP SIGNATURE-----

--=-rK1FzZ4lYoVFRL0t0kAo--



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
