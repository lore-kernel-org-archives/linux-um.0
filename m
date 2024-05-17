Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DDFC25B77
	for <linux-um@archiver.kernel.org>; Fri, 17 May 2024 01:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KrEPs691Td3NZbxOFWTzxJL2b3bXbcRVeAlZkrnOcRA=; b=Vx4fqgn3RObamckzOCKS3uuHSk
	A0ObH8NEEUN0UTpWaDmjDvNcc2fMtcZbZpZIWGr1/pB7rBIGPyoX2jTbMfCI3UN7bnfFjUTv/16+n
	HCjJjJEnNzRCGgv1Eou5N6QRIq/oxl/9z9AjyGfsavQPAjSotdINmpQHIiQrz78xWDg8wW9QKb2LT
	kSqPd3m2i8iCRTxlhelqoKij4T1sKrFX5ycMxn/KaFs9cRmACTMi334DNZu+A+Yvk27n7/yRBJMj2
	30jj3Aw023co2uLJUa8NtlpN64X9HcCoE9uFCgu2UgkRW70uaMljm+AOhpKwOR8Edh0dMc4Xdq71a
	9AjQbQLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7mR6-00000006Z0c-28Qf;
	Fri, 17 May 2024 01:31:04 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7mR2-00000006YwK-1TBO
	for linux-um@lists.infradead.org;
	Fri, 17 May 2024 01:31:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715909450; h=Message-ID:Subject:Date:From:To;
	bh=KrEPs691Td3NZbxOFWTzxJL2b3bXbcRVeAlZkrnOcRA=;
	b=q36dcOsHYOGMsQBTMHzU6uh6h8ojhX/cxKsFrj+EEHsQ42MwEeY8wsRwPKIVjqLQ0e70ZZKKAHhHqCQ95k06o9GSb+eQJYWFXrHypkUAdOfNjhSPZgkd3u5ckO7vBNB1rd8Rlf/MxIcK6qmLyut5YEXY3JRS8i2xb/WNYm4l3J8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W6cslx7_1715909446;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W6cslx7_1715909446)
          by smtp.aliyun-inc.com;
          Fri, 17 May 2024 09:30:47 +0800
Message-ID: <1715909158.0435698-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v9 0/6] refactor the params of find_vqs()
Date: Fri, 17 May 2024 09:25:58 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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
 David Hildenbrand <david@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240516_183100_751450_0582CA5A 
X-CRM114-Status: GOOD (  16.98  )
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

Hi, Michael

I hope this in your for_linus branch to merge to Linux 6.9.

	https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=linux-next

And some commits from me in your branch are changed after you picked them.
And there are merged by net-next.

virtio_net: remove the misleading comment
virtio_net: rx remove premapped failover code
virtio_net: enable premapped by default
virtio_net: big mode support premapped
virtio_net: replace private by pp struct inside page
virtio_ring: enable premapped mode whatever use_dma_api
virtio_ring: introduce dma map api for page

Thanks.



On Wed, 24 Apr 2024 17:15:27 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> This pathset is splited from the
>
>      http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.alibaba.com
>
> That may needs some cycles to discuss. But that notifies too many people.
>
> But just the four commits need to notify so many people.
> And four commits are independent. So I split that patch set,
> let us review these first.
>
> The patch set try to  refactor the params of find_vqs().
> Then we can just change the structure, when introducing new
> features.
>
> Thanks.
>
> v8:
>   1. rebase the vhost branch
>
> v7:
>   1. fix two bugs. @Jason
>
> v6:
>   1. virtio_balloon: a single variable for both purposes.
>   2. if names[i] is null, return error
>
> v5:
>   1. virtio_balloon: follow David Hildenbrand's suggest
>     http://lore.kernel.org/all/3620be9c-e288-4ff2-a7be-1fcf806e6e6e@redhat.com
>   2. fix bug of the reference of "cfg_idx"
>     http://lore.kernel.org/all/202403222227.Sdp23Lcb-lkp@intel.com
>
> v4:
>   1. remove support for names array entries being null
>   2. remove cfg_idx from virtio_vq_config
>
> v3:
>   1. fix the bug: "assignment of read-only location '*cfg.names'"
>
> v2:
>   1. add kerneldoc for "struct vq_transport_config" @ilpo.jarvinen
>
> v1:
>   1. fix some comments from ilpo.jarvinen@linux.intel.com
>
>
>
>
>
>
>
>
>
> Xuan Zhuo (6):
>   virtio_balloon: remove the dependence where names[] is null
>   virtio: remove support for names array entries being null.
>   virtio: find_vqs: pass struct instead of multi parameters
>   virtio: vring_create_virtqueue: pass struct instead of multi
>     parameters
>   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
>   virtio_ring: simplify the parameters of the funcs related to
>     vring_create/new_virtqueue()
>
>  arch/um/drivers/virtio_uml.c             |  36 +++--
>  drivers/platform/mellanox/mlxbf-tmfifo.c |  23 +--
>  drivers/remoteproc/remoteproc_virtio.c   |  37 +++--
>  drivers/s390/virtio/virtio_ccw.c         |  38 ++---
>  drivers/virtio/virtio_balloon.c          |  48 +++---
>  drivers/virtio/virtio_mmio.c             |  36 +++--
>  drivers/virtio/virtio_pci_common.c       |  69 ++++-----
>  drivers/virtio/virtio_pci_common.h       |   9 +-
>  drivers/virtio/virtio_pci_legacy.c       |  16 +-
>  drivers/virtio/virtio_pci_modern.c       |  37 +++--
>  drivers/virtio/virtio_ring.c             | 177 ++++++++---------------
>  drivers/virtio/virtio_vdpa.c             |  51 +++----
>  include/linux/virtio_config.h            |  76 +++++++---
>  include/linux/virtio_ring.h              |  93 +++++++-----
>  tools/virtio/virtio_test.c               |   4 +-
>  tools/virtio/vringh_test.c               |  28 ++--
>  16 files changed, 384 insertions(+), 394 deletions(-)
>
> --
> 2.32.0.3.g01195cf9f
>

