Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4rcR-00017M-SH
 for linux-um@lists.infradead.org; Thu, 20 Feb 2020 19:36:21 +0000
Subject: Re: [PATCH 2/2] um: Delete never executed timer
References: <20200220084014.238768-1-leon@kernel.org>
 <20200220084014.238768-3-leon@kernel.org>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <1b9d7916-92b6-c438-274a-4198e97827b2@cambridgegreys.com>
Date: Thu, 20 Feb 2020 19:36:13 +0000
MIME-Version: 1.0
In-Reply-To: <20200220084014.238768-3-leon@kernel.org>
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
To: Leon Romanovsky <leon@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Leon Romanovsky <leonro@mellanox.com>, linux-um <linux-um@lists.infradead.org>



On 20/02/2020 08:40, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> 
> The "#ifdef undef" construction effectively disabled the timer.
> It causes to the fact that this timer did nothing, so delete it.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>   arch/um/drivers/net_kern.c | 12 ------------
>   1 file changed, 12 deletions(-)
> 
> diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
> index af07733c2dc8..1802cf4ef5a5 100644
> --- a/arch/um/drivers/net_kern.c
> +++ b/arch/um/drivers/net_kern.c
> @@ -274,17 +274,6 @@ static const struct ethtool_ops uml_net_ethtool_ops = {
>   	.get_ts_info	= ethtool_op_get_ts_info,
>   };
> 
> -static void uml_net_user_timer_expire(struct timer_list *t)
> -{
> -#ifdef undef
> -	struct uml_net_private *lp = from_timer(lp, t, tl);
> -	struct connection *conn = &lp->user;
> -
> -	dprintk(KERN_INFO "uml_net_user_timer_expire [%p]\n", conn);
> -	do_connect(conn);
> -#endif
> -}
> -
>   void uml_net_setup_etheraddr(struct net_device *dev, char *str)
>   {
>   	unsigned char *addr = dev->dev_addr;
> @@ -455,7 +444,6 @@ static void eth_configure(int n, void *init, char *mac,
>   		  .add_address 		= transport->user->add_address,
>   		  .delete_address  	= transport->user->delete_address });
> 
> -	timer_setup(&lp->tl, uml_net_user_timer_expire, 0);
>   	spin_lock_init(&lp->lock);
>   	memcpy(lp->mac, dev->dev_addr, sizeof(lp->mac));
> 
> --
> 2.24.1
> 
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

