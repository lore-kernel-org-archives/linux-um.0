Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKMvu-0003jg-I3
 for linux-um@lists.infradead.org; Mon, 21 Sep 2020 14:36:48 +0000
Subject: Re: [PATCH] um: vector: Use GFP_ATOMIC under spin lock
References: <1592544007-2751-1-git-send-email-yangtiezhu@loongson.cn>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <04be37fc-c8cb-f506-20a5-97467b638069@cambridgegreys.com>
Date: Mon, 21 Sep 2020 15:36:38 +0100
MIME-Version: 1.0
In-Reply-To: <1592544007-2751-1-git-send-email-yangtiezhu@loongson.cn>
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
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Xuefeng Li <lixuefeng@loongson.cn>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org



On 19/06/2020 06:20, Tiezhu Yang wrote:
> Use GFP_ATOMIC instead of GFP_KERNEL under spin lock to fix possible
> sleep-in-atomic-context bugs.
> 
> Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/um/drivers/vector_kern.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 8735c46..555203e 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1403,7 +1403,7 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
>   		kfree(vp->bpf->filter);
>   		vp->bpf->filter = NULL;
>   	} else {
> -		vp->bpf = kmalloc(sizeof(struct sock_fprog), GFP_KERNEL);
> +		vp->bpf = kmalloc(sizeof(struct sock_fprog), GFP_ATOMIC);
>   		if (vp->bpf == NULL) {
>   			netdev_err(dev, "failed to allocate memory for firmware\n");
>   			goto flash_fail;
> @@ -1415,7 +1415,7 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
>   	if (request_firmware(&fw, efl->data, &vdevice->pdev.dev))
>   		goto flash_fail;
>   
> -	vp->bpf->filter = kmemdup(fw->data, fw->size, GFP_KERNEL);
> +	vp->bpf->filter = kmemdup(fw->data, fw->size, GFP_ATOMIC);
>   	if (!vp->bpf->filter)
>   		goto free_buffer;
>   
> 
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

