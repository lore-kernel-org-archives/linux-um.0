Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC68C25B77
	for <linux-um@archiver.kernel.org>; Wed, 22 May 2024 12:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kaW0YgGw3dq/rQoPZq4yGMzGnulifIeN6HXu9g9dSzU=; b=3iq28m/2xTHtY7bmjPzvzPTW+f
	2YHoBrjEvwlu089DN218tZwVe1mkYowUG+mBpVkSHkUd/9D6RsT/BDpQC6tJJ++s1pCtvu1QJKTIn
	VpvOyoXFN0P8fnZUBOZ48VUrOKm1aP+wO8mlP884zgmns/BtigBdAVEWsVI1DrVKYBh/NPAEaXX8K
	DGJdo1GtINJC/2di0SDSs/hUykc6bFxg2m2/kwT3n2eBFfLA39pVsleldSxXu67+LswMkQeocKifu
	Ud0rj342AN8ddF2KbKLCO9suWSzOqAL9NXYiueshzRIUjSmoddlGPRcLsRwClXtUfWnBY6NoRG0vr
	o1WViqfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9lHj-00000002xQP-0vKZ;
	Wed, 22 May 2024 12:41:35 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9lHe-00000002xNl-3wzR
	for linux-um@lists.infradead.org;
	Wed, 22 May 2024 12:41:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716381685; h=Message-ID:Subject:Date:From:To;
	bh=kaW0YgGw3dq/rQoPZq4yGMzGnulifIeN6HXu9g9dSzU=;
	b=K7CET/ZKHxPBxAF1BXhnBKUKEv+nIdHmsvcjWmAi7hwh3T78DGLblm+fCqGRJ5/fDxgMvcbo2W8SK7LnNsOXAEkBExpunAiiwfMvNGKOACNvsCJz7vG20MCkz5z8G77nqtKc6D5sZPCd2sLHI+ZEJXn7/10Moz4Z+8lQ56NrsZ8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W7.bw5p_1716381683;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7.bw5p_1716381683)
          by smtp.aliyun-inc.com;
          Wed, 22 May 2024 20:41:24 +0800
Message-ID: <1716381321.6426032-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v9 0/6] refactor the params of find_vqs()
Date: Wed, 22 May 2024 20:35:21 +0800
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
 <20240522082732-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240522082732-mutt-send-email-mst@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_054132_206144_4D9FD357 
X-CRM114-Status: GOOD (  23.69  )
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

On Wed, 22 May 2024 08:28:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Apr 24, 2024 at 05:15:27PM +0800, Xuan Zhuo wrote:
> > This pathset is splited from the
> >
> >      http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.alibaba.com
> >
> > That may needs some cycles to discuss. But that notifies too many people.
> >
> > But just the four commits need to notify so many people.
> > And four commits are independent. So I split that patch set,
> > let us review these first.
> >
> > The patch set try to  refactor the params of find_vqs().
> > Then we can just change the structure, when introducing new
> > features.
> >
> > Thanks.
>
> It's nice but I'd like to see something that uses this before I bother
> merging. IIUC premapped is dropped - are we going to use this in practice?


1. You know this modification makes sense.
2. This modification is difficult. Unlike modifying virtio ring or virtio-net,
   this patch set requires modifying many modules and being reviewed by
   many people.
3. If you do not merge it now, then this patch set will most likely be
   abandoned. And I worked a lot on that.
4. premapped has not been abandoned, I have been advancing this work. What was
   abandoned was just virtio-net big mode's support for premapped.
5. My plan is to complete virtio-net support for af-xdp in 6.10. This must
   depend on premapped.

So, I hope you merge this patch set.

Thanks.


>
> > v8:
> >   1. rebase the vhost branch
> >
> > v7:
> >   1. fix two bugs. @Jason
> >
> > v6:
> >   1. virtio_balloon: a single variable for both purposes.
> >   2. if names[i] is null, return error
> >
> > v5:
> >   1. virtio_balloon: follow David Hildenbrand's suggest
> >     http://lore.kernel.org/all/3620be9c-e288-4ff2-a7be-1fcf806e6e6e@redhat.com
> >   2. fix bug of the reference of "cfg_idx"
> >     http://lore.kernel.org/all/202403222227.Sdp23Lcb-lkp@intel.com
> >
> > v4:
> >   1. remove support for names array entries being null
> >   2. remove cfg_idx from virtio_vq_config
> >
> > v3:
> >   1. fix the bug: "assignment of read-only location '*cfg.names'"
> >
> > v2:
> >   1. add kerneldoc for "struct vq_transport_config" @ilpo.jarvinen
> >
> > v1:
> >   1. fix some comments from ilpo.jarvinen@linux.intel.com
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > Xuan Zhuo (6):
> >   virtio_balloon: remove the dependence where names[] is null
> >   virtio: remove support for names array entries being null.
> >   virtio: find_vqs: pass struct instead of multi parameters
> >   virtio: vring_create_virtqueue: pass struct instead of multi
> >     parameters
> >   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
> >   virtio_ring: simplify the parameters of the funcs related to
> >     vring_create/new_virtqueue()
> >
> >  arch/um/drivers/virtio_uml.c             |  36 +++--
> >  drivers/platform/mellanox/mlxbf-tmfifo.c |  23 +--
> >  drivers/remoteproc/remoteproc_virtio.c   |  37 +++--
> >  drivers/s390/virtio/virtio_ccw.c         |  38 ++---
> >  drivers/virtio/virtio_balloon.c          |  48 +++---
> >  drivers/virtio/virtio_mmio.c             |  36 +++--
> >  drivers/virtio/virtio_pci_common.c       |  69 ++++-----
> >  drivers/virtio/virtio_pci_common.h       |   9 +-
> >  drivers/virtio/virtio_pci_legacy.c       |  16 +-
> >  drivers/virtio/virtio_pci_modern.c       |  37 +++--
> >  drivers/virtio/virtio_ring.c             | 177 ++++++++---------------
> >  drivers/virtio/virtio_vdpa.c             |  51 +++----
> >  include/linux/virtio_config.h            |  76 +++++++---
> >  include/linux/virtio_ring.h              |  93 +++++++-----
> >  tools/virtio/virtio_test.c               |   4 +-
> >  tools/virtio/vringh_test.c               |  28 ++--
> >  16 files changed, 384 insertions(+), 394 deletions(-)
> >
> > --
> > 2.32.0.3.g01195cf9f
>

