Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gc6at-0001VX-9o for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Oct 2006 13:40:23 -0700
Received: from newcod.sandelman.ca ([192.139.46.42] helo=cod.sandelman.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gc6aq-00061m-Px
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Oct 2006 13:40:23 -0700
References: <v0r6x41bnb.fsf@marajade.sandelman.ca>
	<200610210238.16557.blaisorblade@yahoo.it>
	<17462.1161394764@sandelman.ottawa.on.ca>
	<200610210454.23887.blaisorblade@yahoo.it>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Date: Mon, 23 Oct 2006 16:40:05 -0400
In-Reply-To: <200610210454.23887.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Sat,
	21 Oct 2006 04:54:23 +0200")
Message-ID: <v0mz7m3gwq.fsf@marajade.sandelman.ca>
MIME-Version: 1.0
Subject: Re: [uml-devel] Xen 3.0.2 and UML guest
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1896987359=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

--===============1896987359==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Transfer-Encoding: quoted-printable


>>>>> "Blaisorblade" =3D=3D Blaisorblade  <blaisorblade@yahoo.it> writes:
    BB> This is SKAS0 mode (since you said that TT mode works ok), right?=
=20=20
    BB> I really guess that the problem here is not the VTALARM handling (a=
ny UML=20
    BB> strace is cluttered by such calls - but Jeff, didn't you remove all=
 of them=20
    BB> with the soft-irq patch? maybe that was after 2.6.15, in fact I do =
not get=20

  I tried linux-2.6.git, commit that just just past the v2.6.19-rc2 tag poi=
nt.

Linux version 2.6.19-rc2-g575b75b3 (mcr@gimli) (gcc version 4.1.2 20060814 =
(prerelease) (Debian 4.1.1-11)) #1 Mon Oct 23 12:50:48 EDT 2006

  Can I try another git tree with more patches?

    Blaisorblade> A strace -t (or whichever option shows the timings)
    Blaisorblade> would help finding _where_
    Blaisorblade> is the big pause...

    >> I think you mean -T?

    Blaisorblade> Actually -t prints timestamps, which can be more useful t=
o look at "when are=20
    Blaisorblade> we?".

  okay, I can do -T if you want.
  http://www.sandelman.ca/tmp/east.trace.gz

=2D-=20
]            Bear: "Me, I'm just the shape of a bear."          |  firewall=
s  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net archit=
ect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device dri=
ver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"=
); [



--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQEVAwUART0oqICLcPvd0N1lAQKfPwgAvDLsoER/dd+kTs4wFtqpJI0GBWFftXMl
oRR67bb9qR2tBr9qLFJSrkT6C8ijOKopMUCeTlRcEFXGdR2PvkvB+A5QpeJ0lfRg
9A8p65mLqQYo24Pq3+CVFBqHhO5mJ1hfYg2DyWPUWzhgSwjmO72+NKKZHzvvRAcu
I94FXp0YCwsvlvYaiExCYDLD8KHtW5vJ/etvQG6W1jYkW4VIGoHmoT+mIhFJDAAB
IHCjnmJhJ4SYJqnFr2MI42uAmtQDgC7KA/oaP35FJHbrWg7JmGt1cG4XDylxunSf
l6C5lXV6dDh5hWRboifHTwkSoB+5Yu+U8Ai3+QToHE5xBCav40ZO8A==
=u1Hg
-----END PGP SIGNATURE-----
--=-=-=--


--===============1896987359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1896987359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1896987359==--
