Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] arch/um: compile with modern headers
Date: Wed, 13 Dec 2017 21:41:58 +0100
Message-ID: <3173108.m2qnmkuYxR@blindfold>
In-Reply-To: <20171213172230.10552-1-Jason@zx2c4.com>
References: <20171213172230.10552-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Jason,

Am Mittwoch, 13. Dezember 2017, 18:22:30 CET schrieb Jason A. Donenfeld:
> Recent libcs have gotten a bit more strict, so we actually need to
> include the right headers and use the right types. This enables UML to
> compile again.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/um/os-Linux/file.c   | 1 +
>  arch/um/os-Linux/signal.c | 3 ++-
>  arch/x86/um/stub_segv.c   | 3 ++-
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
> index 2db18cbbb0ea..c0197097c86e 100644
> --- a/arch/um/os-Linux/file.c
> +++ b/arch/um/os-Linux/file.c
> @@ -12,6 +12,7 @@
>  #include <sys/mount.h>
>  #include <sys/socket.h>
>  #include <sys/stat.h>
> +#include <sys/sysmacros.h>
>  #include <sys/un.h>
>  #include <sys/types.h>
>  #include <os.h>
> diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
> index a86d7cc2c2d8..bf0acb8aad8b 100644
> --- a/arch/um/os-Linux/signal.c
> +++ b/arch/um/os-Linux/signal.c
> @@ -16,6 +16,7 @@
>  #include <os.h>
>  #include <sysdep/mcontext.h>
>  #include <um_malloc.h>
> +#include <sys/ucontext.h>
> 
>  void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
>  	[SIGTRAP]	= relay_signal,
> @@ -159,7 +160,7 @@ static void (*handlers[_NSIG])(int sig, struct siginfo
> *si, mcontext_t *mc) = {
> 
>  static void hard_handler(int sig, siginfo_t *si, void *p)
>  {
> -	struct ucontext *uc = p;
> +	ucontext_t *uc = p;
>  	mcontext_t *mc = &uc->uc_mcontext;
>  	unsigned long pending = 1UL << sig;
> 
> diff --git a/arch/x86/um/stub_segv.c b/arch/x86/um/stub_segv.c
> index 1518d2805ae8..27361cbb7ca9 100644
> --- a/arch/x86/um/stub_segv.c
> +++ b/arch/x86/um/stub_segv.c
> @@ -6,11 +6,12 @@
>  #include <sysdep/stub.h>
>  #include <sysdep/faultinfo.h>
>  #include <sysdep/mcontext.h>
> +#include <sys/ucontext.h>
> 
>  void __attribute__ ((__section__ (".__syscall_stub")))
>  stub_segv_handler(int sig, siginfo_t *info, void *p)
>  {
> -	struct ucontext *uc = p;
> +	ucontext_t *uc = p;
> 
>  	GET_FAULTINFO_FROM_MC(*((struct faultinfo *) STUB_DATA),
>  			      &uc->uc_mcontext);

Can you please rebase your fix on linux-next?
I have already a very similar fix in the pipe.

Thanks,
//richard

