Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GlOdq-00066U-V4 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Nov 2006 03:45:51 -0800
Received: from nf-out-0910.google.com ([64.233.182.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GlOdq-0007hr-3f
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Nov 2006 03:45:50 -0800
Received: by nf-out-0910.google.com with SMTP id c31so3013697nfb
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 18 Nov 2006 03:45:48 -0800 (PST)
Message-ID: <22a33e9f0611180345w7ec64513l34424a59e1671479@mail.gmail.com>
Date: Sat, 18 Nov 2006 11:45:48 +0000
From: "Matt Willsher" <matt@monki.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] Problem with newer (>2.6.14) UML kernels hanging under
	Xen DomU/Centos 4.4
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

I've been trying to get UML running under a Xen DomU running Centos
4.4, which I understand is a reasonable thing to do.

When I started out I was using a download 2.6.12 kernel and the image
booted up fine. I then tried 2.6.18.2, which is hanging after VFS:
Mounted root (ext3 filesystem) readonly. I've had someone check my
kernel and the image on another machine and it works without problem.
I've tried some other kernels, and 2.6.14 seemed ok, 2.6.16 wasn't.

I've had some problems with TLS under Xen running Berkely DB, so have
rebuilt glibc with native threading disabled, but /lib/tls is still
there because Bdb complains if it's removed.

Below I've give the process list at the time, backtraces of each of
these processes and the output of the ./linux ubd0=root_fs_router
command.  Let me know if more output is required

Any help is very much appreciated.

Thanks,
Matt

The UML processes that are running at this time are:

matt     15425 15415  0 11:22 pts/1    00:00:00 ./linux
ubd0=/home/uml/router/root_fs_router
matt     15430 15415  0 11:22 pts/1    00:00:00 ./linux
ubd0=/home/uml/router/root_fs_router
matt     15431 15415 43 11:22 pts/1    00:07:04 [linux]
matt     15415 17607 50 11:22 pts/1    00:08:09 ./linux
ubd0=/home/uml/router/root_fs_router
matt     15424 15415  0 11:22 pts/1    00:00:00 ./linux
ubd0=/home/uml/router/root_fs_router

15431 and 15415 are taking 100% CPU between then.

backtraces of those PIDs result in:

PID 15425:
#0  0xb7eaddbe in __read_nocancel () from /lib/tls/i686/libc.so.6
#1  0x08070510 in file_io () at include/linux/sched.h:1439
#2  0x0806d5b7 in io_thread (arg=0x0) at arch/um/drivers/ubd_kern.c:1374
#3  0xb7ebbcbe in clone () from /lib/tls/i686/libc.so.6


PID 15430:
#0  0xb7eb2e3a in poll () from /lib/tls/i686/libc.so.6
#1  0x08072b55 in write_sigio_thread () at include/linux/sched.h:1439
#2  0xb7ebbcbe in clone () from /lib/tls/i686/libc.so.6

PID 15431:
Operation not permitted at attach

PID 15415:
#0  0xb7eb5bff in ptrace (request=3086049268) at
../sysdeps/unix/sysv/linux/ptrace.c:104
#1  0x08077352 in userspace () at include/linux/sched.h:1439
#2  0x08061c79 in new_thread_handler (sig=10) at include/asm/thread_info.h:46
#3  <signal handler called>
#4  0xb7e29041 in kill () at ../string/bits/string2.h:1000
#5  0x0828b580 in init_thread_union ()
#6  0x080735aa in set_signals () at include/linux/sched.h:1439
#7  0x08077b78 in new_thread () at include/linux/sched.h:1439
#8  0x00000000 in ?? ()

PID 15424:
#0  0xb7eaddbe in __read_nocancel () from /lib/tls/i686/libc.so.6
#1  0x08070510 in file_io () at include/linux/sched.h:1439
#2  0x0806f95e in not_aio_thread () at include/linux/sched.h:1439
#3  0xb7ebbcbe in clone () from /lib/tls/i686/libc.so.6


Output from ./linux ubd0=./root_fs_router:

[42949372.960000] Linux version 2.6.18.2 (root@localhost)
(gcc version 3.4.6 20060404 (Red Hat 3.4.6-3)) #4 Sat Nov 18 11:13:34 GMT 2006
[42949372.960000] Built 1 zonelists.  Total pages: 8192
[42949372.960000] Kernel command line:
ubd0=/home/uml/router/root_fs_router root=98:0
[42949372.960000] PID hash table entries: 256 (order: 8, 1024 bytes)
[42949372.960000] ------------------------
[42949372.960000] | Locking API testsuite:
[42949372.960000]
----------------------------------------------------------------------------
[42949372.960000]                                  | spin |wlock
|rlock |mutex | wsem | rsem |
[42949372.960000]
--------------------------------------------------------------------------
[42949372.960000]                      A-A deadlock:failed|failed|  ok
 |failed|failed|failed|
[42949372.960000]                  A-B-B-A deadlock:failed|failed|  ok
 |failed|failed|failed|
[42949372.960000]              A-B-B-C-C-A deadlock:failed|failed|  ok
 |failed|failed|failed|
[42949372.960000]              A-B-C-A-B-C deadlock:failed|failed|  ok
 |failed|failed|failed|
[42949372.960000]          A-B-B-C-C-D-D-A deadlock:failed|failed|  ok
 |failed|failed|failed|
[42949372.960000]          A-B-C-D-B-D-D-A deadlock:failed|failed|  ok
 |failed|failed|failed|
[42949372.960000]          A-B-C-D-B-C-D-A deadlock:failed|failed|  ok
 |failed|failed|failed|
[42949372.960000]                     double unlock:  ok  |  ok
|failed|  ok  |failed|failed|
[42949372.960000]                   initialize
held:failed|failed|failed|failed|failed|failed|
[42949372.960000]                  bad unlock order:  ok  |  ok  |  ok
 |  ok  |  ok  |  ok  |
[42949372.960000]
--------------------------------------------------------------------------
[42949372.960000]               recursive read-lock:             |  ok
 |             |failed|
[42949372.960000]            recursive read-lock #2:             |  ok
 |             |failed|
[42949372.960000]             mixed read-write-lock:
|failed|             |failed|
[42949372.960000]             mixed write-read-lock:
|failed|             |failed|
[42949372.960000]
--------------------------------------------------------------------------
[42949372.960000]      hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
[42949372.960000]      soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
[42949372.960000]      hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
[42949372.960000]      soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
[42949372.960000]        sirq-safe-A => hirqs-on/12:failed|failed|  ok  |
[42949372.960000]        sirq-safe-A => hirqs-on/21:failed|failed|  ok  |
[42949372.960000]          hard-safe-A + irqs-on/12:failed|failed|  ok  |
[42949372.960000]          soft-safe-A + irqs-on/12:failed|failed|  ok  |
[42949372.960000]          hard-safe-A + irqs-on/21:failed|failed|  ok  |
[42949372.960000]          soft-safe-A + irqs-on/21:failed|failed|  ok  |
[42949372.960000]     hard-safe-A + unsafe-B #1/123:failed|failed|  ok  |
[42949372.960000]     soft-safe-A + unsafe-B #1/123:failed|failed|  ok  |
[42949372.960000]     hard-safe-A + unsafe-B #1/132:failed|failed|  ok  |
[42949372.960000]     soft-safe-A + unsafe-B #1/132:failed|failed|  ok  |
[42949372.960000]     hard-safe-A + unsafe-B #1/213:failed|failed|  ok  |
[42949372.960000]     soft-safe-A + unsafe-B #1/213:failed|failed|  ok  |
[42949372.960000]     hard-safe-A + unsafe-B #1/231:failed|failed|  ok  |
[42949372.960000]     soft-safe-A + unsafe-B #1/231:failed|failed|  ok  |
[42949372.960000]     hard-safe-A + unsafe-B #1/312:failed|failed|  ok  |
[42949372.960000]     soft-safe-A + unsafe-B #1/312:failed|failed|  ok  |
[42949372.960000]     hard-safe-A + unsafe-B #1/321:failed|failed|  ok  |
[42949372.960000]     soft-safe-A + unsafe-B #1/321:failed|failed|  ok  |
[42949372.960000]     hard-safe-A + unsafe-B #2/123:failed|failed|  ok  |
[42949372.960000]     soft-safe-A + unsafe-B #2/123:failed|failed|  ok  |
[42949372.960000]     hard-safe-A + unsafe-B #2/132:failed|failed|  ok  |
[42949372.960000]     soft-safe-A + unsafe-B #2/132:failed|failed|  ok  |
[42949372.960000]     hard-safe-A + unsafe-B #2/213:failed|failed|  ok  |
[42949372.960000]     soft-safe-A + unsafe-B #2/213:failed|failed|  ok  |
[42949372.960000]     hard-safe-A + unsafe-B #2/231:failed|failed|  ok  |
[42949372.960000]     soft-safe-A + unsafe-B #2/231:failed|failed|  ok  |
[42949372.960000]     hard-safe-A + unsafe-B #2/312:failed|failed|  ok  |
[42949372.960000]     soft-safe-A + unsafe-B #2/312:failed|failed|  ok  |
[42949372.960000]     hard-safe-A + unsafe-B #2/321:failed|failed|  ok  |
[42949372.960000]     soft-safe-A + unsafe-B #2/321:failed|failed|  ok  |
[42949372.960000]       hard-irq lock-inversion/123:failed|failed|  ok  |
[42949372.960000]       soft-irq lock-inversion/123:failed|failed|  ok  |
[42949372.960000]       hard-irq lock-inversion/132:failed|failed|  ok  |
[42949372.960000]       soft-irq lock-inversion/132:failed|failed|  ok  |
[42949372.960000]       hard-irq lock-inversion/213:failed|failed|  ok  |
[42949372.960000]       soft-irq lock-inversion/213:failed|failed|  ok  |
[42949372.960000]       hard-irq lock-inversion/231:failed|failed|  ok  |
[42949372.960000]       soft-irq lock-inversion/231:failed|failed|  ok  |
[42949372.960000]       hard-irq lock-inversion/312:failed|failed|  ok  |
[42949372.960000]       soft-irq lock-inversion/312:failed|failed|  ok  |
[42949372.960000]       hard-irq lock-inversion/321:failed|failed|  ok  |
[42949372.960000]       soft-irq lock-inversion/321:failed|failed|  ok  |
[42949372.960000]       hard-irq read-recursion/123:  ok  |
[42949372.960000]       soft-irq read-recursion/123:  ok  |
[42949372.960000]       hard-irq read-recursion/132:  ok  |
[42949372.960000]       soft-irq read-recursion/132:  ok  |
[42949372.960000]       hard-irq read-recursion/213:  ok  |
[42949372.960000]       soft-irq read-recursion/213:  ok  |
[42949372.960000]       hard-irq read-recursion/231:  ok  |
[42949372.960000]       soft-irq read-recursion/231:  ok  |
[42949372.960000]       hard-irq read-recursion/312:  ok  |
[42949372.960000]       soft-irq read-recursion/312:  ok  |
[42949372.960000]       hard-irq read-recursion/321:  ok  |
[42949372.960000]       soft-irq read-recursion/321:  ok  |
[42949372.960000] --------------------------------------------------------
[42949372.960000] 142 out of 218 testcases failed, as expected. |
[42949372.960000] ----------------------------------------------------
[42949372.960000] Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
[42949372.960000] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
[42949372.960000] Memory: 29408k available
[42949373.480000] Mount-cache hash table entries: 512
[42949373.480000] Checking for host processor cmov support...Yes
[42949373.480000] Checking for host processor xmm support...No
[42949373.480000] Checking that host ptys support output SIGIO...Yes
[42949373.480000] Checking that host ptys support SIGIO on close...No,
enabling workaround
[42949373.480000] /usr/include/linux/aio_abi.h not present during build
[42949373.480000] 2.6 host AIO support not used - falling back to I/O thread
[42949373.480000] NET: Registered protocol family 16
[42949373.480000] NET: Registered protocol family 2
[42949373.660000] IP route cache hash table entries: 256 (order: -2, 1024 bytes)
[42949373.660000] TCP established hash table entries: 1024 (order: 2,
16384 bytes)
[42949373.660000] TCP bind hash table entries: 512 (order: 1, 10240 bytes)
[42949373.660000] TCP: Hash tables configured (established 1024 bind 512)
[42949373.660000] TCP reno registered
[42949373.660000] Checking host MADV_REMOVE support...OK
[42949373.660000] mconsole (version 2) initialized on
/home/matt/.uml/i5b2KQ/mconsole
[42949373.660000] Host TLS support detected
[42949373.660000] Detected host type: i386
[42949373.660000] VFS: Disk quotas dquot_6.5.1
[42949373.660000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[42949373.660000] Initializing Cryptographic API
[42949373.660000] io scheduler noop registered
[42949373.660000] io scheduler anticipatory registered (default)
[42949373.660000] io scheduler deadline registered
[42949373.660000] io scheduler cfq registered
[42949373.660000] loop: loaded (max 8 devices)
[42949373.660000] nbd: registered device at major 43
[42949373.660000] PPP generic driver version 2.4.2
[42949373.660000] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic
channels, max=256).
[42949373.660000] tun: Universal TUN/TAP device driver, 1.6
[42949373.660000] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[42949373.660000] ip_conntrack version 2.4 (229 buckets, 1832 max) -
228 bytes per conntrack
[42949374.160000] NET: Registered protocol family 1
[42949374.160000] NET: Registered protocol family 17
[42949375.000000] Bridge firewalling registered
[42949375.000000] 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
[42949375.000000] All bugs added by David S. Miller <davem@redhat.com>
[42949375.000000] Initialized stdio console driver
[42949375.000000] Console initialized on /dev/tty0
[42949375.000000] Initializing software serial port version 1
[42949375.000000]  ubda: unknown partition table
[42949375.000000] kjournald starting.  Commit interval 5 seconds
[42949375.000000] EXT3-fs: mounted filesystem with ordered data mode.
[42949375.000000] VFS: Mounted root (ext3 filesystem) readonly.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
