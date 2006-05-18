Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FgkL0-0001LK-PK for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 May 2006 08:22:54 -0700
Received: from wx-out-0102.google.com ([66.249.82.198])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FgkL0-0002D1-G1
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 May 2006 08:22:54 -0700
Received: by wx-out-0102.google.com with SMTP id s10so28157wxc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 18 May 2006 08:22:52 -0700 (PDT)
Message-ID: <5d8380130605180822s38e132a4m6d70e09286ab2ab@mail.gmail.com>
From: "Nikola Knezevic" <laladelausanne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Disposition: inline
Subject: [uml-devel] externfs/hostfs problem
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
Date: Thu, 18 May 2006 17:22:52 +0200
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Hi all,
I've applied patches from uml site to 2.6.15.6, but I can't force it
to run using root as hostfs.
this is what I get:

root@nslpc4:/usr/src/um-stable# ./linux root=/dev/root rootflags=/
rootfstype=hostfs noinitrd init=/initrd
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking PROT_EXEC mmap in /tmp...OK
Checking for the skas3 patch in the host:
  - /proc/mm...found
  - PTRACE_FAULTINFO...found
  - PTRACE_LDT...found
UML running in SKAS3 mode
949373.240000] kobject_hotplug: /sbin/hotplug tty seq=280 HOME=/
PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/tty/ptyed
SUBSYSTEM=tty
[42949373.290000] RAMDISK driver initialized: 16 RAM disks of 65536K
size 1024 blocksize
[42949373.290000] loop: loaded (max 8 devices)
[42949373.290000] nbd: registered device at major 43
[42949373.290000] NET: Registered protocol family 2
[42949373.440000] IP route cache hash table entries: 512 (order: -1, 2048 bytes)
[42949373.440000] TCP established hash table entries: 2048 (order: 1,
8192 bytes)
[42949373.440000] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[42949373.440000] TCP: Hash tables configured (established 2048 bind 2048)
[42949373.440000] TCP reno registered
[42949373.440000] TCP bic registered
[42949373.440000] NET: Registered protocol family 8
[42949373.440000] NET: Registered protocol family 20
[42949373.440000] Initialized stdio console driver
[42949373.440000] Console initialized on /dev/tty0
[42949373.440000] Failed to open 'root_fs', errno = 2
[42949373.440000] VFS: Mounted root (hostfs filesystem) readonly.
[42949373.440000] Warning: unable to open an initial console.
[42949373.440000] Failed to execute /initrd.  Attempting defaults...
[42949373.440000] Kernel panic - not syncing: No init found.  Try
passing init= option to kernel.
[42949373.440000]
[42949373.440000] EIP: 0073:[<ffffe410>] CPU: 0 Not tainted ESP:
007b:b7eb0f9c EFLAGS: 00000246
[42949373.440000]     Not tainted
[42949373.440000] EAX: 00000000 EBX: 000026fb ECX: 00000013 EDX: 000026fb
[42949373.440000] ESI: 000026f7 EDI: 00000011 EBP: b7eb0fb8 DS: 007b ES: 007b
[42949373.440000] 08377bc4:  [<08076254>] show_regs+0x104/0x106
[42949373.440000] 08377be0:  [<080634ee>] panic_exit+0x2c/0x4b
[42949373.440000] 08377bf0:  [<08088569>] notifier_call_chain+0x27/0x3b
[42949373.440000] 08377c10:  [<0807a6eb>] panic+0x74/0x11c
[42949373.440000] 08377c30:  [<0805c3ad>] init+0x127/0x16a
[42949373.440000] 08377c48:  [<08071a08>] run_kernel_thread+0x34/0x3f
[42949373.440000] 08377cf8:  [<08065b9f>] new_thread_handler+0x9b/0xc6
[42949373.440000] 08377d1c:  [<ffffe420>] idle_timer+0xf7cb60e4/0x18


Any help?

TIA


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
