Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BkzOt-0000Jy-Jk for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Jul 2004 23:07:23 -0700
Received: from heretic.physik.fu-berlin.de ([160.45.32.227])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BkzOs-000843-W5
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Jul 2004 23:07:23 -0700
From: Axel Thimm <Axel.Thimm@ATrpms.net>
Message-ID: <20040715060709.GA11167@neu.nirvana>
References: <40C20E43.1090305@morpheux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <40C20E43.1090305@morpheux.org>
Subject: [uml-devel] Re: 2.6.6 compile crashing on Fed Core 2
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
Date: Thu, 15 Jul 2004 08:07:09 +0200
To: Faye Gibbins <wibble@morpheux.org>
Cc: user-mode-linux-devel@lists.sourceforge.net



--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 05, 2004 at 07:17:39PM +0100, Faye Gibbins wrote:
> Just finished compiling 2.6.6 with UML patch 2.6.6-1. compile crashed wit=
h:
>=20
> snip---
>=20
> gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free=20
> -Wl,--wrap,calloc \
>         -o linux arch/um/main.o vmlinux -L/usr/lib -lutil
> vmlinux(.text+0x605f): In function `mem_init':
> arch/um/kernel/mem.c:71: undefined reference to `phys_page'
> vmlinux(.init.text+0x3380): In function `kmap_init':
> include/asm/pgtable.h:394: undefined reference to `pte_offset'
> collect2: ld returned 1 exit status
> make: *** [linux] Error 1
> Died at get_uml_patch.pl line 173.
>=20
> snip---
>=20
> gcc 3.3.3
>=20
> On a PII 233 with a fresh Fed Core 2 install (everythign installed) plus=
=20
> all current updates as of 30 May 04.

Did you solve this? I am seeing the same with 2.6.7 & blazorblade's patches.

> Can supply kernel '.config' and build script (perl) upon request, but=20
> essentially I'm doing :
>=20
> snip---
>=20
> use constant K =3D> '2.6.6';
> use constant TMP =3D> '/tmp/';
> use constant PATCHWWW =3D>=20
> 'http://heanet.dl.sourceforge.net/sourceforge/user-mode-linux/';
> use constant PATCH =3D> 'uml-patch-'.K.'-1';
> use constant PATCHMD5BZ2 =3D> 'ac6131657b587aba2d306d3708142ec6';
> use constant PATCHMD5 =3D> '7c27d8acc8aa0ea6fe8dec712b0d4462';
> use constant KWWW =3D>=20
> 'http://www.mirror.ac.uk/sites/ftp.kernel.org/pub/linux/kernel/v2.6/';
> use constant KERNEL =3D> 'linux-'.K.'.tar';
> use constant KMD5BZ2 =3D> '5218790bc3db41e77a7422969639a9ad';
> use constant KMD5 =3D> 'eaf803a496e7b8458ba332b04b89c0c0';
>=20
> #.....
>=20
>     chdir TMP || die "$!";
>=20
>     system("tar","-xf",TMP.KERNEL)&&die"$!";
>=20
>     chdir TMP."/linux-".K || die "$!";
>=20
>     print "Patching...";
>     {
> 	open(P,"<",TMP.PATCH)||die"$!";
> 	my @p =3D <P>;
> 	close P;
> =09
> 	open(OUT,"| patch -p1")||die"$!";
> 	print OUT @p;
> 	close OUT || die"$!";
>     }
>=20
> #.....
>=20
> copy("$FindBin::Bin/uml.2.6.6",TMP."/linux-".K."/.config")||die"$!";
>=20
> chdir TMP."/linux-".K || die "$!";
>=20
> system("make oldconfig ARCH=3Dum") && die "$!";
> system("make linux ARCH=3Dum") && die "$!";
>=20
> snip---
>=20
> Any help would be appreciated.
>=20

--=20
Axel.Thimm at ATrpms.net

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA9h8NQBVS1GOamfERAiEgAKCQbr3CCZoQlASXId0v60efCQb0dgCggslY
jWjvSyktPN5kjOepne/Q1ak=
=JfPr
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
