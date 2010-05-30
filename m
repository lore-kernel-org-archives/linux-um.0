Return-Path: <toralf.foerster@gmx.de>
From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: Re: current git kernel crashes UML system during boot
Date: Sun, 30 May 2010 17:28:25 +0200
References: <201005271944.09541.toralf.foerster@gmx.de> <AANLkTimKwxYxM_PExplIDK1WPTQ9e_-CHn5SnIvfjfUg@mail.gmail.com> <20100530150214.GA1565@liondog.tnic>
In-Reply-To: <20100530150214.GA1565@liondog.tnic>
MIME-Version: 1.0
Content-Type: Text/Plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <201005301728.25976.toralf.foerster@gmx.de>
To: Borislav Petkov <bp@alien8.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Borislav Petkov <borislav.petkov@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


Borislav Petkov wrote at 17:02:14
> Can you guys check whether the following fixes the issue?
> 
> Thanks.
> 
> --
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index 545776e..c9dad12 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -444,7 +444,11 @@ static inline int fls(int x)
>  
>  #define ARCH_HAS_FAST_MULTIPLIER 1
>  
> +#ifdef CONFIG_UML
> +#include <asm-generic/bitops/arch_hweight.h>
> +#else
>  #include <asm/arch_hweight.h>
> +#endif
>  
>  #include <asm-generic/bitops/const_hweight.h>
>  
> 
> 
solved reported issue.
Thx

-- 
MfG/Sincerely
Toralf Förster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3


