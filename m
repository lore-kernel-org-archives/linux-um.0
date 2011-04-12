Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <slyich@gmail.com>) id 1Q9aZ1-0001q4-7Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2011 10:11:15 +0000
Received: from mail-ew0-f47.google.com ([209.85.215.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q9aZ0-0002H7-6K
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2011 10:11:15 +0000
Received: by ewy5 with SMTP id 5so2543661ewy.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Apr 2011 03:11:08 -0700 (PDT)
Date: Tue, 12 Apr 2011 13:13:33 +0300
From: Sergei Trofimovich <slyich@gmail.com>
Message-ID: <20110412131333.52140ee2@sf>
In-Reply-To: <BANLkTikkx-jgNDvh5NhhNvM-yWP2X3GgMA@mail.gmail.com>
References: <20110409170454.73aada78@sf>
	<BANLkTikkx-jgNDvh5NhhNvM-yWP2X3GgMA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0765560230385456121=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] btrfs failure and BUG_ON behaviour
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============0765560230385456121==
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/TVro5b06XkWIMTGa2U1d8LK";
	protocol="application/pgp-signature"

--Sig_/TVro5b06XkWIMTGa2U1d8LK
Content-Type: multipart/mixed; boundary="MP_/bfwg_MHk.evGIaC4Nuzfim."

--MP_/bfwg_MHk.evGIaC4Nuzfim.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 12 Apr 2011 01:13:30 +0200
richard -rw- weinberger <richard.weinberger@gmail.com> wrote:

> > =C2=A0 Here we have BUG_ON in lookup_inline_extent_backref+0x2dc/0x3f0,=
 but that pesky
> > =C2=A0 hard_handler. Is it an UML bug or known and expected behaviour? =
=20
>=20
> Can you please test the attached patch?
> The trace was broken long before I started working on UML.

Attached the BUG backtrace for a crash  without and with patch.
Patched one looks great!

The minor nit is Kbuild does not detect headers change, so I had to
'make clean' build dir first.

Thanks!

--=20

  Sergei

--MP_/bfwg_MHk.evGIaC4Nuzfim.
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=without-patch.txt

/ # rm -rf /mnt/btr/var_tmp/paludis/dev-lang-jhc-9999/
[   50.680000] Kernel panic - not syncing: Kernel mode signal 4
[   50.680000] Call Trace:=20
[   50.680000] 6023d918:  [<601a2342>] panic+0xea/0x1dc
[   50.680000] 6023d938:  [<6001c4a1>] ubd_intr+0x6d/0xc9
[   50.680000] 6023d978:  [<6004d5a9>] handle_irq_event_percpu+0x10a/0x126
[   50.680000] 6023d9c8:  [<6004d5e8>] handle_irq_event+0x23/0x2f
[   50.680000] 6023d9e8:  [<60018092>] free_irqs+0x72/0xdc
[   50.680000] 6023da18:  [<60016aa3>] relay_signal+0x38/0x79
[   50.680000] 6023da28:  [<600140d1>] sigio_handler+0x5a/0x5f
[   50.680000] 6023da48:  [<6001fc2d>] sig_handler_common+0x87/0x9b
[   50.680000] 6023da68:  [<6001fc7d>] real_alarm_handler+0x3c/0x3e
[   50.680000] 6023daf0:  [<6006cdab>] kernel_map_pages+0x73/0x18c
[   50.680000] 6023db78:  [<6001fd22>] sig_handler+0x30/0x3e
[   50.680000] 6023db98:  [<6001f93e>] handle_signal+0x72/0xa8
[   50.680000] 6023dbe8:  [<60020b3c>] hard_handler+0x10/0x14
[   50.680000] 6023dca8:  [<600d4985>] btrfs_unlink+0x75/0xbc
[   50.680000]=20
[   50.680000]=20
[   50.680000] Pid: 1, comm: busybox Not tainted 2.6.39-rc3
[   50.680000] RIP: 0033:[<00000000005443a7>]
[   50.680000] RSP: 0000007fbfe894f8  EFLAGS: 00000246
[   50.680000] RAX: ffffffffffffffda RBX: 00000000008536a0 RCX: fffffffffff=
fffff
[   50.680000] RDX: 0000007fbfe89500 RSI: 0000007fbfe89500 RDI: 00000000008=
536a0
[   50.680000] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[   50.680000] R10: 7263616d2d63612f R11: 0000000000000246 R12: 00000000000=
00000
[   50.680000] R13: 0000000040001010 R14: 00000000008536a0 R15: 00000000fff=
fffff
[   50.680000] Call Trace:=20
[   50.680000] 6023d898:  [<60016c99>] panic_exit+0x2f/0x45
[   50.680000] 6023d8b8:  [<600429ad>] notifier_call_chain+0x5f/0x96
[   50.680000] 6023d908:  [<60042a83>] atomic_notifier_call_chain+0xf/0x11
[   50.680000] 6023d918:  [<601a235d>] panic+0x105/0x1dc
[   50.680000] 6023d938:  [<6001c4a1>] ubd_intr+0x6d/0xc9
[   50.680000] 6023d978:  [<6004d5a9>] handle_irq_event_percpu+0x10a/0x126
[   50.680000] 6023d9c8:  [<6004d5e8>] handle_irq_event+0x23/0x2f
[   50.680000] 6023d9e8:  [<60018092>] free_irqs+0x72/0xdc
[   50.680000] 6023da18:  [<60016aa3>] relay_signal+0x38/0x79
[   50.680000] 6023da28:  [<600140d1>] sigio_handler+0x5a/0x5f
[   50.680000] 6023da48:  [<6001fc2d>] sig_handler_common+0x87/0x9b
[   50.680000] 6023da68:  [<6001fc7d>] real_alarm_handler+0x3c/0x3e
[   50.680000] 6023daf0:  [<6006cdab>] kernel_map_pages+0x73/0x18c
[   50.680000] 6023db78:  [<6001fd22>] sig_handler+0x30/0x3e
[   50.680000] 6023db98:  [<6001f93e>] handle_signal+0x72/0xa8
[   50.680000] 6023dbe8:  [<60020b3c>] hard_handler+0x10/0x14
[   50.680000] 6023dca8:  [<600d4985>] btrfs_unlink+0x75/0xbc
[   50.680000]=20

--MP_/bfwg_MHk.evGIaC4Nuzfim.
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=with-patch.txt

/ # rm -rf /mnt/btr/var_tmp/paludis/dev-lang-jhc-9999/
[   53.270000] BUG: failure at /mnt/archive/src/linux-2.6/fs/btrfs/inode.c:=
2962/btrfs_unlink()!
[   53.270000] Kernel panic - not syncing: BUG!
[   53.270000] Call Trace:=20
[   53.270000] 7fc9bc78:  [<601acc8e>] panic+0xea/0x1dc
[   53.270000] 7fc9bc98:  [<601ace20>] printk+0xa0/0xa8
[   53.270000] 7fc9bcf8:  [<600b80f2>] btrfs_free_path+0x2a/0x2f
[   53.270000] 7fc9bd48:  [<600daac7>] btrfs_unlink_inode+0x1b/0x3b
[   53.270000] 7fc9bd78:  [<600dabab>] btrfs_unlink+0xc4/0xee
[   53.270000] 7fc9bdb8:  [<6007ef54>] vfs_unlink+0x55/0x8e
[   53.270000] 7fc9bde8:  [<6007f055>] do_unlinkat+0xc8/0x156
[   53.270000] 7fc9be48:  [<6007746a>] sys_newlstat+0x29/0x34
[   53.270000] 7fc9bec8:  [<6007f11a>] sys_unlink+0x11/0x13
[   53.270000] 7fc9bed8:  [<600171dc>] handle_syscall+0x50/0x70
[   53.270000] 7fc9bef8:  [<60021aa9>] userspace+0x30f/0x3c9
[   53.270000] 7fc9bf58:  [<60001721>] kernel_init+0x0/0x103
[   53.270000] 7fc9bfc8:  [<60014955>] new_thread_handler+0x8d/0x9b
[   53.270000]=20
[   53.270000]=20
[   53.270000] Pid: 1, comm: busybox Not tainted 2.6.39-rc2+
[   53.270000] RIP: 0033:[<00000000005443a7>]
[   53.270000] RSP: 0000007fbfec0238  EFLAGS: 00000246
[   53.270000] RAX: ffffffffffffffda RBX: 00000000008536c0 RCX: fffffffffff=
fffff
[   53.270000] RDX: 0000007fbfec0240 RSI: 0000007fbfec0240 RDI: 00000000008=
536c0
[   53.270000] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[   53.270000] R10: 7263616d2d63612f R11: 0000000000000246 R12: 00000000000=
00000
[   53.270000] R13: 0000000040001010 R14: 00000000008536c0 R15: 00000000fff=
fffff
[   53.270000] Call Trace:=20
[   53.270000] 7fc9bbf8:  [<60016ce9>] panic_exit+0x2f/0x45
[   53.270000] 7fc9bc18:  [<60043571>] notifier_call_chain+0x5f/0x96
[   53.270000] 7fc9bc68:  [<60043647>] atomic_notifier_call_chain+0xf/0x11
[   53.270000] 7fc9bc78:  [<601acca9>] panic+0x105/0x1dc
[   53.270000] 7fc9bc98:  [<601ace20>] printk+0xa0/0xa8
[   53.270000] 7fc9bcf8:  [<600b80f2>] btrfs_free_path+0x2a/0x2f
[   53.270000] 7fc9bd48:  [<600daac7>] btrfs_unlink_inode+0x1b/0x3b
[   53.270000] 7fc9bd78:  [<600dabab>] btrfs_unlink+0xc4/0xee
[   53.270000] 7fc9bdb8:  [<6007ef54>] vfs_unlink+0x55/0x8e
[   53.270000] 7fc9bde8:  [<6007f055>] do_unlinkat+0xc8/0x156
[   53.270000] 7fc9be48:  [<6007746a>] sys_newlstat+0x29/0x34
[   53.270000] 7fc9bec8:  [<6007f11a>] sys_unlink+0x11/0x13
[   53.270000] 7fc9bed8:  [<600171dc>] handle_syscall+0x50/0x70
[   53.270000] 7fc9bef8:  [<60021aa9>] userspace+0x30f/0x3c9
[   53.270000] 7fc9bf58:  [<60001721>] kernel_init+0x0/0x103
[   53.270000] 7fc9bfc8:  [<60014955>] new_thread_handler+0x8d/0x9b

--MP_/bfwg_MHk.evGIaC4Nuzfim.--

--Sig_/TVro5b06XkWIMTGa2U1d8LK
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk2kJdEACgkQcaHudmEf86rqngCffdmz5ICvwYqrLMXE5PK2TZ7X
/IsAnjPMCjeZpkXjhTBPcARZ7trgXXZI
=RTd5
-----END PGP SIGNATURE-----

--Sig_/TVro5b06XkWIMTGa2U1d8LK--


--===============0765560230385456121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
--===============0765560230385456121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0765560230385456121==--


