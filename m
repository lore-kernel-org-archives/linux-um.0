Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ce8WZ-0003dt-91 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Dec 2004 00:59:15 -0800
Received: from mail.epost.de ([193.28.100.151])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Ce8WX-00026Y-56 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Dec 2004 00:59:15 -0800
Received: from [10.49.3.159] (212.214.189.26) by mail.epost.de (7.2.033.1)
	(authenticated as Armin.Warda)
	id 41BCF86800026F6D for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Dec 2004 09:59:10 +0100
From: "Armin M. Warda" <Armin.Warda@ePost.De>
Reply-To: Armin.Warda@gmx.De
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1392240.Y4xgQlmNSQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412140958.58402.Armin.Warda@ePost.De>
Subject: [uml-devel] UML fills /tmp irreversibly (2.6.9-bb4 on SuSE 9.2)
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
Date: Tue, 14 Dec 2004 09:58:52 +0100
To: user-mode-linux-devel@lists.sourceforge.net

--nextPart1392240.Y4xgQlmNSQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  Hi,

running UML 2.6.9-bb4 on SuSE Professional 9.2 with host kernel SuSE=20
2.6.8-24.5 (with SKAS) I notice the strange effect, that /tmp keeps=20
filling irreversibly.

/tmp space is not only consumed as long as UMLs are running (as seen=20
with "lsof|grep deleted"), /tmp space is _not_released_ when the UMLs=20
are gone. When all UMLs are gone "lsof|grep deleted" returns nothing,=20
but "df /tmp" still shows the allocations. In this situation attempts=20
to umount (or remount ro) the /tmp fail, even in single user mode.

The only way to recover from such a /tmp full situation is to reboot=20
the host (then unmount of /tmp and the rootfs fail during shutdown,=20
which causes fscks at the reboot...)

I tried out different filesystem types for /tmp: reiserfs 3.6, ext3=20
and tmpfs, no difference.

Anybody seen such behaviour before?

I suppose this must be a bug of the _host_ kernel, not of the UML=20
kernel. Do you agree?

  Armin.

=2D-=20
   --- May the Source be with you! Linux. ---
   --- secure eMail: http://www.gnupg.de/ ---

--nextPart1392240.Y4xgQlmNSQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBvqtSRyBj5Zbydm0RAvTNAJwJ6kea9AZXUVzqXX9ohmfsZAAzeQCgxgVD
RRiW/CA21Y3m1eiLOeCoIVo=
=vhO7
-----END PGP SIGNATURE-----

--nextPart1392240.Y4xgQlmNSQ--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
