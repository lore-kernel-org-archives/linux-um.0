Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cqmqv-00035Y-DA for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jan 2005 22:28:33 -0800
Received: from 13.red-80-24-60.pooles.rima-tde.net ([80.24.60.13]
	helo=sentinel.yadan.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cqmqt-0004JG-7l
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jan 2005 22:28:33 -0800
Received: from amarok.yadan.org (amarok.yadan.org [192.168.0.90])
	by sentinel.yadan.org (Postfix) with ESMTP id C11E510A2A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 18 Jan 2005 07:28:15 +0100 (CET)
From: Yari =?iso-8859-1?q?Ad=E1n_Petralanda?= <mustang@yadan.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3383145.gqIuMPua2g";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501180728.13533.mustang@yadan.org>
Subject: [uml-devel] question about udp fragmentation under UML
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
Date: Tue, 18 Jan 2005 07:28:08 +0100
To: user-mode-linux-devel@lists.sourceforge.net

--nextPart3383145.gqIuMPua2g
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm developing a network block device, which uses both TCP and UDP sockets =
to=20
transmit it's data. When I try to send UDP frames bigger than the MTU, they=
=20
are dropped before they hit the wire. Trying to debug the problem, I ran=20
netcat using udp under a UML. It uses writes of 8192 bytes over a UDP socke=
t.=20
The scenario that made me post here is this:=20
running UML on tracing thread mode, host kernel is 2.6.10, uml kernel is=20
2.6.8.1-1um, if I set the MTU of the localhost device (same problem on=20
tun/tap) to 1500 bytes, netcat doesn't receive any frames sent to the=20
loopback interface. path_mtu_no_discover is 0. The same scenario, on my hos=
t=20
computer, runs fine.=20

Seems to me that IP is refusing to fragment the udp datagrams, and drops th=
em.=20
I don't know if it's a UML problem, but when I saw that not only my code, b=
ut=20
netcat also drops frames, it stranged me.

Thank you very much

=2D-=20
   .-.   =20
    oo|    Yari Ad=E1n Petralanda, a.k.a. mustang
   /`'\         =20
  (\_;/)           http://www.yadan.org
              Registered Linux User #257290                    =20
=2D-
Nothing so needs reforming as other people's habits.
  -- Mark Twain, "Pudd'nhead Wilson's Calendar"

--nextPart3383145.gqIuMPua2g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB7Kx9Rci9gba9XcYRArwwAJ9L/1tQJhYuzpYiWrlWOul2kMjFKwCfdj4B
pI0J8R0mfTrCJiAnNHaXdNg=
=ZNSZ
-----END PGP SIGNATURE-----

--nextPart3383145.gqIuMPua2g--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
