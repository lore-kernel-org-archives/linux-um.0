Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1EDC79FA0
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 08:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/cIx/FN1ld5ZUnvvOO4W6SfTMNv+qsyUKpor9qdoZ3s=; b=fvmV+Tt+xhNmSjw5ngxjvJC/KC
	PMCNJggyZGDyikQkhNEOcgGgmxkwaOS78UMRKhEvRB7A26NT+46svKPnvS9XZZ4zB20VFasdYrBmb
	cG6djbyI8V0Xb64tRI5AW1I9q3OXLq1tZ6fImYbttHvhMO0RovsVG8c03Xy8KKUQ7jYpm31lqBrF6
	YGD8ZVWlv0bbTYT8up2p4CJjhKuP7EmZGugXcdOgXvKBziL63s4xaJOAjfFcBirpBntOVcmovshW5
	5tUQ97rU6LygMpNobbwoz9H+xYkecPT2jGkDtzB89jzljn4GiZhWIeh74E16Avo9oruhOb+d5xzOE
	5LZ/G83g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3r9b-00000008OQx-2RO8;
	Tue, 08 Sep 2026 08:26:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3r9X-00000008OQ5-2JQf
	for linux-um@lists.infradead.org;
	Tue, 08 Sep 2026 08:26:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788855962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/cIx/FN1ld5ZUnvvOO4W6SfTMNv+qsyUKpor9qdoZ3s=;
	b=QUKW+cRB1vgNMh8fgJCHLMmXMprE18hgjlH8ruQ4mKP0QEdME0Bd1bp6oFUehRhSOObasJ
	J7EmHViJb1sqrLkkZGzcUu5I1kKHZvnXtnF8P6Ekqhe3jfIfD5aRcz6JqZzj3963hxYzOu
	DKEer3pEpYfvnVv+cuhlM2gVxZon2X0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-t82_dsEBN7SRqK1pbbRKSw-1; Tue, 08 Sep 2026 04:26:00 -0400
X-MC-Unique: t82_dsEBN7SRqK1pbbRKSw-1
X-Mimecast-MFC-AGG-ID: t82_dsEBN7SRqK1pbbRKSw_1788855960
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495569acf8dso26682995e9.1
        for <linux-um@lists.infradead.org>; Tue, 08 Sep 2026 01:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788855960; x=1789460760;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/cIx/FN1ld5ZUnvvOO4W6SfTMNv+qsyUKpor9qdoZ3s=;
        b=SNAVaKaKMMNqvTt+46Sr75/hCSP1j4tYHNgN5m3NFULyGsjtA3XvQvD9WxUdSYveUS
         BQcze71J1WiirpRYulLdCjwLG8Stg5V3B4Cqy5FpInr+Rsx5Yw8I0FODcKckpdfkq3Xp
         EXocE9a3Y1/l7rkjGgG/NzjYxbcQohbfNFuQoo93vBvteSP85CQnmxK++s1QHfIj4AeH
         MqY9/nzwkNun09ik1Yor4xV3cD32BUgOR+HeaTIse8X4egueS5YMVAhwooB1iEbsNDgD
         0uQkiOWGz+2vwUNy5tNzSBNIW1BidyOUk+h3LrW2aPSoCoPH46jCCnG0UjwdgiOnNSsY
         fqpg==
X-Forwarded-Encrypted: i=1; AKwUvBzae+OLGCMosG1CxjAVbjAVzJwxhn7LuczBvvsnNFna2nN518YslBT9tYl7lrxksHVJrR+s8k6PvA==@lists.infradead.org
X-Gm-Message-State: AFuF++mRC4te8EuhLD5f6hIUOJVG8IHEO3r7TJJJM+beYbJFyaZvRK2H
	6Wn5lNFyekVeeK/b4p0s4E9Cm9JAZFPxVgGmHMkTV3ULKUMVsGiusda5jQCt99Yw42Cya+qUBUe
	sePAnlSaOFd4J83+JSJVlBX0vkc6zWLxn0hxK4CQO+XLVSDplbZGGBfbnU6BpC9GySA==
X-Gm-Gg: AYBFou1gOmlTlkpuX9yibdyB8mFhl9Tohj3hbhJrYEdgrX7FVNQiY04bxwtruW9HoqW
	NmbMosOJCsj0RV2kDE9zOOxgU/iwQabc714lGdGgWo+m+LldH4w5kIBxkKSvchzsJyx59TrawwF
	v3I3zwccb5j3bkF3YH00ijG68bmskSRnAi5SXlX5s3oJYmEELXzQM1xe0Uhs4JEOIUdvXfEqgF8
	hco3A78SkTLqo+hw8KGH+4sE5ezE3vkhnGXpElm2IzR9pl0Om5yEQeTfegIHOgOY8ugUWwxAzgF
	QPVop3BfK0yrftMo6pydLQhjQtsrq+dkZEtQ5RDpRNdiXZML30wMbzJjM7QgJYFpgN1HzYX1Z5q
	QDd0ky8fF3cT5Hae51BbDi2M=
X-Received: by 2002:a05:600c:c4aa:b0:49c:e3c3:5efd with SMTP id 5b1f17b1804b1-49cf8241a84mr469629035e9.9.1788855959346;
        Tue, 08 Sep 2026 01:25:59 -0700 (PDT)
X-Received: by 2002:a05:600c:c4aa:b0:49c:e3c3:5efd with SMTP id 5b1f17b1804b1-49cf8241a84mr469628205e9.9.1788855958792;
        Tue, 08 Sep 2026 01:25:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d04fe7f9dsm275644125e9.0.2026.09.08.01.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 01:25:58 -0700 (PDT)
Date: Tue, 8 Sep 2026 04:25:53 -0400
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
Message-ID: <20260908042440-mutt-send-email-mst@kernel.org>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PzVVkp-IIut9-4iMThREdhtYbiOz3J0lB2ucH3QguxU_1788855960
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_012605_168478_339CAB05 
X-CRM114-Status: GOOD (  33.20  )
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


Thanks I applied since this looks like a net improvement.
Pls keep iterating on the core change.
If you want to take a stab at some of the pre-existing issues -
will be welcome.
Pls do note which patches were tested and which were not.

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


