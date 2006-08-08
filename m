Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GASsX-0001a6-QD for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 07:48:21 -0700
Received: from nemesis.fprintf.net ([66.134.112.218])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GASsV-0007yq-87
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 07:48:21 -0700
From: Daniel Gryniewicz <dang@gentoo.org>
In-Reply-To: <20060808140335.81959.qmail@web25219.mail.ukl.yahoo.com>
References: <20060808140335.81959.qmail@web25219.mail.ukl.yahoo.com>
Date: Tue, 08 Aug 2006 10:47:55 -0400
Message-Id: <1155048476.18932.17.camel@athena.fprintf.net>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/3] uml: use -mcmodel=kernel for x86_64
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0437818219=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Paolo Giarrusso <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, Andi Kleen <ak@suse.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


--===============0437818219==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-RKeyaclj8y0JuO9SU+mU"


--=-RKeyaclj8y0JuO9SU+mU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-08-08 at 16:03 +0200, Paolo Giarrusso wrote:

> Moreover, who has recently tested module loading in x86-64 uml
> kernels? I don't remember doing such testing recently...
>=20

Well, modules seem to work fine here on x86_64.  I'm running 2.6.16-bs2.
I only tested the loop module, but others also load.

Daniel

--=-RKeyaclj8y0JuO9SU+mU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5-ecc0.1.6 (GNU/Linux)

iD8DBQBE2KQbomPajV0RnrERAkXUAJsE5WuxR6pv/6HWpiqPHW6YBrslLACdG7Mt
17BpCawE+f9pLrN0nE3gNX4=
=Pohy
-----END PGP SIGNATURE-----

--=-RKeyaclj8y0JuO9SU+mU--



--===============0437818219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0437818219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0437818219==--

