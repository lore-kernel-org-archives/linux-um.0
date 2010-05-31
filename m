Return-Path: <toralf.foerster@gmx.de>
From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: Re: [PATCH] x86, hweight: Fix UML boot crash
Date: Mon, 31 May 2010 15:55:53 +0200
References: <201005271944.09541.toralf.foerster@gmx.de> <20100530193956.GA2498@liondog.tnic> <20100530201738.GB2498@liondog.tnic>
In-Reply-To: <20100530201738.GB2498@liondog.tnic>
MIME-Version: 1.0
Content-Type: Text/Plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <201005311555.56791.toralf.foerster@gmx.de>
To: Borislav Petkov <bp@alien8.de>, Borislav Petkov <borislav.petkov@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


Borislav Petkov wrote at 22:17:38
> LKML-Reference: <201005271944.09541.toralf.foerster@gmx.de>
> Signed-off-by: Borislav Petkov <bp@alien8.de>
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
> 
This patch does not to solve the reported issue by me.

-- 
MfG/Sincerely
Toralf Förster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3


