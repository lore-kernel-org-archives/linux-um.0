Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdZRQ-0006di-Uh
 for linux-um@lists.infradead.org; Fri, 13 Nov 2020 13:48:42 +0000
Subject: Re: [PATCH] um: "borrow" cmpxchg from x86 tree in UML
References: <20201113115437.14325-1-anton.ivanov@cambridgegreys.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <e22c7628-29a7-6dea-1707-948f89334a79@cambridgegreys.com>
Date: Fri, 13 Nov 2020 13:48:36 +0000
MIME-Version: 1.0
In-Reply-To: <20201113115437.14325-1-anton.ivanov@cambridgegreys.com>
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
To: linux-um@lists.infradead.org
Cc: richard@nod.at


On 13/11/2020 11:54, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>
> UML was falling back to asm-generic cmpxchg which emulates atomic
> behaviour by turning irqs on/off. On UML this means turning
> on/off signals for each cmpxchg which is expensive.
>
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>   arch/um/include/asm/cmpxchg-x86.h |  1 +
>   arch/um/include/asm/cmpxchg.h     | 13 +++++++++++++
>   arch/um/include/asm/cmpxchg_32.h  |  1 +
>   arch/um/include/asm/cmpxchg_64.h  |  1 +
>   4 files changed, 16 insertions(+)
>   create mode 120000 arch/um/include/asm/cmpxchg-x86.h
>   create mode 100644 arch/um/include/asm/cmpxchg.h
>   create mode 120000 arch/um/include/asm/cmpxchg_32.h
>   create mode 120000 arch/um/include/asm/cmpxchg_64.h
>
> diff --git a/arch/um/include/asm/cmpxchg-x86.h b/arch/um/include/asm/cmpxchg-x86.h
> new file mode 120000
> index 000000000000..a5c607edde88
> --- /dev/null
> +++ b/arch/um/include/asm/cmpxchg-x86.h
> @@ -0,0 +1 @@
> +../../../x86/include/asm/cmpxchg.h
> \ No newline at end of file
> diff --git a/arch/um/include/asm/cmpxchg.h b/arch/um/include/asm/cmpxchg.h
> new file mode 100644
> index 000000000000..c9367b37d925
> --- /dev/null
> +++ b/arch/um/include/asm/cmpxchg.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_UM_CMPXCHG_H
> +#define _ASM_UM_CMPXCHG_H
> +
> +#ifdef CONFIG_64BIT
> +#undef CONFIG_X86_32
> +#else
> +#define CONFIG_X86_32 1
> +#endif
> +
> +#include <asm/cmpxchg-x86.h>
> +
> +#endif
> diff --git a/arch/um/include/asm/cmpxchg_32.h b/arch/um/include/asm/cmpxchg_32.h
> new file mode 120000
> index 000000000000..1f360d0a9fa9
> --- /dev/null
> +++ b/arch/um/include/asm/cmpxchg_32.h
> @@ -0,0 +1 @@
> +../../../x86/include/asm/cmpxchg_32.h
> \ No newline at end of file
> diff --git a/arch/um/include/asm/cmpxchg_64.h b/arch/um/include/asm/cmpxchg_64.h
> new file mode 120000
> index 000000000000..bc09ae22b0cb
> --- /dev/null
> +++ b/arch/um/include/asm/cmpxchg_64.h
> @@ -0,0 +1 @@
> +../../../x86/include/asm/cmpxchg_64.h
> \ No newline at end of file

I think that was it. Or to be more exact, I hope that was it.

I went a few times through asm-generic and that looks like all the bits which are worth implementing for a uniprocessor architecture as a replacement for their generic equivalents.

So to recap:

string.h
xor.h
futex.h
cmpxchg.h
atomic.h

Brgds,

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

