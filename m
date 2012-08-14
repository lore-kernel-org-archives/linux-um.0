Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1T1IVm-0005Nc-90
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2012 14:54:26 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T1IVj-0004Mm-RY
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2012 14:54:26 +0000
Message-ID: <502A6696.4030200@nod.at>
Date: Tue, 14 Aug 2012 16:54:14 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <502A613F.1090600@nod.at> <87a9xys53h.fsf@rustcorp.com.au>
	<20120726150419.0de645e8750e3a15fa0f1aaa@canb.auug.org.au>
	<50115FCF.4060708@xenotime.net> <502932A0.3060001@xenotime.net>
	<15532.1344954413@warthog.procyon.org.uk>
	<15981.1344955883@warthog.procyon.org.uk>
In-Reply-To: <15981.1344955883@warthog.procyon.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4817141092980584925=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] linux-next: Tree for July 26 (uml)
To: David Howells <dhowells@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, user-mode-linux-devel@lists.sourceforge.net, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4817141092980584925==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDC65854493518245CE064E31"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC65854493518245CE064E31
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 14.08.2012 16:51, schrieb David Howells:
> Richard Weinberger <richard@nod.at> wrote:
>=20
>> Is there no way to get this information from the UML subarch?
>> Which is currently X86_32 or X86_64.
>=20
> Or ppc or ia64?  Or are those defunct?

Those are defunct.
AFAIK viro is working on UML/ppc64.

> I can certainly try pasting the lines from x86/Kconfig to uml/Kconfig.c=
ommon
> to switch the REL/RELA bits, but it would be nice to get this from the =
actual
> arch if possible to reduce redundancy.

The issue happens only on -next, right?
I can have a closer look at the issue tomorrow.

Thanks,
//richard


--------------enigDC65854493518245CE064E31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJQKmaXAAoJEN9758yqZn9eLOgH/1Er70Qz04+e70Ga1vIAsYvI
cwCi+G75LBUC6T3W1N4AF7QW3WzEiy1+4+AJd0SJIntp0EDcpTqJ0XM9lEyD7jRp
S1qc4+Ls6xMEUcDCnOiiLll2u/7TJRcTrUmxCWYI+AvN9JAvNsMWWHgweDxUA917
/MbjnRl6TtAgD0mZdIUFbSDKQNPLWv6ItRmm5EX5Ddl0RjMOT8hEGdOIAPcNNrTJ
PFp8cRCt3rt7LHdwnec1E5iymAP/aPPiAFCNgpAPs1xz190f4EdCjvwe6lrtGSmX
PnyhU7eimWghKCaX7mdhd4iL7/w/pnUc7LwYfZ4nBSgwgASuhej5rutFhuTDSnU=
=8dnn
-----END PGP SIGNATURE-----

--------------enigDC65854493518245CE064E31--


--===============4817141092980584925==
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
--===============4817141092980584925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============4817141092980584925==--


