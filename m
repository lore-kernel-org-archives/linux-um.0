Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1SckE5-0001R1-4l
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 21:26:41 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SckE3-0001om-Qq
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 21:26:41 +0000
Message-ID: <4FD11C88.6090308@nod.at>
Date: Thu, 07 Jun 2012 23:26:32 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <4FD1164B.6060307@gmail.com>
In-Reply-To: <4FD1164B.6060307@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4692115999788591637=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: pass siginfo to guest process
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4692115999788591637==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFA40FE63C899261EB7BCC188"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA40FE63C899261EB7BCC188
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 07.06.2012 22:59, schrieb Martin P=E4rtel:
> Signal handlers in UML guest processes now get correct siginfo_t fields=

> for SIGTRAP, SIGFPE, SIGILL and SIGBUS. Specifically, si_addr and si_co=
de
> are now correct where previously they were si_addr =3D NULL and si_code=
 =3D 128.

What exactly is broken?
In my SIGSEGV test case si_addr is not NULL, it contains the correct faul=
ting address.

> +
> +			ptrace(PTRACE_GETSIGINFO, pid, 0, &si);
> +

Doesn't this leak the host siginfo_t into the guest?

Thanks,
//richard


--------------enigFA40FE63C899261EB7BCC188
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJP0RyIAAoJEN9758yqZn9exl4IALWCPLje2mNu6JhBsBMWeT5M
X1IG6s8n+sYow6OIX7Jc3JNcApD/cEeaNUfFGpGqMbLMj+qLsf55DppeHh6wjagX
bSgy7hPCatx2yxbkGp5d+IdLkXD/vMs9hY0S/sEMlNWA4QSuLw6wksndsvTlc2j5
Kzy81et/bfXz4o2sj3MfEbtn/hlh0XexLAgRJ6r+H2ULTklGVlPRBTVj0mMZePya
nr6DiI0Y/1u74HmlBYeq/o3rW0hDUHm/0gH8q6TOzX6j+my4j2z72XjtrEVVa1B+
L5aVVJULoS2pfVMemF2bSoyDQyo1pcGUrIm017Ly4XO066QKWUfqYeqwrGYn530=
=re2d
-----END PGP SIGNATURE-----

--------------enigFA40FE63C899261EB7BCC188--


--===============4692115999788591637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============4692115999788591637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============4692115999788591637==--


