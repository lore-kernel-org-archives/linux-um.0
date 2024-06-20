Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221F4C2BA18
	for <linux-um@archiver.kernel.org>; Thu, 20 Jun 2024 09:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c2UyGUAnU9MppByM5/160z/h1FZQF4H8b3fhx9biUXw=; b=r7ZGi0lwsxxTMzxAtNBGExshPN
	3j6wQwjHA6Z4JozOsvOSfHRfEoCOaOI9e3B/sUKedBSydfCLLHDr2J3+Ib4MnPfZFeMGPqxYoaAZr
	tvDMcA+a0T+7Qjxp6Qm5VYwqi6t9D1l9nHfRsEgAN4dsSJ4GM76j4HUr7qldYbNhmmEwQRCW3UeQv
	9rC5rnAJxt+JcawmuT3hLpMZfJ1euvLenD38yFdoAICF7SP+AynSxaFlsDk8QyeyTN1p69QNycE4+
	V3yuGMU9DaD1Lita4y1IJ1tZe1Lv2fUqdLWTVAAuw9NEw7DnLkfMlGqIXBSPlzU34WP4Z/3m1x9bj
	xO6uw+Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKE0S-00000004MPz-0lvw;
	Thu, 20 Jun 2024 09:23:00 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKE0N-00000004MP7-2q3N
	for linux-um@lists.infradead.org;
	Thu, 20 Jun 2024 09:22:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718875372; h=Message-ID:Subject:Date:From:To;
	bh=c2UyGUAnU9MppByM5/160z/h1FZQF4H8b3fhx9biUXw=;
	b=PEIbrbmuyjiqx8aoq+/JkHzBALmKo491kktGU9ZKQw2wsLw2HVafGwb5OyGYIBTmxN16W8WfCRzLhKNPASZk6ILRz2U1k+gYWGY/bfkrXmuXKb95VQvXX328xKFrRGq2N3Bnbk/hyWBu+0jOrCC4W/+nzDP18qhQmCXX3OTnWIU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W8rDkyX_1718875370;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8rDkyX_1718875370)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 17:22:50 +0800
Message-ID: <1718875249.1787696-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v9 3/6] virtio: find_vqs: pass struct instead of multi parameters
Date: Thu, 20 Jun 2024 17:20:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
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
 David Hildenbrand <david@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-4-xuanzhuo@linux.alibaba.com>
 <20240620034823-mutt-send-email-mst@kernel.org>
 <1718874049.457552-1-xuanzhuo@linux.alibaba.com>
 <20240620050545-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620050545-mutt-send-email-mst@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_022257_212712_CF366D3C 
X-CRM114-Status: GOOD (  11.33  )
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

On Thu, 20 Jun 2024 05:14:24 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Jun 20, 2024 at 05:00:49PM +0800, Xuan Zhuo wrote:
> > > > @@ -226,21 +248,37 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
> > > >
> > > >  static inline
> > > >  int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > > > -			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > -			const char * const names[],
> > > > -			struct irq_affinity *desc)
> > > > +		    struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > +		    const char * const names[],
> > > > +		    struct irq_affinity *desc)
> > > >  {
> > > > -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
> > > > +	struct virtio_vq_config cfg = {};
> > > > +
> > > > +	cfg.nvqs = nvqs;
> > > > +	cfg.vqs = vqs;
> > > > +	cfg.callbacks = callbacks;
> > > > +	cfg.names = (const char **)names;
> > >
> > >
> > > Casting const away? Not safe.
> >
> >
> >
> > Because the vp_modern_create_avq() use the "const char *names[]",
> > and the virtio_uml.c changes the name in the subsequent commit, so
> > change the "names" inside the virtio_vq_config from "const char *const
> > *names" to "const char **names".
>
> I'm not sure I understand which commit you mean,
> and this kind of change needs to be documented, but it does not matter.
> Don't cast away const.


Do you mean change the virtio_find_vqs(), from
const char * const names[] to const char *names[].

And update the caller?

If we do not cast the const, we need to update all the caller to remove the
const.

Right?

Thanks.

>
> --
> MST
>

