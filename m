Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CgviK-0008VZ-Ea for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Dec 2004 17:54:56 -0800
Received: from ctron-dnm.enterasys.com ([12.25.1.120] ident=firewall-user)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CgviH-00069n-Ne for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Dec 2004 17:54:56 -0800
Received: (from uucp@localhost)
	by ctron-dnm.enterasys.com (8.8.7/8.8.7) id VAA01515
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 21 Dec 2004 21:00:16 -0500 (EST)
Message-ID: <41C8D3BF.6070609@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE87BDC1D1B10D44F766BC3C2"
Subject: [uml-devel] 2.4 series include path confusion
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
Date: Tue, 21 Dec 2004 20:54:07 -0500
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE87BDC1D1B10D44F766BC3C2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

so, trying to build 3rd party tools against the UML kernel headers and run into 
things like "can't find sysdep/ptrace.h"

poking around a bit - i wonder why there are headers under the arch/um/include 
directory when we have a perfectly good seperate include/asm-um area to play in?

things that want to build against a set of kernel headers shouldn't know about the 
arch, right? they should be able to follow UML include paths that are setup during 
the build stage that does the soft linking of asm and such.

unimportant compared to the scope of 2.6 work i understand, but i thought i'd 
bring it up and see if you think i'm way off my rocker or if i have a point.

thank you all for keeping at it.
-- 
db

--------------enigE87BDC1D1B10D44F766BC3C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFByNPE3XQ4zakZ3z4RAsvqAJ9iU4iU0wXEZmuyLDAh54xyNrXWFgCePTSX
HMR9YdTmSqjD+ZD2wvgPxfk=
=kg4w
-----END PGP SIGNATURE-----

--------------enigE87BDC1D1B10D44F766BC3C2--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
