Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KGx09-0005YC-1L for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 07:20:05 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1KGx08-00032v-2A
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 07:20:04 -0700
From: Toralf =?iso-8859-15?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Thu, 10 Jul 2008 16:19:51 +0200
MIME-Version: 1.0
Message-Id: <200807101619.54052.toralf.foerster@gmx.de>
Subject: [uml-devel] UML kernel failed to start betvee 2.6.8-rc8 and current
	git sources
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2116986924=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

--===============2116986924==
Content-Type: multipart/signed; boundary="nextPart202621813.ZLCUdcvA5Z";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart202621813.ZLCUdcvA5Z
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hm,

from v2.6.26-rc8 to v2.6.26-rc9-56-g6329d30 sth. affected UML, b/c my user =
mode linux kernel produces this :

=2E..
VFS: Mounted root (ext3 filesystem) readonly.
Registers -
        0       0x0
        1       0x0
        2       0x0
        3       0x0
        4       0x0
        5       0x0
        6       0x0
        7       0x0
        8       0x0
        9       0x0
        10      0x0
        11      0x0
        12      0x0
        13      0x0
        14      0x0
        15      0x0
        16      0x0
Kernel panic - not syncing: do_syscall_stub : PTRACE_SETREGS failed, errno =
=3D 5


EIP: 0073:[<b7eef424>] CPU: 0 Not tainted ESP: 007b:bfc0acf0 EFLAGS: 002002=
46
    Not tainted
EAX: 00000000 EBX: 00002e8f ECX: 00000013 EDX: 00002e8f
ESI: 00002e8b EDI: 00000000 EBP: 00000002 DS: 007b ES: 007b
17c6bd00:  [<080927c3>] notifier_call_chain+0x43/0x90
17c6bd24:  [<0809286e>] atomic_notifier_call_chain+0x2e/0x40
17c6bd3c:  [<08078eb6>] panic+0x76/0x110
17c6bd5c:  [<0806e4d3>] run_syscall_stub+0x2f3/0x300
17c6bd90:  [<0807044d>] write_ldt_entry+0x1ad/0x1c0
17c6bdd8:  [<08070c0e>] init_new_ldt+0x18e/0x3d0
17c6bdf0:  [<080a55a7>] __alloc_pages_internal+0x87/0x450
17c6be1c:  [<0806f105>] start_userspace+0x1a5/0x1f0
17c6be50:  [<0805ede1>] init_new_context+0x91/0x140
17c6be6c:  [<080c6789>] bprm_mm_init+0x49/0x1c0
17c6be78:  [<0806c485>] set_signals+0x25/0x30
17c6be80:  [<080be18a>] kmem_cache_alloc+0x4a/0xa0
17c6be98:  [<080c7e73>] do_execve+0x83/0x1e0
17c6bebc:  [<0805a685>] execve1+0x35/0x60
17c6bedc:  [<0805a714>] um_execve+0x14/0x50
17c6bee0:  [<080ce4cb>] dupfd+0xfb/0x130
17c6beec:  [<0805ce8f>] kernel_execve+0x3f/0x50
17c6bf08:  [<0805a302>] run_init_process+0x22/0x30
17c6bf18:  [<0805a3c6>] init_post+0xb6/0x100
17c6bf2c:  [<080496e1>] kernel_init+0x251/0x2b0
17c6bf54:  [<08055400>] tcp_congestion_default+0x0/0x20
17c6bfa4:  [<08075b36>] finish_task_switch+0x26/0x80
17c6bfbc:  [<0806b0b3>] run_kernel_thread+0x43/0x50
17c6bfd8:  [<0806b08f>] run_kernel_thread+0x1f/0x50
17c6bfe4:  [<0805be11>] new_thread_handler+0x61/0x90
17c6bfe8:  [<08049490>] kernel_init+0x0/0x2b0

Terminated

=2D-=20
MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

--nextPart202621813.ZLCUdcvA5Z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkh2GokACgkQhyrlCH22naNkaACfRsB3ASYdHiiFvjhtTsE5sKkf
A1oAoIhRYBKXEhEP+ImNQUrFuAvYwHKE
=hY0a
-----END PGP SIGNATURE-----

--nextPart202621813.ZLCUdcvA5Z--


--===============2116986924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============2116986924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2116986924==--

