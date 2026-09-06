Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6D4C79F99
	for <linux-um@archiver.kernel.org>; Sun,  6 Sep 2026 06:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JFzl9H4Eb8cyafOk0wAUSRBkZEcWcFmHLhnYc0Tm+4s=; b=gIskvzfbUOOkwQQp5wDzVf4fSU
	etV8cM7RIQ0Talxqg2x6gJr5/FGJWrz9jaLjwdj7qIU8fv5wJbtTRkg+/5fX004wnpGA3JegFDINj
	TmWGgYfoXMXGuJeuWJDmBiBb5lSqdtFa/VfIDP90r+8Yp6HyXC6RvDOdDuSIse7k4vdJ+jMYahO+u
	YC9qbo77lcU8hjxLeIWdTc+wKlib9vn14X4YfX2ZoGsVyVCjuBG+H9f8rXdJHvK3aJniBiSzcz8BL
	cpApm4EAgz3jUab7l31GfQlE6HtSpWrc1HwyMh1gtSyXQ4bxVDQ1+XLD4UCtjxtIgY/cH3J+zyeet
	FlMsgLpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x36bH-00000004m1i-1NPc;
	Sun, 06 Sep 2026 06:43:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x36bG-00000004m1c-1Zba
	for linux-um@bombadil.infradead.org;
	Sun, 06 Sep 2026 06:43:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JFzl9H4Eb8cyafOk0wAUSRBkZEcWcFmHLhnYc0Tm+4s=; b=K/tE9qSHSlp9I3W584GXza2q4+
	4k8Kvqy8LJHooOaR9fb/SxsTGEzXq/6H72xlCLhBwqIDg6IxBhm2QpDq5VdnKNMU3Iy5tBjn521CL
	Cv/VKl2AfVMo0xI0ZXNjRAMqh8ifbHDtZkRfabmzzziVXQl3vTLWbClHQGyGdqh2NB/j4WuiJkUZq
	RljAhzoRTLMcr7OFczJd6MjI43lPcssW9ESDINbJmnAG984xo99i5sbPMBkttRRNE4ZbTqxJA5YQR
	01apvX/amBxmT7Miobu0lDx10eSNAyVN/VbbaT8mWKkyMwXAfzfDTABc8JEWs+as9kDVY1NVnKTQQ
	x4Sjs71g==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x36bC-0000000FIlX-3cdh
	for linux-um@lists.infradead.org;
	Sun, 06 Sep 2026 06:43:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788676999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JFzl9H4Eb8cyafOk0wAUSRBkZEcWcFmHLhnYc0Tm+4s=;
	b=Uxcy9YIwquXIIqPL/rfcOkhJjwAAPr1JlAejFl864q0EAQEbben2CQwvAwdpYqk02wU7tT
	OZp1wMGT52BoFO5d8PqQuA00xDm4jziJdyTTVhtKtkAg0DfDhxtwC2K3jR0dyVySXO8D1/
	syTKNANQayH7gbF193rmVTi+t8Iqk5g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788677007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JFzl9H4Eb8cyafOk0wAUSRBkZEcWcFmHLhnYc0Tm+4s=;
	b=flH3RTAhZTcrgxiTIMuyzuVOioE6FPR8ooIs6Iah1BR14VObdGRieo1IerDxkJ5J/V0wzl
	jskboNQDuXeOHXm1PwEfn+UDV+UbJ67hOQDoqUbVGx2j6YWEuo2SeVisJ7lWx1I4M9MTwq
	/bG7UuALhyoY1OSOVEZhlz0AOjIKYsM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-WAzl-NnnO9maqeO41Qr63g-1; Sun, 06 Sep 2026 02:43:15 -0400
X-MC-Unique: WAzl-NnnO9maqeO41Qr63g-1
X-Mimecast-MFC-AGG-ID: WAzl-NnnO9maqeO41Qr63g_1788676994
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-482f41ca436so1975394f8f.1
        for <linux-um@lists.infradead.org>; Sat, 05 Sep 2026 23:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788676994; x=1789281794;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JFzl9H4Eb8cyafOk0wAUSRBkZEcWcFmHLhnYc0Tm+4s=;
        b=ApikFh0YXVi7gBqUpnJirnz5RxifM3HUnwCGPh4tt7M2cPRCIOxzKz+jmlNmX9qnRX
         eBC6tAoC2w8ZyDXZrsiLM1ZFh549IRy3JDCb68A28KrhQg7RnzNHamiBLMjFF+3UwD2u
         Twxy+xP3xq3t7V8XslDKiInE1EyfWVdiFIg9eFJjzf+433OJtK897leBP0ILm/LKB2yK
         zDzts91iGiWTRXfNxHYaHIBY0NaUNJ8rcbQyZcMBxYfdpnnRv6AqogE1bCmBCh1ANs8q
         xyzQ+x/LznYIVk5PM48cd+d8xBUMptuV/C/Vq37XgyC8n0KsFfa2YgSCNhAy+GOn7UfA
         QL3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxM8VXc/UQ9Bev9B6DHPGjm2c7P5ZAaoAZ1BBCmMqE4vt2RWMvwyFIshVHZw3RK6aKcGBHatwnymg==@lists.infradead.org
X-Gm-Message-State: AFuF++nNbMygwBUdHZ1qSOKhDM4Yel9xKXuproHMFDir60LZtZu+hDN4
	AF00bnez1rCFPl+gsh0DMSCLHwe8ohqE9zFcO5C5GNGZL9iUCdKVKCvyYDSgRNh2gYGXaBgkKHE
	Tpnpt3WAwD+ACXKUlHkVG+7aISt5WTPRPVhcTrmQ8Z030r50a3qqiry5Nvq7ohr3djg==
X-Gm-Gg: AYBFou3C0IEgxvvux/RUm8rFz1/nBdRW7LayZLivM/x18cuVAqe5zAeIKLf2krgEW3j
	dxv4h2j2kN4xIQuONTK29ZeWtjP8qDg00RIOhonl/XqwuAelzLymqX7peFvbeJNOQdvZCmOIjG9
	F7cPaktyINnmOHutrJE5NqrnnJe8xGnh8Xb9NvSFISvBSMUUCGWDP0U9Qhdod/8GoCZH2ADdAvo
	+rDufgrskhS+2prVxYT2HaIGtYmNtEKNs41lMi/CWTejwzzyeEERNQ/DmEsUvh/8mH38lbB6CBV
	G5YN7IZrup2TUo8w4mKwf+3aLxdYBJjsOQ7XN8Hn+DrjO9TzK6hDu3piI6Uo9+p3amtms0w2lff
	ohwvV60NHG+GK05/4K5ySvHw=
X-Received: by 2002:a05:600c:3b18:b0:49c:fa21:1c8a with SMTP id 5b1f17b1804b1-49cfa211d97mr124000005e9.31.1788676994408;
        Sat, 05 Sep 2026 23:43:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3b18:b0:49c:fa21:1c8a with SMTP id 5b1f17b1804b1-49cfa211d97mr123999575e9.31.1788676993918;
        Sat, 05 Sep 2026 23:43:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm648354005e9.0.2026.09.05.23.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:43:13 -0700 (PDT)
Date: Sun, 6 Sep 2026 02:43:09 -0400
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
Message-ID: <20260906024233-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: he2le2IAhEs8i1CGtGWnWq3sPZFK-D_uwAr7KmcDfHo_1788676994
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260906_074331_413313_EAACF2A2 
X-CRM114-Status: GOOD (  27.24  )
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
> 
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

changelog?

> -- 
> 2.39.5 (Apple Git-154)


