Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <slyich@gmail.com>) id 1SElkT-0005Hb-Nz
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 18:13:01 +0000
Received: from mail-we0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SElkO-0000ql-6V
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 18:13:01 +0000
Received: by wera1 with SMTP id a1so2511978wer.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 02 Apr 2012 11:12:50 -0700 (PDT)
Date: Mon, 2 Apr 2012 21:17:30 +0300
From: Sergei Trofimovich <slyich@gmail.com>
Message-ID: <20120402211730.19f6baaf@sf.home>
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6688012752837425785=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] 3.4.0-rc1 is broken due to asm/system.h restructure
To: user-mode-linux-devel@lists.sourceforge.net
Cc: David Howells <dhowells@redhat.com>

--===============6688012752837425785==
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/5nVMm_hfkcGo+myxmK7/FaX";
	protocol="application/pgp-signature"

--Sig_/5nVMm_hfkcGo+myxmK7/FaX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

The asm/system.h patches missed ARCH=3Dum
which caused build breakage [2].

The commit can be used as an example [2].
I've failed to produce fix myself. Sorry.

[1]:
> commit f05e798ad4c09255f590f5b2c00a7ca6c172f983
> Author: David Howells <dhowells@redhat.com>
> Date:   Wed Mar 28 18:11:12 2012 +0100
>
>    Disintegrate asm/system.h for X86

[2]:
linux-2.6/arch/um/drivers/mconsole_kern.c: In function 'stack_proc':
linux-2.6/arch/um/drivers/mconsole_kern.c:707:2: error: implicit declaratio=
n of function 'switch_to'
make[2]: *** [arch/um/drivers/mconsole_kern.o] Error 1
make[2]: Target `__build' not remade because of errors.
make[1]: *** [arch/um/drivers] Error 2
  CC      kernel/sys.o
  CC      kernel/sched/core.o
linux-2.6/kernel/sched/core.c: In function 'context_switch':
linux-2.6/kernel/sched/core.c:2086:2: error: expected ':' or ')' before '__=
percpu_arg'
make[3]: *** [kernel/sched/core.o] Error 1
make[3]: Target `__build' not remade because of errors.
make[2]: *** [kernel/sched] Error 2
make[2]: Target `__build' not remade because of errors.
make[1]: *** [kernel] Error 2
  CC      fs/exec.o
linux-2.6/fs/exec.c: In function 'setup_arg_pages':
linux-2.6/fs/exec.c:686:2: error: implicit declaration of function 'arch_al=
ign_stack'
make[2]: *** [fs/exec.o] Error 1
  CC      fs/binfmt_elf.o
linux-2.6/fs/binfmt_elf.c: In function 'create_elf_tables':
linux-2.6/fs/binfmt_elf.c:165:2: error: implicit declaration of function 'a=
rch_align_stack'
make[2]: *** [fs/binfmt_elf.o] Error 1
make[2]: Target `__build' not remade because of errors.
make[1]: *** [fs] Error 2
make[1]: Target `_all' not remade because of errors.
make: *** [sub-make] Error 2
make: Target `_all' not remade because of errors.
make: Leaving directory `linux-2.6'

--=20

  Sergei

--Sig_/5nVMm_hfkcGo+myxmK7/FaX
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk957TsACgkQcaHudmEf86ohrwCffzhbVKIZa06cKIKflh+klokV
qVMAn3rH5IjgWyznaJI2rqXxJOn+Q4vZ
=U7cv
-----END PGP SIGNATURE-----

--Sig_/5nVMm_hfkcGo+myxmK7/FaX--


--===============6688012752837425785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============6688012752837425785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============6688012752837425785==--


