Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3fie-00025L-FC	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 13:01:32 -0700
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E3fid-0005d1-S4
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 13:01:32 -0700
From: leslie.polzer@gmx.net
Message-ID: <20050812200118.GA8508@paktahn.black.cat>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
Subject: [uml-devel] Hang at delay loop calibration
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
Date: Fri, 12 Aug 2005 22:01:18 +0200
To: user-mode-linux-devel@lists.sourceforge.net


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

% linux
Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid =3D 8456
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Linux version 2.4.26-1um (root@aries) (gcc version 3.4.0) #1 Sat Jul 3 00:2=
2:45 PDT 2004
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/ubd0
Calibrating delay loop...

[ stays here indefinitely until killed ]

% uname -a
Linux paktahn 2.6.12-RT-V0.7.51-33-ARCH #1 SMP Mon Jul 25 15:35:17 CEST 200=
5 i686 AMD Athlon(tm) XP 2400+ AuthenticAMD GNU/Linux

This is a 2.6.12 with realtime-preempt patch.

Leslie


--=20
PGP-KID: 0x52D70289

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFC/QAOn/ep3VLXAokRAie6AJoCV2oZpxp+Q7ePIUfSKbkogrlvNQCaA0ak
Fwki7r4+XekF166gD7OGvDo=
=4BRM
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
