Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1T1I9l-00008r-1m
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2012 14:31:41 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T1I9i-0006fh-GE
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2012 14:31:41 +0000
Message-ID: <502A613F.1090600@nod.at>
Date: Tue, 14 Aug 2012 16:31:27 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <87a9xys53h.fsf@rustcorp.com.au>
	<20120726150419.0de645e8750e3a15fa0f1aaa@canb.auug.org.au>
	<50115FCF.4060708@xenotime.net> <502932A0.3060001@xenotime.net>
	<15532.1344954413@warthog.procyon.org.uk>
In-Reply-To: <15532.1344954413@warthog.procyon.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9150634518889096653=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] linux-next: Tree for July 26 (uml)
To: David Howells <dhowells@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, user-mode-linux-devel@lists.sourceforge.net, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============9150634518889096653==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig95FD8DA7F5FAB50EAB9478D6"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig95FD8DA7F5FAB50EAB9478D6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 14.08.2012 16:26, schrieb David Howells:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
>=20
>>>>   CC      arch/x86/um/../kernel/module.o
>>>> arch/x86/um/../kernel/module.c:96:5: error: redefinition of 'apply_r=
elocate_add'
>>>> include/linux/moduleloader.h:64:19: note: previous definition of 'ap=
ply_relocate_add' was here
>>>> make[2]: *** [arch/x86/um/../kernel/module.o] Error 1
>=20
> Hmmm...  I'm not sure how to deal with this.  The problem is that UML d=
oesn't
> draw the:
>=20
> 	select MODULES_USE_ELF_REL if X86_32
> 	select MODULES_USE_ELF_RELA if X86_64
>=20
> definitions from arch/foo/Kconfig that tell it what modules will look l=
ike.
>=20
> Should I just enable both REL and RELA in UML, or is there a better way=
 to do
> this?

Is there no way to get this information from the UML subarch?
Which is currently X86_32 or X86_64.

Thanks,
//richard


--------------enig95FD8DA7F5FAB50EAB9478D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJQKmFAAAoJEN9758yqZn9eMQsIAIfhSZNfzO9od5/7oE/DTinR
pClB9vwteHAj2wzYvpG9t3E1F1TP4tChWeIEP/1of2ToQpCsSOo0vJFjf7X2c+63
L8199lMnVQsqeAMgtbY6Q3jJ+SI0GIEPgheiHu+lO1znl8hNGu0o3eg4nrXWhkco
oVAtUbucwzDy0OFrXKZD0h7fLcrrocdN4Z3C75pAEZeB3lXYsG77XX9rz5pBloDN
htWZ61RQBoSJhAxeeV5r4WEKVNg0Wxkbc2QoFqi8WKxg6zvHgPtsfnP/h29zKaso
rS5WTouAqP7e/YIBbA8VQr+lhAzuPMJDiSrdoEJLDLj95SDFEmESoGvBsjGiDbE=
=p0wF
-----END PGP SIGNATURE-----

--------------enig95FD8DA7F5FAB50EAB9478D6--


--===============9150634518889096653==
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
--===============9150634518889096653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============9150634518889096653==--


