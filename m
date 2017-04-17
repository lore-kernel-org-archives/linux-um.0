Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 17 Apr 2017 13:37:38 -0700
From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] um: Include kbuild.h instead of duplicating its macros
Message-ID: <20170417203738.GQ28657@google.com>
References: <20170403195458.112185-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170403195458.112185-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

El Mon, Apr 03, 2017 at 12:54:58PM -0700 Matthias Kaehlcke ha dit:

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/x86/um/shared/sysdep/kernel-offsets.h | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/x86/um/shared/sysdep/kernel-offsets.h b/arch/x86/um/shared/sysdep/kernel-offsets.h
> index 46a9df99f3c5..7e1d35b6ad5c 100644
> --- a/arch/x86/um/shared/sysdep/kernel-offsets.h
> +++ b/arch/x86/um/shared/sysdep/kernel-offsets.h
> @@ -2,16 +2,9 @@
>  #include <linux/sched.h>
>  #include <linux/elf.h>
>  #include <linux/crypto.h>
> +#include <linux/kbuild.h>
>  #include <asm/mman.h>
>  
> -#define DEFINE(sym, val) \
> -	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
> -
> -#define BLANK() asm volatile("\n->" : : )
> -
> -#define OFFSET(sym, str, mem) \
> -	DEFINE(sym, offsetof(struct str, mem));
> -
>  void foo(void)
>  {
>  #include <common-offsets.h>
> -- 

Ping, any comment on this patch?

Cheers

Matthias

