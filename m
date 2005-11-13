Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eb6nc-00048F-VT for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 17:36:52 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eb6nc-0001mA-Gj
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 17:36:53 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jAD3AKeV022874
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 12 Nov 2005 22:10:20 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121936.41697.rob@landley.net>
Subject: [uml-devel] [PATCH] Ok, I build x86-64 -skas0, and it still segfaults.
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
Date: Sat, 12 Nov 2005 19:36:41 -0600
To: user-mode-linux-devel@lists.sourceforge.net

I needed to patch two things to get 2.6.15-rc1 to build on an x86-64
system running PLD linux:

diff -ru linux-2.6.15-rc1/arch/um/Kconfig.x86_64 linux-2.6.15-rc1-new/arch/um/Kconfig.x86_64
--- linux-2.6.15-rc1/arch/um/Kconfig.x86_64 2005-11-13 02:08:34.318108152 +0100
+++ linux-2.6.15-rc1-new/arch/um/Kconfig.x86_64 2005-11-13 01:55:47.761861224 +0100
@@ -9,7 +9,7 @@
 #XXX: this is so in the underlying arch, but it's wrong!!!
 config RWSEM_GENERIC_SPINLOCK
  bool
- default y
+ default n
 
 config SEMAPHORE_SLEEPERS
  bool
diff -ru linux-2.6.15-rc1/arch/um/Makefile linux-2.6.15-rc1-new/arch/um/Makefile
--- linux-2.6.15-rc1/arch/um/Makefile 2005-11-13 02:08:34.318108152 +0100
+++ linux-2.6.15-rc1-new/arch/um/Makefile 2005-11-13 02:01:11.364014056 +0100
@@ -107,7 +107,7 @@
 prepare: $(ARCH_DIR)/include/kern_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib
+LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
 
 CPP_MODE-$(CONFIG_MODE_TT) := -DMODE_TT
 CONFIG_KERNEL_STACK_ORDER ?= 2


Then I ran it with my standard ./linux rootfstype=hostfs rw init=/bin/sh
and got the following:

Kernel command line: rootfstype=hostfs rw init=/bin/sh root=98:0
PID hash table entries: 256 (order: 8, 8192 bytes)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Memory: 30208k available
Mount-cache hash table entries: 256
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Linux NoNET1.0 for Linux 2.6
Using 2.6 host AIO
io scheduler noop registered
loop: loaded (max 8 devices)
Initialized stdio console driver
Console initialized on /dev/tty0
Failed to open 'root_fs', errno = 2
VFS: Mounted root (hostfs filesystem).
Stub registers -
        0 - 9090909090909090
        1 - 9090909090909090
        2 - 9090909090909090
        3 - 9090909090909090
        4 - 9090909090909090
        5 - 9090909090909090
        6 - 9090909090909090
        7 - 9090909090909090
        8 - 9090909090909090
        9 - 9090909090909090
        10 - 0
        11 - 9090909090909090
        12 - 9090909090909090
        13 - 9090909090909090
        14 - 9090909090909090
        15 - ffffffffffffffff
        16 - 9090909090909090
        17 - 33
        18 - 292
        19 - 9090909090909090
        20 - 2b
...
[Remaining registers omitted because Jeff's debug patch iterates with the
wrong constants.  The corrected version produced only the first 20.]
...
Kernel panic - not syncing: get_skas_faultinfo : failed to wait for SIGUSR1/SIGTRAP, pid = 10090, n = 10090, errno = 0, status = 0xb7f


Pid: 1, comm: sh Not tainted 2.6.15-rc1
RIP: 0033:[<0000000040000ac0>]
RSP: 0000007f7facdfe0  EFLAGS: 00010212
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Call Trace:
6018b6a8:  [<60014cba>] panic_exit+0x2a/0x50
6018b6b8:  [<60033dff>] notifier_call_chain+0x1f/0x40
6018b6d8:  [<6002479f>] panic+0xcf/0x170
6018b6f8:  [<6001223c>] set_signals+0x6c/0x130
6018b750:  [<60018370>] copy_chunk_to_user+0x0/0x40
6018b7b8:  [<60016274>] wait_stub_done+0xd4/0x160
6018b948:  [<6008b0fa>] load_elf_binary+0xfa/0x10a0
6018bb08:  [<60012157>] enable_mask+0x47/0x70
6018bb28:  [<6001223c>] set_signals+0x6c/0x130
6018bbd8:  [<6006c508>] do_execve+0x198/0x220
6018bbf0:  [<6000da40>] init+0x0/0x180
6018bbf8:  [<6001053f>] current_cmd+0x3f/0x70
6018bc30:  [<6000da40>] init+0x0/0x180
6018bc38:  [<60014669>] do_longjmp+0x9/0x20
6018bc48:  [<6000e137>] um_execve+0x47/0x50
6018bc78:  [<6000da40>] init+0x0/0x180
6018bd08:  [<6001f8d2>] run_kernel_thread+0x52/0xa0
6018bd38:  [<6001635a>] get_skas_faultinfo+0x5a/0x70
6018bd48:  [<60017e53>] user_signal+0x63/0x90
6018bd68:  [<6001691f>] userspace+0x14f/0x1c0
6018bdb0:  [<6000da40>] init+0x0/0x180
6018bdc0:  [<6000da40>] init+0x0/0x180
6018bdd8:  [<600174d7>] new_thread_handler+0x107/0x140




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
