Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaErp-0004zO-Vf
 for linux-um@lists.infradead.org; Thu, 28 Nov 2019 08:09:39 +0000
Date: Thu, 28 Nov 2019 11:06:41 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH -next] um: vector: use GFP_ATOMIC under spin lock
Message-ID: <20191128080641.GD1781@kadam>
References: <20191128020147.191893-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191128020147.191893-1-weiyongjun1@huawei.com>
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
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, kernel-janitors@vger.kernel.org, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Thu, Nov 28, 2019 at 02:01:47AM +0000, Wei Yongjun wrote:
> A spin lock is taken here so we should use GFP_ATOMIC.
> 
> Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  arch/um/drivers/vector_kern.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 92617e16829e..6ff0065a271d 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1402,7 +1402,7 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
>  		kfree(vp->bpf->filter);
>  		vp->bpf->filter = NULL;
>  	} else {
> -		vp->bpf = kmalloc(sizeof(struct sock_fprog), GFP_KERNEL);
> +		vp->bpf = kmalloc(sizeof(struct sock_fprog), GFP_ATOMIC);
>  		if (vp->bpf == NULL) {
>  			netdev_err(dev, "failed to allocate memory for firmware\n");
>  			goto flash_fail;
> @@ -1414,7 +1414,7 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
>  	if (request_firmware(&fw, efl->data, &vdevice->pdev.dev))
            ^^^^^^^^^^^^^^^^

Is it really possible to call request_firmware() while holding a
spin_lock?  I was so sure that read from the disk.

regards,
dan carpenter

>  		goto flash_fail;
>  
> -	vp->bpf->filter = kmemdup(fw->data, fw->size, GFP_KERNEL);
> +	vp->bpf->filter = kmemdup(fw->data, fw->size, GFP_ATOMIC);
>  	if (!vp->bpf->filter)
>  		goto free_buffer;
> 
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

