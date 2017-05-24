Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] um: Allow building and running on older hosts
References: <20170524010858.16134-1-f.fainelli@gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <d2f4abc4-3d79-45e8-661a-25a244c836e4@nod.at>
Date: Wed, 24 May 2017 09:01:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170524010858.16134-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: elicooper@gmx.com, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, Thomas Meyer <thomas@m3y3r.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

CC'ing Thomas. We is also facing issues with these commits.

Am 24.05.2017 um 03:08 schrieb Florian Fainelli:
> Commit a78ff1112263 ("um: add extended processor state save/restore
> support") and b6024b21fec8 ("um: extend fpstate to _xstate to support
> YMM registers") forced the use of the x86 FP _xstate and
> PTRACE_GETREGSET/SETREGSET. On older hosts, we would neither be able to
> build UML nor run it anymore with these two commits applied because we
> don't have definitions for struct _xstate nor these two ptrace requests.
> 
> We can determine at build time which fp context structure to check
> against, just like we can keep using the old i387 fp save/restore if
> PTRACE_GETRESET/SETREGSET are not defined.
> 
> Fixes: a78ff1112263 ("um: add extended processor state save/restore support")
> Fixes: b6024b21fec8 ("um: extend fpstate to _xstate to support YMM registers")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/x86/um/os-Linux/registers.c | 13 +++++++++----
>  arch/x86/um/user-offsets.c       |  4 ++++
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
> index 00f54a91bb4b..502bd642e5c2 100644
> --- a/arch/x86/um/os-Linux/registers.c
> +++ b/arch/x86/um/os-Linux/registers.c
> @@ -26,13 +26,14 @@ int save_i387_registers(int pid, unsigned long *fp_regs)
>  
>  int save_fp_registers(int pid, unsigned long *fp_regs)
>  {
> -	struct iovec iov;
> -
>  	if (have_xstate_support) {
> +#ifdef PTRACE_GETREGSET
> +		struct iovec iov;
>  		iov.iov_base = fp_regs;
>  		iov.iov_len = sizeof(struct _xstate);
>  		if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
>  			return -errno;
> +#endif
>  		return 0;
>  	} else {
>  		return save_i387_registers(pid, fp_regs);
> @@ -48,13 +49,15 @@ int restore_i387_registers(int pid, unsigned long *fp_regs)
>  
>  int restore_fp_registers(int pid, unsigned long *fp_regs)
>  {
> -	struct iovec iov;
> -
>  	if (have_xstate_support) {
> +#ifdef PTRACE_SETREGSET
> +		struct iovec iov;
> +
>  		iov.iov_base = fp_regs;
>  		iov.iov_len = sizeof(struct _xstate);
>  		if (ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
>  			return -errno;
> +#endif
>  		return 0;
>  	} else {
>  		return restore_i387_registers(pid, fp_regs);
> @@ -127,8 +130,10 @@ void arch_init_registers(int pid)
>  
>  	iov.iov_base = &fp_regs;
>  	iov.iov_len = sizeof(struct _xstate);
> +#ifdef PTRACE_GETREGSET
>  	if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) == 0)
>  		have_xstate_support = 1;
> +#endif
>  }
>  #endif
>  
> diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
> index cb3c22370cf5..8af0fb5d2780 100644
> --- a/arch/x86/um/user-offsets.c
> +++ b/arch/x86/um/user-offsets.c
> @@ -50,7 +50,11 @@ void foo(void)
>  	DEFINE(HOST_GS, GS);
>  	DEFINE(HOST_ORIG_AX, ORIG_EAX);
>  #else
> +#if defined(PTRACE_GETREGSET) && defined(PTRACE_SETREGSET)
>  	DEFINE(HOST_FP_SIZE, sizeof(struct _xstate) / sizeof(unsigned long));
> +#else
> +	DEFINE(HOST_FP_SIZE, sizeof(struct _fpstate) / sizeof(unsigned long));
> +#endif
>  	DEFINE_LONGS(HOST_BX, RBX);
>  	DEFINE_LONGS(HOST_CX, RCX);
>  	DEFINE_LONGS(HOST_DI, RDI);
> 

