Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWjam-0001Wi-6T for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 14:57:00 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CWjac-0007Qg-Um for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 14:56:59 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML 2.4 shmem.c changes? panic w/ backtrace
References: <41A35EF5.4080302@enterasys.com>
In-Reply-To: <41A35EF5.4080302@enterasys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411232113.51612.blaisorblade_spam@yahoo.it>
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
Date: Tue, 23 Nov 2004 21:13:51 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "D. Bahi" <dbahi@enterasys.com>

On Tuesday 23 November 2004 17:01, D. Bahi wrote:
> hello uml folks,

> i know things are hot and heavy in 2.6 but i hope
> somebody can spare a thought about this panic i'm
> struggling to understand.

> i know UML touches shmem.c - lightly
I'll drop that change ASAP from the -bs tree - it's useless currently (it's a 
residual from older work).
> and i'd like 
> to think it's a kernel bug w/ shmem but we run this
> 2.4.20 kernel on hardware with the same applications
> and do not see this failure.

If you don't access /dev/anon inside UML, that change should be a no-op. 
Should, however, means no certainty. But how do you reproduce that?

> host is RH9 2.4.20-31.9 + skas

> guest is UML 2.4.26-3um
> backported to 2.4.20-montavista 3.1 pro
Err - what is this montavista tree? If it supports realtime, then the 
interaction is probably unlikely to be good.
> (gdb) bt
> #0  0x08167aca in nanosleep () at proc_fs.h:154
> #1  0x081679cb in sleep () at proc_fs.h:154
> #2  0x080e3bc1 in stop () at user_util.c:52
> #3  0x080e37ec in panic_waitonerr (self=0x81f77cc, unused1=0,
> unused2=0x8206120) at um_arch.c:457
> #4  0x0805eeb2 in notifier_call_chain (n=0xfffffffc, val=0, v=0x8206120)
> at sys.c:131
> #5  0x08053bb3 in panic (fmt=0x81c99c0 "Kernel mode fault at addr 0x%lx,
> ip 0x%lx") at panic.c:69
> #6  0x080e2efd in segv (address=0, ip=1078054417, is_write=0, is_user=0,
> sc=0x30da82a4) at trap_kern.c:149
> #7  0x080e31cd in segv_handler (sig=11, regs=0x30da82a4) at trap_user.c:74
> #8  0x080e5611 in sig_handler_common_skas (sig=11, sc_ptr=0x58) at
> trap_user.c:35
> #9  0x080e31ee in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0,
> __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 49168, edi = 336, esi =
> 818643476, ebp = 819657132, esp = 819657124, ebx = 0, edx = 42, ecx =
> 818643560, eax = 0, trapno = 14, err = 4, eip = 134682879, cs = 35,
> __csh = 0, eflags = 2163270, esp_at_signal = 819657124, ss = 43, __ssh =
> 0, fpstate = 0x0, oldmask = 134217728, cr2 = 0}) at trap_user.c:109
> #10 <signal handler called>
> #11 shmem_block (index=42, page=0x0, direct=0x0, indirect=0x30cb8268) at
> shmem.c:149
> #12 0x08071984 in shmem_swp_entry (info=0x0, index=42, page=0x0) at
> shmem.c:182
> #13 0x08071aa5 in shmem_truncate (inode=0x30cb8100) at shmem.c:349
> #14 0x08064772 in vmtruncate (inode=0x30cb8100, offset=172368) at
> memory.c:1128
> #15 0x080898b9 in inode_setattr (inode=0x30cb8100, attr=0x30dafb24) at
> attr.c:67
> #16 0x08071c16 in shmem_notify_change (dentry=0x0, attr=0x30dafb24) at
> shmem.c:398
> #17 0x08089a3d in notify_change (dentry=0x30ed4878, attr=0x30dafb24) at
> attr.c:132
> #18 0x08073f4a in do_truncate (dentry=0x30ed4878, length=172368) at
> open.c:113
> #19 0x080751bf in do_sys_ftruncate (fd=0, length=172368, small=1) at
> open.c:220
> #20 0x08073f8f in sys_ftruncate (fd=21, length=172368) at open.c:229
> #21 0x080e5162 in execute_syscall_skas (r=0x2a) at syscall_kern.c:28
> #22 0x080e5192 in handle_syscall (regs=0x30da82a4) at syscall_user.c:26
> #23 0x080e43c1 in handle_trap (pid=5308, regs=0x30da82a4) at process.c:85
> #24 0x080e4693 in userspace (regs=0x30da82a4) at process.c:160
> #25 0x080e4dae in fork_handler (sig=10) at process_kern.c:104
> #26 <signal handler called>
> #27 0x0815a631 in kill () at proc_fs.h:154
> #28 0x080e8708 in os_usr1_process (pid=5304) at process.c:98
> #29 0x080e4706 in new_thread (stack=Cannot access memory at address 0x8
> ) at process.c:197

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
