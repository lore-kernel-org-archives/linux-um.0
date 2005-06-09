Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgBg2-0003gh-EO	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Jun 2005 18:17:46 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DgBfz-0005yX-8l	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Jun 2005 18:17:46 -0700
From: antoine <antoine@nagafix.co.uk>
Content-Type: multipart/mixed; boundary="=-B6xY5+1yy3pU7Xpu/pKW"
Message-Id: <1118280325.10107.124.camel@localhost>
Mime-Version: 1.0
Subject: [uml-devel] 2.6.12-rc6-mm1 patches testing
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
Date: Thu, 09 Jun 2005 02:25:25 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>


--=-B6xY5+1yy3pU7Xpu/pKW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I noticed a new set of patches were out, so I gave it usual bashing.
Maybe this will be useful to someone else:
1) as before fp-state does not apply.
2) os-main gave me a reject on arch/um/kernel/main.c
fixed by simply removing the file.

Built ok (no tweaks needed this time!).
Runs ok, but it is still loosing memory fast.

Then I tried adding some more experimental features...
Attached is a stacktrace I encountered (pcap related):
Seems like the pcap patch is causing some problems when running in a
chroot which does not have the libraries required by pcap (nss?)
Some processes were still running when I got back to the shell.
Btw, how do I figure out which libs I need to copy to the chroot?

But apart from that slight problem, when running outside the chroot it
works exactly as expected. I vote for including it in the next release
with appropriate warnings about runtime libraries issues.
Now, if someone could have a look at hppfs I could resurect my
honeypots.

Also, is anyone interested in some SELinux policies for UML? They need a
little bit of tidying up but seem to work. See below (I extracted the
generic part - unfortunately some parts are specific to my setup).

Antoine

type um_t, domain, privowner;
type um_kernel_t, domain, privowner;

type um_admin_t, file_type, sysadmfile;
type um_exec_t, file_type, exec_type;
type um_kernel_exec_t, file_type, sysadmfile, exec_type;
type um_home_t, file_type;
type um_fs_t, file_type;
type um_tmp_t, file_type, tmpfile;
type um_proc_t, file_type;
type um_tundev_t, device_type, dev_fs;


file_type_auto_trans(um_t, tmp_t, um_tmp_t)
file_type_auto_trans(um_kernel_t, tmp_t, um_tmp_t)

domain_auto_trans(initrc_t, um_exec_t, um_t)
domain_auto_trans(sysadm_t, um_exec_t, um_t)
domain_auto_trans(um_t, um_kernel_exec_t, um_kernel_t)


# network
allow um_kernel_t netif_t:netif { tcp_recv tcp_send };
allow um_kernel_t node_t:node { tcp_recv tcp_send };
allow um_kernel_t port_t:socket { recv_msg send_msg };
# sockets
allow um_kernel_t self:packet_socket create;
allow um_kernel_t self:unix_dgram_socket { bind create ioctl };
allow um_kernel_t self:unix_stream_socket { create ioctl read write };
# process
allow um_kernel_t self:process { execmem fork ptrace sigchld sigkill signal sigstop };
# devices
allow um_kernel_t device_t:dir search;
allow um_kernel_t null_device_t:chr_file { ioctl read write };
allow um_kernel_t um_tundev_t:chr_file { ioctl read write };
allow um_kernel_t random_device_t:chr_file read;
# files
allow um_kernel_t um_tmp_t:file execute;
allow um_kernel_t um_fs_t:file { getattr lock read write };
allow um_kernel_t um_fs_t:lnk_file read;
# proc
allow um_kernel_t um_proc_t:file read;
allow um_kernel_t um_proc_t:dir search;
# home
allow um_kernel_t um_home_t:dir { add_name create getattr read remove_name rmdir write search};
allow um_kernel_t um_home_t:file { create getattr lock read unlink write };
allow um_kernel_t um_home_t:sock_file { create unlink };
# all other dirs:
allow um_kernel_t um_admin_t:dir search;


--=-B6xY5+1yy3pU7Xpu/pKW
Content-Description: 
Content-Disposition: inline; filename=2.6.12-rc6-mm1.bug
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

[42949587.660000] 67d9fb48:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9fb78:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9fb98:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9fbb8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9fbd8:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9fbe8:  [<60056864>] sys_reboot+0x234/0x240
[42949587.660000] 67d9fc08:  [<60052f27>] kill_proc_info+0x37/0x50
[42949587.660000] 67d9fc28:  [<60052f7c>] kill_something_info+0x3c/0x140
[42949587.660000] 67d9fcc8:  [<6008a29b>] filp_close+0x4b/0x90
[42949587.660000] 67d9fd18:  [<6001aed6>] execute_syscall_skas+0xc6/0xd0
[42949587.660000] 67d9fd38:  [<6001aefb>] handle_syscall+0x1b/0x40
[42949587.660000] 67d9fd58:  [<6003d1fb>] userspace+0x15b/0x2f0
[42949587.660000] 67d9fdb8:  [<6001b0a4>] fix_range+0x34/0x40
[42949587.660000] 67d9fdf8:  [<6001aac2>] fork_handler+0xc2/0xd0
[42949587.660000] 67d9fe38:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9fee8:  [<602160c9>] __kill+0x9/0x20
[42949587.660000]
[42949587.660000]  <0>Kernel panic - not syncing: Kernel mode fault at addr 0x100, ip 0x401c69d7
[42949587.660000]
[42949587.660000] Pid: 3288, comm: halt Not tainted 2.6.12-rc6-mm1
[42949587.660000] RIP: 0033:[<00000000401c69d7>]
[42949587.660000] RSP: 0000007fbfc37bb0  EFLAGS: 00000202
[42949587.660000] RAX: ffffffffffffffda RBX: 0000007fbfc37c68 RCX: ffffffffffffffff
[42949587.660000] RDX: 000000004321fedc RSI: 0000000028121969 RDI: fffffffffee1dead
[42949587.660000] RBP: 0000000000000002 R08: 000000000000004c R09: 0000000000000000
[42949587.660000] R10: 00000000401159a8 R11: 0000000000000202 R12: 0000000000000000
[42949587.660000] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
[42949587.660000] Call Trace:
[42949587.660000] 67d9d9d8:  [<6001755f>] panic_exit+0x2f/0x50
[42949587.660000] 67d9d9f8:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9da28:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9da68:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9da98:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9dac8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9dad8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9db18:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9db28:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9db38:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9db88:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9dba8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9dbb8:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9dc28:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9dc58:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9dc68:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9dca8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9dcb8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9dd50:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9dd58:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9dd68:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9ddd8:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9ddf8:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9de88:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9dea8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9dec8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9dee8:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9df08:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9df28:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9df48:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9df68:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9df78:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9df88:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9dfa8:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9dfd8:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9e018:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e048:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9e078:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e088:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e0c8:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9e0d8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e0e8:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9e138:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e158:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e168:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9e1d8:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9e208:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9e218:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9e258:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e268:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e300:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9e308:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9e318:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9e388:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9e3a8:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9e438:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9e458:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e478:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e498:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9e4b8:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9e4d8:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9e4f8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9e518:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9e528:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9e538:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9e558:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9e588:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9e5c8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e5f8:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9e628:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e638:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e678:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9e688:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e698:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9e6e8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e708:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e718:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9e788:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9e7b8:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9e7c8:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9e808:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e818:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e8b0:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9e8b8:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9e8c8:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9e938:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9e958:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9e9e8:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9ea08:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9ea28:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9ea48:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9ea68:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9ea88:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9eaa8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9eac8:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9ead8:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9eae8:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9eb08:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9eb38:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9eb78:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9eba8:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9ebd8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9ebe8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9ec28:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9ec38:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9ec48:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9ec98:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9ecb8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9ecc8:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9ed38:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9ed68:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9ed78:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9edb8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9edc8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9ee60:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9ee68:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9ee78:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9eee8:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9ef08:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9ef98:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9efb8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9efd8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9eff8:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9f018:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9f038:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9f058:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9f078:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9f088:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9f098:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9f0b8:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9f0e8:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9f128:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f158:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9f188:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f198:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9f1d8:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9f1e8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f1f8:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9f248:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f268:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f278:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9f2e8:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9f318:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9f328:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9f368:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f378:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9f410:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9f418:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9f428:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9f498:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9f4b8:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9f548:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9f568:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f588:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f5a8:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9f5c8:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9f5e8:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9f608:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9f628:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9f638:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9f648:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9f668:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9f698:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9f6d8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f708:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9f748:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f788:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9f798:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f7a8:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9f808:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f818:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f828:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9f898:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9f8c8:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9f8d8:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9f918:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f928:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9f9c0:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9f9c8:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9f9d8:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9fa78:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9fab8:  [<60039123>] enable_mask+0x43/0x60
[42949587.660000] 67d9fac8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9fb08:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9fb48:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9fb78:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9fb98:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9fbb8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9fbd8:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9fbe8:  [<60056864>] sys_reboot+0x234/0x240
[42949587.660000] 67d9fc08:  [<60052f27>] kill_proc_info+0x37/0x50
[42949587.660000] 67d9fc28:  [<60052f7c>] kill_something_info+0x3c/0x140
[42949587.660000] 67d9fcc8:  [<6008a29b>] filp_close+0x4b/0x90
[42949587.660000] 67d9fd18:  [<6001aed6>] execute_syscall_skas+0xc6/0xd0
[42949587.660000] 67d9fd38:  [<6001aefb>] handle_syscall+0x1b/0x40
[42949587.660000] 67d9fd58:  [<6003d1fb>] userspace+0x15b/0x2f0
[42949587.660000] 67d9fdb8:  [<6001b0a4>] fix_range+0x34/0x40
[42949587.660000] 67d9fdf8:  [<6001aac2>] fork_handler+0xc2/0xd0
[42949587.660000] 67d9fe38:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9fee8:  [<602160c9>] __kill+0x9/0x20
[42949587.660000]
[42949587.660000]  <0>Kernel panic - not syncing: Kernel mode fault at addr 0x100, ip 0x401c69d7
[42949587.660000]
[42949587.660000] Pid: 3288, comm: halt Not tainted 2.6.12-rc6-mm1
[42949587.660000] RIP: 0033:[<00000000401c69d7>]
[42949587.660000] RSP: 0000007fbfc37bb0  EFLAGS: 00000202
[42949587.660000] RAX: ffffffffffffffda RBX: 0000007fbfc37c68 RCX: ffffffffffffffff
[42949587.660000] RDX: 000000004321fedc RSI: 0000000028121969 RDI: fffffffffee1dead
[42949587.660000] RBP: 0000000000000002 R08: 000000000000004c R09: 0000000000000000
[42949587.660000] R10: 00000000401159a8 R11: 0000000000000202 R12: 0000000000000000
[42949587.660000] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
[42949587.660000] Call Trace:
[42949587.660000] 67d9d428:  [<6001755f>] panic_exit+0x2f/0x50
[42949587.660000] 67d9d448:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9d478:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9d4b8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d4e8:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9d518:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9d528:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9d568:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9d578:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9d588:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9d5d8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d5f8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9d608:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9d678:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9d6a8:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9d6b8:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9d6f8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9d708:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9d7a0:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9d7a8:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9d7b8:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9d828:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9d848:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9d8d8:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9d8f8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d918:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d938:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9d958:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9d978:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9d998:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9d9b8:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9d9c8:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9d9d8:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9d9f8:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9da28:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9da68:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9da98:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9dac8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9dad8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9db18:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9db28:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9db38:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9db88:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9dba8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9dbb8:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9dc28:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9dc58:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9dc68:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9dca8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9dcb8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9dd50:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9dd58:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9dd68:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9ddd8:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9ddf8:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9de88:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9dea8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9dec8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9dee8:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9df08:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9df28:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9df48:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9df68:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9df78:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9df88:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9dfa8:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9dfd8:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9e018:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e048:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9e078:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e088:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e0c8:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9e0d8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e0e8:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9e138:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e158:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e168:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9e1d8:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9e208:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9e218:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9e258:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e268:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e300:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9e308:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9e318:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9e388:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9e3a8:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9e438:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9e458:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e478:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e498:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9e4b8:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9e4d8:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9e4f8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9e518:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9e528:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9e538:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9e558:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9e588:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9e5c8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e5f8:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9e628:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e638:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e678:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9e688:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e698:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9e6e8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e708:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e718:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9e788:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9e7b8:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9e7c8:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9e808:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e818:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e8b0:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9e8b8:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9e8c8:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9e938:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9e958:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9e9e8:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9ea08:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9ea28:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9ea48:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9ea68:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9ea88:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9eaa8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9eac8:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9ead8:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9eae8:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9eb08:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9eb38:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9eb78:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9eba8:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9ebd8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9ebe8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9ec28:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9ec38:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9ec48:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9ec98:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9ecb8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9ecc8:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9ed38:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9ed68:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9ed78:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9edb8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9edc8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9ee60:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9ee68:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9ee78:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9eee8:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9ef08:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9ef98:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9efb8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9efd8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9eff8:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9f018:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9f038:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9f058:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9f078:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9f088:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9f098:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9f0b8:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9f0e8:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9f128:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f158:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9f188:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f198:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9f1d8:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9f1e8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f1f8:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9f248:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f268:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f278:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9f2e8:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9f318:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9f328:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9f368:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f378:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9f410:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9f418:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9f428:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9f498:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9f4b8:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9f548:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9f568:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f588:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f5a8:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9f5c8:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9f5e8:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9f608:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9f628:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9f638:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9f648:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9f668:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9f698:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9f6d8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f708:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9f748:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f788:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9f798:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f7a8:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9f808:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f818:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f828:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9f898:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9f8c8:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9f8d8:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9f918:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f928:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9f9c0:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9f9c8:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9f9d8:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9fa78:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9fab8:  [<60039123>] enable_mask+0x43/0x60
[42949587.660000] 67d9fac8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9fb08:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9fb48:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9fb78:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9fb98:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9fbb8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9fbd8:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9fbe8:  [<60056864>] sys_reboot+0x234/0x240
[42949587.660000] 67d9fc08:  [<60052f27>] kill_proc_info+0x37/0x50
[42949587.660000] 67d9fc28:  [<60052f7c>] kill_something_info+0x3c/0x140
[42949587.660000] 67d9fcc8:  [<6008a29b>] filp_close+0x4b/0x90
[42949587.660000] 67d9fd18:  [<6001aed6>] execute_syscall_skas+0xc6/0xd0
[42949587.660000] 67d9fd38:  [<6001aefb>] handle_syscall+0x1b/0x40
[42949587.660000] 67d9fd58:  [<6003d1fb>] userspace+0x15b/0x2f0
[42949587.660000] 67d9fdb8:  [<6001b0a4>] fix_range+0x34/0x40
[42949587.660000] 67d9fdf8:  [<6001aac2>] fork_handler+0xc2/0xd0
[42949587.660000] 67d9fe38:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9fee8:  [<602160c9>] __kill+0x9/0x20
[42949587.660000]
[42949587.660000]  <0>Kernel panic - not syncing: Kernel mode fault at addr 0x100, ip 0x401c69d7
[42949587.660000]
[42949587.660000] Pid: 3288, comm: halt Not tainted 2.6.12-rc6-mm1
[42949587.660000] RIP: 0033:[<00000000401c69d7>]
[42949587.660000] RSP: 0000007fbfc37bb0  EFLAGS: 00000202
[42949587.660000] RAX: ffffffffffffffda RBX: 0000007fbfc37c68 RCX: ffffffffffffffff
[42949587.660000] RDX: 000000004321fedc RSI: 0000000028121969 RDI: fffffffffee1dead
[42949587.660000] RBP: 0000000000000002 R08: 000000000000004c R09: 0000000000000000
[42949587.660000] R10: 00000000401159a8 R11: 0000000000000202 R12: 0000000000000000
[42949587.660000] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
[42949587.660000] Call Trace:
[42949587.660000] 67d9ce78:  [<6001755f>] panic_exit+0x2f/0x50
[42949587.660000] 67d9ce98:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9cec8:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9cf08:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9cf38:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9cf68:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9cf78:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9cfb8:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9cfc8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9cfd8:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9d028:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d048:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9d058:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9d0c8:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9d0f8:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9d108:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9d148:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9d158:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9d1f0:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9d1f8:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9d208:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9d278:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9d298:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9d328:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9d348:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d368:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d388:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9d3a8:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9d3c8:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9d3e8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9d408:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9d418:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9d428:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9d448:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9d478:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9d4b8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d4e8:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9d518:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9d528:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9d568:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9d578:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9d588:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9d5d8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d5f8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9d608:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9d678:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9d6a8:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9d6b8:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9d6f8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9d708:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9d7a0:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9d7a8:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9d7b8:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9d828:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9d848:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9d8d8:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9d8f8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d918:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d938:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9d958:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9d978:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9d998:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9d9b8:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9d9c8:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9d9d8:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9d9f8:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9da28:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9da68:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9da98:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9dac8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9dad8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9db18:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9db28:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9db38:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9db88:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9dba8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9dbb8:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9dc28:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9dc58:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9dc68:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9dca8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9dcb8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9dd50:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9dd58:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9dd68:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9ddd8:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9ddf8:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9de88:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9dea8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9dec8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9dee8:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9df08:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9df28:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9df48:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9df68:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9df78:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9df88:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9dfa8:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9dfd8:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9e018:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e048:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9e078:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e088:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e0c8:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9e0d8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e0e8:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9e138:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e158:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e168:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9e1d8:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9e208:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9e218:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9e258:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e268:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e300:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9e308:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9e318:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9e388:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9e3a8:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9e438:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9e458:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e478:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e498:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9e4b8:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9e4d8:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9e4f8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9e518:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9e528:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9e538:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9e558:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9e588:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9e5c8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e5f8:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9e628:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e638:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e678:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9e688:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e698:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9e6e8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e708:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e718:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9e788:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9e7b8:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9e7c8:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9e808:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e818:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e8b0:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9e8b8:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9e8c8:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9e938:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9e958:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9e9e8:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9ea08:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9ea28:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9ea48:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9ea68:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9ea88:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9eaa8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9eac8:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9ead8:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9eae8:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9eb08:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9eb38:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9eb78:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9eba8:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9ebd8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9ebe8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9ec28:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9ec38:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9ec48:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9ec98:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9ecb8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9ecc8:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9ed38:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9ed68:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9ed78:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9edb8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9edc8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9ee60:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9ee68:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9ee78:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9eee8:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9ef08:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9ef98:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9efb8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9efd8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9eff8:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9f018:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9f038:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9f058:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9f078:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9f088:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9f098:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9f0b8:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9f0e8:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9f128:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f158:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9f188:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f198:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9f1d8:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9f1e8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f1f8:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9f248:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f268:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f278:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9f2e8:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9f318:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9f328:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9f368:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f378:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9f410:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9f418:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9f428:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9f498:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9f4b8:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9f548:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9f568:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f588:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f5a8:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9f5c8:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9f5e8:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9f608:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9f628:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9f638:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9f648:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9f668:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9f698:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9f6d8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f708:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9f748:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f788:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9f798:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f7a8:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9f808:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f818:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f828:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9f898:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9f8c8:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9f8d8:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9f918:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f928:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9f9c0:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9f9c8:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9f9d8:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9fa78:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9fab8:  [<60039123>] enable_mask+0x43/0x60
[42949587.660000] 67d9fac8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9fb08:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9fb48:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9fb78:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9fb98:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9fbb8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9fbd8:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9fbe8:  [<60056864>] sys_reboot+0x234/0x240
[42949587.660000] 67d9fc08:  [<60052f27>] kill_proc_info+0x37/0x50
[42949587.660000] 67d9fc28:  [<60052f7c>] kill_something_info+0x3c/0x140
[42949587.660000] 67d9fcc8:  [<6008a29b>] filp_close+0x4b/0x90
[42949587.660000] 67d9fd18:  [<6001aed6>] execute_syscall_skas+0xc6/0xd0
[42949587.660000] 67d9fd38:  [<6001aefb>] handle_syscall+0x1b/0x40
[42949587.660000] 67d9fd58:  [<6003d1fb>] userspace+0x15b/0x2f0
[42949587.660000] 67d9fdb8:  [<6001b0a4>] fix_range+0x34/0x40
[42949587.660000] 67d9fdf8:  [<6001aac2>] fork_handler+0xc2/0xd0
[42949587.660000] 67d9fe38:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9fee8:  [<602160c9>] __kill+0x9/0x20
[42949587.660000]
[42949587.660000]  <0>Kernel panic - not syncing: Kernel mode fault at addr 0x100, ip 0x401c69d7
[42949587.660000]
[42949587.660000] Pid: 3288, comm: halt Not tainted 2.6.12-rc6-mm1
[42949587.660000] RIP: 0033:[<00000000401c69d7>]
[42949587.660000] RSP: 0000007fbfc37bb0  EFLAGS: 00000202
[42949587.660000] RAX: ffffffffffffffda RBX: 0000007fbfc37c68 RCX: ffffffffffffffff
[42949587.660000] RDX: 000000004321fedc RSI: 0000000028121969 RDI: fffffffffee1dead
[42949587.660000] RBP: 0000000000000002 R08: 000000000000004c R09: 0000000000000000
[42949587.660000] R10: 00000000401159a8 R11: 0000000000000202 R12: 0000000000000000
[42949587.660000] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
[42949587.660000] Call Trace:
[42949587.660000] 67d9c8c8:  [<6001755f>] panic_exit+0x2f/0x50
[42949587.660000] 67d9c8e8:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9c918:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9c958:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9c988:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9c9b8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9c9c8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9ca08:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9ca18:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9ca28:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9ca78:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9ca98:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9caa8:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9cb18:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9cb48:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9cb58:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9cb98:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9cba8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9cc40:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9cc48:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9cc58:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9ccc8:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9cce8:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9cd78:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9cd98:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9cdb8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9cdd8:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9cdf8:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9ce18:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9ce38:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9ce58:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9ce68:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9ce78:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9ce98:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9cec8:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9cf08:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9cf38:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9cf68:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9cf78:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9cfb8:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9cfc8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9cfd8:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9d028:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d048:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9d058:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9d0c8:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9d0f8:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9d108:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9d148:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9d158:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9d1f0:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9d1f8:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9d208:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9d278:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9d298:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9d328:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9d348:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d368:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d388:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9d3a8:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9d3c8:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9d3e8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9d408:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9d418:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9d428:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9d448:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9d478:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9d4b8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d4e8:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9d518:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9d528:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9d568:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9d578:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9d588:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9d5d8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d5f8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9d608:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9d678:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9d6a8:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9d6b8:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9d6f8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9d708:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9d7a0:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9d7a8:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9d7b8:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9d828:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9d848:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9d8d8:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9d8f8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d918:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9d938:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9d958:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9d978:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9d998:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9d9b8:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9d9c8:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9d9d8:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9d9f8:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9da28:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9da68:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9da98:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9dac8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9dad8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9db18:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9db28:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9db38:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9db88:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9dba8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9dbb8:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9dc28:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9dc58:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9dc68:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9dca8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9dcb8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9dd50:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9dd58:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9dd68:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9ddd8:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9ddf8:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9de88:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9dea8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9dec8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9dee8:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9df08:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9df28:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9df48:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9df68:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9df78:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9df88:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9dfa8:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9dfd8:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9e018:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e048:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9e078:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e088:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e0c8:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9e0d8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e0e8:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9e138:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e158:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e168:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9e1d8:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9e208:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9e218:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9e258:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e268:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e300:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9e308:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9e318:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9e388:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9e3a8:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9e438:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9e458:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e478:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e498:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9e4b8:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9e4d8:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9e4f8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9e518:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9e528:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9e538:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9e558:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9e588:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9e5c8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e5f8:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9e628:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e638:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e678:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9e688:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e698:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9e6e8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9e708:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9e718:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9e788:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9e7b8:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9e7c8:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9e808:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9e818:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9e8b0:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9e8b8:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9e8c8:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9e938:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9e958:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9e9e8:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9ea08:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9ea28:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9ea48:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9ea68:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9ea88:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9eaa8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9eac8:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9ead8:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9eae8:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9eb08:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9eb38:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9eb78:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9eba8:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9ebd8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9ebe8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9ec28:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9ec38:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9ec48:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9ec98:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9ecb8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9ecc8:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9ed38:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9ed68:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9ed78:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9edb8:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9edc8:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9ee60:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9ee68:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9ee78:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9eee8:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9ef08:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9ef98:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9efb8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9efd8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9eff8:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9f018:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9f038:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9f058:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9f078:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9f088:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9f098:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9f0b8:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9f0e8:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9f128:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f158:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9f188:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f198:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9f1d8:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9f1e8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f1f8:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9f248:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f268:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f278:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9f2e8:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9f318:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9f328:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9f368:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f378:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9f410:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9f418:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9f428:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9f498:  [<600434ac>] release_console_sem+0x7c/0xc0
[42949587.660000] 67d9f4b8:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9f548:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9f568:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f588:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f5a8:  [<6022d765>] __libc_waitpid+0x95/0xc0
[42949587.660000] 67d9f5c8:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9f5e8:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9f608:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9f628:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9f638:  [<600140a9>] machine_halt+0x9/0x10
[42949587.660000] 67d9f648:  [<60017575>] panic_exit+0x45/0x50
[42949587.660000] 67d9f668:  [<6005602b>] notifier_call_chain+0x2b/0x50
[42949587.660000] 67d9f698:  [<600423c4>] panic+0xe4/0x180
[42949587.660000] 67d9f6d8:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f708:  [<600165f8>] handle_page_fault+0xf8/0x2b0
[42949587.660000] 67d9f748:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f788:  [<6001699a>] segv+0x1ea/0x2b0
[42949587.660000] 67d9f798:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f7a8:  [<60039021>] change_sig+0x61/0x80
[42949587.660000] 67d9f808:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9f818:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9f828:  [<60039091>] change_signals+0x51/0x80
[42949587.660000] 67d9f898:  [<60016da8>] segv_handler+0x148/0x1c0
[42949587.660000] 67d9f8c8:  [<60016c60>] segv_handler+0x0/0x1c0
[42949587.660000] 67d9f8d8:  [<6003dbae>] sig_handler_common_skas+0xee/0x140
[42949587.660000] 67d9f918:  [<60038cb5>] sig_handler+0x25/0x30
[42949587.660000] 67d9f928:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9f9c0:  [<60020770>] pcap_remove+0x0/0x40
[42949587.660000] 67d9f9c8:  [<6022d709>] __libc_waitpid+0x39/0xc0
[42949587.660000] 67d9f9d8:  [<60022654>] pcap_close+0x4/0x40
[42949587.660000] 67d9fa78:  [<6004326c>] vprintk+0x15c/0x260
[42949587.660000] 67d9fab8:  [<60039123>] enable_mask+0x43/0x60
[42949587.660000] 67d9fac8:  [<60216155>] sigemptyset+0x15/0x40
[42949587.660000] 67d9fb08:  [<60043100>] printk+0xa0/0xb0
[42949587.660000] 67d9fb48:  [<60216091>] __sigprocmask+0x11/0x40
[42949587.660000] 67d9fb78:  [<6002078e>] pcap_remove+0x1e/0x40
[42949587.660000] 67d9fb98:  [<6002f6e5>] close_devices+0x55/0x60
[42949587.660000] 67d9fbb8:  [<60013292>] do_uml_exitcalls+0x22/0x40
[42949587.660000] 67d9fbd8:  [<60014079>] machine_power_off+0x9/0x30
[42949587.660000] 67d9fbe8:  [<60056864>] sys_reboot+0x234/0x240
[42949587.660000] 67d9fc08:  [<60052f27>] kill_proc_info+0x37/0x50
[42949587.660000] 67d9fc28:  [<60052f7c>] kill_something_info+0x3c/0x140
[42949587.660000] 67d9fcc8:  [<6008a29b>] filp_close+0x4b/0x90
[42949587.660000] 67d9fd18:  [<6001aed6>] execute_syscall_skas+0xc6/0xd0
[42949587.660000] 67d9fd38:  [<6001aefb>] handle_syscall+0x1b/0x40
[42949587.660000] 67d9fd58:  [<6003d1fb>] userspace+0x15b/0x2f0
[42949587.660000] 67d9fdb8:  [<6001b0a4>] fix_range+0x34/0x40
[42949587.660000] 67d9fdf8:  [<6001aac2>] fork_handler+0xc2/0xd0
[42949587.660000] 67d9fe38:  [<60215e10>] __restore_rt+0x0/0x10
[42949587.660000] 67d9fee8:  [<602160c9>] __kill+0x9/0x20
[42949587.660000]
[42949587.660000]  <0>Kernel panic - not syncing: Kernel mode fault at addr 0x100, ip 0x401c69d7
/uml/start.sh: line 1:  3487 Segmentation fault      /kernel-4 umid=4 mem=128M ubd0=/uml/root_fs

--=-B6xY5+1yy3pU7Xpu/pKW--



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
