Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knokP-00013h-Jv
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 20:10:38 +0000
Message-ID: <e273fd64b50edfab011ee1c773ed77f54da46075.camel@sipsolutions.net>
Subject: Re: [PATCH v4 4/7] um: add a UML specific futex implementation
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 11 Dec 2020 21:10:26 +0100
In-Reply-To: <20201211174559.26010-5-anton.ivanov@cambridgegreys.com>
References: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
 <20201211174559.26010-5-anton.ivanov@cambridgegreys.com>
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

On Fri, 2020-12-11 at 17:45 +0000, anton.ivanov@cambridgegreys.com
wrote:
> 
> +++ b/arch/um/include/asm/futex.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_FUTEX_H
> +#define _ASM_GENERIC_FUTEX_H
> +
> +#include <linux/futex.h>
> +#include <linux/uaccess.h>
> +#include <asm/errno.h>
> +
> +
> +extern int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr);
> +extern int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> +			      u32 oldval, u32 newval);

"extern" for functions in header files is kinda pointless, and usually
not used.

(indentation also seems off a bit)

> +/**
> + * arch_futex_atomic_op_inuser() - Atomic arithmetic operation with constant
> + *			  argument and comparison of the previous
> + *			  futex value with another constant.

Is there much value in (copying?) the documentation? It wouldn't get
included anywhere, I'd think.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

