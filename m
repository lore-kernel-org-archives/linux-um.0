Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1T1IYt-0001Zb-6Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2012 14:57:39 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T1IYr-0006X8-NC
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2012 14:57:39 +0000
Message-ID: <502A6759.3090802@nod.at>
Date: Tue, 14 Aug 2012 16:57:29 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <15981.1344955883@warthog.procyon.org.uk>
	<502A613F.1090600@nod.at> <87a9xys53h.fsf@rustcorp.com.au>
	<20120726150419.0de645e8750e3a15fa0f1aaa@canb.auug.org.au>
	<50115FCF.4060708@xenotime.net> <502932A0.3060001@xenotime.net>
	<15532.1344954413@warthog.procyon.org.uk>
	<18600.1344956051@warthog.procyon.org.uk>
In-Reply-To: <18600.1344956051@warthog.procyon.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3725775446566086993=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] linux-next: Tree for July 26 (uml)
To: David Howells <dhowells@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, user-mode-linux-devel@lists.sourceforge.net, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3725775446566086993==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8E501A7871E5A94D4A2E91DD"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E501A7871E5A94D4A2E91DD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 14.08.2012 16:54, schrieb David Howells:
> David Howells <dhowells@redhat.com> wrote:
>=20
>> I can certainly try pasting the lines from x86/Kconfig to uml/Kconfig.=
common
>> to switch the REL/RELA bits, but it would be nice to get this from the=
 actual
>> arch if possible to reduce redundancy.
>=20
> The attached patch works.
>=20
> David
> ---
> diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
> index cb837c2..0463e48 100644
> --- a/arch/um/Kconfig.common
> +++ b/arch/um/Kconfig.common
> @@ -11,6 +11,8 @@ config UML
>  	select GENERIC_CPU_DEVICES
>  	select GENERIC_IO
>  	select GENERIC_CLOCKEVENTS
> +	select MODULES_USE_ELF_REL if X86_32
> +	select MODULES_USE_ELF_RELA if X86_64

I think arch/x86/um/Kconfig makes more sense.

Thanks,
//richard


--------------enig8E501A7871E5A94D4A2E91DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJQKmdZAAoJEN9758yqZn9euisH/14FmxsgQ+gSJtgG2YWNqJpt
FfbLvJOJnMcwMCkt3KAT0HA/DxC0WrIFYxbyItAzkZrFg/0CU+O9g1Qe4YKj05mc
HZP+qqjaFktDK8gxgNkL6PgrXJLtb7LdnT8NK/3sNco0rOYhvRFS13yT3RSKwV3T
Ifr+/N7DTCudWHRrxlFf5KlTI/zh8MvFBj9hyJXTWYJaqgwM4bxZTNzB9hydWIac
rW4ny72wU1syhyGXeJaDM6a0M4YdslEZ/Hu0YzsvNXE2v63AwktqBvZPZJrrQa17
fZOjFlVZ0aIf7M5uwyOr9SOJ+SvBqhzD/JPOUWmGfkr0/I556SD7x7OJ6v7+pz0=
=PDUD
-----END PGP SIGNATURE-----

--------------enig8E501A7871E5A94D4A2E91DD--


--===============3725775446566086993==
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
--===============3725775446566086993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============3725775446566086993==--


