Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrkX0-0002CI-3P for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Jan 2005 14:11:58 -0800
Received: from 13.red-80-24-60.pooles.rima-tde.net ([80.24.60.13]
	helo=sentinel.yadan.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CrkWx-0008JD-R2
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Jan 2005 14:11:58 -0800
From: Yari =?iso-8859-15?q?Ad=E1n_Petralanda?= <mustang@yadan.org>
Subject: Re: [uml-devel] question about udp fragmentation under UML
References: <200501180728.13533.mustang@yadan.org>
	<200501192254.24207.blaisorblade@yahoo.it>
In-Reply-To: <200501192254.24207.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2073615.yanpXS0m4I";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501202311.38548.mustang@yadan.org>
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
Date: Thu, 20 Jan 2005 23:11:29 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

--nextPart2073615.yanpXS0m4I
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi again,

Problem solved with 2.6.9 vanilla and 2.6.9-bb4. Thank you very much for yo=
ur=20
answer, and sorry for not testing it on the latest kernels before. I though=
t=20
there were no new versions when I saw 2.6.8.1 last on the website. Didnt kn=
ew=20
2.6.9 works right out of the box,

Thank you again

El Mi=E9rcoles, 19 de Enero de 2005 22:54, escribi=F3:
> On Tuesday 18 January 2005 07:28, Yari Ad=E1n Petralanda wrote:
> > Hi,
> >
> > I'm developing a network block device, which uses both TCP and UDP
> > sockets to transmit it's data. When I try to send UDP frames bigger than
> > the MTU, they are dropped before they hit the wire.
>
> This exact problem (a checksum corruption in fragmented UDP packets) was
> already debugged and solved, and even vanilla 2.6.9 includes the fix...
> currently the recommended tree is 2.6.9-bb4 on my homepage.
>
> I assume that you should first try 2.6.9-bb and, if you still have
> problems, ask again... Anyway please post an ack about whether 2.6.9-bb
> solves this bug, ok? Thanks.
>
> > Trying to debug the problem, I
> > ran netcat using udp under a UML. It uses writes of 8192 bytes over a U=
DP
> > socket. The scenario that made me post here is this:
> > running UML on tracing thread mode, host kernel is 2.6.10, uml kernel is
> > 2.6.8.1-1um,
> >
> > if I set the MTU of the localhost device (same problem on
> > tun/tap) to 1500 bytes, netcat doesn't receive any frames sent to the
> > loopback interface. path_mtu_no_discover is 0. The same scenario, on my
> > host computer, runs fine.
> >
> > Seems to me that IP is refusing to fragment the udp datagrams, and drops
> > them.
>
> I've debugged this with ethereal and the result was that the checksum, in
> the case of fragmented packets, was wrong - so the receiving side dropped
> the packets...
>
> Bye

=2D-=20
   .-.   =20
    oo|    Yari Ad=E1n Petralanda, a.k.a. mustang
   /`'\         =20
  (\_;/)           http://www.yadan.org
              Registered Linux User #257290                    =20
=2D-
You will be audited by the Internal Revenue Service.

--nextPart2073615.yanpXS0m4I
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB8CyaRci9gba9XcYRAk7FAKCMUeXGegCjZ2fbMWZaJYyV0CqziQCg0Zz4
6dH8beFbPpW0qfuoqoc/juU=
=d3+C
-----END PGP SIGNATURE-----

--nextPart2073615.yanpXS0m4I--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
