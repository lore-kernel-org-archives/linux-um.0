Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfJ1t-007SKN-2e
 for linux-um@lists.infradead.org; Sat, 08 May 2021 09:13:46 +0000
Subject: Re: [PATCH 1/1] um: fix error return code in winch_tramp()
References: <20210508032239.2177-1-thunder.leizhen@huawei.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <01f2ebc7-effd-19f1-53cf-648cf81f811b@cambridgegreys.com>
Date: Sat, 8 May 2021 10:13:41 +0100
MIME-Version: 1.0
In-Reply-To: <20210508032239.2177-1-thunder.leizhen@huawei.com>
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
To: Zhen Lei <thunder.leizhen@huawei.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Andrew Morton <akpm@linux-foundation.org>, Eduard-Gabriel Munteanu <maxdamage@aladin.ro>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

On 08/05/2021 04:22, Zhen Lei wrote:
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.
> 
> Fixes: 89df6bfc0405 ("uml: DEBUG_SHIRQ fixes")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   arch/um/drivers/chan_user.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
> index d8845d4aac6a..6040817c036f 100644
> --- a/arch/um/drivers/chan_user.c
> +++ b/arch/um/drivers/chan_user.c
> @@ -256,7 +256,8 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
>   		goto out_close;
>   	}
>   
> -	if (os_set_fd_block(*fd_out, 0)) {
> +	err = os_set_fd_block(*fd_out, 0);
> +	if (err) {
>   		printk(UM_KERN_ERR "winch_tramp: failed to set thread_fd "
>   		       "non-blocking.\n");
>   		goto out_close;
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

