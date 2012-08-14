Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1T1Ijm-0002Cz-6S
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2012 15:08:54 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T1Ijl-0003Ol-B5
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2012 15:08:54 +0000
Message-ID: <502A69FA.8040805@nod.at>
Date: Tue, 14 Aug 2012 17:08:42 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <502A6759.3090802@nod.at> <15981.1344955883@warthog.procyon.org.uk>
	<502A613F.1090600@nod.at> <87a9xys53h.fsf@rustcorp.com.au>
	<20120726150419.0de645e8750e3a15fa0f1aaa@canb.auug.org.au>
	<50115FCF.4060708@xenotime.net> <502932A0.3060001@xenotime.net>
	<15532.1344954413@warthog.procyon.org.uk>
	<18600.1344956051@warthog.procyon.org.uk>
	<18933.1344956788@warthog.procyon.org.uk>
In-Reply-To: <18933.1344956788@warthog.procyon.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3516201282751336139=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] linux-next: Tree for July 26 (uml)
To: David Howells <dhowells@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, user-mode-linux-devel@lists.sourceforge.net, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3516201282751336139==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB3A42E01BD9E7F7D941E32CC"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB3A42E01BD9E7F7D941E32CC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 14.08.2012 17:06, schrieb David Howells:
> Richard Weinberger <richard@nod.at> wrote:
>=20
>> I think arch/x86/um/Kconfig makes more sense.
>=20
> warthog>ls arch/um
> defconfig     Kconfig.common  Kconfig.um     Makefile-os-Linux  scripts=
/
> drivers/      Kconfig.debug   kernel/        Makefile-ppc       sys-ia6=
4/
> include/      Kconfig.net     Makefile       Makefile-skas      sys-ppc=
/
> Kconfig.char  Kconfig.rest    Makefile-ia64  os-Linux/
>=20
> It doesn't exist.  Should I create it?

arch/x86/um, not arch/um.

arch/um/ contains the generic UML stuff.
arch/x86/um/ the x86 specific UML stuff.

Thanks,
//richard



--------------enigB3A42E01BD9E7F7D941E32CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJQKmn7AAoJEN9758yqZn9eo5MH+wb9aFuvSJBBPi3pkJSR1O5t
gIyjpq9F1UjVTYYB0iSjSFzYAsQ3OpPRVaRvLAm9fqA+W/popqKgVbfiTSOjXjrT
DY+YlpAhzn73PSS7UWp8EY8BB/ax2reYVDcE5gwFWMhDgbbjz9U10RvY8nPwvTOE
XZVPML9yqZm4IFjhTEnbYJMoI4/ELG2RG2pu1oLtPrsJ8r0rB95VndypUVn+M5hN
6gPOxfog6wFkXYZcfYRUEj7ktmESuUgtp1LE0tyzAH9uXFyzCVaNfobOrAMPEkYn
6t1qGBT6zvL/3ZUQn/nDWEPpRGfx//23Q6ir18BJrhWXMRhVaRR6auCWvjfg97Y=
=eCU+
-----END PGP SIGNATURE-----

--------------enigB3A42E01BD9E7F7D941E32CC--


--===============3516201282751336139==
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
--===============3516201282751336139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============3516201282751336139==--


