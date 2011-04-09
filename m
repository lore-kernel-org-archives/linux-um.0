Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <richard.weinberger@gmail.com>) id 1Q8fmN-00047h-OJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Apr 2011 21:33:15 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q8fmM-0004Sz-Un
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Apr 2011 21:33:15 +0000
Received: by mail-iw0-f175.google.com with SMTP id 10so6122491iwn.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 09 Apr 2011 14:33:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110409170454.73aada78@sf>
References: <20110409170454.73aada78@sf>
Date: Sat, 9 Apr 2011 23:33:14 +0200
Message-ID: <BANLkTikjjWR2Ki0aNoTBhecodkGpW2cUzw@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] btrfs failure and BUG_ON behaviour
To: Sergei Trofimovich <slyich@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Apr 9, 2011 at 4:04 PM, Sergei Trofimovich <slyich@gmail.com> wrote:
> I've decided to use UML when caught some hard to
> debug OOpses on btrfs.
>
> The first attempt to use btrfs on UML gave me stable
> UML crash. I suspect it's a UML's problem.
>
> So I have some questions here (I'm on x86_64,
> 2.6.39-rc2):
>
> 1. (major one) BUG_ON trace in UML does not look
> =A0 as in real kernel. ud2 handler does not show us nice
> =A0 backtrace, but calls some suspicious handler.
>
> /mnt/btr # touch asd-`seq 1 10000`
> [ =A0 95.540000] Kernel panic - not syncing: Kernel mode signal 4
> [ =A0 95.540000] Call Trace:
> [ =A0 95.540000] 602d9908: =A0[<60227a48>] panic+0xea/0x1e0
> [ =A0 95.540000] 602d99b8: =A0[<600342ed>] do_softirq+0x4d/0x70
> [ =A0 95.540000] 602d9a08: =A0[<60016947>] relay_signal+0x87/0xa0
> [ =A0 95.540000] 602d9a18: =A0[<60021f70>] set_signals+0x30/0x40
> [ =A0 95.540000] 602d9a38: =A0[<60021df9>] sig_handler_common+0x59/0xd0
> [ =A0 95.540000] 602d9a58: =A0[<60021f2c>] real_alarm_handler+0x3c/0x50
> [ =A0 95.540000] 602d9ae0: =A0[<6018c0a0>] strncpy+0x20/0x30
> [ =A0 95.540000] 602d9b78: =A0[<6002200f>] sig_handler+0x3f/0x50
> [ =A0 95.540000] 602d9b98: =A0[<600222a1>] handle_signal+0x71/0xb0
> [ =A0 95.540000] 602d9be8: =A0[<60023630>] hard_handler+0x10/0x20
> [ =A0 95.540000] 602d9ca8: =A0[<6011263c>] lookup_inline_extent_backref+0=
x2dc/0x3f0
> [ =A0 95.540000]
> [ =A0 95.540000]
> [ =A0 95.540000] Pid: 1, comm: sh Not tainted 2.6.39-rc2+
>
> =A0 Here we have BUG_ON in lookup_inline_extent_backref+0x2dc/0x3f0, but =
that pesky
> =A0 hard_handler. Is it an UML bug or known and expected behaviour?

It's expected behavior.

> =A0 Now I use 'gdb -p $pid' to get nicer backtrace:
>
> Program received signal SIGILL, Illegal instruction.
> lookup_inline_extent_backref (trans=3D0x70c6e000, root=3D<value optimized=
 out>, path=3D0x70c82000,
> =A0 =A0ref_ret=3D<value optimized out>, bytenr=3D<value optimized out>, n=
um_bytes=3D<value optimized out>, parent=3D0,
> =A0 =A0root_objectid=3D5, owner=3D0, offset=3D0, insert=3D0) at /home/sly=
fox/linux-2.6/fs/btrfs/extent-tree.c:1399
> 1399 =A0 =A0 =A0 =A0 =A0 =A0BUG_ON(ret);
>
> =A0 Can UML call the same ud2 handler as the real handler? We would see s=
omething like:

It's on my maybe-TODO list. :-)

>
> [ =A0155.038388] kernel BUG at /mnt/archive/src/linux-2.6/fs/btrfs/inode.=
c:2967!
> [ =A0155.038643] invalid opcode: 0000 [#1] PREEMPT SMP
>
> =A0 How does UML implement running userspace processes and kernel threads=
 in it?
> =A0 I guess it's a problem, why UML can't distinct where ud2 comes from a=
nd call
> =A0 proper handler.

UML can distinct the source of ud2. Otherwise any process within UML
could kill the kernel.

> 2. btrfs in UML does not work for me at all. It corrupts data right off
> =A0 the start. I only need to format the filesystem, touch there ~20
> =A0 files and I get corrupted FS:
>
> =A0 I run the following tiny script in UML:
>
> /tools/mkfs.btrfs /dev/ubda
> mount /mnt/btr/
> cd /mnt/btr/
> touch `seq 1 11`
> ls
>
> =A0 The result is:
> / # ./kill_btr
>
> WARNING! - Btrfs v0.19-35-g1b444cd-dirty IS EXPERIMENTAL
> WARNING! - see http://btrfs.wiki.kernel.org before using
>
> fs created label (null) on /dev/ubda
> =A0 =A0 =A0 =A0nodesize 4096 leafsize 4096 sectorsize 4096 size 1.91GB
> Btrfs v0.19-35-g1b444cd-dirty
> [ =A0 =A02.770000] device fsid f2407093ae1f3a78-9e203194e541bfbd devid 1 =
transid 7 /dev/ubda
> [ =A0 =A02.770000] btrfS: invalid dir item name len: 12594
> [ =A0 =A02.770000] btrfS: invalid dir item name len: 0
> [ =A0 =A02.770000] btrfS: invalid dir item name len: 0
> 11
>
> Corruption. Only last file is seen. Later, after unmount I get an OOps.
>
> It does not happen in real OS. I've enabled all the corruption
> detecting tehniques in the kernel config and it didn't change picture.
> I can share .config if you like. kernel builds only 4 minutes on my slow
> laptop.
>
> Is there serious problems in UML block device handling?

I hope not!
We have had some problems with the block layer in ~2.6.32 to 2.6.35.
Commit 4752690 fixed the issues.

Can you please re-test it with 2.6.38?
Does you script work with other file systems?

> I run UML this way:
> ./vmlinux =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0\
> =A0 =A0ubd0=3D$(pwd)/btr.img =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0\
> =A0 =A0root=3D/dev/root =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 \
> =A0 =A0rootflags=3D"$(pwd)/root" rw rootfstype=3Dhostfs \
> =A0 =A0mem=3D256M init=3D/init =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0\
>
> btr.img is a 2048000000 bytes sized file. rootfs contains statically link=
ed
> busybox and latest statically linked btrfs-progs. I can share my root if
> you are interested. It's tiny (btrfs-progs tree is mounted from hostfs):
> $ find root/ -type f
> root/bin/busybox
> root/bin/strace
> root/kill_btr
> root/etc/fstab
> root/init
>
> Thank you!
>
> --
>
> =A0Sergei
>
> -------------------------------------------------------------------------=
-----
> Xperia(TM) PLAY
> It's a major breakthrough. An authentic gaming
> smartphone on the nation's most reliable network.
> And it wants your games.
> http://p.sf.net/sfu/verizon-sfdev
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>
>

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

