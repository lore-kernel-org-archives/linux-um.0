Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRxpT-0006Ll-PQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Nov 2004 11:08:27 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CRxpS-00015w-OQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Nov 2004 11:08:27 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1356586.hH1RFF5opU";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411102008.02212.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] 2.6.9-bb2 released.
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
Date: Wed, 10 Nov 2004 20:07:46 +0100
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: LKML <linux-kernel@vger.kernel.org>

--nextPart1356586.hH1RFF5opU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

You can find all on http://www.user-mode-linux.org/~blaisorblade/.

Changes in both 2.6.9-bb2 against 2.6.9-bb1:
=2D updated most bugs of -bb1 which were reported
=2D fixed the Gentoo/NPTL issue, thanks to Bodo Stroesser (sorry for forget=
ting=20
the credit on the changelog, but I'm leaving for one day in a few minutes):
but you must still compile Uml disabling CONFIG_MODE_TT (and obviously use =
the=20
SKAS patch you find on the same site).

More info on the website "Changelog" page.

Distribution (like -bb1):

* the patch are also in split-out form, both web-browsable and tarballed.
* md5sums are available (to test with "md5sum -c *.md5").

Any testing and report is welcome.

Hope It Rocks!
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--nextPart1356586.hH1RFF5opU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBkmcRqH9OHC+5NscRAhlgAJ9udAuPfVO+R1Kf90epy7CBlEqqGQCgjqty
RF9jeeKvVYk8yJ3MhwcgsC4=
=q6sS
-----END PGP SIGNATURE-----

--nextPart1356586.hH1RFF5opU--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
