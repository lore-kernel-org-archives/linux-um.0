Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069C8C79F89
	for <linux-um@archiver.kernel.org>; Mon,  7 Sep 2026 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5punYBPTQYCYDbZdD+Tip6UD659TFwSyiVivgWnd/bQ=; b=LjtvYBidPYc6da/VHviUeUnpsM
	cA57Ny0VHgHjCg6vj5RLk7oIwDpC8ICDMBltNfQceLPLETCfrJuRuyct/WMaSHUxUSNs3V4rkOBwj
	kFX0l/OnGrDdYivpWQv2kLD3oUpUL6+B8JsYn/yF4RZ9++LsfAuXB+VMB/AS8/tF/aaPgp9Lw7nNV
	qk2z5ixUKPU7dDIj4ci4PQbBHo4Hu67KF06suAl1+6EA/thvoLl6Gdi4z5HVkdVFkwvp7PDGp2EpY
	LQAtzWWiLoH3eIYM3pSMFMMKdQZzqwdhILd/IVuycpuwL/yl005JQSZsvTH3XgLPv5egKST8a+fsN
	emuFENsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3ZAN-00000006uJy-2XHt;
	Mon, 07 Sep 2026 13:13:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3ZAK-00000006uJb-2gOk
	for linux-um@lists.infradead.org;
	Mon, 07 Sep 2026 13:13:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788786818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5punYBPTQYCYDbZdD+Tip6UD659TFwSyiVivgWnd/bQ=;
	b=IuyNgUJ/fLRGiHz8A0GUMqZGU5dc8xos1XfIbjUWmEXMnzh2pYF1U/elNoU4DdJy3rVZuZ
	vIb4Zf1+UgD3ZuAR6WO9hqZedEcL23ucHQBn8BZyAWZjwEYLB29xnT0hFZ/wYruCLlLYRd
	NsW9gdrsjrNzeFfK1kHZHN/+25QnKQc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-m4bz-DgpOQiW4v2YjGUJsg-1; Mon, 07 Sep 2026 09:13:34 -0400
X-MC-Unique: m4bz-DgpOQiW4v2YjGUJsg-1
X-Mimecast-MFC-AGG-ID: m4bz-DgpOQiW4v2YjGUJsg_1788786813
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49545071724so27732325e9.0
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 06:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786813; x=1789391613;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5punYBPTQYCYDbZdD+Tip6UD659TFwSyiVivgWnd/bQ=;
        b=skn8iS0PDYcZl8BOFoijwISPmGJRdabqOvxyYZomN//9hBnaTxOCwhQhm/+1n10IFK
         OOGuf0gOPajM90FQqgrTdlI0xQnayDQz7RFJ+AUpTK/CLOBjkxzTG2aPWwTgHcsY5MqT
         wojHeRhu8d5m9JTbAY+WxHeZB1bmCdoKJpJzyzIFkhVvzTZNBNtvWI1iWQnktFMXGST3
         FPUHwMHt0/EeKFPZodGu0mELyhtoLseghkOMkAylU72UsU+fh0ndgJrcNX3NEh51Tnoo
         Kw0lrGkj8R4jlaRY0WzhqKIRKkjWOBr2C4QtJPbN32pu+jczcaNEbQIaqsAjPq5mrtmv
         w5rQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRBgSrXn1C4NHLIKqdKAJ/Mc1gTtTvQ1doMP4Xc6h2Kt+v6dT28hHlE66RrH1/Fcs7bYpBt+vKyw==@lists.infradead.org
X-Gm-Message-State: AFuF++l9lumgpiphUlzzTK3CJx6zK1TINrrOh0Np7BnQpWGygRF6KfIa
	MoVbdLexv9TBky0wKZ6+Tdzq/yT97T80nJJv0f+ljpvu9NRUHIQpuRAXvGT7FBq3LGkYcqCgKXp
	ceM13kha0imyDOCAfzVKRR4wBdQgGjNsfPpEutFsLzCOzrUGg26gDOWE/zB7N6d1dTA==
X-Gm-Gg: AYBFou3Yb25KVFqO+7X/ogIQRcd9locOZzJbvanyGd1QZL+mlU89/zQIPaP6/PG/Ia/
	5uu5NSAXy8SSLt1TxuIcW1kAWBqVednvjOEtfUtRNbf9hn/jNq0Xn2dQUS2MLnA6eaJwOVGa8iW
	xnEdxV8BX6nLJp7AKGN3z3ozk95040U+QpAAIuFGWq6EU8oYAQeIvd5mgXm65NAlG1pqVugadVv
	ylJDejv3lV73bKtg7lEu0W0G0ww2BBxuVtP9iNIpcq5pfxSRhI4eog3/ciFdaylH1H6uraWmHqx
	Y9hFuSptbyNw+u+c6aSa297sm2Ypg8wwcc31/ZC5TGJ3dPKKktF7GC8E9T07xBeiTEhE1f/TpkP
	mAHHz5giz7cEnrLkXd1R38P0=
X-Received: by 2002:a05:600c:4684:b0:49c:fc6c:be14 with SMTP id 5b1f17b1804b1-49cfc6cc10bmr197561065e9.26.1788786813404;
        Mon, 07 Sep 2026 06:13:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4684:b0:49c:fc6c:be14 with SMTP id 5b1f17b1804b1-49cfc6cc10bmr197560545e9.26.1788786812906;
        Mon, 07 Sep 2026 06:13:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm270920615e9.3.2026.09.07.06.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:13:32 -0700 (PDT)
Date: Mon, 7 Sep 2026 09:13:28 -0400
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
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <20260907091033-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mY0vo3zIhT8haPUXqhhY2AePhayeSpzYvHqNz6ocVio_1788786813
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_061340_775890_A19CF356 
X-CRM114-Status: GOOD (  29.85  )
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

On Sat, Sep 05, 2026 at 05:20:56PM +0200, Karl Mehltretter wrote:
> A virtqueue callback can outlive virtio_reset_device() and race with a
> driver freeing the state it uses. The reset helper documents that no
> callbacks remain in progress, but that depends on the transport:
> virtio-pci waits in vp_reset(), while virtio-mmio does not.
> 
> virtio_input has a related ordering problem: it unregisters the input
> device before resetting the virtio device, while an event callback may
> still be using the input device.
> 
> Patch 1 moves the callback wait into the core, using the existing
> virtio_synchronize_cbs() operation. Patch 2 fixes the virtio_input teardown
> order. Patch 3 adds the missing synchronize_cbs hooks for UML, TmFIFO,
> remoteproc and virtio-vdpa. Remoteproc uses one SRCU domain per processor.
> 
> The new hooks wait for callbacks already running. UML, TmFIFO and
> remoteproc still allow new callbacks after reset; fixing that is separate
> work. The event-virtqueue DMA mapping issue is also separate.
> 
> Changes in v2:
> - Patch 1: move the wait into the core instead of fixing only MMIO, as
>   Michael suggested. Remove the duplicate PCI wait, preserve its shutdown
>   wait, and fix CCW callback locking. Drop the MMIO polling: reset polling
>   for v3 and newer is already in fa8833c085b6 ("virtio-mmio: add support
>   for transport version 3").
> - Patch 2: keep draining completed events when ready becomes false,
>   instead of breaking out, so teardown does not truncate an input packet.
> - Patch 3 is new, at Michael's request.

got all 3 patches now. it's a good start, thanks, but they need
a bit more work, in particular addressing sashiko comments.
I'd also prefer patch 1 to be split: moving code from pci to core
is separate from ccw fixes.

Pls write or at least edit commit log messages yourself,
after reviewing Documentation/process/coding-assistants.rst

Thanks a lot!


> I reran the 120-cycle unbind/rebind test in an arm64 KASAN guest with four
> vCPUs and a 5 ms busy delay per event. With patch 2 alone over virtio-mmio,
> reset returned with the callback still running in all 84 overlapping
> cycles. With the series, it waited in all 103. Over PCI with per-queue
> MSI-X, it waited in all 66, including runs with threadirqs. No KASAN or
> lockdep reports. These runs predate the per-rproc change, which leaves
> the tested MMIO and PCI paths unchanged. They confirmed the missing wait,
> but did not reproduce a use-after-free: with evdev attached,
> input_unregister_device() waits for an RCU grace period that the IRQ
> callback blocks.
> 
> That version also passed QEMU input, rebind and shutdown checks on arm64
> MMIO and x86-64 PCI, including arm64 RT, KASAN and KCSAN builds, and x86
> UP/Tiny SRCU. A legacy INTx NIC was present for an additional x86
> shutdown check. The changed objects built with W=1 without warnings on
> arm64, x86-64, s390 and SMP UML. The per-rproc version built with W=1
> on arm64 KASAN and x86 Tiny SRCU, and passed six remoteproc callback and
> lifetime KUnit tests on each, using mock remoteproc devices.
> 
> Link: https://lore.kernel.org/r/20260818040433.66986-1-kmehltretter@gmail.com
> 
> Karl Mehltretter (3):
>   virtio: synchronize callbacks during device reset
>   virtio_input: stop callbacks before unregistering input device
>   virtio: implement synchronize_cbs for remaining transports
> 
>  arch/um/drivers/virtio_uml.c             | 10 ++++++++++
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 14 ++++++++++++++
>  drivers/remoteproc/remoteproc_core.c     | 10 ++++++++++
>  drivers/remoteproc/remoteproc_virtio.c   | 20 +++++++++++++++++---
>  drivers/s390/virtio/virtio_ccw.c         |  6 +-----
>  drivers/virtio/virtio.c                  |  2 ++
>  drivers/virtio/virtio_input.c            |  8 ++++++--
>  drivers/virtio/virtio_pci_legacy.c       |  2 --
>  drivers/virtio/virtio_pci_modern.c       |  3 ---
>  drivers/virtio/virtio_vdpa.c             | 21 ++++++++++++++++++++-
>  include/linux/remoteproc.h               |  3 +++
>  include/linux/virtio_config.h            |  6 +++---
>  12 files changed, 86 insertions(+), 19 deletions(-)
> 
> base-commit: a500db7819c50db59e55f1b4fa1c3baa5a2616f3
> -- 
> 2.39.5 (Apple Git-154)


