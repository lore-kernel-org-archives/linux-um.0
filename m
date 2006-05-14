Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FfLHm-00066s-Pc for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2006 11:25:46 -0700
Received: from wx-out-0102.google.com ([66.249.82.194])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FfLHm-0003BQ-31
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2006 11:25:46 -0700
Received: by wx-out-0102.google.com with SMTP id h26so564859wxd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 14 May 2006 11:25:44 -0700 (PDT)
From: Alberto Bertogli <albertito@gmail.com>
Message-ID: <20060514182541.GA4980@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on x86-64
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
Date: Sun, 14 May 2006 15:25:41 -0300
To: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


Hi!

I'm having some problems building and running UML using vanilla
2.6.17-rc4 under x86-64 with glibc 2.4.

First of all, it won't build because lack of definitions for some
constants in arch/um/os-Linux/sys-x86_64/registers.c. After some
digging, I found that these were defined in public setjmp headers in
previous glibc's, but have been removed in 2.4.

So I copied them from sysdeps/x86_64/jmpbuf-offsets.h, and building went
on. Probably, the same happens under i386.


Then, it built fine, but at the end several errors showed up:

-----------------8<-----------------8<-----------------8<-----------------

  SYSMAP  .tmp_System.map
  LINK linux
  Building modules, stage 2.
  MODPOST
WARNING: vmlinux - Section mismatch: reference to .init.text:do_mount_root from .bss between '__guard@@GLIBC_2.3.2' (at offset 0x603c5688) and 'stdout@@GLIBC_2.2.5'
WARNING: vmlinux - Section mismatch: reference to .init.text:parse_header from .bss between 'stdout@@GLIBC_2.2.5' (at offset 0x603c5690) and 'completed.1'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .plt after '' (at offset 0x603c5278)
WARNING: vmlinux - Section mismatch: reference to .init.ramfs: from .plt after '' (at offset 0x603c5370)
WARNING: vmlinux - Section mismatch: reference to .init.text:nosmp from .plt after '' (at offset 0x603c5418)
WARNING: vmlinux - Section mismatch: reference to .init.text:maxcpus from .plt after '' (at offset 0x603c5428)
WARNING: vmlinux - Section mismatch: reference to .init.text:obsolete_checksetup from .plt after '' (at offset 0x603c5440)
WARNING: vmlinux - Section mismatch: reference to .init.text:debug_kernel from .plt after '' (at offset 0x603c5450)
WARNING: vmlinux - Section mismatch: reference to .init.text:quiet_kernel from .plt after '' (at offset 0x603c5458)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_debug_kernel from .plt after '' (at offset 0x603c5460)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_quiet_kernel from .plt after '' (at offset 0x603c5470)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_loglevel from .plt after '' (at offset 0x603c5478)
WARNING: vmlinux - Section mismatch: reference to .init.text:unknown_bootoption from .plt after '' (at offset 0x603c5488)
WARNING: vmlinux - Section mismatch: reference to .init.text:init_setup from .plt after '' (at offset 0x603c5490)
WARNING: vmlinux - Section mismatch: reference to .init.text:rdinit_setup from .plt after '' (at offset 0x603c54a8)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_rdinit_setup from .plt after '' (at offset 0x603c54c0)
WARNING: vmlinux - Section mismatch: reference to .init.text:do_early_param from .plt after '' (at offset 0x603c54d8)
WARNING: vmlinux - Section mismatch: reference to .init.text:boot_cpu_init from .plt after '' (at offset 0x603c54f0)
WARNING: vmlinux - Section mismatch: reference to .init.text:initcall_debug_setup from .plt after '' (at offset 0x603c54f8)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_initcall_debug_setup from .plt after '' (at offset 0x603c5510)
WARNING: vmlinux - Section mismatch: reference to .init.text:do_initcalls from .plt after '' (at offset 0x603c5518)
WARNING: vmlinux - Section mismatch: reference to .init.text:load_ramdisk from .plt after '' (at offset 0x603c5540)
WARNING: vmlinux - Section mismatch: reference to .init.text:readwrite from .plt after '' (at offset 0x603c5550)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_readonly from .plt after '' (at offset 0x603c5560)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_readwrite from .plt after '' (at offset 0x603c5568)
WARNING: vmlinux - Section mismatch: reference to .init.text:root_dev_setup from .plt after '' (at offset 0x603c5578)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_root_dev_setup from .plt after '' (at offset 0x603c5590)
WARNING: vmlinux - Section mismatch: reference to .init.text:root_data_setup from .plt after '' (at offset 0x603c5598)
WARNING: vmlinux - Section mismatch: reference to .init.text:fs_names_setup from .plt after '' (at offset 0x603c55a8)
WARNING: vmlinux - Section mismatch: reference to .init.text:root_delay_setup from .plt after '' (at offset 0x603c55b8)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_root_data_setup from .plt after '' (at offset 0x603c55d0)WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_fs_names_setup from .plt after '' (at offset 0x603c55e0)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_root_delay_setup from .plt after '' (at offset 0x603c55f0)
WARNING: vmlinux - Section mismatch: reference to .init.text:get_fs_names from .plt after '' (at offset 0x603c55f8)
WARNING: vmlinux - Section mismatch: reference to .init.text:malloc from .plt after '' (at offset 0x603c5608)
WARNING: vmlinux - Section mismatch: reference to .init.text:free from .plt after '' (at offset 0x603c5610)
WARNING: vmlinux - Section mismatch: reference to .init.text:find_link from .plt after '' (at offset 0x603c5618)
WARNING: vmlinux - Section mismatch: reference to .exit.text: from .plt after '' (at offset 0x603c5368)

-----------------8<-----------------8<-----------------8<-----------------


However, the linux image was there, and I tried it.

It begins to boot, but panics right after mounting root:

[42949373.800000] kjournald starting.  Commit interval 5 seconds
[42949373.800000] EXT3-fs: mounted filesystem with ordered data mode.
[42949373.800000] VFS: Mounted root (ext3 filesystem) readonly.
[42949373.800000] Kernel panic - not syncing: handle_trap - failed to wait at end of syscall, errno = 0, status = 2943
[42949373.800000]
[42949373.800000]
[42949373.800000] Modules linked in:
[42949373.800000] Pid: 1, comm: init Not tainted 2.6.17-rc4
[42949373.800000] RIP: 0033:[<000000004000f349>]
[42949373.800000] RSP: 0000007f7fbfbfc8  EFLAGS: 00000246
[42949373.800000] RAX: 0000000000000000 RBX: 0000007f7fbfbfe0 RCX: ffffffffffffffff
[42949373.800000] RDX: 0000007f7fbfc2a0 RSI: 0000000040010900 RDI: 0000007f7fbfbfe0
[42949373.800000] RBP: 0000000000402240 R08: 0000000000000000 R09: 0000000000000000
[42949373.800000] R10: 0000000000000064 R11: 0000000000000246 R12: 0000007f7fbfc170
[42949373.800000] R13: 0000000040001530 R14: 0000000000400040 R15: 0000000000000008
[42949373.800000] Call Trace:
[42949373.800000] 6042bc38:  [<6001a10a>] panic_exit+0x2a/0x50
[42949373.800000] 6042bc48:  [<60044a8c>] notifier_call_chain+0x1c/0x30
[42949373.800000] 6042bc68:  [<6003488f>] panic+0xcf/0x170
[42949373.800000] 6042bcc8:  [<6027b4b1>] __down_read+0xa1/0xb0
[42949373.800000] 6042bce8:  [<6013f0fe>] __up_read+0x1e/0xc0
[42949373.800000] 6042bcf8:  [<600285b4>] set_signals+0x14/0x30
[42949373.800000] 6042bd08:  [<6002f0a1>] sys_uname64+0x31/0x90
[42949373.800000] 6042bd18:  [<6002acf2>] move_registers+0x42/0x80
[42949373.800000] 6042bd48:  [<6002bf65>] userspace+0x255/0x2d0
[42949373.800000] 6042bdc0:  [<60014010>] init+0x0/0x170
[42949373.800000] 6042bdd8:  [<6001a7a2>] new_thread_handler+0x102/0x140
[42949373.800000]

And I couldn't get past that. I found the error comes from
arch/um/os-Linux/skas/process.c, but I'm not sure what causes it or if
it's related to the constants defined above.

Any ideas?

Thanks,
		Alberto



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
