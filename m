Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ayfm7-00026l-LJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Mar 2004 15:27:39 -0800
Received: from i-195-137-100-222.freedom2surf.net ([195.137.100.222]
	helo=greenrd.org) by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AyfYw-0001jj-S0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Mar 2004 15:14:03 -0800
From: Robin Green <greenrd@greenrd.org>
Message-ID: <20040303231401.GM14069@localhost.localdomain>
References: <20040303200937.GK14069@localhost.localdomain>
	<Pine.LNX.4.44.0403032227040.17693-100000@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z/kiM2A+9acXa48/"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403032227040.17693-100000@filer.marasystems.com>
Subject: [uml-devel] More security questions (was: Module exploits into the
	host?)
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
Date: Wed, 3 Mar 2004 23:14:01 +0000
To: user-mode-linux-devel@lists.sourceforge.net



--Z/kiM2A+9acXa48/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 03, 2004 at 10:29:59PM +0100, Henrik Nordstrom wrote:
> On Wed, 3 Mar 2004, Robin Green wrote:
> > Even with the skas patch, is it possible for an insmod to allow an atta=
cker to
> > break out of a UML?
>=20
> Yes.

OK thanks.

Two more security questions:

1. Has the lcall vulnerability been fixed? By a change in the mainline kern=
el?

2. I read on some mailing list (not this one) that in tt mode, processes wi=
thin
a UML instance can read and write to each other's memory! Ah, here we are,
=66rom last year:

http://www.paul.sladen.org/vserver/archives/200305/0074.html

Is this true, or just a rumour?

I have a security proposal to post next, but first I want to understand the
current state of play of UML security.

--=20
Robin

--Z/kiM2A+9acXa48/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFARma5tPCt67UksSYRAouNAJ9y3dP7QSQ7olwcRTw/Jt807zD+nACfWIkR
kWQQ69n8RZ5McvIUqIiAcUU=
=64gA
-----END PGP SIGNATURE-----

--Z/kiM2A+9acXa48/--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
