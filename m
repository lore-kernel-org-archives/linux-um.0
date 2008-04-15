Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JlgJ2-0004MG-Ly for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 01:14:20 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JlgJ1-0001tN-01
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 01:14:20 -0700
From: Toralf =?iso-8859-15?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Tue, 15 Apr 2008 10:14:06 +0200
MIME-Version: 1.0
Message-Id: <200804151014.09006.toralf.foerster@gmx.de>
Subject: [uml-devel] typo in boot message
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0611751938=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============0611751938==
Content-Type: multipart/signed; boundary="nextPart4245707.JudaL8CWBi";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4245707.JudaL8CWBi
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

during start of my UML I get :

Apr 15 10:11:56 n22_uml Choosing a random ethernet address for device eth0
Apr 15 10:11:56 n22_uml Netdevice 0 (a2:cb:2b:02:31:93) : <6>TUN/TAP backen=
d - IP =3D 192.168.0.253

but instead it is a random mac address, isn't it ?

=2D-=20
MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

--nextPart4245707.JudaL8CWBi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBIBGPQhyrlCH22naMRAheVAKCr388wuX7AfriPKPCxyu2Mv1yH3gCgtohc
ePiLGNeS9CRHbMR6bdDwmmM=
=QPnB
-----END PGP SIGNATURE-----

--nextPart4245707.JudaL8CWBi--


--===============0611751938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0611751938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0611751938==--

