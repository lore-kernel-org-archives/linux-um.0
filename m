Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdALl-0001An-Vh
 for linux-um@lists.infradead.org; Thu, 12 Nov 2020 11:01:12 +0000
Message-ID: <ad8a0e21d0785978f23ef42e4491c942f3a4e75f.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: enable the use of optimized xor routines in UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 12 Nov 2020 12:00:57 +0100
In-Reply-To: <20201112103337.4862-1-anton.ivanov@cambridgegreys.com>
References: <20201112103337.4862-1-anton.ivanov@cambridgegreys.com>
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

On Thu, 2020-11-12 at 10:33 +0000, anton.ivanov@cambridgegreys.com
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

I thought you said it was some leftover? :)

> +	for (index = 0; index < MAX_UM_CPU_FEATURES; index++) {
> +		if (boot_cpu_data.host_features & (1 << index))
> +			seq_printf(m, " %s", host_cpu_feature_names[index]);

Confused. Now I don't see MAX_UM_CPU_FEATURES or
host_cpu_feature_names[] anywhere now?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

