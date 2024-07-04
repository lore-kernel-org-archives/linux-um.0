Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE288C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 07:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lLij6tPeWFMJQc93/6NJr+Bbfsst3M7+ZaeRvPCF5UI=; b=hmU1l8S3zEAcs8qWbwzT2/yLVG
	WKp4HzYXGmOnv1Mpl0XLd6OOsRHOSolAOFwexFTqrBK6aZheI4J59GpDPuJp1YBspEG4cx9dZA6IA
	hUgfFD/IcRIklf4fSCweW2DrGVaFbB+AYPJv+xKW3yLu9eU5k0dlC/X7DFPWz8K5WVVhebLCgsWi2
	4afWjv4pgAcaVStbL6mWYg0z1mDifrQ2uxuYeaQHZetBWJ0OzAszQly6+LOdSTqgTJ3jMTNHo9sx8
	cvoiJm36rTiWFm5gehKGjXuGJU65QhfCj8X87Of3ZEUoTo0FblogCLWcOJ7i58D3yUkaI3YYTwJbH
	yb2bkj1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGRo-0000000CP0x-0i2u;
	Thu, 04 Jul 2024 07:00:04 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGRj-0000000COzr-2OVH
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 07:00:02 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPGRh-005c6r-SH; Thu, 04 Jul 2024 06:59:57 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPGRf-0079I9-0b;
	Thu, 04 Jul 2024 07:59:57 +0100
Message-ID: <f3da3a3e-d515-4d29-a1b6-7913a51f5e52@kot-begemot.co.uk>
Date: Thu, 4 Jul 2024 07:59:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] um: vector: remove vp->lock
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20240703184606.19aa35b14959.I9cf5f2c4e35abd06cc89bf2e990fa755eb8e5f0f@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20240703184606.19aa35b14959.I9cf5f2c4e35abd06cc89bf2e990fa755eb8e5f0f@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_235959_648022_61A80FCB 
X-CRM114-Status: GOOD (  16.77  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 03/07/2024 17:46, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This lock is useless, all the places that are using
> it for some locking will already hold the RTNL. Just
> remove it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v2: remove unused flags variables
> ---
>   arch/um/drivers/vector_kern.c | 16 +---------------
>   arch/um/drivers/vector_kern.h |  1 -
>   2 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 4279793b11b7..0861e32d2fbd 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1115,7 +1115,6 @@ static int irq_rr;
>   static int vector_net_close(struct net_device *dev)
>   {
>   	struct vector_private *vp = netdev_priv(dev);
> -	unsigned long flags;
>   
>   	netif_stop_queue(dev);
>   	del_timer(&vp->tl);
> @@ -1158,10 +1157,8 @@ static int vector_net_close(struct net_device *dev)
>   		destroy_queue(vp->tx_queue);
>   	kfree(vp->fds);
>   	vp->fds = NULL;
> -	spin_lock_irqsave(&vp->lock, flags);
>   	vp->opened = false;
>   	vp->in_error = false;
> -	spin_unlock_irqrestore(&vp->lock, flags);
>   	return 0;
>   }
>   
> @@ -1203,17 +1200,12 @@ static void vector_reset_tx(struct work_struct *work)
>   static int vector_net_open(struct net_device *dev)
>   {
>   	struct vector_private *vp = netdev_priv(dev);
> -	unsigned long flags;
>   	int err = -EINVAL;
>   	struct vector_device *vdevice;
>   
> -	spin_lock_irqsave(&vp->lock, flags);
> -	if (vp->opened) {
> -		spin_unlock_irqrestore(&vp->lock, flags);
> +	if (vp->opened)
>   		return -ENXIO;
> -	}
>   	vp->opened = true;
> -	spin_unlock_irqrestore(&vp->lock, flags);
>   
>   	vp->bpf = uml_vector_user_bpf(get_bpf_file(vp->parsed));
>   
> @@ -1387,8 +1379,6 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
>   		return -1;
>   	}
>   
> -	spin_lock(&vp->lock);
> -
>   	if (vp->bpf != NULL) {
>   		if (vp->opened)
>   			uml_vector_detach_bpf(vp->fds->rx_fd, vp->bpf);
> @@ -1417,15 +1407,12 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
>   	if (vp->opened)
>   		result = uml_vector_attach_bpf(vp->fds->rx_fd, vp->bpf);
>   
> -	spin_unlock(&vp->lock);
> -
>   	return result;
>   
>   free_buffer:
>   	release_firmware(fw);
>   
>   flash_fail:
> -	spin_unlock(&vp->lock);
>   	if (vp->bpf != NULL)
>   		kfree(vp->bpf->filter);
>   	kfree(vp->bpf);
> @@ -1631,7 +1618,6 @@ static void vector_eth_configure(
>   	INIT_WORK(&vp->reset_tx, vector_reset_tx);
>   
>   	timer_setup(&vp->tl, vector_timer_expire, 0);
> -	spin_lock_init(&vp->lock);
>   
>   	/* FIXME */
>   	dev->netdev_ops = &vector_netdev_ops;
> diff --git a/arch/um/drivers/vector_kern.h b/arch/um/drivers/vector_kern.h
> index 2a1fa8e0f3e1..806df551be0b 100644
> --- a/arch/um/drivers/vector_kern.h
> +++ b/arch/um/drivers/vector_kern.h
> @@ -71,7 +71,6 @@ struct vector_estats {
>   
>   struct vector_private {
>   	struct list_head list;
> -	spinlock_t lock;
>   	struct net_device *dev;
>   	struct napi_struct		napi	____cacheline_aligned;
>   

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

