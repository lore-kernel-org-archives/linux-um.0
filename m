Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12736C54E58
	for <linux-um@archiver.kernel.org>; Mon, 25 Mar 2024 06:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2wvKbE33fAJ4kNFKPB3UPmddRQV+uumgQtNtBaMBvfA=; b=rUPMkuv3K3t5eNxBJHL2Z4cVZT
	3dGu+qH04Spab3FoDpsNdk0k1QgtJEhS4Y/qpHDgXOTcxCe/OgctoH6oikFSY7dL/l53zuGc2UjCS
	BVK6kKfeNYjLRgKKf7qHcnnFz2DjTEu3tvjFhBcolNWHY7lbcwCcqRqsj6p9SCchUXBPnbMavdMM8
	EZAY4CQl4mp+3AHYt9jG+ICFTxpOhX1gtsr8Yu1A3maGTjmWv9twdsWI14T/CMXeobclc6j7OM89k
	ND2pq8SvElDgJTIymfLyA/M1cNiuu6OVfbI1Rnpl/6/WQrFJGEsPWsvAObq4c/1lREiKOXiSgqhyV
	7DOGmZ2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rodRA-0000000FXtG-1uBf;
	Mon, 25 Mar 2024 06:04:00 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rodR5-0000000FXpW-2WoS
	for linux-um@lists.infradead.org;
	Mon, 25 Mar 2024 06:03:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711346630; h=Message-ID:Subject:Date:From:To;
	bh=2wvKbE33fAJ4kNFKPB3UPmddRQV+uumgQtNtBaMBvfA=;
	b=UCB4OKvNG2xNqUY3Fq0w2kzqGgoUZfQWEMHUd/+uyVPdMxjQdnFlJ50incAst6K4PQOWJrIaE+Y6HOwMjqDlsTb1540PChh1fORFp0R52JI3kl8GEj/IGn+V4UqAFwxpgmcJe2JKXXuVl5t8nUX0/H8in8ktPQ/i1csr4DSSneo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W39d4bX_1711346625;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W39d4bX_1711346625)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 14:03:46 +0800
Message-ID: <1711346600.0136697-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v4 1/6] virtio_balloon: remove the dependence where names[] is null
Date: Mon, 25 Mar 2024 14:03:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240321101532.59272-1-xuanzhuo@linux.alibaba.com>
 <20240321101532.59272-2-xuanzhuo@linux.alibaba.com>
 <3620be9c-e288-4ff2-a7be-1fcf806e6e6e@redhat.com>
In-Reply-To: <3620be9c-e288-4ff2-a7be-1fcf806e6e6e@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240324_230355_853602_A3801A0B 
X-CRM114-Status: GOOD (  23.20  )
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

On Fri, 22 Mar 2024 12:56:46 +0100, David Hildenbrand <david@redhat.com> wrote:
> On 21.03.24 11:15, Xuan Zhuo wrote:
> > Currently, the init_vqs function within the virtio_balloon driver relies
> > on the condition that certain names array entries are null in order to
> > skip the initialization of some virtual queues (vqs). This behavior is
> > unique to this part of the codebase. In an upcoming commit, we plan to
> > eliminate this dependency by removing the function entirely. Therefore,
> > with this change, we are ensuring that the virtio_balloon no longer
> > depends on the aforementioned function.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >   drivers/virtio/virtio_balloon.c | 41 +++++++++++++++------------------
> >   1 file changed, 19 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 1f5b3dd31fcf..becc12a05407 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -531,49 +531,46 @@ static int init_vqs(struct virtio_balloon *vb)
> >   	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
> >   	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
> >   	const char *names[VIRTIO_BALLOON_VQ_MAX];
> > -	int err;
> > +	int err, nvqs, idx;
> >
> > -	/*
> > -	 * Inflateq and deflateq are used unconditionally. The names[]
> > -	 * will be NULL if the related feature is not enabled, which will
> > -	 * cause no allocation for the corresponding virtqueue in find_vqs.
> > -	 */
> >   	callbacks[VIRTIO_BALLOON_VQ_INFLATE] = balloon_ack;
> >   	names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
> >   	callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
> >   	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
>
> I'd remove the static dependencies here completely and do it
> consistently:
>
> nvqs = 0;
>
> callbacks[nvqs] = balloon_ack;
> names[nvqs++] = "inflate";
> callbacks[nvqs] = balloon_ack;
> names[nvqs++] = "deflate";
>
>
> > -	callbacks[VIRTIO_BALLOON_VQ_STATS] = NULL;
> > -	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
> > -	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> > -	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> > -	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
> > +
> > +	nvqs = VIRTIO_BALLOON_VQ_DEFLATE + 1;
> >
> >   	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
> > -		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
> > -		callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
> > +		names[nvqs] = "stats";
> > +		callbacks[nvqs] = stats_request;
> > +		++nvqs;
>
> callbacks[nvqs++] = stats_request;
>
> If you prefer to keep it separate, "nvqs++" please.
>
> ... same here:
>
> idx = 0;
> vb->inflate_vq = vqs[idx++];
> vb->deflate_vq = vqs[idx++];
>
> ...
>
> >
> >   	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
> >   	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
> > +
> > +	idx = VIRTIO_BALLOON_VQ_DEFLATE + 1;
> > +
> >   	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
> >   		struct scatterlist sg;
> >   		unsigned int num_stats;
> > -		vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
> > +		vb->stats_vq = vqs[idx++];
> >
> >   		/*
> >   		 * Prime this virtqueue with one buffer so the hypervisor can
> > @@ -593,10 +590,10 @@ static int init_vqs(struct virtio_balloon *vb)
> >   	}
> >
> >   	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> > -		vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
> > +		vb->free_page_vq = vqs[idx++];
> >
> >   	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> > -		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
> > +		vb->reporting_vq = vqs[idx++];
> >
>
> Apart from that LGTM

Will fix in next version.

Thanks.


>
> --
> Cheers,
>
> David / dhildenb
>

