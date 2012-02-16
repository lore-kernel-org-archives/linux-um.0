Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <malattia@linux.it>) id 1Ry8t0-0003zM-Gj
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Feb 2012 21:29:06 +0000
Received: from ac250205.ppp.asahi-net.or.jp ([183.77.250.205]
	helo=smtp.kamineko.org)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ry8sv-0002lM-Fi for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Feb 2012 21:29:06 +0000
Date: Fri, 17 Feb 2012 06:29:27 +0900
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20120216212926.GA8970@kamineko.org>
References: <1329323907-7696-1-git-send-email-joerg.roedel@amd.com>
	<1329323907-7696-2-git-send-email-joerg.roedel@amd.com>
	<1329367790.3048.168.camel@deadeye>
MIME-Version: 1.0
In-Reply-To: <1329367790.3048.168.camel@deadeye>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8974817608901488626=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 2/2] kbuild: Only build linux-image package
	for UML
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Michal Marek <mmarek@suse.cz>, maximilian attems <max@stro.at>, user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>, linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org


--===============8974817608901488626==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2012 at 04:49:50AM +0000, Ben Hutchings wrote:
> On Wed, 2012-02-15 at 17:38 +0100, Joerg Roedel wrote:
> > For user-mode Linux the other packages are not required. So
> > only build the package with the linux-image in it.
> >=20
> > Cc: Michal Marek <mmarek@suse.cz>
> > Cc: maximilian attems <max@stro.at>
> > Cc: Ben Hutchings <ben@decadent.org.uk>
> > Cc: debian-kernel@lists.debian.org
> > Cc: linux-kbuild@vger.kernel.org
> > Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> Tested-by: Ben Hutchings <ben@decadent.org.uk>
>=20
> But I've never touched UML either so we should get confirmation that
> this really is the right thing to do.

there is a wishlist bug opened ages ago (and pinged not so long ago)
requesting headers to be packaged in debian:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D186930
Just to say that there is some interest in having headers packaged
somehow.

--=20
mattia
:wq!

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk89dTYACgkQgpRPaOotLEGmwwCeIOIw5eX2x+w2/QMPAnhLKEk/
XRwAoODTPg/s5HZyRJRf8CUm/vNaJnOJ
=LYHv
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--


--===============8974817608901488626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--===============8974817608901488626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============8974817608901488626==--


