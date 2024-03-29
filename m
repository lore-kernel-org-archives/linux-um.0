Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538FACD11DD
	for <linux-um@archiver.kernel.org>; Fri, 29 Mar 2024 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+BsDTTyNU5pgUTxWeniUBybyV1pHa+zj3gLQFOaKcJw=; b=mscBevZnqdNs7mRl6uKoxFqDhz
	GMj9XuUtD6Lbc7eWROvuiMHkmbWraqGwDgHXPfJgQkvN8I8hA0grYXWPlQeO7/L4Pp6DqdmhFZxHa
	EB7uWSSggGr4J4t0WmyhwIxsQBwIGD4HDQtnL2hVk9sXSkZBTPMiZMEX9cxJFy3L6YVJdkDHUqPsD
	AP+0X7Jrmx5IjcplIwo2hiEP+Xnw8ulV+R50ow0p5ys/FTlQ5clCVYItyonAQEzs37BRWCpJleECM
	lKEJo7u4PGbehvlrdPmdmHmj7hS6BzBiZq6WaGAoL7bBTyu3Lb54y7CBXFJUxgbg3RFK8N4Yw6Xf9
	sJJhKtAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqAcp-00000000Dl0-1FY5;
	Fri, 29 Mar 2024 11:42:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqAcm-00000000Djl-0B9T
	for linux-um@lists.infradead.org;
	Fri, 29 Mar 2024 11:42:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711712538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+BsDTTyNU5pgUTxWeniUBybyV1pHa+zj3gLQFOaKcJw=;
	b=XLABrnXRSolT0vceLyGVBE+H8tmnoJucjQkXgGm5dGhzmbe0PHjzXWegDjl/dH3F52wgXz
	s8P7CvQ2OgvHo91ewidlrjPVmcPOzvQX8CAx6c5AXRIR1IZRRX9HJLW8VmgjV/yoNiVKKq
	kc7vZTvsGb8cj5DOiQE3wPulhCNzZLw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-XtKHJm0TOECPZk3YMwaejQ-1; Fri, 29 Mar 2024 07:42:16 -0400
X-MC-Unique: XtKHJm0TOECPZk3YMwaejQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d6c8f170e2so18982071fa.3
        for <linux-um@lists.infradead.org>; Fri, 29 Mar 2024 04:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711712535; x=1712317335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BsDTTyNU5pgUTxWeniUBybyV1pHa+zj3gLQFOaKcJw=;
        b=gBOAkfVcSi8oPREUePfkv7/A1YjSz+A+Y2DVtoF5ssZ2m9E45y2MlT52QWlJHxSNiK
         4abOiGsksRjOJcREBaDrKaBnwM5fFus5H0cE7ZEqG9OChnx7Iy54f982pV7DAOzbyYt3
         TK7cv5F26eu/6TcUCNbU8Qu+d1T7zG+JKQR37J6Y3/deSDqMe41E5iZSa/cH+ug65Ntc
         VbGlNhJKsD1K/uAY8NjFJH/0fMpoA27OIc2jRl2SyWcGCarUvMqNPSeBgFE3KdxSo6kw
         GvlZ0L/TQZBt0xIab7vk92CFunxJvOhuF/cwILBDDcRXFB+Ve8QY5SuLFIrQ6tlDOhqz
         yX0w==
X-Forwarded-Encrypted: i=1; AJvYcCV09RMlLUzsD+t4ZJzuRFL8Y9zGmI+L1szZEgeFgwPoroqtSREZ4HnAO3ji23fh+zkiG/8YIeB4ex9FPCHgqFXOFILVVW7hbBoxoh7p
X-Gm-Message-State: AOJu0Yy5G5Niru019d0p/wc/2ExN63QEe/2tgDjUY+xctxxtW3FNI6Vf
	3IOFtK3A27A9DjWxBEw1Sef1xAKocZLG4Vv6h0Sx2x0gMPWsngpo8PGAjGLk9LO62m62ghlCKP0
	Hzx3nnDqv2+kfvMRfJHhd0WFEGDE0yV+MCpoPH/oL874WeMtR9uI3VDM9524tYA==
X-Received: by 2002:a2e:9659:0:b0:2d6:e148:2463 with SMTP id z25-20020a2e9659000000b002d6e1482463mr1428695ljh.24.1711712535130;
        Fri, 29 Mar 2024 04:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEACBjwkvqDUtHOsu+pH/smraarLJWyQq+BtaLZf+sEYEs2CGiOj/cy+sTyYbp3cXHSv/vHng==
X-Received: by 2002:a2e:9659:0:b0:2d6:e148:2463 with SMTP id z25-20020a2e9659000000b002d6e1482463mr1428676ljh.24.1711712534737;
        Fri, 29 Mar 2024 04:42:14 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id s7-20020a1709062ec700b00a46abaeeb1csm1837128eji.104.2024.03.29.04.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:42:14 -0700 (PDT)
Date: Fri, 29 Mar 2024 12:42:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Kalle Valo <kvalo@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Anton Yakovlev <anton.yakovlev@opensynergy.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	v9fs@lists.linux.dev, kvm@vger.kernel.org, linux-wireless@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 01/22] virtio: store owner from modules with
 register_virtio_driver()
Message-ID: <oaoiehcpkjs3wrhc22pwx676pompxml2z5dcq32a6fvsyntonw@hnohrbbp6wpm>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
 <20240327-module-owner-virtio-v1-1-0feffab77d99@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20240327-module-owner-virtio-v1-1-0feffab77d99@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_044220_179803_99354E89 
X-CRM114-Status: GOOD (  20.88  )
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

On Wed, Mar 27, 2024 at 01:40:54PM +0100, Krzysztof Kozlowski wrote:
>Modules registering driver with register_virtio_driver() might forget to
>set .owner field.  i2c-virtio.c for example has it missing.  The field
>is used by some of other kernel parts for reference counting
>(try_module_get()), so it is expected that drivers will set it.
>
>Solve the problem by moving this task away from the drivers to the core
>amba bus code, just like we did for platform_driver in
>commit 9447057eaff8 ("platform_device: use a macro instead of
>platform_driver_register").
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---
> Documentation/driver-api/virtio/writing_virtio_drivers.rst | 1 -
> drivers/virtio/virtio.c                                    | 6 ++++--
> include/linux/virtio.h                                     | 7 +++++--
> 3 files changed, 9 insertions(+), 5 deletions(-)
>
>diff --git a/Documentation/driver-api/virtio/writing_virtio_drivers.rst b/Documentation/driver-api/virtio/writing_virtio_drivers.rst
>index e14c58796d25..e5de6f5d061a 100644
>--- a/Documentation/driver-api/virtio/writing_virtio_drivers.rst
>+++ b/Documentation/driver-api/virtio/writing_virtio_drivers.rst
>@@ -97,7 +97,6 @@ like this::
>
> 	static struct virtio_driver virtio_dummy_driver = {
> 		.driver.name =  KBUILD_MODNAME,
>-		.driver.owner = THIS_MODULE,
> 		.id_table =     id_table,
> 		.probe =        virtio_dummy_probe,
> 		.remove =       virtio_dummy_remove,
>diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>index f173587893cb..9510c551dce8 100644
>--- a/drivers/virtio/virtio.c
>+++ b/drivers/virtio/virtio.c
>@@ -362,14 +362,16 @@ static const struct bus_type virtio_bus = {
> 	.remove = virtio_dev_remove,
> };
>
>-int register_virtio_driver(struct virtio_driver *driver)
>+int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
> {
> 	/* Catch this early. */
> 	BUG_ON(driver->feature_table_size && !driver->feature_table);
> 	driver->driver.bus = &virtio_bus;
>+	driver->driver.owner = owner;
>+

`.driver.name =  KBUILD_MODNAME` also seems very common, should we put
that in the macro as well?

> 	return driver_register(&driver->driver);
> }
>-EXPORT_SYMBOL_GPL(register_virtio_driver);
>+EXPORT_SYMBOL_GPL(__register_virtio_driver);
>
> void unregister_virtio_driver(struct virtio_driver *driver)
> {
>diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>index b0201747a263..26c4325aa373 100644
>--- a/include/linux/virtio.h
>+++ b/include/linux/virtio.h
>@@ -170,7 +170,7 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
>
> /**
>  * struct virtio_driver - operations for a virtio I/O driver
>- * @driver: underlying device driver (populate name and owner).
>+ * @driver: underlying device driver (populate name).
>  * @id_table: the ids serviced by this driver.
>  * @feature_table: an array of feature numbers supported by this driver.
>  * @feature_table_size: number of entries in the feature table array.
>@@ -208,7 +208,10 @@ static inline struct virtio_driver *drv_to_virtio(struct device_driver *drv)
> 	return container_of(drv, struct virtio_driver, driver);
> }
>
>-int register_virtio_driver(struct virtio_driver *drv);
>+/* use a macro to avoid include chaining to get THIS_MODULE */
>+#define register_virtio_driver(drv) \
>+	__register_virtio_driver(drv, THIS_MODULE)
>+int __register_virtio_driver(struct virtio_driver *drv, struct module *owner);
> void unregister_virtio_driver(struct virtio_driver *drv);
>
> /* module_virtio_driver() - Helper macro for drivers that don't do
>
>-- 
>2.34.1
>


