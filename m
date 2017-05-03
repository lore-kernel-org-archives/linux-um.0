Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <20170403195458.112185-1-mka@chromium.org>
References: <20170403195458.112185-1-mka@chromium.org>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 3 May 2017 22:54:14 +0200
Message-ID: <CAFLxGvy1Hzti9+2XFPzeFBVuFnKaPX=+yEzxD+Wdb1dAkfP5rw@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: Include kbuild.h instead of duplicating
	its macros
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Matthias Kaehlcke <mka@chromium.org>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Mon, Apr 3, 2017 at 9:54 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
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
> -       asm volatile("\n->" #sym " %0 " #val : : "i" (val))
> -
> -#define BLANK() asm volatile("\n->" : : )
> -
> -#define OFFSET(sym, str, mem) \
> -       DEFINE(sym, offsetof(struct str, mem));
> -
>  void foo(void)
>  {
>  #include <common-offsets.h>
> --
> 2.12.2.564.g063fe858b8-goog
>

Applied.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

