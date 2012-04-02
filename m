Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rrs@researchut.com>) id 1SEbxf-0004mG-4V
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 07:45:59 +0000
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SEbxZ-0002Ul-Lh
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 07:45:59 +0000
Received: by dadz9 with SMTP id z9so2422469dad.33
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 02 Apr 2012 00:45:47 -0700 (PDT)
Message-ID: <4F795309.7030206@debian.org>
Date: Mon, 02 Apr 2012 12:49:37 +0530
From: Ritesh Raj Sarraf <rrs@debian.org>
MIME-Version: 1.0
References: <0uvj49xgsm.ln2@news.researchut.com>
	<CAFLxGvx2fDWexwA1wmLZ4T0EDaUcaMiROrP-_diQi6bGTNEkyw@mail.gmail.com>
In-Reply-To: <CAFLxGvx2fDWexwA1wmLZ4T0EDaUcaMiROrP-_diQi6bGTNEkyw@mail.gmail.com>
Reply-To: rrs@debian.org
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5576568070075599032=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] uml build failure on arch i386
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============5576568070075599032==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="------------enig7BB7C71B0D37DAB814DC9BB7"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7BB7C71B0D37DAB814DC9BB7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Monday 02 April 2012 11:59 AM, richard -rw- weinberger wrote:
>> > My initial search led me to:
>> > http://sourceforge.net/mailarchive/message.php?msg_id=3D27848489
>> >
>> > Based on the comment there, I've tried SUBARCH=3Di386. But that didn=
't
>> > help. Any suggestions?
> Please share your .config.

Config file available at:
http://people.debian.org/~rrs/tmp/config.i386

--=20
Ritesh Raj Sarraf | http://people.debian.org/~rrs
Debian - The Universal Operating System


--------------enig7BB7C71B0D37DAB814DC9BB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCgAGBQJPeVMUAAoJEKY6WKPy4XVp9IsQALquYylnQcAkCRbD3wlUsrAn
1yzSTXS+o1s7sKadOUIFz305ict7LcqtcndrijEQ6Kcj0G++QQBk0wmVSXVlawt1
gSBfdhQoY+aKPqIZWPKXdVvVFWCnnQOOCzOT5B5qYeS3PjkshxBkP5Q3Hyk76c1d
qUOA9tcLGja2FY0ItO9SlD1H20kUEgB2Y+PZ9jOtum6AHfwJjbRRORh3ycnLTroJ
/MF8WfSkRWffWvCRhpZIClVOKPEvUUhu6oalJdTLat2w6Za0drRh45VallGdQI7g
iIJOkUaQj0XW720kQklHKBbJjSLPDEVISfmbQAj3dO9RsfnJLdUsr7jd77veCN3z
0c4t/ocA9TQ3agT6fkLGP9f2Ox1ggsnbuptDBecMpVrfylMwPyrK3A1te5gpYfxw
p3uw/4dYjNXETjNhtNsrxSze9zOuvAi5tMKmLliiqhnGDoq2zyanx3t9rZfhbBdO
fyDSaLOQkubx2OCha2kCbosqyEAQPNtg2+J4Zkm3p9NGX3PHmHnD7WGLzQkfMli5
klYsb7JfaNKCtP0vwHsyO1bLBkM/ODTplFt5eGit4t+bgkAXSPxINdWHQ2l9GxAA
mDcLCyeC6dSm1BOxAdReo/pgsdldzPfIntcdseCuYTPDdsit1zPYZePtzwmOhxnL
vHnoHdZwtuoy7MeUaGJi
=L50+
-----END PGP SIGNATURE-----

--------------enig7BB7C71B0D37DAB814DC9BB7--


--===============5576568070075599032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============5576568070075599032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5576568070075599032==--


