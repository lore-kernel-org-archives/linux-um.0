Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh1GQ-0007Ak-Oo
 for linux-um@lists.infradead.org; Tue, 08 Jan 2019 23:58:32 +0000
Received: by mail-vs1-xe44.google.com with SMTP id z3so3653527vsf.7
 for <linux-um@lists.infradead.org>; Tue, 08 Jan 2019 15:58:29 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com.
 [209.85.221.180])
 by smtp.gmail.com with ESMTPSA id r130sm32293094vka.55.2019.01.08.15.58.26
 for <linux-um@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 15:58:26 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id 185so1290756vkc.3
 for <linux-um@lists.infradead.org>; Tue, 08 Jan 2019 15:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20181226075449.11071-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20181226075449.11071-1-christophe.jaillet@wanadoo.fr>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 8 Jan 2019 15:58:14 -0800
Message-ID: <CAGXu5jKogPgKdL9kZEEbaNYL44LQ8o7EupDiwN+DE42JtckkHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] um: vector: Use 'kmalloc_array' instead of 'kmalloc'
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
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: kernel-janitors@vger.kernel.org, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, YueHaibing <yuehaibing@huawei.com>, LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, anton.ivanov@cambridgegreys.com

On Fri, Dec 28, 2018 at 1:57 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Use 'kmalloc_array' instead of 'kmalloc' when appropriate.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

Richard, can you take these?

> ---
> I don't know why it has not already been replaced in 6da2ec56059c
> ("treewide: kmalloc() -> kmalloc_array()".

Hm, not sure. I'd guess it was from the ()s and some Coccinelle rule
missing handling that. I thought I caught them all. :P

> ---
>  arch/um/drivers/vector_kern.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 5b917716289d..dee5246bda81 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -507,12 +507,12 @@ static struct vector_queue *create_queue(
>                 return NULL;
>         result->max_depth = max_size;
>         result->dev = vp->dev;
> -       result->mmsg_vector = kmalloc(
> -               (sizeof(struct mmsghdr) * max_size), GFP_KERNEL);
> +       result->mmsg_vector = kmalloc_array(max_size, sizeof(struct mmsghdr),
> +                                           GFP_KERNEL);
>         if (result->mmsg_vector == NULL)
>                 goto out_mmsg_fail;
> -       result->skbuff_vector = kmalloc(
> -               (sizeof(void *) * max_size), GFP_KERNEL);
> +       result->skbuff_vector = kmalloc_array(max_size, sizeof(void *),
> +                                             GFP_KERNEL);
>         if (result->skbuff_vector == NULL)
>                 goto out_skb_fail;
>
> --
> 2.19.1
>


-- 
Kees Cook

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

