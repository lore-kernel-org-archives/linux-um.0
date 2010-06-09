Return-Path: <bharrosh@panasas.com>
Message-ID: <4C0FC3DC.9040401@panasas.com>
Date: Wed, 09 Jun 2010 19:39:56 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH resend] um, hweight: Fix UML boot crash
References: <4C0F4B00.4090307@panasas.com>
In-Reply-To: <4C0F4B00.4090307@panasas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 06/09/2010 11:04 AM, Boaz Harrosh wrote:
> From: Borislav Petkov <bp@alien8.de>
> 
> Obviously UML cannot stomach callee reg-saving trickery
> introduced with d61931d89be506372d01a90d1755f6d0a9fafe2d
> (x86: Add optimized popcnt variants) and oopses during boot:
> http://marc.info/?l=linux-kernel&m=127522065202435&w=2
> 
> Redirect arch_hweight.h include from the x86 portion to the generic
> arch_hweight.h which is a fallback to the software hweight routines.
> 

CC: Andrew Morton <akpm@linux-foundation.org>
> LKML-Reference: <201005271944.09541.toralf.foerster@gmx.de>
> Signed-off-by: Borislav Petkov <bp@alien8.de>

Andrew would you please push this patch for 2.6.35-rc3

Thanks
Boaz

> ---
>  arch/um/include/asm/arch_hweight.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>  create mode 100644 arch/um/include/asm/arch_hweight.h
> 
> diff --git a/arch/um/include/asm/arch_hweight.h b/arch/um/include/asm/arch_hweight.h
> new file mode 100644
> index 0000000..c656cf4
> --- /dev/null
> +++ b/arch/um/include/asm/arch_hweight.h
> @@ -0,0 +1,6 @@
> +#ifndef _ASM_UM_HWEIGHT_H
> +#define _ASM_UM_HWEIGHT_H
> +
> +#include <asm-generic/bitops/arch_hweight.h>
> +
> +#endif
> -- 1.7.1 

