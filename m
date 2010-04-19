Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jan.kiszka@web.de>) id 1O3xIa-0001zB-2d
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2010 20:10:28 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O3xIY-0001xz-St for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2010 20:10:27 +0000
Message-ID: <4BCCB89C.50201@web.de>
Date: Mon, 19 Apr 2010 22:10:04 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <4BCB353A.3040806@web.de> <4BCB788E.2040501@kernel.org>
	<4BCC07C0.5050601@web.de>
	<alpine.LRH.2.00.1004191829220.28179@twin.jikos.cz>
In-Reply-To: <alpine.LRH.2.00.1004191829220.28179@twin.jikos.cz>
Subject: Re: [uml-devel] [PATCH] uml: Fix build breakage after slab.h changes
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8775464685783657046=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jiri Kosina <jkosina@suse.cz>
Cc: Tejun Heo <tj@kernel.org>, Jeff Dike <jdike@addtoit.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============8775464685783657046==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3640B990EB6D183C933C45CC"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3640B990EB6D183C933C45CC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jiri Kosina wrote:
> On Mon, 19 Apr 2010, Jan Kiszka wrote:
>=20
>>> I suppose this patch will go through um tree?
>> Good question. Does such a tree exist? I'm sitting on a few more um
>> cleanups & fixes, and so far I'm working against Linus' tree as I fail=
ed
>> to find anything more recent.
>=20
> If these are simple-enough cleanups and/or compile fixes, feel free to =

> send them to trivial@kernel.org.
>=20

Some are trivial, but most aren't. Will check if I can split the formers
out, but I guess it's simpler to keep the queue.

Thanks,
Jan


--------------enig3640B990EB6D183C933C45CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvMuJwACgkQitSsb3rl5xTajQCffeqqvI2VVy7tWiANpP9xlRhY
qYMAoJ6DnahHr/Y0EFjb4dUATx0ZSrAs
=OPAM
-----END PGP SIGNATURE-----

--------------enig3640B990EB6D183C933C45CC--


--===============8775464685783657046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============8775464685783657046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============8775464685783657046==--


