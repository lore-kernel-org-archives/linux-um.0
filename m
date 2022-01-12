Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7aTo-001wah-W0
 for linux-um@lists.infradead.org; Wed, 12 Jan 2022 10:03:48 +0000
Subject: Re: [PATCH] um: fix and optimize xor select template for CONFIG64 and
 timetravel mode
References: <20220111200507.1445489-1-benjamin.beichler@uni-rostock.de>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <1b6de9af-905c-1416-1fd3-f22748befa60@cambridgegreys.com>
Date: Wed, 12 Jan 2022 10:03:28 +0000
MIME-Version: 1.0
In-Reply-To: <20220111200507.1445489-1-benjamin.beichler@uni-rostock.de>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: johannes.berg@intel.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org



On 11/01/2022 20:05, Benjamin Beichler wrote:
> Due to dropped inclusion of asm-generic/xor.h, xor_block_8regs symbol is
> missing with CONFIG64 and break compilation, as the asm/xor_64.h also did
> not include it. The patch recreate the logic from arch/x86, which check
> whether AVX is available and add fallbacks for 32bit and 64bit config of
> um.
> 
> A very minor additional "fix" is, the return of the macro parameter
> instead of NULL, as this is the original intent of the macro, but
> this does not change the actual behavior.
> 
> Fixes: c0ecca6604b8 ("um: enable the use of optimized xor routines in UML")
> Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
> ---
>   arch/um/include/asm/xor.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
> index f512704a9ec7..22b39de73c24 100644
> --- a/arch/um/include/asm/xor.h
> +++ b/arch/um/include/asm/xor.h
> @@ -4,8 +4,10 @@
>   
>   #ifdef CONFIG_64BIT
>   #undef CONFIG_X86_32
> +#define TT_CPU_INF_XOR_DEFAULT (AVX_SELECT(&xor_block_sse_pf64))
>   #else
>   #define CONFIG_X86_32 1
> +#define TT_CPU_INF_XOR_DEFAULT (AVX_SELECT(&xor_block_8regs))
>   #endif
>   
>   #include <asm/cpufeature.h>
> @@ -16,7 +18,7 @@
>   #undef XOR_SELECT_TEMPLATE
>   /* pick an arbitrary one - measuring isn't possible with inf-cpu */
>   #define XOR_SELECT_TEMPLATE(x)	\
> -	(time_travel_mode == TT_MODE_INFCPU ? &xor_block_8regs : NULL)
> +	(time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x))
>   #endif
>   
>   #endif
> 
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

