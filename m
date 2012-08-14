Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1T1Irw-0006mD-EI
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2012 15:17:20 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T1Irv-0003yH-MQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2012 15:17:20 +0000
Message-ID: <502A6BF8.6040804@nod.at>
Date: Tue, 14 Aug 2012 17:17:12 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <502A69FA.8040805@nod.at> <502A6759.3090802@nod.at>
	<15981.1344955883@warthog.procyon.org.uk>
	<502A613F.1090600@nod.at> <87a9xys53h.fsf@rustcorp.com.au>
	<20120726150419.0de645e8750e3a15fa0f1aaa@canb.auug.org.au>
	<50115FCF.4060708@xenotime.net> <502932A0.3060001@xenotime.net>
	<15532.1344954413@warthog.procyon.org.uk>
	<18600.1344956051@warthog.procyon.org.uk>
	<18933.1344956788@warthog.procyon.org.uk>
	<30102.1344957328@warthog.procyon.org.uk>
In-Reply-To: <30102.1344957328@warthog.procyon.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8593981963548626651=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] linux-next: Tree for July 26 (uml)
To: David Howells <dhowells@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, user-mode-linux-devel@lists.sourceforge.net, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============8593981963548626651==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1B9ECB9B1B5FB94E2CFFE3F7"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1B9ECB9B1B5FB94E2CFFE3F7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 14.08.2012 17:15, schrieb David Howells:
> How about this then?
>=20
> David
> ---
> diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
> index 9926e11..a4b0c10 100644
> --- a/arch/x86/um/Kconfig
> +++ b/arch/x86/um/Kconfig
> @@ -21,9 +21,11 @@ config 64BIT
>  config X86_32
>  	def_bool !64BIT
>  	select HAVE_AOUT
> +	select MODULES_USE_ELF_REL
> =20
>  config X86_64
>  	def_bool 64BIT
> +	select MODULES_USE_ELF_RELA
> =20
>  config RWSEM_XCHGADD_ALGORITHM
>  	def_bool X86_XADD && 64BIT

Looks sane.

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard


--------------enig1B9ECB9B1B5FB94E2CFFE3F7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJQKmv4AAoJEN9758yqZn9ebaAH/1dOgLeyMCJ5hVEaMw1QmnXq
0rSNc6wv0zi0BRRuv3XLrzddDq//ouEkMTDRTMdA0Vk8qNi5XTSonTr4fxoyRiLk
FY4AWweNn7rjNpaFVy+07BRsr47g3h+MWoYSrGq/MiCZy5A33DUR9QtGslxIxN9X
3Ym5zGIRkUquhGoYRBADX279q3ctHelT68L0tcoavSJU8wBQi4A1JHnRIZ7eUobQ
kE9E/TGUcyg1Yc1tOB8TCJd42Qsxw+skJZNYZilE6QnOLyfhIuI7j1eoRDySDnOD
DLRh2wTYZOiurTbHOUIKJZx0nc79jZkdXamOZWVYWFJUAYy0jS4x0N8hGO+kI2M=
=h7xw
-----END PGP SIGNATURE-----

--------------enig1B9ECB9B1B5FB94E2CFFE3F7--


--===============8593981963548626651==
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
--===============8593981963548626651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============8593981963548626651==--


