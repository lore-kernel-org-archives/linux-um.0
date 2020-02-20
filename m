Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4rbT-00012V-U8
 for linux-um@lists.infradead.org; Thu, 20 Feb 2020 19:35:21 +0000
Subject: Re: [PATCH 0/2] Remove dead code and driver version
References: <20200220084014.238768-1-leon@kernel.org>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <c26c2741-fdb5-a492-2b7b-8973650f15e8@cambridgegreys.com>
Date: Thu, 20 Feb 2020 19:35:09 +0000
MIME-Version: 1.0
In-Reply-To: <20200220084014.238768-1-leon@kernel.org>
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
> Hi,
> 
> This short series is an outcome of the change in ethtool [1] to provide
> proper driver version that will work reliably. The second patch is
> removal of useless timer setup.
> 
> Code is compile tested only.
> 
> [1] https://lore.kernel.org/linux-rdma/20200127072028.19123-1-leon@kernel.org/
> 
> Leon Romanovsky (2):
>    um: Don't overwrite ethtool driver version
>    um: Delete never executed timer
> 
>   arch/um/drivers/net_kern.c    | 13 -------------
>   arch/um/drivers/vector_kern.c |  2 --
>   2 files changed, 15 deletions(-)
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

