Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9qSK-0004Z4-AC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Sep 2004 12:37:40 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1C9qSI-0007HZ-SC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Sep 2004 12:37:39 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <EAC7622167479948B614F8B9AD41C505ECA519@MAANDMBX2.ets.enterasys.com>
In-Reply-To: <EAC7622167479948B614F8B9AD41C505ECA519@MAANDMBX2.ets.enterasys.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409212045.01102.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] Kernel panic: Segfault with no mm &&
	CONFIG_DEBUG_SLAB
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
Date: Tue, 21 Sep 2004 20:45:01 +0200
To: user-mode-linux-user@lists.sourceforge.net
Cc: "Tsillas, Demetrios J" <jtsillas@enterasys.com>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Sunday 19 September 2004 15:03, Tsillas, Demetrios J wrote:

OK, let's start analyzing it. I have some ideas, but that's just a guess about 
it.

Here there is segv handling stack, nothing new:

> #0  0x08157021 in kill ()
...
> #9  0x080d9f5e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0,
> __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 671043576, esi
> = 671088637, ebp = 154237660, esp = 154237636, ebx = 671039488, edx =
> 4096, ecx = 2, eax = 154206208, trapno = 14, err = 4, eip = 135120628,
> cs = 35, __csh = 0, eflags = 66054, esp_at_signal = 154237636, ss = 43,
> __ssh = 0, fpstate = 0x0, oldmask = 134217728, cr2 = 671088640}) at
> trap_user.c:109

> #10 <signal handler called>
Here we have the problem:

> #11 0x080dc6f4 in copy_from_user_skas (to=0x27fff005, from=0x27fffffd,
> n=136244252) at string.h:202
Here we do copy_from_user_skas, and we should be with get_fs() == KERNEL_DS;  
maybe we are not with that set (although for the init task this should be 
granted, see include/asm-um/thread_info.h: INIT_THREAD_INFO).

> #12 0x0808a50c in copy_mount_options (data=0x27fff005, where=0x9317b30)
> at um_uaccess.h:31
This is actually inside fs/namespace.c, but executing UML code.

> #13 0x0808aa18 in sys_mount (dev_name=0x81ad3f8 "/dev/root",
> dir_name=0x81ad3fc "/root", type=0x27fff005 "ext2", flags=32769,
> data=0x0) at namespace.c:838

As you see below, we are called from kernel-space code. And with SKAS one more 
copy_from_user hurts a lot, if get_fs() has not the right ! I guess that 
get_fs() != KERNEL_DS, i.e. it is not set correctly.

> #14 0x08049878 in mount_block_root (name=0x81ad3f8 "/dev/root",
> flags=32769) at init/do_mounts.c:371
> #15 0x08049cbc in mount_root () at init/do_mounts.c:816
> #16 0x08050717 in prepare_namespace () at init/do_mounts.c:944
> #17 0x080504e1 in init (unused=0x0) at init/main.c:562
> #18 0x080d6239 in run_kernel_thread (fn=0x80504d0 <init>, arg=0x0,
> jmp_ptr=0x81eec1c) at process.c:231
> #19 0x080dba06 in new_thread_handler (sig=10) at process_kern.c:72

We are called by rest_init(), by way of kernel_thread.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
