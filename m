Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99608C79F8C
	for <linux-um@archiver.kernel.org>; Sun,  6 Sep 2026 06:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uDjy72BsvDFpaL9e5tQovRjuStP4IqOhC4YA9r9skOM=; b=JmWZsNwlrMsviCAHpWdiCWLk4n
	rFZoYNblvXYTKQrQc6Bsuh0hlhpd1n6ETl23b44wxs5Pxtlr1I7CkcwAglHtOZ9+WQs3AFPqJ+nHp
	fQ9ikE2l4jrtTxUWiwwc+UicZZXUaNNbCdpDXjZqjvBWRe9QDTc/anLTVGcWgEfb57okYOQ3e4kRK
	PRomO4lW2OuzOoXxRVRoUNl8aKRxexe7XaMwK3r+1VQdiWH5Y73JyUS3O+rDbX77vnvfZf3rz5Rvv
	v27LqlTxx1zTKCMuIzmoJF3FpDqGzPdTlzvkhLxOtwVEA/rZ9zfz4fiprCHExEQ8xHgoLdcYibagf
	UlD6AVhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x36kh-00000004mmL-3aw8;
	Sun, 06 Sep 2026 06:53:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x36ke-00000004mlx-46Y1
	for linux-um@lists.infradead.org;
	Sun, 06 Sep 2026 06:53:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788677596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uDjy72BsvDFpaL9e5tQovRjuStP4IqOhC4YA9r9skOM=;
	b=L1cEVRh0SVxMV34G4AgXrG99tvKFjtkXZ1G4TfE87T43PIMq8Q1f4LWCvzDQKmGxBi/vhf
	H4m0MRa0Ownb3mJ94wd0PPwby3KH8npNbEiL5MayCEewn2cdUnGfsBpRFv9NHPL3sqPwnc
	4TX1hnK4eo0Ub4MU2SYqLKo6i6bKavU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-tbrMztXQPSinqSuzc8QALQ-1; Sun, 06 Sep 2026 02:53:12 -0400
X-MC-Unique: tbrMztXQPSinqSuzc8QALQ-1
X-Mimecast-MFC-AGG-ID: tbrMztXQPSinqSuzc8QALQ_1788677591
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4858e4b3e92so801732f8f.3
        for <linux-um@lists.infradead.org>; Sat, 05 Sep 2026 23:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788677591; x=1789282391;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uDjy72BsvDFpaL9e5tQovRjuStP4IqOhC4YA9r9skOM=;
        b=QWbH2GMXd0V4R5BRNsPhHUli2FHFvsLZ0qPqYqve8F6QteiiNNxRPMmUelalVyjbTG
         tAz7dvKqza1AB9wnFcNqBhX3TT79Qxfay7ZiPPyTOFtFnQtIZdFsnlscHeUQW6NCcRBR
         Gs3WbvqQwTNiuyIms1qZVEiWWpP5fkQWnw7q7UrMsumuYZTo/AeEncyyC97vUb4Tu0jN
         E2fxLoidCPjTK7kz4UUySiqkMbchDbGKtUbFpwldk0ZuRvp0TU7+licFyYUMSW8TmIPa
         L5wSJ8j0alEFkvmZAJTfrBRO/mOr2HS/T/jbq2FEMxPEyK/bY7etA38p9sshkd2RmjEP
         7dJA==
X-Forwarded-Encrypted: i=1; AKwUvBx+pr2QJfy9MOjRPQu9UyOL9IzA8fbsHIlOBcVTYm8q0wuDAx7q4yl92qR9kzQdlaWCF9VV8AbByQ==@lists.infradead.org
X-Gm-Message-State: AFuF++mCNbma+sFIvZ2z1/2wrwKa/6itPbUm/bMEH6Fm+ywr2ZfhlUJZ
	3Iwpm3lPEwxAVqDXjyNU5dHlsofMobimXUZkTfudPlTk5OytpeOwVHYovuJFVLDRUkbw8/+fL74
	vFFtOD8Za1/KXrvGG+Nrg9pvTDgaITnIxQiDZc8NrE/C2tSOBxQ3c8+6HU6W4i6JB/A==
X-Gm-Gg: AYBFou3DcqdMKPR1elhB3tbOfVjUxV/2v8Khk2ZBoymobuaSALp4eF5uU0L8VtRo95c
	BMRQoiDeHcQ+lpUb6X/dAPEIj/3eD+yVNt/+F3l1vQoappXh/PFa4hR4Z1Phr1YYDA4KIfDg8dL
	9qgA7r9GUC6cIBdoH5j3y02MxT7KAEeZwn53vJwmTr3Baf8Asp9oxz9lXBiQsxWuPJeY2y9og57
	rIoVe0nhA5v90sn3ChiyThbwHi4CvLlAPi+qhKuV7PKhoIktFicRYeF4JnEfuYQ91sdGMVx4WzV
	8CyFq6dR6kwk0VR27UWvrCxBg7ZQ/srN+chNBmfSe8zJuoxPoUwzcCDsTI20/8KHW4IsZ96qQBd
	3ajpGnsAszLjGxPpIofIpvso=
X-Received: by 2002:a5d:64eb:0:b0:482:e4bc:51a8 with SMTP id ffacd0b85a97d-485870899cfmr18773113f8f.7.1788677590870;
        Sat, 05 Sep 2026 23:53:10 -0700 (PDT)
X-Received: by 2002:a5d:64eb:0:b0:482:e4bc:51a8 with SMTP id ffacd0b85a97d-485870899cfmr18773081f8f.7.1788677590394;
        Sat, 05 Sep 2026 23:53:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883acd33sm18455464f8f.18.2026.09.05.23.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:53:09 -0700 (PDT)
Date: Sun, 6 Sep 2026 02:53:05 -0400
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
Message-ID: <20260906025249-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hc1v29zKPXT1dbBow0p8Rg-qUy_H16dEd0ydrTpJoeo_1788677591
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_235317_112013_C3E1C84C 
X-CRM114-Status: GOOD (  27.07  )
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


You didn't send patch 3.

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


