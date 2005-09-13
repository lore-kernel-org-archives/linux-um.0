Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFJvQ-0000cN-QF	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Sep 2005 16:10:52 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFJvP-0006vw-Pg
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Sep 2005 16:10:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id A319C45649
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 14 Sep 2005 06:17:33 +0100 (BST)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 02751-17 for <user-mode-linux-devel@lists.sourceforge.net>;
 Wed, 14 Sep 2005 06:17:30 +0100 (BST)
Received: from [192.168.0.3] (host-87-74-41-116.bulldogdsl.com [87.74.41.116])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 31E1445648
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 14 Sep 2005 06:17:30 +0100 (BST)
From: antoine <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1126653933.3769.45.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] testing: 2.6.13 to 2.6.14-rc1 TT boot hangs early
	(sometimes)
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
Date: Wed, 14 Sep 2005 00:25:32 +0100
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Hello list,

I am back testing things, some initial results:

* Some of the latest kernels I've built for x86 stop early in the boot.
Here is a 2.6.14-rc1 TT guest:

read(255, "./kernel.bin root=/dev/ubda mem="..., 330) = 130
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|
SIGCHLD, child_tidptr=0xb7e70928) = 922
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x8078320, [], 0}, {SIG_DFL}, 8) = 0
waitpid(-1, Checking for /proc/mm...found
Checking for the skas3 patch in the host...found
UML running in SKAS3 mode
Checking PROT_EXEC mmap in /tmp...OK
Kernel virtual memory size shrunk to 28311552 bytes

[{WIFEXITED(s) && WEXITSTATUS(s) == 1}], 0) = 922
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, 0xbf8c7e6c, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [])
rt_sigaction(SIGINT, {SIG_DFL}, {0x8078320, [], 0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "", 330)                      = 0
exit_group(1)                           = ?

# uname -a
Linux localhost 2.6.13.1-skas3-v9-pre7 #3 Sat Sep 10 20:35:26 BST 2005
i686 AMD Athlon(tm) XP 3200+ unknown GNU/Linux

What's this about shrinking vm size? (reducing the mem gets rid of this
warning) - Google found some dead links.
I also tried mode=tt and mode=skas0 with the same result.
I've also had kernels booting up to the point of mounting root and then
spinning at 100% cpu usage.

* Next one:
Not sure if I am supposed to be able to strace a TT kernel, but when I
do (this is on another system that breaks) here is what I get (end of
long log only).
Kernel panic - not syncing: Kernel mode fault at addr 0x8c2420, ip
0x8c2420

[42949374.400000] ReiserFS: ubda: Using r5 hash to sort names
[42949374.400000] VFS: Mounted root (reiserfs filesystem) readonly.
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGALRM}], WSTOPPED) =
2037
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_CONT, 2037, 0, SIGALRM)   = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGIO}], WSTOPPED) = 2037
ptrace(PTRACE_CONT, 2037, 0, SIGIO)     = 0
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGIO}], WSTOPPED) = 2037
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_CONT, 2037, 0, SIGIO)     = 0
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGIO}], WSTOPPED) = 2037
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_CONT, 2037, 0, SIGIO)     = 0
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGIO}], WSTOPPED) = 2037
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_CONT, 2037, 0, SIGIO)     = 0
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGIO}], WSTOPPED) = 2037
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_CONT, 2037, 0, SIGIO)     = 0
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGIO}], WSTOPPED) = 2037
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_CONT, 2037, 0, SIGIO)     = 0
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGIO}], WSTOPPED) = 2037
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_CONT, 2037, 0, SIGIO)     = 0
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGIO}], WSTOPPED) = 2037
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_CONT, 2037, 0, SIGIO)     = 0
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGIO}], WSTOPPED) = 2037
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_CONT, 2037, 0, SIGIO)     = 0
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGIO}], WSTOPPED) = 2037
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_CONT, 2037, 0, SIGIO)     = 0
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGIO}], WSTOPPED) = 2037
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_CONT, 2037, 0, SIGIO)     = 0
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGIO}], WSTOPPED) = 2037
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_CONT, 2037, 0, SIGIO)     = 0
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGIO}], WSTOPPED) = 2037
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_CONT, 2037, 0, SIGIO)     = 0
waitpid(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGUSR1}], WSTOPPED) =
2039
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_ATTACH, 2065, 0, 0)       = 0
ptrace(PTRACE_CONT, 2065, 0, SIG_0)     = 0
waitpid(2065, NULL, WSTOPPED)           = 2065
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_GETREGS, 2039, 0, 0xbfdc2f50) = 0
kill(2039, SIGKILL)                     = 0
ptrace(PTRACE_KILL, 2039, 0, 0xbfdc2f50) = 0
[42949374.410000] Kernel panic - not syncing: Kernel mode fault at addr
0x1a8420, ip 0x1a8420
[42949374.410000]
[42949374.410000] EIP: 0073:[<001a8420>] CPU: 0 Not tainted ESP:
007b:b022310c EFLAGS: 00010296
[42949374.410000]     Not tainted
[42949374.410000] EAX: a03bae68 EBX: 00000001 ECX: 00000005 EDX:
00000000
[42949374.410000] ESI: 00000008 EDI: b022354c EBP: b02233ec DS: 007b ES:
007b
[42949374.410000] b0222c30:  [<a0040d93>] show_regs+0x113/0x140
[42949374.410000] b0222c50:  [<a001948c>] panic_exit+0x2c/0x50
[42949374.410000] b0222c60:  [<a005471d>] notifier_call_chain+0x2d/0x50
[42949374.410000] b0222c80:  [<a0044e72>] panic+0x72/0x110
[42949374.410000] b0222ca0:  [<a00189b4>] segv+0x274/0x2b0
[42949374.410000] b0222d90:  [<a0018c9e>] segv_handler+0x8e/0x90
[42949374.410000] b0222dc0:  [<a001c297>] sig_handler_common_tt
+0xb7/0x150
[42949374.410000] b0222e20:  [<a003cd48>] sig_handler+0x18/0x20
[42949374.410000] b0222e30:  [<001a8420>] 0x1a8420
[42949374.410000] b02233f0:  [<a00166e2>] change_signals+0x62/0x90
[42949374.410000] b0223490:  [<a0016742>] unblock_signals+0x12/0x20
[42949374.410000] b02234a0:  [<a015260b>] generic_unplug_device
+0x1b/0x20
[42949374.410000] b02234b0:  [<a015262d>] blk_backing_dev_unplug
+0x1d/0x20
[42949374.410000] b02234c0:  [<a00878a2>] sync_buffer+0x42/0x50
[42949374.410000] b02234d0:  [<a023a966>] __wait_on_bit+0x66/0x70
[42949374.410000] b02234f0:  [<a023a9f4>] out_of_line_wait_on_bit
+0x84/0x90
[42949374.410000] b0223580:  [<a0087948>] __wait_on_buffer+0x38/0x40
[42949374.410000] b0223590:  [<a00e357e>] search_by_key+0xee/0xe10
[42949374.410000] b02236d0:  [<a00c979e>] search_by_entry_key+0x2e/0x230
[42949374.410000] b0223710:  [<a00c9d60>] reiserfs_find_entry+0x90/0x130
[42949374.410000] b0223770:  [<a00c9e7b>] reiserfs_lookup+0x7b/0x170
[42949374.410000] b0223860:  [<a00940bc>] real_lookup+0xbc/0xe0
[42949374.410000] b0223880:  [<a0094464>] do_lookup+0x94/0xa0
[42949374.410000] b02238b0:  [<a0094c9c>] __link_path_walk+0x82c/0x1070
[42949374.410000] b02239d0:  [<a0095522>] link_path_walk+0x42/0xf0
[42949374.410000] b0223a50:  [<a00958c5>] path_lookup+0xa5/0x1e0
[42949374.410000] b0223ab0:  [<a0090d28>] open_exec+0x28/0xf0
[42949374.410000] b0223b30:  [<a0091e24>] do_execve+0x44/0x220
[42949374.410000] b0223b60:  [<a00118d8>] execve1+0x38/0x80
[42949374.410000] b0223b90:  [<a0011942>] um_execve+0x22/0x60
[42949374.410000] b0223bb0:  [<a00111bc>] run_init_process+0x4c/0x80
[42949374.410000] b0223be0:  [<a00112c4>] init+0xd4/0x170
[42949374.410000] b0223c00:  [<a003ccf9>] run_kernel_thread+0x49/0x50
[42949374.410000] b0223cd0:  [<a001a7cb>] new_thread_handler+0x14b/0x180
[42949374.410000] b0223d20:  [<001a8420>] 0x1a8420
[42949374.410000]
[42949374.410000]  Failed to restore terminal state - errno = 1
tracing thread pid = 2033

# uname -a
Linux mamba 2.6.12-skas3-v9-pre4 #2 Thu Jun 23 16:28:29 GMT i686 AMD
Athlon(tm) XP 2000+ AuthenticAMD GNU/Linux
I tried the same filesystem as ext3 but that made no difference.
Guest is 2.6.14-rc1

Same kernel in skas3/skas0 works occasionally! But when it does not:
[42949374.340000] VFS: Mounted root (ext3 filesystem) readonly.
[42949384.250000] BUG: soft lockup detected on CPU#0!
[42949384.250000]
[42949384.250000] EIP: 0073:[<400007c0>] CPU: 0 Not tainted ESP:
007b:bffdde70 EFLAGS: 00000202
[42949384.250000]     Not tainted
[42949384.250000] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX:
00000000
[42949384.250000] ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 007b ES:
007b
[42949384.250000] b1b071f8:  [<a0046574>] show_regs+0x214/0x220
[42949384.250000] b1b07228:  [<a006e6d7>] softlockup_tick+0x57/0x60
[42949384.250000] b1b07248:  [<a00582a7>] do_timer+0x47/0xd0
[42949384.250000] b1b07258:  [<a00181c4>] um_timer+0x14/0x50
[42949384.250000] b1b07268:  [<a006e873>] handle_IRQ_event+0x33/0x80
[42949384.250000] b1b07298:  [<a006e915>] __do_IRQ+0x55/0xb0
[42949384.250000] b1b072c8:  [<a0012180>] do_IRQ+0x30/0x40
[42949384.250000] b1b072d8:  [<a0018113>] timer_irq+0x113/0x170
[42949384.250000] b1b07308:  [<a00184d0>] timer_handler+0x70/0x90
[42949384.250000] b1b07328:  [<a001fef3>] sig_handler_common_skas
+0x93/0xf0
[42949384.250000] b1b07358:  [<a0040d9c>] alarm_handler+0x5c/0x70
[42949384.250000] b1b07378:  [<002e4420>] 0x2e4420
[42949384.250000] b1b07668:  [<a0018d3c>] flush_tlb_kernel_range_common
+0xbc/0x170
[42949384.250000] b1b07698:  [<a0018f6e>] flush_tlb_kernel_vm+0x2e/0x30
[42949384.250000] b1b076a8:  [<a0019508>] segv+0x258/0x2b0
[42949384.250000] b1b07798:  [<a001984f>] segv_handler+0xaf/0x100
[42949384.250000] b1b077c8:  [<a001fef3>] sig_handler_common_skas
+0x93/0xf0
[42949384.250000] b1b077f8:  [<a0040d35>] sig_handler+0x35/0x40
[42949384.250000] b1b07808:  [<002e4420>] 0x2e4420
[42949384.250000] b1b07b20:  [<a0143dc6>] snprintf+0x26/0x30
[42949384.250000] b1b07b40:  [<a0019cfd>] set_cmdline+0x9d/0x100
[42949384.250000] b1b07b70:  [<a001194b>] execve1+0x7b/0x80
[42949384.250000] b1b07ba0:  [<a0011972>] um_execve+0x22/0x60
[42949384.250000] b1b07bc0:  [<a00111bc>] run_init_process+0x4c/0x80
[42949384.250000] b1b07bf0:  [<a00112b8>] init+0xc8/0x170
[42949384.250000] b1b07c10:  [<a0040cc9>] run_kernel_thread+0x49/0x50
[42949384.250000] b1b07ce0:  [<a001f593>] new_thread_handler+0xc3/0x120
[42949384.250000] b1b07d20:  [<002e4420>] 0x2e4420
[42949384.250000]


* Good points:
pcap works really well.
I just wished there was a way to easily figure out which libraries need
to be included in the chroot to make it work (beyond lipcap)


* Some other small issues:
when building IPv6 & pcap, I get:
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/../../../libc.a(in6_addr.o)(.rodata+0x10): multiple definition of `in6addr_loopback'

(This has been the case with the last few releases)

Hope this helps, as usual - let me know what I can do to help

Cheers
Antoine



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
