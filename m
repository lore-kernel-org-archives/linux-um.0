Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vKyK-0008M8-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 11:06:12 -0700
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vKyJ-00030J-Ln
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 11:06:11 -0700
Received: from 216-15-124-77.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com ([216.15.124.77] helo=mizar.alcor.net)
	by smtp01.mrf.mail.rcn.net with esmtp (Exim 3.35 #4)
	id 19vKyF-0004Kx-00
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 14:06:07 -0400
Received: from mdz by mizar.alcor.net with local (Exim 3.36 #1 (Debian))
	id 19vKyF-0000Ie-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 14:06:07 -0400
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20030905180607.GA1112@alcor.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
Subject: [uml-devel] [PATCH] uml_mkcow depends on PAGE_SIZE
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 5 Sep 2003 14:06:07 -0400
To: user-mode-linux-devel@lists.sourceforge.net



--St7VIuEGZ6dlpu13
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline



--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This caused uml_mkcow to fail to build on several Debian architectures.  It
is also my understanding that the page size can be different for different
systems within an architecture (and so needs to be determined at runtime).

--=20
 - mdz

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mkcow-pagesize.diff"
Content-Transfer-Encoding: quoted-printable

Index: moo/uml_mkcow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/debian/packages/uml-utilities/moo/uml_mkcow.c,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -u -r1.1.1.1 -r1.2
--- moo/uml_mkcow.c	3 Sep 2003 17:35:16 -0000	1.1.1.1
+++ moo/uml_mkcow.c	5 Sep 2003 17:06:47 -0000	1.2
@@ -2,6 +2,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <fcntl.h>
+#include <unistd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/user.h>
@@ -57,7 +58,7 @@
 	exit(1);
   }
  =20
-  if(init_cow_file(fd, cow_file, backing_file, 512, PAGE_SIZE,=20
+  if(init_cow_file(fd, cow_file, backing_file, 512, sysconf(_SC_PAGESIZE),=
=20
 		   &bitmap_offset_out, &bitmap_len_out, &data_offset_out)){
 	perror("write_cow_header");
 	exit(1);

--cNdxnHkX5QqsyA0e--

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/WNCPArxCt0PiXR4RAueTAKDAo/sUzeVlYfgQsPBOaeDS1LwtZQCeNbtG
wIB6ozo9pn/vskk5xVJDiLM=
=cC96
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
