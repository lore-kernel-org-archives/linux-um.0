Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxTvh-0008Kn-5b for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 08:36:37 -0800
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AxTU2-0001hy-9x for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 08:08:02 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1AxTkR-0007eR-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 29 Feb 2004 17:24:59 +0100
Received: from pd9e58ebe.dip.t-dialin.net ([217.229.142.190])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun Feb 29 16:24:59 2004
Received: from skoehler by pd9e58ebe.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun Feb 29 16:24:59 2004
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <c1t3op$g63$1@sea.gmane.org>
References: <c1srf3$vpe$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
In-Reply-To: <c1srf3$vpe$1@sea.gmane.org>
Subject: [uml-devel] Re: bootstrap stage1 with python2.2
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
Date: Sun, 29 Feb 2004 17:24:51 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

ohh, sorry, wrong list! just delete my last mail, it was ment for the=20
gentoo-devel list, not uml-devel.

Sven K=F6hler wrote:
> Hi,
>=20
> i don't want to report a bug or something like that before i discussed=20
> it here, but if you bootstrap the old release-stage1 from 20030910,=20
> python 2.3 will be installed, but python 2.2 won't be uninstalled, but=20
> python 2.2 isn't listed to be installed. (qpkg -I |grep python only=20
> shows python2.3, but not python2.2)
>=20
> bootstrap.sh should somehow upgrade python to the current version, but i =

> cannot imagine how that should work. python2.2 cannot be unmerged (since =

> qpkg -I doesn't list it), and python2.3 has a lot of dependencies.
>=20
> I wonder if there are more files like /usr/bin/python2.2/* that don't=20
> belong to any package listed by "qpkg -I". These files could be recorded =

> in the database as a package called "stage1" which can be unmerged after =

> the "emerge system".
>=20
> What do you think?
>=20
> Thx
>   Sven
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=3D1356&alloc_id=3D3438&op=3Dclick



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=3D1356&alloc_id=3D3438&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
