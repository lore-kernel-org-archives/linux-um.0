Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA18C5478C
	for <linux-um@archiver.kernel.org>; Mon, 26 Feb 2024 06:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zqZsfZ/qluUEW7qkID/ee5gWeGwmJGn3HGM5FIAvvSM=; b=V8qBsDogK0kma0zaO21+6sAicX
	0wnIkj/bfovXo3xwxselzztAkViRfbt4kkbBfCrhB+7imVWItlhOPWc7FJQdRNEGi4thD+W44h6eY
	05e0NLEeM4YN9PN2b0IgcHSefYlIcACsyn1m0p24wzNYeZQ8159joXP/FiF9SvMtuoCgc9C20Q5dc
	meDVBNRYOUuE91Ja2Sj4OiZx8uNYN16ZcGZAzZf96SRKufshhE/E+VHhdzGqqN7TtEVHTYSuQcYeS
	VSmp71Ngo/7mlhb9BIxYNt6EJ0T69B7XgePnmQSHJG1B/1aMtSVdsTonFRusZqtxsn3FjvKsM/8e2
	GodrZbTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reUlr-0000000GhJM-1pOB;
	Mon, 26 Feb 2024 06:47:27 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reUln-0000000GhHv-34vW
	for linux-um@lists.infradead.org;
	Mon, 26 Feb 2024 06:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708930038; h=Message-ID:Subject:Date:From:To;
	bh=zqZsfZ/qluUEW7qkID/ee5gWeGwmJGn3HGM5FIAvvSM=;
	b=QeNDH/nWrlwrclQ1ckkE6ko+ZJcEDA6GAnZ4Zmr8vy71QCjtqcpTqdFt708kNbRrreKiiiXMFQdG3vsUXzIzUUCN2z95U716S4WWeGRC5yzHdvBDF3lMS1JBIMY9FZMA9Eafy4kifO8IjtUWPocy7euB9wt3NMtvlaqQYwhscNg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0W1Cedgm_1708930033;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1Cedgm_1708930033)
          by smtp.aliyun-inc.com;
          Mon, 26 Feb 2024 14:47:14 +0800
Message-ID: <1708927861.8802218-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v2 19/19] virtio_net: sq support premapped mode
Date: Mon, 26 Feb 2024 14:11:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
 linux-um@lists.infradead.org,
 netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
 <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
 <20240225032330-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240225032330-mutt-send-email-mst@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240225_224724_119143_EA427A5F 
X-CRM114-Status: GOOD (  32.48  )
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

On Sun, 25 Feb 2024 03:38:48 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Feb 23, 2024 at 04:27:26PM +0800, Xuan Zhuo wrote:
> > If the xsk is enabling, the xsk tx will share the send queue.
> > But the xsk requires that the send queue use the premapped mode.
> > So the send queue must support premapped mode.
> >
> > cmd:
> >     sh samples/pktgen/pktgen_sample01_simple.sh -i eth0 \
> >         -s 16 -d 10.0.0.128 -m 00:16:3e:2c:c8:2e -n 0 -p 100
> > CPU:
> >     Intel(R) Xeon(R) Platinum 8369B CPU @ 2.70GHz
> >
> > Machine:
> >     ecs.g7.2xlarge(Aliyun)
> >
> > before:              1600010.00
> > after(no-premapped): 1599966.00
> > after(premapped):    1600014.00
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 136 +++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 132 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7715bb7032ec..b83ef6afc4fb 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -146,6 +146,25 @@ struct virtnet_rq_dma {
> >  	u16 need_sync;
> >  };
> >
> > +

[...]

> > +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *sq,
> > +						int nents, void *data)
> > +{
> > +	struct virtnet_sq_dma *d;
> > +	struct scatterlist *sg;
> > +	int i;
> > +
> > +	if (!sq->dmainfo.free)
> > +		return NULL;
> > +
> > +	d = sq->dmainfo.free;
> > +	sq->dmainfo.free = d->next;
> > +
> > +	for_each_sg(sq->sg, sg, nents, i) {
> > +		if (virtqueue_dma_map_sg_attrs(sq->vq, sg, DMA_TO_DEVICE, 0))
> > +			goto err;
> > +
> > +		d->addr[i] = sg->dma_address;
> > +		d->len[i] = sg->length;
> > +	}
> > +
> > +	d->data = data;
> > +	d->num = i;
> > +	return d;
> > +
> > +err:
> > +	d->num = i;
> > +	virtnet_sq_unmap(sq, (void **)&d);
> > +	return NULL;
> > +}
>
>
> Do I see a reimplementation of linux/llist.h here?

YES. This can be done by the APIs of linux/lllist.h.

But now, there is not __llist_del_first() (That will be used by
virtnet_sq_map_sg()).
And that is simple and just two places may use the APIs, so I implement it
directly.

>
>
> > +
> > +static int virtnet_add_outbuf(struct send_queue *sq, u32 num, void *data)
> > +{
> > +	int ret;
> > +
> > +	if (sq->vq->premapped) {
> > +		data = virtnet_sq_map_sg(sq, num, data);
> > +		if (!data)
> > +			return -ENOMEM;
> > +	}
> > +
> > +	ret = virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMIC);
> > +	if (ret && sq->vq->premapped)
> > +		virtnet_sq_unmap(sq, &data);
> > +
> > +	return ret;
> > +}
> > +
> > +static int virtnet_sq_init_dma_mate(struct send_queue *sq)
>
> Mate? The popular south african drink?

Sorry, should be meta, I mean metadata.

>
> > +{
> > +	struct virtnet_sq_dma *d;
> > +	int num, i;
> > +
> > +	num = virtqueue_get_vring_size(sq->vq);
> > +
> > +	sq->dmainfo.free = kcalloc(num, sizeof(*sq->dmainfo.free), GFP_KERNEL);
> > +	if (!sq->dmainfo.free)
> > +		return -ENOMEM;
>
>
> This could be quite a bit of memory for a large queue.  And for a bunch
> of common cases where unmap is a nop (e.g. iommu pt) this does nothing
> useful at all.

Then can we skip the unmap api, so pass a zero to the unmap api?

> And also, this does nothing useful if PLATFORM_ACCESS is off
> which is super common.

That is ok. That just work when PLATFORM_ACCESS is on.

Thanks.

>
> A while ago I proposed:
> - extend DMA APIs so one can query whether unmap is a nop
>   and whether sync is a nop
> - virtio wrapper taking into account PLATFORM_ACCESS too
>
> then we can save all this work and memory when not needed.
>
>
>
> > +
> > +	sq->dmainfo.p = sq->dmainfo.free;
> > +
> > +	for (i = 0; i < num; ++i) {
> > +		d = &sq->dmainfo.free[i];
> > +		d->next = d + 1;
> > +	}
> > +
> > +	d->next = NULL;
> > +
> > +	return 0;
> > +}
> > +
> >  static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> >  			    struct virtnet_sq_free_stats *stats)
> >  {
> > @@ -377,6 +487,9 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> >  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> >  		++stats->packets;
> >
> > +		if (sq->vq->premapped)
> > +			virtnet_sq_unmap(sq, &ptr);
> > +
> >  		if (!is_xdp_frame(ptr)) {
> >  			struct sk_buff *skb = ptr;
> >
> > @@ -890,8 +1003,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
> >  			    skb_frag_size(frag), skb_frag_off(frag));
> >  	}
> >
> > -	err = virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> > -				   xdp_to_ptr(xdpf), GFP_ATOMIC);
> > +	err = virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf));
> >  	if (unlikely(err))
> >  		return -ENOSPC; /* Caller handle free/refcnt */
> >
> > @@ -2357,7 +2469,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
> >  			return num_sg;
> >  		num_sg++;
> >  	}
> > -	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
> > +	return virtnet_add_outbuf(sq, num_sg, skb);
> >  }
> >
> >  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > @@ -4166,6 +4278,8 @@ static void virtnet_free_queues(struct virtnet_info *vi)
> >  	for (i = 0; i < vi->max_queue_pairs; i++) {
> >  		__netif_napi_del(&vi->rq[i].napi);
> >  		__netif_napi_del(&vi->sq[i].napi);
> > +
> > +		kfree(vi->sq[i].dmainfo.p);
> >  	}
> >
> >  	/* We called __netif_napi_del(),
> > @@ -4214,6 +4328,15 @@ static void free_receive_page_frags(struct virtnet_info *vi)
> >
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> >  {
> > +	struct virtnet_info *vi = vq->vdev->priv;
> > +	struct send_queue *sq;
> > +	int i = vq2rxq(vq);
> > +
> > +	sq = &vi->sq[i];
> > +
> > +	if (sq->vq->premapped)
> > +		virtnet_sq_unmap(sq, &buf);
> > +
> >  	if (!is_xdp_frame(buf))
> >  		dev_kfree_skb(buf);
> >  	else
> > @@ -4327,8 +4450,10 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> >  		if (ctx)
> >  			ctx[rxq2vq(i)] = true;
> >
> > -		if (premapped)
> > +		if (premapped) {
> >  			premapped[rxq2vq(i)] = true;
> > +			premapped[txq2vq(i)] = true;
> > +		}
> >  	}
> >
> >  	cfg.nvqs      = total_vqs;
> > @@ -4352,6 +4477,9 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> >  		vi->rq[i].vq = vqs[rxq2vq(i)];
> >  		vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
> >  		vi->sq[i].vq = vqs[txq2vq(i)];
> > +
> > +		if (vi->sq[i].vq->premapped)
> > +			virtnet_sq_init_dma_mate(&vi->sq[i]);
> >  	}
> >
> >  	/* run here: ret == 0. */
> > --
> > 2.32.0.3.g01195cf9f
>

