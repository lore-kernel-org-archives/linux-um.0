Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <slyich@gmail.com>) id 1Q8YkL-0001nZ-DP
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Apr 2011 14:02:41 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q8YkK-00061S-EC
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Apr 2011 14:02:41 +0000
Received: by fxm19 with SMTP id 19so4722346fxm.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 09 Apr 2011 07:02:34 -0700 (PDT)
Date: Sat, 9 Apr 2011 17:04:54 +0300
From: Sergei Trofimovich <slyich@gmail.com>
Message-ID: <20110409170454.73aada78@sf>
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
Content-Type: multipart/mixed; boundary="===============0466977393050602646=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] btrfs failure and BUG_ON behaviour
To: user-mode-linux-devel@lists.sourceforge.net

--===============0466977393050602646==
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/saBPhRD7RPlZQdQb6iym+mK";
	protocol="application/pgp-signature"

--Sig_/saBPhRD7RPlZQdQb6iym+mK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I've decided to use UML when caught some hard to
debug OOpses on btrfs.

The first attempt to use btrfs on UML gave me stable
UML crash. I suspect it's a UML's problem.

So I have some questions here (I'm on x86_64,
2.6.39-rc2):

1. (major one) BUG_ON trace in UML does not look
   as in real kernel. ud2 handler does not show us nice
   backtrace, but calls some suspicious handler.

/mnt/btr # touch asd-`seq 1 10000`
[   95.540000] Kernel panic - not syncing: Kernel mode signal 4
[   95.540000] Call Trace:=20
[   95.540000] 602d9908:  [<60227a48>] panic+0xea/0x1e0
[   95.540000] 602d99b8:  [<600342ed>] do_softirq+0x4d/0x70
[   95.540000] 602d9a08:  [<60016947>] relay_signal+0x87/0xa0
[   95.540000] 602d9a18:  [<60021f70>] set_signals+0x30/0x40
[   95.540000] 602d9a38:  [<60021df9>] sig_handler_common+0x59/0xd0
[   95.540000] 602d9a58:  [<60021f2c>] real_alarm_handler+0x3c/0x50
[   95.540000] 602d9ae0:  [<6018c0a0>] strncpy+0x20/0x30
[   95.540000] 602d9b78:  [<6002200f>] sig_handler+0x3f/0x50
[   95.540000] 602d9b98:  [<600222a1>] handle_signal+0x71/0xb0
[   95.540000] 602d9be8:  [<60023630>] hard_handler+0x10/0x20
[   95.540000] 602d9ca8:  [<6011263c>] lookup_inline_extent_backref+0x2dc/0=
x3f0
[   95.540000]=20
[   95.540000]=20
[   95.540000] Pid: 1, comm: sh Not tainted 2.6.39-rc2+

   Here we have BUG_ON in lookup_inline_extent_backref+0x2dc/0x3f0, but tha=
t pesky
   hard_handler. Is it an UML bug or known and expected behaviour?

   Now I use 'gdb -p $pid' to get nicer backtrace:

Program received signal SIGILL, Illegal instruction.
lookup_inline_extent_backref (trans=3D0x70c6e000, root=3D<value optimized o=
ut>, path=3D0x70c82000,=20
    ref_ret=3D<value optimized out>, bytenr=3D<value optimized out>, num_by=
tes=3D<value optimized out>, parent=3D0,=20
    root_objectid=3D5, owner=3D0, offset=3D0, insert=3D0) at /home/slyfox/l=
inux-2.6/fs/btrfs/extent-tree.c:1399
1399            BUG_ON(ret);

   Can UML call the same ud2 handler as the real handler? We would see some=
thing like:

[  155.038388] kernel BUG at /mnt/archive/src/linux-2.6/fs/btrfs/inode.c:29=
67!
[  155.038643] invalid opcode: 0000 [#1] PREEMPT SMP=20

   How does UML implement running userspace processes and kernel threads in=
 it?
   I guess it's a problem, why UML can't distinct where ud2 comes from and =
call
   proper handler.

2. btrfs in UML does not work for me at all. It corrupts data right off
   the start. I only need to format the filesystem, touch there ~20
   files and I get corrupted FS:

   I run the following tiny script in UML:

/tools/mkfs.btrfs /dev/ubda
mount /mnt/btr/
cd /mnt/btr/
touch `seq 1 11`
ls

   The result is:
/ # ./kill_btr=20

WARNING! - Btrfs v0.19-35-g1b444cd-dirty IS EXPERIMENTAL
WARNING! - see http://btrfs.wiki.kernel.org before using

fs created label (null) on /dev/ubda
        nodesize 4096 leafsize 4096 sectorsize 4096 size 1.91GB
Btrfs v0.19-35-g1b444cd-dirty
[    2.770000] device fsid f2407093ae1f3a78-9e203194e541bfbd devid 1 transi=
d 7 /dev/ubda
[    2.770000] btrfS: invalid dir item name len: 12594
[    2.770000] btrfS: invalid dir item name len: 0
[    2.770000] btrfS: invalid dir item name len: 0
11=20

Corruption. Only last file is seen. Later, after unmount I get an OOps.

It does not happen in real OS. I've enabled all the corruption
detecting tehniques in the kernel config and it didn't change picture.
I can share .config if you like. kernel builds only 4 minutes on my slow
laptop.

Is there serious problems in UML block device handling?

I run UML this way:
./vmlinux                                        \
    ubd0=3D$(pwd)/btr.img                          \
    root=3D/dev/root                               \
    rootflags=3D"$(pwd)/root" rw rootfstype=3Dhostfs \
    mem=3D256M init=3D/init                          \

btr.img is a 2048000000 bytes sized file. rootfs contains statically linked
busybox and latest statically linked btrfs-progs. I can share my root if
you are interested. It's tiny (btrfs-progs tree is mounted from hostfs):
$ find root/ -type f
root/bin/busybox
root/bin/strace
root/kill_btr
root/etc/fstab
root/init

Thank you!

--=20

  Sergei

--Sig_/saBPhRD7RPlZQdQb6iym+mK
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk2gZ4sACgkQcaHudmEf86pRpQCfRAIjkRF1KVgzEaw/vPU7uaql
jCAAn3tmosua4HkKwUXaGZ+JmUFrx77u
=nwU1
-----END PGP SIGNATURE-----

--Sig_/saBPhRD7RPlZQdQb6iym+mK--


--===============0466977393050602646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
--===============0466977393050602646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0466977393050602646==--


