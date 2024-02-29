Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9542C48BF6
	for <linux-um@archiver.kernel.org>; Thu, 29 Feb 2024 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F4AGC6LhQ8Etbmz/AgXkeOLKjk+I82HAP2LPRb2GsOc=; b=Eajbq18MGterNnoFqFdwk+IudH
	gCWuxnUvty0Wvvl0PVX1sK22pcsjwHtCtobST+eNtBmAgzvJTq7CWH0r/pX2oudbjM8wBVYv5L5jW
	A0bX6LiEL8wDVp1lKN/VTWhZI7NtT0Rn4yyEu6t9xwVNWk6pUrrSqHrXuLiWYt2YhkCi1PAktiwkm
	SLGyRtmxsHNJK+n8q+GTCHTro2Gj0RCZ1BtZQ4IjucpCzNf6NJfTljzsF3mmEDOy4p4Hh7HeUdz5R
	B/nHw2aVpBA2CJURu+JH66VtYtZBIQuDLN5yNmtX/SrTp8WE2bYuPVA38ihbUzyOCCjpbMbogIyHU
	ADFRciNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfctr-0000000Cxjo-0hoP;
	Thu, 29 Feb 2024 09:40:23 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfcto-0000000Cxi4-1jTn
	for linux-um@lists.infradead.org;
	Thu, 29 Feb 2024 09:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709199618; h=Message-ID:Subject:Date:From:To;
	bh=F4AGC6LhQ8Etbmz/AgXkeOLKjk+I82HAP2LPRb2GsOc=;
	b=FnJ22vVnlDVDoASdcCs5twMlelDjQjNou7UDNW7Ur8lJzk/dosj7/dE7qt0EgOKp0WLluOMiBzR/7YROcAYvTH3R3B7SbFsMvKERhMSHZRjd/ql9o9t9E6sJzp5zuUGrg2+vEzSOleEQjflkfLpHE6VJ+b4Dl0p4xdjfkursPHA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0W1SfgPr_1709199614;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1SfgPr_1709199614)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 17:40:15 +0800
Message-ID: <1709199386.9824007-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v3 00/19] virtio: drivers maintain dma info for premapped vq
Date: Thu, 29 Feb 2024 17:36:26 +0800
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
References: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
 <20240229031755-mutt-send-email-mst@kernel.org>
 <1709197357.626784-1-xuanzhuo@linux.alibaba.com>
 <20240229043238-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240229043238-mutt-send-email-mst@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_014020_787806_5AE56AF2 
X-CRM114-Status: GOOD (  36.78  )
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

On Thu, 29 Feb 2024 04:34:20 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Feb 29, 2024 at 05:02:37PM +0800, Xuan Zhuo wrote:
> > On Thu, 29 Feb 2024 03:21:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Thu, Feb 29, 2024 at 03:20:25PM +0800, Xuan Zhuo wrote:
> > > > As discussed:
> > > > http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com
> > > >
> > > > If the virtio is premapped mode, the driver should manage the dma info by self.
> > > > So the virtio core should not store the dma info.
> > > > So we can release the memory used to store the dma info.
> > > >
> > > > But if the desc_extra has not dma info, we face a new question,
> > > > it is hard to get the dma info of the desc with indirect flag.
> > > > For split mode, that is easy from desc, but for the packed mode,
> > > > it is hard to get the dma info from the desc. And for hardening
> > > > the dma unmap is saft, we should store the dma info of indirect
> > > > descs.
> > > >
> > > > So I introduce the "structure the indirect desc table" to
> > > > allocate space to store dma info with the desc table.
> > > >
> > > > On the other side, we mix the descs with indirect flag
> > > > with other descs together to share the unmap api. That
> > > > is complex. I found if we we distinguish the descs with
> > > > VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
> > > >
> > > > Because of the dma array is allocated in the find_vqs(),
> > > > so I introduce a new parameter to find_vqs().
> > > >
> > > > Note:
> > > >     this is on the top of
> > > >         [PATCH vhost v1] virtio: packed: fix unmap leak for indirect desc table
> > > >         http://lore.kernel.org/all/20240223071833.26095-1-xuanzhuo@linux.alibaba.com
> > > >
> > > > Please review.
> > > >
> > > > Thanks
> > > >
> > > > v3:
> > > >     1. fix the conflict with the vp_modern_create_avq().
> > >
> > > Okay but are you going to address huge memory waste all this is causing for
> > > - people who never do zero copy
> > > - systems where dma unmap is a nop
> > >
> > > ?
> > >
> > > You should address all comments when you post a new version, not just
> > > what was expedient, or alternatively tag patch as RFC and explain
> > > in commit log that you plan to do it later.
> >
> >
> > Do you miss this one?
> > http://lore.kernel.org/all/1708997579.5613105-1-xuanzhuo@linux.alibaba.com
>
>
> I did. The answer is that no, you don't get to regress memory usage
> for lots of people then fix it up.
> So the patchset is big, I guess it will take a couple of cycles to
> merge gradually.

I see.

But I hope we can review the other part of this patch set.  @Jason @Michael

I don't want us to give up on this plan for some other reason after I've done so
much work.

Thanks.


>
> > I asked you. But I didnot recv your answer.
> >
> > Thanks.
> >
> >
> > >
> > > > v2:
> > > >     1. change the dma item of virtio-net, every item have MAX_SKB_FRAGS + 2
> > > >         addr + len pairs.
> > > >     2. introduce virtnet_sq_free_stats for __free_old_xmit
> > > >
> > > > v1:
> > > >     1. rename transport_vq_config to vq_transport_config
> > > >     2. virtio-net set dma meta number to (ring-size + 1)(MAX_SKB_FRGAS +2)
> > > >     3. introduce virtqueue_dma_map_sg_attrs
> > > >     4. separate vring_create_virtqueue to an independent commit
> > > >
> > > >
> > > >
> > > > Xuan Zhuo (19):
> > > >   virtio_ring: introduce vring_need_unmap_buffer
> > > >   virtio_ring: packed: remove double check of the unmap ops
> > > >   virtio_ring: packed: structure the indirect desc table
> > > >   virtio_ring: split: remove double check of the unmap ops
> > > >   virtio_ring: split: structure the indirect desc table
> > > >   virtio_ring: no store dma info when unmap is not needed
> > > >   virtio: find_vqs: pass struct instead of multi parameters
> > > >   virtio: vring_create_virtqueue: pass struct instead of multi
> > > >     parameters
> > > >   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
> > > >   virtio_ring: simplify the parameters of the funcs related to
> > > >     vring_create/new_virtqueue()
> > > >   virtio: find_vqs: add new parameter premapped
> > > >   virtio_ring: export premapped to driver by struct virtqueue
> > > >   virtio_net: set premapped mode by find_vqs()
> > > >   virtio_ring: remove api of setting vq premapped
> > > >   virtio_ring: introduce dma map api for page
> > > >   virtio_ring: introduce virtqueue_dma_map_sg_attrs
> > > >   virtio_net: unify the code for recycling the xmit ptr
> > > >   virtio_net: rename free_old_xmit_skbs to free_old_xmit
> > > >   virtio_net: sq support premapped mode
> > > >
> > > >  arch/um/drivers/virtio_uml.c             |  31 +-
> > > >  drivers/net/virtio_net.c                 | 283 ++++++---
> > > >  drivers/platform/mellanox/mlxbf-tmfifo.c |  24 +-
> > > >  drivers/remoteproc/remoteproc_virtio.c   |  31 +-
> > > >  drivers/s390/virtio/virtio_ccw.c         |  33 +-
> > > >  drivers/virtio/virtio_mmio.c             |  30 +-
> > > >  drivers/virtio/virtio_pci_common.c       |  59 +-
> > > >  drivers/virtio/virtio_pci_common.h       |   9 +-
> > > >  drivers/virtio/virtio_pci_legacy.c       |  16 +-
> > > >  drivers/virtio/virtio_pci_modern.c       |  38 +-
> > > >  drivers/virtio/virtio_ring.c             | 698 ++++++++++++-----------
> > > >  drivers/virtio/virtio_vdpa.c             |  45 +-
> > > >  include/linux/virtio.h                   |  13 +-
> > > >  include/linux/virtio_config.h            |  48 +-
> > > >  include/linux/virtio_ring.h              |  82 +--
> > > >  tools/virtio/virtio_test.c               |   4 +-
> > > >  tools/virtio/vringh_test.c               |  28 +-
> > > >  17 files changed, 847 insertions(+), 625 deletions(-)
> > > >
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > >
>

