Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1vYE-0000sk-VC for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Mar 2004 14:54:46 -0800
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B1vYD-00085s-Bg for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Mar 2004 14:54:45 -0800
Received: from tipau.fokus.fraunhofer.de (tipau [193.175.133.74])
	by mailhub.fokus.fraunhofer.de (8.11.6p2/8.11.6) with ESMTP id
	i2CMsgJ04649 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Mar 2004 23:54:42 +0100 (MET)
Received: from tipau.fokus.fraunhofer.de (localhost [127.0.0.1])
	by tipau.fokus.fraunhofer.de (8.12.7/8.8.8) with ESMTP id
	i2CMsbaU000860 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Mar 2004 23:54:37 +0100
Received: (from cco@localhost)
	by tipau.fokus.fraunhofer.de (8.12.7/8.12.1/Debian -1) id
	i2CMsbGa000859 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Mar 2004 23:54:37 +0100
From: Cristian CONSTANTIN <constantin@fokus.fraunhofer.de>
Message-ID: <20040312225437.GB622@terix.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
Subject: [uml-devel] noexec /tmp & uml
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
Date: Fri, 12 Mar 2004 23:54:37 +0100
To: user-mode-linux-devel@lists.sourceforge.net



--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi!

don't know if anyone else saw it / knew it before, but I found it out
the hard way...
so, my /tmp is mounted with noexec option. when I start uml (2.4.23) it
stops booting, barking like:

Kernel panic: map_memory(0xa2800000, 3, 0x8dc000, 4096, 1, 1, 1) failed,
err =3D -1

strace on the uml executable image (linux) reveals:

mmap2(0xa2800000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXE=
D, 3,
 0x8dc) =3D -1 EPERM (Operation not permitted)

it seems fd 3 points to a file somewhere in /tmp.
mounting /tmp with exec option solves the problem.

bye now!
cristian
--=20
 _          | There are many people who use UNIX or Linux =20
(_'_        | who IMHO do not understand UNIX.
  (_'rist   |              --David Korn =20
GPG public key at wwwkeys.de.pgp.net

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAUj+typNgyZIZ1MERAmVxAKCu9nA73hsRVSkJHFnpKgtFk6InogCfXW8W
il9aedjIIoSEU3wOhxjN3LY=
=sHs5
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
