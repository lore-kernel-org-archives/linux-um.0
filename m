Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh1Go-0007Cf-Dw
 for linux-um@lists.infradead.org; Tue, 08 Jan 2019 23:58:55 +0000
Received: by mail-vs1-xe44.google.com with SMTP id x28so3625838vsh.12
 for <linux-um@lists.infradead.org>; Tue, 08 Jan 2019 15:58:54 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com.
 [209.85.221.172])
 by smtp.gmail.com with ESMTPSA id e67sm32718753vsd.32.2019.01.08.15.58.51
 for <linux-um@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 15:58:52 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id 197so1293265vkf.4
 for <linux-um@lists.infradead.org>; Tue, 08 Jan 2019 15:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20181226075436.11018-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20181226075436.11018-1-christophe.jaillet@wanadoo.fr>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 8 Jan 2019 15:58:40 -0800
Message-ID: <CAGXu5jKhBmBX90aXi3J57cVAZ2aSrRggzwNpvfnxYufZLoYCeA@mail.gmail.com>
Subject: Re: [PATCH 1/2] um: vector: Fix a potential NULL pointer dereference
 in 'vector_net_open()'
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
> 'create_queue()' returns NULL in case of memory allocation failure. So we
> must check if it succeeds in order to avoid potential NULL pointer
> dereference.
>
> For 'vp->rx_queue', the dereference would occur just one line after the
> failed allocation. For 'vp->tx_queue', it would occur later during normal
> processing.
>
> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/um/drivers/vector_kern.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 046fa9ea0ccc..5b917716289d 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1182,6 +1182,8 @@ static int vector_net_open(struct net_device *dev)
>                         vp->rx_header_size,
>                         MAX_IOV_SIZE
>                 );
> +               if (!vp->rx_queue)
> +                       goto out_close;
>                 vp->rx_queue->queue_depth = get_depth(vp->parsed);
>         } else {
>                 vp->header_rxbuffer = kmalloc(
> @@ -1198,6 +1200,8 @@ static int vector_net_open(struct net_device *dev)
>                         vp->header_size,
>                         MAX_IOV_SIZE
>                 );
> +               if (!vp->tx_queue)
> +                       goto out_close;
>         } else {
>                 vp->header_txbuffer = kmalloc(vp->header_size, GFP_KERNEL);
>                 if (vp->header_txbuffer == NULL)
> --
> 2.19.1
>


-- 
Kees Cook

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

