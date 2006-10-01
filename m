Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GTp1S-0003l7-J8 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Sep 2006 17:17:34 -0700
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GTp1R-0008Hr-5O
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Sep 2006 17:17:34 -0700
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GTp1D-0007xO-Sx for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 02:17:19 +0200
Received: from dslb-084-061-156-009.pools.arcor-ip.net ([84.61.156.9])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 01 Oct 2006 02:17:19 +0200
Received: from skoehler by dslb-084-061-156-009.pools.arcor-ip.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 01 Oct 2006 02:17:19 +0200
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Date: Sun, 01 Oct 2006 02:17:07 +0200
Message-ID: <efn1e9$46l$1@sea.gmane.org>
Mime-Version: 1.0
Subject: [uml-devel] 2.6.18 compile problem: undefined reference to
	crypto_tfm_ctx_offset
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0722942121=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0722942121==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6D5296E4E0A9C6F40E46B8FF"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D5296E4E0A9C6F40E46B8FF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I get this error:


# LANG=3DC make ARCH=3Dum vmlinux
make[1]: `arch/um/sys-i386/user-offsets.s' is up to date.
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/i386/crypto/built-in.o: In function `aes_enc_blk':
aes.c:(.text+0xd): undefined reference to `crypto_tfm_ctx_offset'
arch/i386/crypto/built-in.o: In function `aes_dec_blk':
aes.c:(.text+0xb95): undefined reference to `crypto_tfm_ctx_offset'
aes.c:(.text+0xb9c): undefined reference to `crypto_tfm_ctx_offset'
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
No valid symbol.
make: *** [.tmp_kallsyms1.S] Error 1



I guess, i just have to disable some crypto-stuff, but i wanted to
inform you about that.


--------------enig6D5296E4E0A9C6F40E46B8FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFHwkE7Ww7FjRBE4ARAlefAKCanVg4BeIiyViVkmHdaDHd8qZ7qgCdHnUN
MrbLI5o73kAeZl3i9/fPnQ8=
=4NUx
-----END PGP SIGNATURE-----

--------------enig6D5296E4E0A9C6F40E46B8FF--



--===============0722942121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0722942121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0722942121==--

