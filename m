Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <556B65FB.8040404@nod.at>
Date: Sun, 31 May 2015 21:50:19 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1413111733-10763-1-git-send-email-nicolas.iooss_linux@m4x.org> <1413111733-10763-3-git-send-email-nicolas.iooss_linux@m4x.org>
In-Reply-To: <1413111733-10763-3-git-send-email-nicolas.iooss_linux@m4x.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 3/3] um/os-Linux: Use char[] for syscall_stub declarations
To: Nicolas Iooss <nicolas.iooss_linux@m4x.org>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 12.10.2014 um 13:02 schrieb Nicolas Iooss:
> When declaring __syscall_stub_start, use the same type in UML userspace
> code as in arch/um/include/asm/sections.h.
> 
> While at it, also declare batch_syscall_stub as char[].
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
> ---
>  arch/um/os-Linux/skas/mem.c     |  6 +++---
>  arch/um/os-Linux/skas/process.c | 11 +++++------
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
> index 689b18db798f..abb02becca80 100644
> --- a/arch/um/os-Linux/skas/mem.c
> +++ b/arch/um/os-Linux/skas/mem.c
> @@ -19,7 +19,7 @@
>  #include <sysdep/ptrace.h>
>  #include <sysdep/stub.h>
>  
> -extern unsigned long batch_syscall_stub, __syscall_stub_start;
> +extern char batch_syscall_stub[], __syscall_stub_start[];
>  
>  extern void wait_stub_done(int pid);
>  
> @@ -39,8 +39,8 @@ static int __init init_syscall_regs(void)
>  {
>  	get_safe_registers(syscall_regs, NULL);
>  	syscall_regs[REGS_IP_INDEX] = STUB_CODE +
> -		((unsigned long) &batch_syscall_stub -
> -		 (unsigned long) &__syscall_stub_start);
> +		((unsigned long) batch_syscall_stub -
> +		 (unsigned long) __syscall_stub_start);
>  	return 0;
>  }
>  
> diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
> index 908579f2b0ab..fa934d0c8932 100644
> --- a/arch/um/os-Linux/skas/process.c
> +++ b/arch/um/os-Linux/skas/process.c
> @@ -193,7 +193,7 @@ static void handle_trap(int pid, struct uml_pt_regs *regs,
>  	handle_syscall(regs);
>  }
>  
> -extern int __syscall_stub_start;
> +extern char __syscall_stub_start[];
>  
>  static int userspace_tramp(void *stack)
>  {
> @@ -218,7 +218,7 @@ static int userspace_tramp(void *stack)
>  		 */
>  		int fd;
>  		unsigned long long offset;
> -		fd = phys_mapping(to_phys(&__syscall_stub_start), &offset);
> +		fd = phys_mapping(to_phys(__syscall_stub_start), &offset);
>  		addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
>  			      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
>  		if (addr == MAP_FAILED) {
> @@ -245,7 +245,7 @@ static int userspace_tramp(void *stack)
>  
>  		unsigned long v = STUB_CODE +
>  				  (unsigned long) stub_segv_handler -
> -				  (unsigned long) &__syscall_stub_start;
> +				  (unsigned long) __syscall_stub_start;
>  
>  		set_sigstack((void *) STUB_DATA, UM_KERN_PAGE_SIZE);
>  		sigemptyset(&sa.sa_mask);
> @@ -474,7 +474,7 @@ static int __init init_thread_regs(void)
>  	/* Set parent's instruction pointer to start of clone-stub */
>  	thread_regs[REGS_IP_INDEX] = STUB_CODE +
>  				(unsigned long) stub_clone_handler -
> -				(unsigned long) &__syscall_stub_start;
> +				(unsigned long) __syscall_stub_start;
>  	thread_regs[REGS_SP_INDEX] = STUB_DATA + UM_KERN_PAGE_SIZE -
>  		sizeof(void *);
>  #ifdef __SIGNAL_FRAMESIZE
> @@ -582,8 +582,7 @@ int map_stub_pages(int fd, unsigned long code, unsigned long data,
>  	struct proc_mm_op mmop;
>  	int n;
>  	unsigned long long code_offset;
> -	int code_fd = phys_mapping(to_phys((void *) &__syscall_stub_start),
> -				   &code_offset);
> +	int code_fd = phys_mapping(to_phys(__syscall_stub_start), &code_offset);
>  
>  	mmop = ((struct proc_mm_op) { .op        = MM_MMAP,
>  				      .u         =

Thank you Nicoals, all three patches are now in my 4.2 queue!
Special thanks to Thomas Meyer for exhuming this patches. :-)

Thanks,
//richard
