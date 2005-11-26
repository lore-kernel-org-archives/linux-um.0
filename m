Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eg8KH-0002UN-G7 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 14:15:21 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eg8KF-0008Ft-TJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 14:15:21 -0800
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Eg8J6-00083F-NM for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 23:14:08 +0100
Received: from dslb-082-083-008-021.pools.arcor-ip.net ([82.83.8.21])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 26 Nov 2005 23:14:08 +0100
Received: from skoehler by dslb-082-083-008-021.pools.arcor-ip.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 26 Nov 2005 23:14:08 +0100
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <dmammg$iem$1@sea.gmane.org>
References: <200511261303.42684.rob@landley.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC89998B8B690B3A574077DFE"
In-Reply-To: <200511261303.42684.rob@landley.net>
Subject: [uml-devel] Re: Using lilo on ubda?
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
Date: Sat, 26 Nov 2005 23:13:47 +0100
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC89998B8B690B3A574077DFE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

> Lilo is saying that ubda is not a device with partitions.
>=20
> Anybody know what it's talking about?  (I've got a ubda1.  I'm trying t=
o make=20
> a disk image I can test boot with qemu without having to boot a knoppix=
 image=20
> to do it...)

I think, LILO tries to probe which BIOS-device-number it must use for
ubda. You can try to tell LILO manually. (Take a look at man lilo, i
remember that i've done this once a long time ago, but i don't know the
syntax anymore).


--------------enigC89998B8B690B3A574077DFE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDiN4c7Ww7FjRBE4ARAoWlAJ9Wpcd1fx2GatyMCP3aVFTby3TDuwCeKBTR
w/yg6Q2T/ip1ruJEV4T5Hpc=
=jHHJ
-----END PGP SIGNATURE-----

--------------enigC89998B8B690B3A574077DFE--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
