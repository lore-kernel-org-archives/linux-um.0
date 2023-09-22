Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507A4CD4F49
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 10:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EwDVPvBxzK/eMNAx7XF/xooLfTJ1ebjz/is3ATtUHzM=; b=JrzDPLjGosxIaE
	BoLUnpwu2KBK7iFbx2Wq2zSc5sLI+fVTAB2YEQoxfl6VyQYXiGjtvnoITEASr/c5Itkby1BTQl1wr
	QkTysAz5X8c40dcY3gMiuOPlMGxHT/Cre+nZwXKM4G7Zie4+UA96v9eoGbYnyZtuvauTg35xtgGvE
	LrOsYiiJzN79/Za8dRTdXg9R3hrgmuU/bKQqFW8TE9CXxSk1q7zjwXN3Mawu+gr8hNqgEf4CM9wgG
	oZD3bVwPtzwPZ5420LlSPN2iy/Hl9k3mijyaK+jufTxG98rLzuDxdiWTIgCxRLnG2/mreVcY+2bdB
	dWoSHQL1N3TEdZhT83xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjdgV-008tHM-3C;
	Fri, 22 Sep 2023 10:46:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjdgR-008tGo-1r
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 10:46:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695379610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=523CLNpg/sOwhLY70FMKKiUkZU7FDspbvgGF4P5huNs=;
	b=GbFWs1a6vULU+egABQkZGxqrjH5nY57GIPKRgKhe27EAbHpLR/NMJsYTFcCM6lOdnf2kn8
	lLh5N1dSLKmhobXgDkNehXmseV179D+Q2kMXjJUk77UPzyVSU/tXQR2viylk5gjOAtJmfG
	m+utMEptyL99WH2HyDbIhq3wcXv4Pp0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-aauiK04WPPetKFwGeR75Ow-1; Fri, 22 Sep 2023 06:46:48 -0400
X-MC-Unique: aauiK04WPPetKFwGeR75Ow-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-532c1dfebe6so1348959a12.3
        for <linux-um@lists.infradead.org>; Fri, 22 Sep 2023 03:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695379607; x=1695984407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=523CLNpg/sOwhLY70FMKKiUkZU7FDspbvgGF4P5huNs=;
        b=czHSRbTKcuLtThroc4acBs6PSfvDqxZMrAY+UlAyBwwBK9nYqq841X5BJ/Bw8QtyJK
         9nbM85k2jDe+H0FWU2AIurKEyTQORZCsMrHntrcJcjsp3xBn7Ypi9AY2tl9xfVbwjev7
         06By0euHUfmernizmhvPBpGyidJ94HueIvfxTujPViH0VzKJTt12BBWi5GxPRkUngWBd
         E/lJoSNnprvpztGK2AwZnnY3mPxLfoymj2EkQAwNQwfu85sSbQ5fqAPLL8Ebuxkb+YUa
         AfMv5HHyr9UnwiA3UF9Hex3yG9P+5psAnaCs83cwZNaHfvncd/GuArKTZCEEMATa6XFz
         JLww==
X-Gm-Message-State: AOJu0Yyli+sPfx9lxfVYkzcdsALkxDbeVQhimOnxBcu7/tr30+0Pxch/
	3eubU3ggoeRJFtDyx5SUzTnK+cliDUxoC01c/C/1fMXr+Mawz4thcEkWZP578HG7FsxrHpSlvvQ
	oWf08VA/vb0kNAQLUO4qmjNIi
X-Received: by 2002:a17:906:41:b0:9ad:e66a:4141 with SMTP id 1-20020a170906004100b009ade66a4141mr7499957ejg.28.1695379607568;
        Fri, 22 Sep 2023 03:46:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/7A6BDEm5D1OAZEqbWCsMuJ65vhHu1qiz2aGlCcO2bpN2TOKZRlo73gCToO1Ojpp+az0gQA==
X-Received: by 2002:a17:906:41:b0:9ad:e66a:4141 with SMTP id 1-20020a170906004100b009ade66a4141mr7499940ejg.28.1695379607265;
        Fri, 22 Sep 2023 03:46:47 -0700 (PDT)
Received: from redhat.com ([2.52.150.187])
        by smtp.gmail.com with ESMTPSA id d26-20020a1709064c5a00b009ad875d12d7sm2528479ejw.210.2023.09.22.03.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 03:46:46 -0700 (PDT)
Date: Fri, 22 Sep 2023 06:46:39 -0400
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
Message-ID: <20230922064550-mutt-send-email-mst@kernel.org>
References: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
 <20220801063902.129329-31-xuanzhuo@linux.alibaba.com>
 <20230921100112-mutt-send-email-mst@kernel.org>
 <1695347358.2770545-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1695347358.2770545-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_034651_686386_7B85B00D 
X-CRM114-Status: GOOD (  27.66  )
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

On Fri, Sep 22, 2023 at 09:49:18AM +0800, Xuan Zhuo wrote:
> On Thu, 21 Sep 2023 10:02:53 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Aug 01, 2022 at 02:38:50PM +0800, Xuan Zhuo wrote:
> > > Introduce new helpers to implement queue reset and get queue reset
> > > status.
> > >
> > >  https://github.com/oasis-tcs/virtio-spec/issues/124
> > >  https://github.com/oasis-tcs/virtio-spec/issues/139
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_pci_modern_dev.c | 39 ++++++++++++++++++++++++++
> > >  include/linux/virtio_pci_modern.h      |  2 ++
> > >  2 files changed, 41 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > > index fa2a9445bb18..869cb46bef96 100644
> > > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > > @@ -3,6 +3,7 @@
> > >  #include <linux/virtio_pci_modern.h>
> > >  #include <linux/module.h>
> > >  #include <linux/pci.h>
> > > +#include <linux/delay.h>
> > >
> > >  /*
> > >   * vp_modern_map_capability - map a part of virtio pci capability
> > > @@ -474,6 +475,44 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
> > >  }
> > >  EXPORT_SYMBOL_GPL(vp_modern_set_status);
> > >
> > > +/*
> > > + * vp_modern_get_queue_reset - get the queue reset status
> > > + * @mdev: the modern virtio-pci device
> > > + * @index: queue index
> > > + */
> > > +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> > > +{
> > > +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> > > +
> > > +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> > > +
> > > +	vp_iowrite16(index, &cfg->cfg.queue_select);
> > > +	return vp_ioread16(&cfg->queue_reset);
> > > +}
> > > +EXPORT_SYMBOL_GPL(vp_modern_get_queue_reset);
> > > +
> >
> > Actually, this does not validate that the config structure is big
> > enough. So it can access some unrelated memory. Don't know whether
> > that's exploitable e.g. for CoCo but not nice, anyway.
> > Need to validate the size and disable reset if it's too small.
> 
> 
> static int vp_modern_disable_vq_and_reset(struct virtqueue *vq)
> {
> 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> 	struct virtio_pci_vq_info *info;
> 	unsigned long flags;
> 
> ->	if (!virtio_has_feature(vq->vdev, VIRTIO_F_RING_RESET))
> 		return -ENOENT;
> 
> 	vp_modern_set_queue_reset(mdev, vq->index);
> 
> 
> I checked VIRTIO_F_RING_RESET before call this.

Yes but the point is that virtio is used with untrusted devices
(e.g. for SEV/TDX), so you can't really assume config structures
are in sync with feature bits.


> Do you mean, we should put the check to this function.
> 
> 
> Thanks.
> 
> 
> 
> >
> >
> > > +/*
> > > + * vp_modern_set_queue_reset - reset the queue
> > > + * @mdev: the modern virtio-pci device
> > > + * @index: queue index
> > > + */
> > > +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> > > +{
> > > +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> > > +
> > > +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> > > +
> > > +	vp_iowrite16(index, &cfg->cfg.queue_select);
> > > +	vp_iowrite16(1, &cfg->queue_reset);
> > > +
> > > +	while (vp_ioread16(&cfg->queue_reset))
> > > +		msleep(1);
> > > +
> > > +	while (vp_ioread16(&cfg->cfg.queue_enable))
> > > +		msleep(1);
> > > +}
> > > +EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> > > +
> > >  /*
> > >   * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
> > >   * @mdev: the modern virtio-pci device
> > > diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> > > index 05123b9a606f..c4eeb79b0139 100644
> > > --- a/include/linux/virtio_pci_modern.h
> > > +++ b/include/linux/virtio_pci_modern.h
> > > @@ -113,4 +113,6 @@ void __iomem * vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
> > >  				       u16 index, resource_size_t *pa);
> > >  int vp_modern_probe(struct virtio_pci_modern_device *mdev);
> > >  void vp_modern_remove(struct virtio_pci_modern_device *mdev);
> > > +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
> > > +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
> > >  #endif
> > > --
> > > 2.31.0
> >


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
