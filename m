Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZMQy-0007vj-OO
 for linux-um@lists.infradead.org; Mon, 25 Nov 2019 22:02:18 +0000
Received: by mail-wm1-x344.google.com with SMTP id l17so1013130wmh.0
 for <linux-um@lists.infradead.org>; Mon, 25 Nov 2019 14:02:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com>
 <3ed3c306fc51b0073fcf3a222f7314fcaf50ccf4.1573179553.git.thehajime@gmail.com>
In-Reply-To: <3ed3c306fc51b0073fcf3a222f7314fcaf50ccf4.1573179553.git.thehajime@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 25 Nov 2019 23:02:04 +0100
Message-ID: <CAFLxGvzXv7pHaY8i_RBs2BL5qHLMQJO97MWGF5cnh34kmeGZJg@mail.gmail.com>
Subject: Re: [RFC v2 01/37] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: Octavian Purdila <tavi.purdila@gmail.com>, linux-kernel-library@freelists.org, Akira Moroo <retrage01@gmail.com>, linux-um@lists.infradead.org, Linux-Arch <linux-arch@vger.kernel.org>

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> With CONFIG_64BIT enabled, atomic64 via CONFIG_GENERIC_ATOMIC64 options
> are not compiled due to type conflict of atomic64_t defined in
> linux/type.h.
>
> This commit fixes the issue and allow using generic atomic64 ops.

Hmm, why is this specific to LKL?
This need a review from core developers.

> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
> ---
>  include/asm-generic/atomic64.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
> index 370f01d4450f..9b15847baae5 100644
> --- a/include/asm-generic/atomic64.h
> +++ b/include/asm-generic/atomic64.h
> @@ -9,9 +9,11 @@
>  #define _ASM_GENERIC_ATOMIC64_H
>  #include <linux/types.h>
>
> +#ifndef CONFIG_64BIT
>  typedef struct {
>         s64 counter;
>  } atomic64_t;
> +#endif
>
>  #define ATOMIC64_INIT(i)       { (i) }
>
> --
> 2.20.1 (Apple Git-117)
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um



-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

