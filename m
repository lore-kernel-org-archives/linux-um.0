Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1RtgFO-0003Mz-04
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Feb 2012 14:05:46 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RtgFM-0002tG-8O
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Feb 2012 14:05:45 +0000
Message-ID: <4F2D3B2B.206@nod.at>
Date: Sat, 04 Feb 2012 15:05:31 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <20120130192552.GL23916@ZenIV.linux.org.uk>
	<1328311063-17630-1-git-send-email-richard@nod.at>
	<20120204001431.GY23916@ZenIV.linux.org.uk>
In-Reply-To: <20120204001431.GY23916@ZenIV.linux.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5833214471622909862=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: Cleanup headers files
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============5833214471622909862==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7857CC569163458946A6691D"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7857CC569163458946A6691D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 04.02.2012 01:14, schrieb Al Viro:
> On Sat, Feb 04, 2012 at 12:17:43AM +0100, Richard Weinberger wrote:
>> Many header files can be replaced by generic variants.
>=20
> Umm...  I suspect that for auxvec.h the right thing is to simply
> remove it - it's never used on uml builds.
>=20
> FWIW, I've rebased my local queue to current and pushed it to kernel.or=
g
> again; it's on git.kernel.org/pub/scm/linux/kernel/git/viro/um-headers.=
git

BTW: You changed a lot in line.c.
Have you seen this thread?
http://permalink.gmane.org/gmane.linux.uml.devel/13329

At first I thought moving to tty_port solved all problems
but later I've realized that this is not the case.

Thanks,
//richard


--------------enig7857CC569163458946A6691D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPLTsvAAoJEN9758yqZn9ecc4IAKEMFiH5/lidVWcd6e062svv
KQiYwFtPe/fc+vbGcT9kBBZZrCenw+qPpVDEbwWl03oornlzHtF4iWqGY5nyfzXf
ACXNSvvqdyPfOXMKW7w3E8B8ZUvffJGuBXVMwbdiRDdVPqacLa11zoB9cV09uB5P
vfNrqxqz8gqYsKi3FOQ//LHHvV91holGH5LqCzjeRG6APx6Y5C4z/CbGChytFdAZ
1NRQ+Dy7e+zb5n4LhZejldPWB4MXlY9qWxSO1vcdrnc3Zb6SgF6ec7eNLYDym5L6
B9asLLCtBAvoC4PHA9EBiXjWPnkxh78fIf9Y42OCLgXQ9iE6Q8FrH9dktxZ33kk=
=QD6K
-----END PGP SIGNATURE-----

--------------enig7857CC569163458946A6691D--


--===============5833214471622909862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
--===============5833214471622909862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5833214471622909862==--


