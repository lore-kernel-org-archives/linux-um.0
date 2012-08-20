Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1T3VE5-00063u-0s
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Aug 2012 16:53:17 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T3VE2-0008JL-FI
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Aug 2012 16:53:16 +0000
Message-ID: <50326B64.7020904@nod.at>
Date: Mon, 20 Aug 2012 18:52:52 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <alpine.DEB.2.00.1208200947470.9242@cobra.newdream.net>
In-Reply-To: <alpine.DEB.2.00.1208200947470.9242@cobra.newdream.net>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1687162473470038211=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] build error on 3.6-rc1 and later
To: Sage Weil <sage@inktank.com>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1687162473470038211==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig788A7AA630B903027C4435B7"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig788A7AA630B903027C4435B7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 20.08.2012 18:49, schrieb Sage Weil:
> I'm getting
>=20
> arch/um/os-Linux/time.c: In function 'deliver_alarm':
> arch/um/os-Linux/time.c:117:3: error: too few arguments to function 'al=
arm_handler'
> In file included from arch/um/os-Linux/time.c:13:0:
> arch/um/os-Linux/internal.h:1:6: note: declared here
>=20
> on 3.6-rc1 and later.  FWIW I blindly added an extra NULL argument and =
it=20
> seems to behave:
>=20
> diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
> index f602385..0748fe0 100644
> --- a/arch/um/os-Linux/time.c
> +++ b/arch/um/os-Linux/time.c
> @@ -114,7 +114,7 @@ static void deliver_alarm(void)
>         skew +=3D this_tick - last_tick;
> =20
>         while (skew >=3D one_tick) {
> -               alarm_handler(SIGVTALRM, NULL);
> +               alarm_handler(SIGVTALRM, NULL, NULL);
>                 skew -=3D one_tick;
>         }
> =20

Martin,

looks like you've introduced this regression.
Can you please have a look?

Thanks,
//richard


--------------enig788A7AA630B903027C4435B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJQMmtkAAoJEN9758yqZn9eI4UIAJiZ9FCi5tiUEwk0ksh8Bdkf
L7QxEp1g0qKrAVGRiJSz6ffSvZdikmn4VY+C0PBfhHSBxIa5kTZ7XXl4N2SjRHch
+76YtIz+QZNvb6ljfGmw9dk9rzsKhM921XOS+g0OIMIg8aarlstCo+DX4ygkOk4j
dSXQFUTlUFT/PonPeM3Ky4Vm3V3disj+QuLsMz2FCMc5wg+p813MxF6E35LTdcpz
JH6AT/MBnQ7O76by88i6X1bwbq+2PjF1XQLrpruPVR9+KJpB8aBXBsAjL2lRFuhF
Y2BQ13P5vPNJp2RJ+tNxPZl3TEOEOmdy4ZPAQ5U3ZTGKHhNUM5aoDVdEqchRG1c=
=ehr2
-----END PGP SIGNATURE-----

--------------enig788A7AA630B903027C4435B7--


--===============1687162473470038211==
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
--===============1687162473470038211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1687162473470038211==--


