Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ES5Iy-0002gZ-7G	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Oct 2005 21:11:56 -0700
Received: from slartibartfast.pa.net ([66.59.111.182])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ES5Iw-0008Or-LH
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Oct 2005 21:11:56 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-devel] 2.6.14-rc4; panic: do_syscall_stub : failed to wait
 for SIGUSR1/SIGTRAP
In-Reply-To: <20051013161937.GA5352@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.64.0510190006090.6385@sparrow>
References: <Pine.LNX.4.64.0510122241080.6495@sparrow>
 <20051013161937.GA5352@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Wed, 19 Oct 2005 00:09:41 -0400 (EDT)
To: Jeff Dike <jdike@addtoit.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, William Stearns <wstearns@pobox.com>

Good evening, Jeff,

On Thu, 13 Oct 2005, Jeff Dike wrote:

> On Wed, Oct 12, 2005 at 11:39:02PM -0400, William Stearns wrote:
>> Kernel panic - not syncing: do_syscall_stub : failed to wait for
>> SIGUSR1/SIGTRAP, pid = 3357, n = 3357, errno = 0, status = 0xb7f
>
> Can you apply the patch below, and see what it says?
>
> 				Jeff
>
> Index: linux-2.6.14-rc2-mm1/arch/um/kernel/skas/process.c
> ===================================================================
> --- linux-2.6.14-rc2-mm1.orig/arch/um/kernel/skas/process.c	2005-10-05 18:37:51.000000000 -0400
> +++ linux-2.6.14-rc2-mm1/arch/um/kernel/skas/process.c	2005-10-05 18:50:23.000000000 -0400
> @@ -69,6 +69,17 @@
>
>         if((n < 0) || !WIFSTOPPED(status) ||
>            (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status) != SIGTRAP)){
> +		unsigned long regs[FRAME_SIZE];
> +		if(ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
> +			printk("Failed to get registers from stub, "
> +			       "errno = %d\n", errno);
> +		else {
> +			int i;
> +
> +			printk("Stub registers -\n");
> +			for(i = 0; i < FRAME_SIZE; i++)
> +				printk("\t%d - %lx\n", i, regs[i]);
> +		}
>                 panic("%s : failed to wait for SIGUSR1/SIGTRAP, "
>                       "pid = %d, n = %d, errno = %d, status = 0x%x\n",
>                       fname, pid, n, errno, status);

 	OK, switched over to an fc3 rootfs and ran with your patch:

...
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Warning: unable to open an initial console.
Stub registers -
         0 - 357e
         1 - 13
         2 - 357e
         3 - 357b
         4 - 0
         5 - 0
         6 - 4
         7 - 0
         8 - 0
         9 - 0
         10 - 0
         11 - ffffffff
         12 - bfffe0dd
         13 - 73
         14 - 10202
         15 - bffff008
         16 - 7b
Kernel panic - not syncing: do_syscall_stub : failed to wait for 
SIGUSR1/SIGTRAP, pid = 13697, n = 13697, errn
o = 0, status = 0xb7f


EIP: 0000:[<0000007b>] CPU: 0 Not tainted EFLAGS: 00000000
     Not tainted
EAX: 00000000 EBX: 0000357e ECX: 00000013 EDX: 0000357e
ESI: 0000357b EDI: 0000007b EBP: 00000000 DS: 0025 ES: 46c1
a64a3300:  [<a0032e13>] show_regs+0x1db/0x1ec
a64a3330:  [<a001c933>] panic_exit+0x27/0x48
a64a3350:  [<a00478f2>] notifier_call_chain+0x1e/0x3c
a64a3380:  [<a0036dc6>] panic+0x56/0xfc
a64a33a0:  [<a0020119>] wait_stub_done+0xc1/0x170
a64a3440:  [<a001f836>] do_syscall_stub+0x62/0x1c8
a64a34d0:  [<a001fa42>] run_syscall_stub+0xa6/0xd4
a64a34f0:  [<a001fbee>] map+0xf2/0x110
a64a3580:  [<a0021634>] do_ops+0xec/0xf8
a64a35d0:  [<a001b6d2>] fix_range_common+0x1d2/0x284
a64a3650:  [<a0021677>] fix_range+0x37/0x3c
a64a3680:  [<a00216c2>] flush_tlb_range_skas+0x2e/0x34
a64a36a0:  [<a001ba33>] flush_tlb_range+0x33/0x38
a64a36c0:  [<a001b93b>] flush_tlb_page+0x1f/0x24
a64a36e0:  [<a001bc15>] handle_page_fault+0x189/0x250
a64a3730:  [<a0021906>] maybe_map+0x66/0x98
a64a3770:  [<a0021949>] do_op+0x11/0x48
a64a3790:  [<a00219eb>] do_buffer_op+0x6b/0x138
a64a37e0:  [<a001d081>] setjmp_wrapper+0x45/0x50
a64a38b0:  [<a0021adf>] buffer_op+0x27/0x5c
a64a38f0:  [<a0021e43>] clear_user_skas+0x53/0x7c
a64a3930:  [<a0099a47>] padzero+0x2f/0x50
a64a3950:  [<a009a337>] load_elf_interp+0x1e3/0x2a0
a64a39a0:  [<a009ae97>] load_elf_binary+0x8bf/0xf84
a64a3af0:  [<a007c00c>] search_binary_handler+0x54/0xf0
a64a3b30:  [<a007c22a>] do_execve+0x182/0x240
a64a3b70:  [<a00157e4>] execve1+0x28/0x7c
a64a3ba0:  [<a001584d>] um_execve+0x15/0x50
a64a3bc0:  [<a0015164>] run_init_process+0x40/0x6c
a64a3bf0:  [<a0015256>] init+0xc6/0x168
a64a3c10:  [<a002daa9>] run_kernel_thread+0x31/0x38
a64a3cd0:  [<a0021014>] new_thread_handler+0xb0/0x10c
a64a3d20:  [<b7f5d420>] 0xb7f5d420


[wstearns@sparrow test-fc3]$

 	These filesystems seem to have an almost empty /dev/, so I'll 
repopulate with device nodes and retry.  I'll report back if I can get any 
more luck with this, but wanted to get an initial answer back finally.
 	Sorry to take so long.
 	Cheers,
 	- Bill

---------------------------------------------------------------------------
 	"Hackers do not feel that leisure time is automatically any more
meaningful than work time. The desirability of both depends on how they
are realized.  From the point of a view of a meaningful life, the entire
work/leisure duality must be abandoned.  As long as we are living our
work or our leisure, we are not even truly living.  Meaning cannot be
found in work or leisure but has to arise out of the nature of the
activity itself.  Out of passion.  Social value.  Creativity."
         -- Andrew Leonard <aleonard@salon.com>
         http://salon.com/tech/col/leon/2001/02/05/hacker_ethic/index2.html
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
