Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSviv-0008Hf-VZ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Aug 2008 08:23:50 -0700
Received: from yx-out-1718.google.com ([74.125.44.154])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSviv-0001uM-IL
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Aug 2008 08:23:49 -0700
Received: by yx-out-1718.google.com with SMTP id 3so945190yxi.82
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Aug 2008 08:23:49 -0700 (PDT)
Message-ID: <5861bf050808120823w483e87eev7ff181eab9c8c026@mail.gmail.com>
Date: Tue, 12 Aug 2008 12:23:48 -0300
From: "=?ISO-8859-1?Q?Roberto_Alc=E2ntara?=" <roberto@eletronica.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] Error starting uml
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Guys, I'm trying to start uml with website fedora fs.
I downloaded 2.6.26 source and build without problems. But when I
start I have segmentation fault error.

I'm a bit confused about these messages:

console [mc-1] enabled
 ubda: unknown partition table
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.

My fs was mounted ok? What is ubda partition error?

Anyone have some suggestion? Log messages below.

My host is: Linux ubuntu 2.6.24-16-generic #1 SMP Thu Apr 10 13:23:42
UTC 2008 i686 GNU/Linux

Thank you,
 - Roberto


roberto@ubuntu:~/sandbox/linux-2.6.26_orig$ ./linux
ubda=../FedoraCore5-x86-root_fs mem=128M  2> out.txt
Locating the bottom of the address space ... 0x10000
Locating the top of the address space ... 0xc0000000
Core dump limits :
        soft - 0
        hard - NONE
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
UML running in SKAS0 mode
 'ptyp2' (0fca66a8): fill_kobj_path: path = '/class/tty/ptyp2'
khelper used greatest stack depth: 3016 bytes left
khelper used greatest stack depth: 2908 bytes left
TCP cubic registered
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
console [tty0] enabled
Initializing software serial port version 1
console [mc-1] enabled
 ubda: unknown partition table
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Stub registers -
        0 - 0
        1 - 0
        2 - 0
        3 - 0
        4 - 0
        5 - 0
        6 - 0
        7 - 0
        8 - 0
        9 - 0
        10 - 0
        11 - ffffffff
        12 - 0
	13 - 73
	14 - 10202
	15 - 0
	16 - 7b
wait_stub_done : failed to wait for SIGTRAP, pid = 2886, n = 2886,
errno = 0, status = 0xb7f
Kernel panic - not syncing: Attempted to kill init!

EIP: 0073:[<b7f66410>] CPU: 0 Not tainted ESP: 007b:bfcd9958 EFLAGS: 00000246
    Not tainted
EAX: 00000000 EBX: 00000b41 ECX: 00000013 EDX: 00000b41
ESI: 00000b3d EDI: b7e10aac EBP: bfcd9984 DS: 007b ES: 007b
0fc5cb10:  [<0806a53f>] show_regs+0xb4/0xb9
0fc5cb3c:  [<08059c76>] panic_exit+0x25/0x3b
0fc5cb50:  [<08085886>] notifier_call_chain+0x27/0x4c
0fc5cb78:  [<080858c5>] __atomic_notifier_call_chain+0x1a/0x1c
0fc5cb88:  [<080858dc>] atomic_notifier_call_chain+0x15/0x17
0fc5cba4:  [<08070aea>] panic+0x52/0xd8
0fc5cbc4:  [<08073a59>] do_exit+0x5a/0x64c
0fc5cc04:  [<080740dd>] do_group_exit+0x92/0xbe
0fc5cc24:  [<0807c5d7>] get_signal_to_deliver+0x2ac/0x2ca
0fc5cc4c:  [<080585ac>] do_signal+0x256/0x310
0fc5cd1c:  [<08059ad3>] fatal_sigsegv+0x1f/0x24
0fc5cd30:  [<08067572>] wait_stub_done+0xa3/0xab
0fc5cd5c:  [<08066e27>] do_syscall_stub+0x9e/0x171
0fc5cd80:  [<08067004>] run_syscall_stub+0x9c/0xa1
0fc5cd94:  [<0806848a>] write_ldt_entry+0xe2/0x140
0fc5cddc:  [<08068b74>] init_new_ldt+0x1a8/0x2e0
0fc5ce5c:  [<08059f84>] init_new_context+0xca/0x10e
0fc5ce7c:  [<080b2abc>] bprm_mm_init+0x3f/0x167
0fc5ceac:  [<080b3813>] do_execve+0x6d/0x198
0fc5cecc:  [<08056a5d>] execve1+0x25/0x62
0fc5cef0:  [<08056aee>] um_execve+0x14/0x34
0fc5cefc:  [<0805889d>] kernel_execve+0x2c/0x36
0fc5cf1c:  [<080567ac>] run_init_process+0x18/0x1d
0fc5cf30:  [<08056857>] init_post+0xa6/0xcf
0fc5cf3c:  [<0804953f>] kernel_init+0x1e2/0x1ec
0fc5cfb4:  [<080645af>] run_kernel_thread+0x37/0x3f
0fc5cfe0:  [<08057b04>] new_thread_handler+0x57/0x7e
0fc5cffc:  [<00000000>] 0x0

Segmentation Fault

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
