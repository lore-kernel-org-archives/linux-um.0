Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C05FC79FA0
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 08:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qlpA25HriXdx9v6T6FYmtvmjD7yzSHEf8Vv9SuYbJrQ=; b=sH5xnoru9pdVBBZP/xUAbBlkNe
	a1a8+0am9y+Cus+PyKIpN43kdqunUH+KyoHLSSIT+TmnbJWNkJ6kOZjXrazoxjqWnhjeAV2Lkqxzm
	YJKcVn+ril9pClvCEWJae6SyMRh8e5tF0RybsQVCnZq9+Ihi/9BRwVBYHN2i1yQGJNMzWx4Inb+Kh
	N+xF67k+53Dz/hvPwdqwP6wvOkYbikWTfOvmI8SokJ1zxbLHuySNFGQNxrVzK1bS5WM28RtGINHhv
	++bej7bDK7apZ524rwk7x9NrNzG/TDALSp33DC4Jw/Sg2PR90Sun/hsfmmtw6WHQP4x2J72YNipsI
	bUsXhmpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3qqx-00000008Li7-1DSa;
	Tue, 08 Sep 2026 08:06:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3qqu-00000008LhT-3YHh
	for linux-um@lists.infradead.org;
	Tue, 08 Sep 2026 08:06:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788854807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlpA25HriXdx9v6T6FYmtvmjD7yzSHEf8Vv9SuYbJrQ=;
	b=agqUC0k3rfHzEHi/BNs8nDCpNVfMLArazlyCV5N1zSj+YV4+qXFkO3UgmsWMOrSM2VEMd0
	zS8IHuhyYRQpWdgHuvl3UzqHb1e04JKR5E6BCOnJZLw5Q86k8zpZQZXNzgyxIHKUMR2d2h
	xG23I1WTxi5JtxnhSVjfoQ9Czt3GyHY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-Ruh1DUVxNDGW1IA7Pg4IQA-1; Tue, 08 Sep 2026 04:06:46 -0400
X-MC-Unique: Ruh1DUVxNDGW1IA7Pg4IQA-1
X-Mimecast-MFC-AGG-ID: Ruh1DUVxNDGW1IA7Pg4IQA_1788854805
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49b8c651ac0so62202615e9.2
        for <linux-um@lists.infradead.org>; Tue, 08 Sep 2026 01:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788854805; x=1789459605;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qlpA25HriXdx9v6T6FYmtvmjD7yzSHEf8Vv9SuYbJrQ=;
        b=b8cU6XDAVT2B3sgE3Hrz/a+ksKbEofVlA8heEFDIWKlwByDi2IRRUnI3ceh2qcx/GB
         V43zA4KCOft98nHgaCA4f3YGlys8vvIH1jzzYOGUg6m9MMwa6JAr8PfOEWInTOKQZUQi
         PJ0nR9p+UfrRitBRviVDOfdM21nA/pt0v3eg19lCrbiXVmYOKlNht+8BLncXQOCmHfSb
         Ut5l+OPF94yKSHdCfexZJlM22YoSlnNEXWLC0+qQL0O1jM50v4ev62FPZOVoKxJkbgXL
         fuvbDF7vVsljJyYZUI+Z6tU7G4vpUVSIO09AFsiILCaxlgOt6JmgyuXUqllEDsELIFEf
         yL4A==
X-Forwarded-Encrypted: i=1; AKwUvByaS7jEEa178NNhmaNu8X8a3jaJvOgVoGzivupzmb0TVFz5JFuYGz+FiGBYCKtREpkHXc8cXxlAZg==@lists.infradead.org
X-Gm-Message-State: AFuF++l+PBhHxuZibnfUT8WzdX0hESCD462nkAoC/AQl3ttwQBOkdDYM
	vjQOgc7YZg5gKO+tit7aQ8mn2GoWlukP4etbdkB8sCBGyZl9WElZcAs/8L+sGfaDPSOye+FuykZ
	2gwt9YpSeKksDLazYe2zdfyJUe29KsmL7B8zBhqwXypwhAdYCR1ivykKC+9/ErhCzjA==
X-Gm-Gg: AYBFou1jbsvoPtZCrkKpFzLId28EcZlsCZ8H/cRWTqYAdVRFGa4o0Zig7H2LjPsp9qd
	OqGV0kW5bZM+7LaY4o2qfkGViRgEjKfzWXyWEgw0UeE8SlwJnmd84TAepe8BFaojko3hw5ky1lc
	wOmFY8RaOK+HSRns5d/l2IwkD3kYncZC1textOcksmFkT0zy2s6Sbc1HjNiS6TnNwznfQiahcRF
	xs4iPK77rGqHL0zIBHev2KWdSocm2G9WEa8+QP4dXZVhVm1oGGpSFPlco082ICsr54rU1V78zQs
	/iffjPz/9PbmTWXvS7miG38+S3wYnRPRAGDuihHP/zAT0TCLYZXWtgUyOpYhgScnl/bwPQnsJMb
	S5jtmeMPg4TxdEyrSyTVOUjE=
X-Received: by 2002:a05:600c:6209:b0:49c:fed6:cd3f with SMTP id 5b1f17b1804b1-49cfed6cd4dmr208433925e9.23.1788854804733;
        Tue, 08 Sep 2026 01:06:44 -0700 (PDT)
X-Received: by 2002:a05:600c:6209:b0:49c:fed6:cd3f with SMTP id 5b1f17b1804b1-49cfed6cd4dmr208433115e9.23.1788854804098;
        Tue, 08 Sep 2026 01:06:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d08144037sm282102195e9.7.2026.09.08.01.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 01:06:43 -0700 (PDT)
Date: Tue, 8 Sep 2026 04:06:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 0/6] virtio: fix and add callback synchronization hooks
Message-ID: <20260908040141-mutt-send-email-mst@kernel.org>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6sPo4LuTEZWbPkqX_ktZeAIiclMOHTyanLgZlRLNtP4_1788854805
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_010648_961396_33B1A0CA 
X-CRM114-Status: GOOD (  33.15  )
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

On Tue, Sep 08, 2026 at 07:38:11AM +0200, Karl Mehltretter wrote:
> This is v3 of the callback synchronization series. It is based on
> Michael S. Tsirkin's linux-next branch at f49e6cf91942 ("virtio:
> synchronize callbacks after device reset"), which already contains the
> core change and the virtio_input teardown reorder from v2.


Pls note I dropped the core change for now.
That one needs more work:

- transport changes should be separate patches from core
  changes

- shutdown generally needs more work, it should disable
  config in particular just like remove does.
 
- drivers that queue work must have a shutdown callback to
  sync it - that part can be separate patchsets




> Patches 1 and 2 fix two bugs in virtio-ccw's existing
> synchronize_cbs() hook. After a fallback from adapter to classic
> interrupts it selects the wrong lock, and the classic interrupt handler
> only takes the matching lock when notification hardening is enabled.
> Patch 3 adds SRCU tracking for remoteproc callbacks, which can sleep.
> Patches 4 and 5 replace the RCU fallback with synchronization against
> the UML IRQ and the TmFIFO callback locks. The fallback already covers
> these IRQ handlers and spinlock sections. Patch 6 adds SRCU tracking
> in virtio_vdpa so callback synchronization does not depend on the
> context in which the vDPA driver invokes the callback.
> 
> The UML, TmFIFO and remoteproc reset paths do not themselves prevent
> new virtqueue callbacks. UML and TmFIFO only clear a status field, and
> remoteproc does not wait for the remote side to acknowledge the reset.
> Without notification hardening or driver-specific teardown protection,
> callbacks can still start after reset. The new synchronization hooks
> do not fix that. The TmFIFO hook also does not synchronize with the
> rest of the FIFO work item outside the callback locks.
> 
> The virtio_input loop change from v2 (continue instead of break, so
> events the device already completed are still delivered) and the
> event buffer leak are sent separately.
> 
> Changes in v3:
> - Rebased on Michael's linux-next branch. Dropped the core change and
>   the virtio_input patch, which are there already.
> - Split the virtio-ccw fixes out of the core patch, one per bug, and
>   the transport patch into one patch per transport. The CCW and TmFIFO
>   changes are functionally unchanged from v2.
> - Patch 2: added a Fixes tag and described the existing shutdown
>   case. Removed the dependency note on the core reset change.
> - remoteproc: read the queue pointer once in rproc_vq_interrupt(), and
>   synchronize with callbacks in __rproc_virtio_del_vqs() before
>   freeing the queues (Sashiko). Place vq_srcu next to rvdevs so the
>   hunk also applies to mainline, which added attach_work after index.
> - virtio_uml: compare against UM_IRQ_ALLOC instead of a bare negative
>   check.
> - virtio_vdpa: use SRCU instead of a per-device rwlock, so the
>   callback tracking uses per-CPU counters, and cover the config
>   callback (Sashiko).
> - Rewrote the commit messages. Corrected the RCU fallback description
>   for UML, TmFIFO and the vDPA simulators. Dropped the claimed simulator
>   reset race: the simulators disable bottom halves around virtqueue
>   callbacks and serialize reset with the worker's mutex.
> 
> Changes in v2:
> - Moved callback synchronization from virtio-pci into the core, as
>   Michael suggested, and added the missing synchronize_cbs() hooks.
> 
> Testing: the changed objects build with W=1 without warnings, with
> clang on arm64, x86-64 and s390 and with gcc on SMP UML, and the
> patches also apply to current mainline and linux-next. The runtime
> tests from v2 were not repeated on this version: the input, rebind and
> shutdown checks on arm64 MMIO and x86 PCI covered code that is
> unchanged here, and the remoteproc and virtio_vdpa hooks have only
> been build-tested. No remoteproc, TmFIFO or s390 hardware was
> available.
> 
> v2: https://lore.kernel.org/r/20260905152059.89560-1-kmehltretter@gmail.com
> v1: https://lore.kernel.org/r/20260818040433.66986-1-kmehltretter@gmail.com
> 
> Karl Mehltretter (6):
>   virtio_ccw: fix synchronize_cbs() after interrupt fallback
>   virtio_ccw: always take irq_lock in the classic interrupt handler
>   remoteproc: implement synchronize_cbs() for virtio devices
>   um: virtio_uml: implement synchronize_cbs()
>   platform/mellanox: mlxbf-tmfifo: implement synchronize_cbs()
>   virtio_vdpa: implement synchronize_cbs()
> 
>  arch/um/drivers/virtio_uml.c             | 10 +++++++
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 15 ++++++++++
>  drivers/remoteproc/remoteproc_core.c     | 12 ++++++++
>  drivers/remoteproc/remoteproc_virtio.c   | 37 +++++++++++++++++++-----
>  drivers/s390/virtio/virtio_ccw.c         |  6 +---
>  drivers/virtio/virtio_vdpa.c             | 34 ++++++++++++++++++++--
>  include/linux/remoteproc.h               |  3 ++
>  7 files changed, 102 insertions(+), 15 deletions(-)
> 
> 
> base-commit: f49e6cf919425cc55f10fd7cda7e0fc895df4cc0
> -- 
> 2.39.5 (Apple Git-154)


