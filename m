Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfJ1O-007SIz-Og
 for linux-um@lists.infradead.org; Sat, 08 May 2021 09:13:16 +0000
Subject: Re: [PATCH 1/1] um: fix error return code in slip_open()
References: <20210508031354.2127-1-thunder.leizhen@huawei.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <70835fd6-69ba-8bff-65a1-aad83e400a52@cambridgegreys.com>
Date: Sat, 8 May 2021 10:13:02 +0100
MIME-Version: 1.0
In-Reply-To: <20210508031354.2127-1-thunder.leizhen@huawei.com>
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
To: Zhen Lei <thunder.leizhen@huawei.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Andrew Morton <akpm@osdl.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

On 08/05/2021 04:13, Zhen Lei wrote:
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.
> 
> Fixes: a3c77c67a443 ("[PATCH] uml: slirp and slip driver cleanups and fixes")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   arch/um/drivers/slip_user.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/slip_user.c b/arch/um/drivers/slip_user.c
> index 482a19c5105c..7334019c9e60 100644
> --- a/arch/um/drivers/slip_user.c
> +++ b/arch/um/drivers/slip_user.c
> @@ -145,7 +145,8 @@ static int slip_open(void *data)
>   	}
>   	sfd = err;
>   
> -	if (set_up_tty(sfd))
> +	err = set_up_tty(sfd);
> +	if (err)
>   		goto out_close2;
>   
>   	pri->slave = sfd;
> 
Acked-By: anton.ivanov@cambridgegreys.com

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

