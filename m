Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kctDg-0007sD-IJ
 for linux-um@lists.infradead.org; Wed, 11 Nov 2020 16:43:41 +0000
Message-ID: <f6678bb73cd5163521eef21a640cad90408b8f6e.camel@sipsolutions.net>
Subject: Re: [PATCH] um: enable the use of optimized xor routines in UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 11 Nov 2020 17:43:34 +0100
In-Reply-To: <20201111150114.23778-1-anton.ivanov@cambridgegreys.com>
References: <20201111150114.23778-1-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at

On Wed, 2020-11-11 at 15:01 +0000, anton.ivanov@cambridgegreys.com
wrote:
> 
> +++ b/arch/um/include/asm/xor.h
> @@ -1,7 +1,22 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm-generic/xor.h>
> +#ifndef _ASM_UM_XOR_H
> +#define _ASM_UM_XOR_H
> +
> +#ifdef CONFIG_64BIT
> +#undef CONFIG_X86_32
> +#else
> +#define CONFIG_X86_32 "Y"
> +#endif

Should that be '1' instead of '"Y"' to match what gets into the kernel's
autoconf.h, i.e. just '#define CONFIG_X86_32 1'?

Probably just used with #ifdef, but still, the string looks odd.

> +++ b/arch/um/kernel/um_arch.c
> @@ -48,9 +48,16 @@ static void __init add_arg(char *arg)
>   */
>  struct cpuinfo_um boot_cpu_data = {
>  	.loops_per_jiffy	= 0,
> -	.ipi_pipe		= { -1, -1 }
> +	.ipi_pipe		= { -1, -1 },
> +	.host_features		= 0

Don't _really_ need to 0-initialize, but also doesn't hurt :)
Might want to add a , at the end to make the next change easier.

> +const char* host_cpu_feature_names[] = {"mmx", "xmm", "avx", "rep_good", "erms"};
> +#define MAX_UM_CPU_FEATURES 5

Why the define rather than ARRAY_SIZE()?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

