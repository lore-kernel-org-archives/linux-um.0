Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvkNp-0007b3-BK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Feb 2004 13:46:29 -0800
Received: from napo.bezeqint.net ([192.115.104.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvkFP-00008D-BA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Feb 2004 13:37:47 -0800
Received: from napo.bezeqint.net (localhost [127.0.0.1])
	by napo.bezeqint.net (Bezeq International SMTP out Mail Server) with
	SMTP id 26501DC064 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 24 Feb 2004 23:37:35 +0200 (IST)
Received: from localhost (localhost.active.ath.cx [127.0.0.1])
	by active.ath.cx (Postfix) with ESMTP id 8F3465C82
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 24 Feb 2004 23:37:34 +0200 (IST)
Received: from active.ath.cx ([127.0.0.1])
	by localhost (active.ath.cx [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP
	id 57353-10 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 24 Feb 2004 23:37:33 +0200 (IST)
From: "Amir S." <amir@boom.org.il>
Message-ID: <20040224213733.GA32999@active.ath.cx>
Reply-To: amir@boom.org.il
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
Subject: [uml-devel] export strnlen_user_tt and strnlen_user_skas
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
Date: Tue, 24 Feb 2004 23:37:33 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

both strnlen_user_tt, and strnlen_user_skas aren't exported.

this is required for modules to use strnlen_user() function under UML.

--=20
	Amir.


--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (FreeBSD)

iD8DBQFAO8Qd6GJjqfuvOIgRAmsDAJ4sWJzPGIZDAyE66efPbFnZLC4uxgCZAYpt
qqIVNfATBMksnaZZOlge2u8=
=7elW
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
