Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BWPYd-0006sB-JX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Jun 2004 18:01:11 -0700
Received: from mta11.adelphia.net ([68.168.78.205])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BWPYd-0005sV-AE for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Jun 2004 18:01:11 -0700
Received: from mizar.alcor.net ([69.167.148.207]) by mta11.adelphia.net
	(InterMail vM.5.01.06.08 201-253-122-130-108-20031117) with ESMTP
	id <20040605010104.QXYB21898.mta11.adelphia.net@mizar.alcor.net>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 4 Jun 2004 21:01:04 -0400
Received: from mdz by mizar.alcor.net with local (Exim 4.34)
	id 1BWPYV-0008Mj-N3 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Jun 2004 18:01:03 -0700
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20040605010103.GA32113@alcor.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
Subject: [uml-devel] [PATCH] More hostfs breakage
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
Date: Fri, 4 Jun 2004 18:01:03 -0700
To: user-mode-linux-devel@lists.sourceforge.net



--Bn2rw/3z4jIqBvZU
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline



--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Even after applying Henrik's patches, hostfs was still not working for me.
I tracked the problem down to this; I'm not exactly sure why it works this
way (why does it always try to open the file read/write first?), but this
got it working again for me so far.

If this is really the right way to go about this, then it needs to check for
other things as well (EROFS?), but it doesn't seem right...

--=20
 - mdz

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hostfs-perms.diff"

--- kernel-source-2.4.25/arch/um/fs/hostfs/host_fs.c~	2004-06-04 17:56:52.000000000 -0700
+++ kernel-source-2.4.25/arch/um/fs/hostfs/host_fs.c	2004-06-04 17:59:04.000000000 -0700
@@ -146,7 +146,7 @@
 	    kfree(fh);
 	    return NULL;
 	}
-	if (err == -EPERM)
+	if (err == -EPERM || err == -EACCES)
 	    err = host_open_file(path, 1, 0, fh);
 	if(err)
 		goto out_free;

--sm4nu43k4a2Rpi4c--

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAwRtPArxCt0PiXR4RAtNhAJ93d6YAvM4Mh8Gh7CV+Ot/8GWDxswCfZuQE
kzyajpEa+38zXUtZCf3/aLk=
=S6dJ
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
