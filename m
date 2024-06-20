Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D0EC27C79
	for <linux-um@archiver.kernel.org>; Thu, 20 Jun 2024 10:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2vIY8NZnvngm+xxf0k0vAQCKhjahEOWJHOTFFlU+/BE=; b=Lv2GCEHMMmtk0SbDQirf7uUzXR
	ijKPeGQn9KIGLlxU6zkHmVm9+IIt8IsBS0X31RduckOzhRWodqxiWdZr+EPVeUwZj5RqxkF6nMgvj
	DpPU02MIXqdzaeqXVS55QMxgQUSTfu17ucpII5WNonzmtbSTu/NKR7fwA/Cr2b/CSuZAK5GDC18N+
	3iwcGSLd16AAV/SuusnvUsPCofUy9PCxAAh7G5CnghoKmu8ZdL6x3M9/Tzt9Iw9jkEl4pcPB4Aq+M
	k0v7/NAdMp7NMs/UsvGBioynlLsyGsZxkrGZl4dZ/JCwuShf1tmxXmet89OXpluZy9sb2zjvZ7oR1
	lNbTrxvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKFQb-00000004eX5-024N;
	Thu, 20 Jun 2024 10:54:05 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKFQX-00000004eVa-2xT2
	for linux-um@lists.infradead.org;
	Thu, 20 Jun 2024 10:54:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718880839; h=Message-ID:Subject:Date:From:To;
	bh=2vIY8NZnvngm+xxf0k0vAQCKhjahEOWJHOTFFlU+/BE=;
	b=S0l6vp9OukbkV5RYsVoz3F/mYQVPyeqtf6gz5P+vrm1GVVBYDPGrdNlWDw5INirkjsnqVZhFbqShyV42GKO8rTKXEsk2c7XaDz09Mows0DsoGPtPz+BCQxZEtEJyZ9/SxgD6xEaRUB55JhNHvk+cOi+udBb3XzSA4ofgsuizro0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W8sD2ym_1718880836;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8sD2ym_1718880836)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 18:53:57 +0800
Message-ID: <1718880548.281809-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v9 2/6] virtio: remove support for names array entries being null.
Date: Thu, 20 Jun 2024 18:49:08 +0800
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
 kvm@vger.kernel.org,
 Wei Wang <wei.w.wang@intel.com>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-3-xuanzhuo@linux.alibaba.com>
 <20240620035749-mutt-send-email-mst@kernel.org>
 <1718872778.4831812-1-xuanzhuo@linux.alibaba.com>
 <20240620044839-mutt-send-email-mst@kernel.org>
 <1718874293.698573-2-xuanzhuo@linux.alibaba.com>
 <20240620054548-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620054548-mutt-send-email-mst@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_035402_039714_67B99208 
X-CRM114-Status: GOOD (  37.70  )
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

On Thu, 20 Jun 2024 06:01:54 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Jun 20, 2024 at 05:04:53PM +0800, Xuan Zhuo wrote:
> > On Thu, 20 Jun 2024 05:01:08 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Thu, Jun 20, 2024 at 04:39:38PM +0800, Xuan Zhuo wrote:
> > > > On Thu, 20 Jun 2024 04:02:45 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Wed, Apr 24, 2024 at 05:15:29PM +0800, Xuan Zhuo wrote:
> > > > > > commit 6457f126c888 ("virtio: support reserved vqs") introduced this
> > > > > > support. Multiqueue virtio-net use 2N as ctrl vq finally, so the logic
> > > > > > doesn't apply. And not one uses this.
> > > > > >
> > > > > > On the other side, that makes some trouble for us to refactor the
> > > > > > find_vqs() params.
> > > > > >
> > > > > > So I remove this support.
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > Acked-by: Eric Farman <farman@linux.ibm.com> # s390
> > > > > > Acked-by: Halil Pasic <pasic@linux.ibm.com>
> > > > >
> > > > >
> > > > > I don't mind, but this patchset is too big already.
> > > > > Why do we need to make this part of this patchset?
> > > >
> > > >
> > > > If some the pointers of the names is NULL, then in the virtio ring,
> > > > we will have a trouble to index from the arrays(names, callbacks...).
> > > > Becasue that the idx of the vq is not the index of these arrays.
> > > >
> > > > If the names is [NULL, "rx", "tx"], the first vq is the "rx", but index of the
> > > > vq is zero, but the index of the info of this vq inside the arrays is 1.
> > >
> > >
> > > Ah. So actually, it used to work.
> > >
> > > What this should refer to is
> > >
> > > commit ddbeac07a39a81d82331a312d0578fab94fccbf1
> > > Author: Wei Wang <wei.w.wang@intel.com>
> > > Date:   Fri Dec 28 10:26:25 2018 +0800
> > >
> > >     virtio_pci: use queue idx instead of array idx to set up the vq
> > >
> > >     When find_vqs, there will be no vq[i] allocation if its corresponding
> > >     names[i] is NULL. For example, the caller may pass in names[i] (i=4)
> > >     with names[2] being NULL because the related feature bit is turned off,
> > >     so technically there are 3 queues on the device, and name[4] should
> > >     correspond to the 3rd queue on the device.
> > >
> > >     So we use queue_idx as the queue index, which is increased only when the
> > >     queue exists.
> > >
> > >     Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> >
> > That just work for PCI.
> >
> > The trouble I described is that we can not index in the virtio ring.
> >
> > In virtio ring, we may like to use the vq.index that do not increase
> > for the NULL.
> >
> >
> > >
> > > Which made it so setting names NULL actually does not reserve a vq.
> > >
> > > But I worry about non pci transports - there's a chance they used
> > > a different index with the balloon. Did you test some of these?
> > >
> >
> > Balloon is out of spec.
> >
> > The vq.index does not increase for the name NULL. So the Balloon use the
> > continuous id. That is out of spec.
>
>
> I see. And apparently the QEMU implementation is out of spec, too,
> so they work fine. And STATS is always on in QEMU.
>
> That change by Wei broke the theoretical config which has
> !STATS but does have FREE_PAGE. We never noticed - not many people
> ever bothered with FREE_PAGE.
>
> However QEMU really is broken in a weird way.
> In particular if it exposes STATS but driver does not
> configure STATS then QEMU still has the stats vq.
> Things will break then.
>
>
> In short, it's a mess, and it needs thought.
> At this point I suggest we keep the ability to set
> names to NULL in case we want to just revert Wei's patch.
>
>
>
> > That does not matter for this patchset.
> > The name NULL is always skipped.
> >
> > Thanks.
>
>
> Let's keep this patchset as small as possible.
> Keep the existing functionality, we'll do cleanups
> later.


I am ok. But we need a idx to index the info of the vq.

How about a new element "cfg_idx" to virtio_vq_config.

struct virtio_vq_config {
	unsigned int nvqs;
->	unsigned int cfg_idx;

	struct virtqueue   **vqs;
	vq_callback_t      **callbacks;
	const char         **names;
	const bool          *ctx;
	struct irq_affinity *desc;
};


That is setted by transport. The virtio ring can use this to index the info
of the vq. Then the #1 #2 commits can be dropped.


Thanks.



>
>
> > > --
> > > MST
> > >
>

