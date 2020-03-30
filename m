Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJ209-0002p8-FJ
 for linux-um@lists.infradead.org; Mon, 30 Mar 2020 21:31:22 +0000
Message-ID: <b2a730a4bcafb13cb1b29a637f8f8449cf3521d6.camel@sipsolutions.net>
Subject: Re: [RFC v4 23/25] um lkl: add UML network driver for lkl
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 30 Mar 2020 23:31:15 +0200
In-Reply-To: <0f087b36ad579eeb8062b12e9e61566d9b5b18ac.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
 <0f087b36ad579eeb8062b12e9e61566d9b5b18ac.1585579244.git.thehajime@gmail.com>
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
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, linux-kernel-library@freelists.org, Akira Moroo <retrage01@gmail.com>, linux-arch@vger.kernel.org


> +++ b/arch/um/lkl/include/asm/irq.h
> @@ -2,6 +2,9 @@
>  #ifndef _ASM_LKL_IRQ_H
>  #define _ASM_LKL_IRQ_H
>  
> +/* pull UML's definitions */
> +#include "../../../include/asm/irq.h"

This is _really_ ugly.

> +#if defined(__linux) && (defined(__i386) || defined(__x86_64))
> +#include <os.h>
> +#endif
> +void *um_os_signal(int signum, void *handler);

and arguably those random declarations you're sprinkling are worse.

> @@ -181,6 +196,11 @@ void init_IRQ(void)
>  	for (i = 0; i < NR_IRQS; i++)
>  		irq_set_chip_and_handler(i, &dummy_irq_chip, handle_simple_irq);
>  
> +#if defined(__linux) && (defined(__i386) || defined(__x86_64))

What's with all those ifdefs with this condition?

> +++ b/tools/lkl/lib/um/um_glue.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +
> +
> +
> +char lkl_um_devs[4096];
> +
> +/* from sigio.c */
> +void maybe_sigio_broken(int fd, int read)
> +{
> +}
> +
> +/* from process.c */
> +int os_getpid(void)
> +{
> +	return getpid();
> +}

All of this really is quite ugly - are you sure it's needed for just the
vector network driver??

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

