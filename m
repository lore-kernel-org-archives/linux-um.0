Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bxd3M-0005op-VH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 19:53:24 -0700
Received: from ctron-dnm.enterasys.com ([12.25.1.120] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bxd3K-0005vB-Dz for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 19:53:24 -0700
Received: (from uucp@localhost)
	by ctron-dnm.enterasys.com (8.8.7/8.8.7) id WAA00931
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 18 Aug 2004 22:57:23 -0400 (EDT)
Message-ID: <412415B0.5060102@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0A9BCEB6EA358D0B70555F47"
Subject: [uml-devel] mem= and large file support
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
Date: Wed, 18 Aug 2004 22:51:28 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A9BCEB6EA358D0B70555F47
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


btw: with the 26-3um and 2.6.8.1 announce Jeff mentions the
new SKAS, ! TT, STATIC allows mem= ~2.75G upper limit but do
we need O_LARGEFILE somewhere? or to compile with -D_FILE_OFFSET_64_BITS

[u2](dbahi)277$ ulimit -f
unlimited

linux umid=uml_1 ubd0=/local/umltest/cow/ubd0_1,/local/dbahi/root_fs.rh-9-full 
ubd1=/local/umltest/cow/ubd1_1,/local/dbahi/swap_fs.256 root=/dev/ubd/0 
uml_dir=/local/umltest/umldir hostfs=/local/umltest/hostfs/host_1 mem=2048M 
eth0=daemon,fe:fd:00:00:00:1,unix,/local/umltest/pipe
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
File size limit exceeded

thank you.

--------------enig0A9BCEB6EA358D0B70555F47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBJBWw3XQ4zakZ3z4RAoPkAJ41lKdTbQ+1COASXSw/iayZnQn26gCfRAn1
D+wkzcIhj0g8qBS5iVipA6A=
=ZJeB
-----END PGP SIGNATURE-----

--------------enig0A9BCEB6EA358D0B70555F47--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
