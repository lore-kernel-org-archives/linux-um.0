Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAC4C47DD9
	for <linux-um@archiver.kernel.org>; Sun, 25 Feb 2024 08:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EOMCrVzOmp4RbossCfe+/kCrx/xWG8OsrWuMVOuxeWU=; b=jKVp9CDb353rSCSliVK+njijxl
	mFV4jzmALo0Ert6xOEbHXjrwxZe5XM5gsXsXS1CrADtZUlZ1Dxk2yH58ii8lzlX7dTsEtBiixLQwU
	GPk047IzlTefPQwvkE6ZYjZdl/c/3gjHUzisL00afGFea6KDxp8RGSXFG0fRbUH0cEHWoq1VkERBV
	K5n7ShFGb2S1eQB0cWzYj+C0b/xlGE55/rA/uVUGoOVyC7tveaypEkhUc/vlyDrp9+PIupkZIbLuY
	ReR5bhm78m2+qnvsFtnpPdiksAiXNxBP6EYhNcFE9h/7Ii08q1y5PDiyoOLXkOUaWmIKgHEBrldPb
	StgG7EWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reA2N-0000000EgTi-48tT;
	Sun, 25 Feb 2024 08:39:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reA2K-0000000EgS9-1ujt
	for linux-um@lists.infradead.org;
	Sun, 25 Feb 2024 08:39:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708850339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EOMCrVzOmp4RbossCfe+/kCrx/xWG8OsrWuMVOuxeWU=;
	b=Xvm7M8e+iE8wPXMGigFEuyaI28x5+eQugKjm5cMKp/OjimHF793j76tQuLF/KqDyNrtGus
	SJa7SRcx2waWRdGrI0cNOUlMOGIsnC/tO+nkBki0VCeKk56TwgoHrvuqJaPolV8eXEZLyW
	24ZWF0f+d7AtxuFX7YHNuJXyyT4oJBg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-5RgFRiLwNFy5o9dkGyMMLw-1; Sun, 25 Feb 2024 03:38:57 -0500
X-MC-Unique: 5RgFRiLwNFy5o9dkGyMMLw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d39bc6bf4so1193100f8f.0
        for <linux-um@lists.infradead.org>; Sun, 25 Feb 2024 00:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708850336; x=1709455136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOMCrVzOmp4RbossCfe+/kCrx/xWG8OsrWuMVOuxeWU=;
        b=wd3SkWHBiC3T4opLONX/CJa0sY7P24zgBoLzQjUz7GyWvcuvmeU9bEB8p7QEwkQ+BG
         Iwgt7MAp5xOeT0V3u/gzQjZwGlrU6I0FiQT+EVEsSwPruW6aFDRs4KfHiLZxrxIOzxH1
         yuX7JXE8hMSw4Ykxyp/xihrIBp1ikp/rkbSmaXRiYfLGwfuHwBaSOiUEZnK5He5ttqLz
         qOJLsG1kqlfXd5AJLX1u1Q0FeEJY2rQcNmEojQCfY2pCvy0E4oKV711Z1PvkrAi8jOTB
         xg+SHl3F4j0Gfsd5DsHAtywNmJxJMIZYOkWdyV1WFh6XGIh5JDT2iSp3PsBQqWJrEvyB
         cjdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcU2GvxqdsPN9LsH+mj0MEnaagfZc047OFWaBBSi8Kche2IzGvB0G2yG/Q5t37MWsqQS+n+tTMPOI7tedClQfJDAP9urhZtlWGD806
X-Gm-Message-State: AOJu0Yyubzo8Ioa1PmIOc23AzWGK+tw4Z8rIuWiNq1Zb+uJi9R8LdMxB
	Tzh6gT1UF4ZKUPKv7pYIIg+BDvnqtuvZuMqC7IlPeBH/08KpW1KIouf76O1r4BC4LJ4tnvkEszF
	F3PCyvY9Q04W3ftW/oXaLDrU0iikKcJsXtD0+X5JkOEk4NtdnkdY1a//5nQDXiQ==
X-Received: by 2002:adf:e9cb:0:b0:33d:9d49:cfd1 with SMTP id l11-20020adfe9cb000000b0033d9d49cfd1mr3666336wrn.34.1708850336193;
        Sun, 25 Feb 2024 00:38:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhK28+oXcoeTRfiKdRQ9r84bfxBvSjdNy60lSOACL0i+/V47ase4Z2bcj3vqDRsDCm11uahQ==
X-Received: by 2002:adf:e9cb:0:b0:33d:9d49:cfd1 with SMTP id l11-20020adfe9cb000000b0033d9d49cfd1mr3666304wrn.34.1708850335736;
        Sun, 25 Feb 2024 00:38:55 -0800 (PST)
Received: from redhat.com ([2.52.10.44])
        by smtp.gmail.com with ESMTPSA id bv20-20020a0560001f1400b0033d73e1505bsm4513271wrb.18.2024.02.25.00.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 00:38:54 -0800 (PST)
Date: Sun, 25 Feb 2024 03:38:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH vhost v2 19/19] virtio_net: sq support premapped mode
Message-ID: <20240225032330-mutt-send-email-mst@kernel.org>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
 <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240225_003904_613359_8066F951 
X-CRM114-Status: GOOD (  30.84  )
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

On Fri, Feb 23, 2024 at 04:27:26PM +0800, Xuan Zhuo wrote:
> If the xsk is enabling, the xsk tx will share the send queue.
> But the xsk requires that the send queue use the premapped mode.
> So the send queue must support premapped mode.
> 
> cmd:
>     sh samples/pktgen/pktgen_sample01_simple.sh -i eth0 \
>         -s 16 -d 10.0.0.128 -m 00:16:3e:2c:c8:2e -n 0 -p 100
> CPU:
>     Intel(R) Xeon(R) Platinum 8369B CPU @ 2.70GHz
> 
> Machine:
>     ecs.g7.2xlarge(Aliyun)
> 
> before:              1600010.00
> after(no-premapped): 1599966.00
> after(premapped):    1600014.00
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 136 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 132 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7715bb7032ec..b83ef6afc4fb 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -146,6 +146,25 @@ struct virtnet_rq_dma {
>  	u16 need_sync;
>  };
>  
> +struct virtnet_sq_dma {
> +	union {
> +		struct virtnet_sq_dma *next;
> +		void *data;
> +	};
> +
> +	u32 num;
> +
> +	dma_addr_t addr[MAX_SKB_FRAGS + 2];
> +	u32 len[MAX_SKB_FRAGS + 2];
> +};
> +
> +struct virtnet_sq_dma_head {
> +	/* record for kfree */
> +	void *p;
> +
> +	struct virtnet_sq_dma *free;
> +};
> +
>  /* Internal representation of a send virtqueue */
>  struct send_queue {
>  	/* Virtqueue associated with this send _queue */
> @@ -165,6 +184,8 @@ struct send_queue {
>  
>  	/* Record whether sq is in reset state. */
>  	bool reset;
> +
> +	struct virtnet_sq_dma_head dmainfo;
>  };
>  
>  /* Internal representation of a receive virtqueue */
> @@ -368,6 +389,95 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>  	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
>  }
>  
> +static struct virtnet_sq_dma *virtnet_sq_unmap(struct send_queue *sq, void **data)
> +{
> +	struct virtnet_sq_dma *d;
> +	int i;
> +
> +	d = *data;
> +	*data = d->data;
> +
> +	for (i = 0; i < d->num; ++i)
> +		virtqueue_dma_unmap_page_attrs(sq->vq, d->addr[i], d->len[i],
> +					       DMA_TO_DEVICE, 0);
> +
> +	d->next = sq->dmainfo.free;
> +	sq->dmainfo.free = d;
> +
> +	return d;
> +}
> +
> +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *sq,
> +						int nents, void *data)
> +{
> +	struct virtnet_sq_dma *d;
> +	struct scatterlist *sg;
> +	int i;
> +
> +	if (!sq->dmainfo.free)
> +		return NULL;
> +
> +	d = sq->dmainfo.free;
> +	sq->dmainfo.free = d->next;
> +
> +	for_each_sg(sq->sg, sg, nents, i) {
> +		if (virtqueue_dma_map_sg_attrs(sq->vq, sg, DMA_TO_DEVICE, 0))
> +			goto err;
> +
> +		d->addr[i] = sg->dma_address;
> +		d->len[i] = sg->length;
> +	}
> +
> +	d->data = data;
> +	d->num = i;
> +	return d;
> +
> +err:
> +	d->num = i;
> +	virtnet_sq_unmap(sq, (void **)&d);
> +	return NULL;
> +}


Do I see a reimplementation of linux/llist.h here?


> +
> +static int virtnet_add_outbuf(struct send_queue *sq, u32 num, void *data)
> +{
> +	int ret;
> +
> +	if (sq->vq->premapped) {
> +		data = virtnet_sq_map_sg(sq, num, data);
> +		if (!data)
> +			return -ENOMEM;
> +	}
> +
> +	ret = virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMIC);
> +	if (ret && sq->vq->premapped)
> +		virtnet_sq_unmap(sq, &data);
> +
> +	return ret;
> +}
> +
> +static int virtnet_sq_init_dma_mate(struct send_queue *sq)

Mate? The popular south african drink?

> +{
> +	struct virtnet_sq_dma *d;
> +	int num, i;
> +
> +	num = virtqueue_get_vring_size(sq->vq);
> +
> +	sq->dmainfo.free = kcalloc(num, sizeof(*sq->dmainfo.free), GFP_KERNEL);
> +	if (!sq->dmainfo.free)
> +		return -ENOMEM;


This could be quite a bit of memory for a large queue.  And for a bunch
of common cases where unmap is a nop (e.g. iommu pt) this does nothing
useful at all.  And also, this does nothing useful if PLATFORM_ACCESS is off
which is super common.

A while ago I proposed:
- extend DMA APIs so one can query whether unmap is a nop
  and whether sync is a nop
- virtio wrapper taking into account PLATFORM_ACCESS too

then we can save all this work and memory when not needed.



> +
> +	sq->dmainfo.p = sq->dmainfo.free;
> +
> +	for (i = 0; i < num; ++i) {
> +		d = &sq->dmainfo.free[i];
> +		d->next = d + 1;
> +	}
> +
> +	d->next = NULL;
> +
> +	return 0;
> +}
> +
>  static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>  			    struct virtnet_sq_free_stats *stats)
>  {
> @@ -377,6 +487,9 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>  		++stats->packets;
>  
> +		if (sq->vq->premapped)
> +			virtnet_sq_unmap(sq, &ptr);
> +
>  		if (!is_xdp_frame(ptr)) {
>  			struct sk_buff *skb = ptr;
>  
> @@ -890,8 +1003,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>  			    skb_frag_size(frag), skb_frag_off(frag));
>  	}
>  
> -	err = virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> -				   xdp_to_ptr(xdpf), GFP_ATOMIC);
> +	err = virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf));
>  	if (unlikely(err))
>  		return -ENOSPC; /* Caller handle free/refcnt */
>  
> @@ -2357,7 +2469,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>  			return num_sg;
>  		num_sg++;
>  	}
> -	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
> +	return virtnet_add_outbuf(sq, num_sg, skb);
>  }
>  
>  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> @@ -4166,6 +4278,8 @@ static void virtnet_free_queues(struct virtnet_info *vi)
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		__netif_napi_del(&vi->rq[i].napi);
>  		__netif_napi_del(&vi->sq[i].napi);
> +
> +		kfree(vi->sq[i].dmainfo.p);
>  	}
>  
>  	/* We called __netif_napi_del(),
> @@ -4214,6 +4328,15 @@ static void free_receive_page_frags(struct virtnet_info *vi)
>  
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
> +	struct virtnet_info *vi = vq->vdev->priv;
> +	struct send_queue *sq;
> +	int i = vq2rxq(vq);
> +
> +	sq = &vi->sq[i];
> +
> +	if (sq->vq->premapped)
> +		virtnet_sq_unmap(sq, &buf);
> +
>  	if (!is_xdp_frame(buf))
>  		dev_kfree_skb(buf);
>  	else
> @@ -4327,8 +4450,10 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  		if (ctx)
>  			ctx[rxq2vq(i)] = true;
>  
> -		if (premapped)
> +		if (premapped) {
>  			premapped[rxq2vq(i)] = true;
> +			premapped[txq2vq(i)] = true;
> +		}
>  	}
>  
>  	cfg.nvqs      = total_vqs;
> @@ -4352,6 +4477,9 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  		vi->rq[i].vq = vqs[rxq2vq(i)];
>  		vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
>  		vi->sq[i].vq = vqs[txq2vq(i)];
> +
> +		if (vi->sq[i].vq->premapped)
> +			virtnet_sq_init_dma_mate(&vi->sq[i]);
>  	}
>  
>  	/* run here: ret == 0. */
> -- 
> 2.32.0.3.g01195cf9f


