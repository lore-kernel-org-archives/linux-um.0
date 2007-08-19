Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IMnOU-0003Nz-G9 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Aug 2007 09:12:53 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1IMnOQ-0003Es-MU
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Aug 2007 09:12:48 -0700
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Sun, 19 Aug 2007 18:12:33 +0200
References: <200708191142.57281.toralf.foerster@gmx.de>
	<20070819155746.GA5896@c2.user-mode-linux.org>
In-Reply-To: <20070819155746.GA5896@c2.user-mode-linux.org>
MIME-Version: 1.0
Message-Id: <200708191812.35947.toralf.foerster@gmx.de>
Subject: Re: [uml-devel] build error of an UML kernel with 2.6.2x sources
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1480638971=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============1480638971==
Content-Type: multipart/signed; boundary="nextPart1734526.QC8AspmKIm";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1734526.QC8AspmKIm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sonntag, 19. August 2007 schrieb Jeff Dike:
> On Sun, Aug 19, 2007 at 11:42:55AM +0200, Toralf F=F6rster wrote:
> > arch/um/sys-i386/user-offsets.c:7:22: error: asm/user.h: No such file o=
r directory
> > arch/um/sys-i386/user-offsets.c: In function 'foo':
> > arch/um/sys-i386/user-offsets.c:51: error: invalid application of 'size=
of' to incomplete type 'struct user_i387_struct'
>=20
> What's the host distro?

Im using Gentoo Linux with sys-kernel/linux-headers-2.6.21 and
the kernel sys-kernel/gentoo-sources-2.6.22-r4 (=3D=3D 2.6.22.3 + Gentoo sp=
ecific
patches)

> Do you have either user_i387_struct or elf_fpregset_t anywhere in your
> /usr/include?   If not, then your headers are broken, as there is no
> way to use PTRACE_GETFPREG since you can't tell how big a buffer to
> pass in.
I found a definition of elf_fpregset_t within incluce files from the glibc
package:

tfoerste@n22 /usr/include $ grep -Hir user_i387_struct *

tfoerste@n22 /usr/include $ grep -Hir elf_fpregset_t *
sys/procfs.h:typedef struct user_fpregs_struct elf_fpregset_t;
sys/procfs.h:typedef elf_fpregset_t prfpregset_t;

tfoerste@n22 /usr/include $ equery b sys/procfs.h
[ Searching for file(s) sys/procfs.h in *... ]
sys-libs/glibc-2.5-r4 (/usr/include/sys/procfs.h)


=2D-=20
MfG/Sincerely

Toralf F=F6rster

--nextPart1734526.QC8AspmKIm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGyGvyhyrlCH22naMRAsEIAJ9NdPy1peXGX6cqh++rJ4OM1XYUNgCfSyHU
PVkr+01qeUl/PsUPd3k5Fl8=
=XWeT
-----END PGP SIGNATURE-----

--nextPart1734526.QC8AspmKIm--


--===============1480638971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1480638971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1480638971==--

