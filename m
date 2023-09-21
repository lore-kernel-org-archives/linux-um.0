Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AE2E71072
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 14:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IOEu+eeVTscH+a2eIQ2UeoGoZ2GXeaiUHZO4ihMUs9I=; b=KeVS6Odai4pQ2M
	JG6dPNLebVEclO+9yHrIW0OaWfTJl21z/gLZqPN69b99hoczRG9hvDTv1MhXIebirAMQnvtf7edWB
	yM/MeivyuJMOtmMJbJr0KEAnEu35YEcnbjA+r6CkoH1YYIuTi/U7DNwwVCgnQnjm/hvIft3UQwVkq
	Ay/p6ZrhFtvbs5Ukhjo9IKEiKREOxXIoZtcuji3yVcrylvOF6oAwCclXhCXCSNtbhGpaVEkqsECH/
	dfBMoR3c60XSvUS5+e3OcvcHz/dkCwfWuLE7lmT94VItYJFYffiMkgP+L6oFd9H955mOMygyB+J72
	kLJjRW1n72c+v28CEwtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjKJM-006D6H-0K;
	Thu, 21 Sep 2023 14:05:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjKJI-006Crd-0I
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 14:05:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695304991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mYFUdBslfSemlERse4Us5f4NKymG/+Lupcjrt0UUg2s=;
	b=J01xl0oQtgD0OIuoepvLIIMiEPl9OZ6dWHfgar+QqoS5Mboz01aoICvLNbBC4wdL8qsPuk
	QqFFc5jsbRieta4Bw/tlJmx3AfX7gRiXxkk3wXGxhbMGzJ+8BkK0CWhK8MMjgs8VcfB6pj
	fAc8Wd1czP4N3D7B3bqYcWA6hDdYrqw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-f06k96X3NDqt6S4OavcpNw-1; Thu, 21 Sep 2023 10:03:05 -0400
X-MC-Unique: f06k96X3NDqt6S4OavcpNw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a5d86705e4so77008966b.1
        for <linux-um@lists.infradead.org>; Thu, 21 Sep 2023 07:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695304980; x=1695909780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYFUdBslfSemlERse4Us5f4NKymG/+Lupcjrt0UUg2s=;
        b=n3rSbDMfPumcWzHC03f//wifSsA6IX08zax2nk8Z6CSKVkSU7fqs+20S9TaFBnLy0+
         bOoj+n/KE3bd9D+gIRifGre+X7Vo/vvQ5lIckK0jqURY7AFtlOubbGbRs0XrB1Wrj0no
         n9hLIy5sU2a5vulXAsurnGTmFvIU6pcPryJHOLEUHLJqLwX/RkeYPirBuZ99UC9UADRp
         GzufuQwUHfqdH2aWqfFp6JhGID8/yNUxjPQfBbnRPJE1z+b6RLSFRFBQiLAefR7XbQS2
         owqmejXPBkI0Tm/5UFOERc8ZncCcmJNWTQv1cF95qMuCzK/J0URfU3VeQ3OciHVrhUeP
         XBxg==
X-Gm-Message-State: AOJu0YxzmG2ZUr/rh6TiPKwjVqtNsSeNPZxOGgnYTBHMjJmlF9amx5mo
	fIhwwxZ6RecW6h7SZDPqpzpRt5MjS1I1xD6BxrhLpT9jk279DDjm3iB7NJCsVI+GlnHtdBeDWAG
	6az/ZkX4048MHAMea06xgaWrG
X-Received: by 2002:a17:906:13:b0:9a5:7e63:2e0 with SMTP id 19-20020a170906001300b009a57e6302e0mr5496770eja.30.1695304980536;
        Thu, 21 Sep 2023 07:03:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGDrtu0JFw6590Ay/MhiYHIEI6g5Txx1wcLitr4s1+bWtmtSPAeMYJ5QGJ2kmybduZxOWLIA==
X-Received: by 2002:a17:906:13:b0:9a5:7e63:2e0 with SMTP id 19-20020a170906001300b009a57e6302e0mr5496721eja.30.1695304980143;
        Thu, 21 Sep 2023 07:03:00 -0700 (PDT)
Received: from redhat.com ([2.52.150.187])
        by smtp.gmail.com with ESMTPSA id dt11-20020a170906b78b00b009ae482d70besm1079598ejb.134.2023.09.21.07.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:02:59 -0700 (PDT)
Date: Thu, 21 Sep 2023 10:02:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
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
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org,
	kangjie.xu@linux.alibaba.com
Subject: Re: [PATCH v14 30/42] virtio_pci: introduce helper to get/set queue
 reset
Message-ID: <20230921100112-mutt-send-email-mst@kernel.org>
References: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
 <20220801063902.129329-31-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220801063902.129329-31-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_070540_291044_F29EABEB 
X-CRM114-Status: GOOD (  19.69  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, Aug 01, 2022 at 02:38:50PM +0800, Xuan Zhuo wrote:
> Introduce new helpers to implement queue reset and get queue reset
> status.
> 
>  https://github.com/oasis-tcs/virtio-spec/issues/124
>  https://github.com/oasis-tcs/virtio-spec/issues/139
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 39 ++++++++++++++++++++++++++
>  include/linux/virtio_pci_modern.h      |  2 ++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index fa2a9445bb18..869cb46bef96 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -3,6 +3,7 @@
>  #include <linux/virtio_pci_modern.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/delay.h>
>  
>  /*
>   * vp_modern_map_capability - map a part of virtio pci capability
> @@ -474,6 +475,44 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_set_status);
>  
> +/*
> + * vp_modern_get_queue_reset - get the queue reset status
> + * @mdev: the modern virtio-pci device
> + * @index: queue index
> + */
> +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> +{
> +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> +
> +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> +
> +	vp_iowrite16(index, &cfg->cfg.queue_select);
> +	return vp_ioread16(&cfg->queue_reset);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_get_queue_reset);
> +

Actually, this does not validate that the config structure is big
enough. So it can access some unrelated memory. Don't know whether
that's exploitable e.g. for CoCo but not nice, anyway.
Need to validate the size and disable reset if it's too small.


> +/*
> + * vp_modern_set_queue_reset - reset the queue
> + * @mdev: the modern virtio-pci device
> + * @index: queue index
> + */
> +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> +{
> +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> +
> +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> +
> +	vp_iowrite16(index, &cfg->cfg.queue_select);
> +	vp_iowrite16(1, &cfg->queue_reset);
> +
> +	while (vp_ioread16(&cfg->queue_reset))
> +		msleep(1);
> +
> +	while (vp_ioread16(&cfg->cfg.queue_enable))
> +		msleep(1);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> +
>  /*
>   * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
>   * @mdev: the modern virtio-pci device
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 05123b9a606f..c4eeb79b0139 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -113,4 +113,6 @@ void __iomem * vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
>  				       u16 index, resource_size_t *pa);
>  int vp_modern_probe(struct virtio_pci_modern_device *mdev);
>  void vp_modern_remove(struct virtio_pci_modern_device *mdev);
> +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
> +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
>  #endif
> -- 
> 2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
