Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJvXi-00084h-2R for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jul 2008 12:23:02 -0700
Received: from hs-out-0708.google.com ([64.233.178.250])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KJvXf-0005XW-4n
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jul 2008 12:23:01 -0700
Received: by hs-out-0708.google.com with SMTP id 55so130100hsc.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 18 Jul 2008 12:22:58 -0700 (PDT)
Message-ID: <804dabb00807181222r2e80126fp75bf7bdd9c4cac73@mail.gmail.com>
Date: Sat, 19 Jul 2008 03:22:58 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] Kernel panic - not syncing: do_syscall_stub :
	PTRACE_SETREGS failed, errno = 5
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

First I tried the 2.6.24-rc7.bz2 image mentioned at:

http://user-mode-linux.sourceforge.net/

And it worked.   Next, using the same rootfs, I checkout 2.6.26-rc7
and generated a UML guest for it.   Looking at the
uml/include/config/kernel.release indicated the version of the UML
guest as:

2.6.26-rc4-00103-g1beee8d

It bootup no problem as well.

Next I checkout the 2.6.26 branch (current master), and generated a
UML guest for it.  Now the guest have the same version as the host -
2.6.26.   But bootup with errors:

EXT3-fs: mounted filesystem with ordered data mode.
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
Kernel panic - not syncing: do_syscall_stub : PTRACE_SETREGS failed, errno = 5

EIP: 0073:[<b7f33424>] CPU: 0 Not tainted ESP: 007b:bfe314b0 EFLAGS: 00200246
    Not tainted
EAX: 00000000 EBX: 00000fed ECX: 00000013 EDX: 00000fed
ESI: 00000fe9 EDI: 00000003 EBP: bfe314d8 DS: 007b ES: 007b
0fc5cca8:  [<08069a9b>] show_regs+0xb4/0xb9
0fc5ccd4:  [<0805968e>] panic_exit+0x25/0x3b
0fc5cce8:  [<080832b6>] notifier_call_chain+0x27/0x4c
0fc5cd10:  [<080832f2>] __atomic_notifier_call_chain+0x17/0x19
0fc5cd20:  [<08083309>] atomic_notifier_call_chain+0x15/0x17
0fc5cd3c:  [<0806f9ef>] panic+0x52/0xdd
0fc5cd5c:  [<0806648b>] do_syscall_stub+0x6e/0x173
0fc5cd84:  [<0806669a>] run_syscall_stub+0x9c/0xa1
0fc5cd98:  [<08067ad2>] write_ldt_entry+0xe2/0x140
0fc5cde0:  [<0806813f>] init_new_ldt+0x193/0x2a8
0fc5ce58:  [<08059986>] init_new_context+0xb7/0xf5
0fc5ce78:  [<080ad6cc>] bprm_mm_init+0x3f/0x164
0fc5cea8:  [<080ae2d1>] do_execve+0x6d/0x198
0fc5cec8:  [<080564f9>] execve1+0x25/0x40
0fc5ceec:  [<08056565>] um_execve+0x14/0x34
0fc5cef8:  [<08058225>] kernel_execve+0x2c/0x36
0fc5cf18:  [<0805624c>] run_init_process+0x18/0x1d
0fc5cf2c:  [<080562f7>] init_post+0xa6/0xcf
0fc5cf38:  [<0804953f>] kernel_init+0x1e7/0x1f1
0fc5cfb4:  [<08063c0f>] run_kernel_thread+0x37/0x3f
0fc5cfe0:  [<08057541>] new_thread_handler+0x57/0x7e
0fc5cffc:  [<00000000>] 0x0

Terminated

Seems similar to that of:

http://www.gossamer-threads.com/lists/linux/kernel/944646

Any fix yet?

-- 
Regards,
Peter Teoh

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
