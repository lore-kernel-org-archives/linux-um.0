Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9901FC54E60
	for <linux-um@archiver.kernel.org>; Tue, 19 Mar 2024 06:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WKRneGfnw6MSOgt3Bh59h7eI+wlS3o3Ic4CAJ/J4VaI=; b=QXui3ZMiiSntFRGk0f53Tlu6/J
	tcQheb80tPB1H03Eo1R3Q5RXqeWeaoYpTUx9cP8n3crAchnrJjvfo/CRz6mNKUpmkx50A9Z8KnVfR
	Xau6NzwxUbOjC8heajryLWK8gMuSpH+Z3eG97gUvrtMagrLk/QkGnKpbbrgsu9pyXBsI5dDmJy9h9
	tQpUu3A5kuks5dsG+RF2gh4kYwurUorSgOFPOcfsflYPWEtaxXucpKAp8Cb4DDksIMOoKjlwInAee
	u5SyuAT6YKo6snR6FgCKhRYLVH/WacQcuoU9kMa3E2lEtTIfzoJEFO4DIfLPK3YDM5JoAhEu9HSYo
	95JzbXdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmTQL-0000000Bb57-0vLT;
	Tue, 19 Mar 2024 06:58:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmTQA-0000000Bb3y-1QGD
	for linux-um@lists.infradead.org;
	Tue, 19 Mar 2024 06:58:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710831480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKRneGfnw6MSOgt3Bh59h7eI+wlS3o3Ic4CAJ/J4VaI=;
	b=B9HWhu7V+HNsDZZc4v2VP10ERXW2pmimrCyCEDZ86wDOC+yHnfrvpRASqbGcqImlJnHT/B
	kSwPPr2JEfGu4nrxg92DEZL7eMRbA51VpSies7aqWIDz8cLu+ZN0Owl+jYRnYes2UkkDRX
	/Wy5FWJXI18p9UrsLmqaK1+XUCYuU2A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-bsNaE4TMP-2wLAst2sVBsw-1; Tue, 19 Mar 2024 02:57:59 -0400
X-MC-Unique: bsNaE4TMP-2wLAst2sVBsw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a3fb52f121eso227966066b.0
        for <linux-um@lists.infradead.org>; Mon, 18 Mar 2024 23:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710831478; x=1711436278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKRneGfnw6MSOgt3Bh59h7eI+wlS3o3Ic4CAJ/J4VaI=;
        b=c60+2fd6Jd4df/6SMoPbWZwo7OR0DE/sk6Z2rxrSb0VNbjHUe3obkV+hjrXDTipxLp
         qBvfpplo+ytDs/d+kTCUiXAi094iOGbIGDAzVurAxDJc854XZISeE/eJjatxTIwIg+r/
         zFwREjKbSkxPP/63hkfnjJH8gW3QntrQLiINNKWFtCeYhzzbH/E088yjhm64IbCVdGNk
         JwRfrUzTEzW4KxKkHPkTCkvfPsfWdOExee/ZPiAXAIJyBMY6IkrzAYy6U9IITCsSUh/U
         svSuCtr92ispXPIIYZMjvxAbhvyTCYFTEGS/SK2Fov9wk9/yPhsCscjPH2E8CWUl2oeo
         kXhw==
X-Forwarded-Encrypted: i=1; AJvYcCWbZcwOU0fJYtAXk9ZGiQyjRgCprBwZwdO1TNazzAKplzKkfebVQ1e/iCp4zeSYXkCdLQ2hoQ10fRysO6o+trkSN/gHkVEQi6N+0bh3
X-Gm-Message-State: AOJu0YwZ4Gj5Md3gDNZDDpIxxC6Rooc5w9JDup+CWMJ58R5GMoUXytgP
	PNx/pBqe5ynxisXeZsP/isCPVMxG+ONw7EBRv2b7EAXyPJY5I9Ns0FH0sNPrAcn+JKA6xTHidEv
	jW0figxGK30/ZbCpi2oMmcGGx5H6faD7cjtpFW+3p2fGe67Rz15iKUJH7YJ5eRw==
X-Received: by 2002:a17:906:eece:b0:a46:c11d:dd01 with SMTP id wu14-20020a170906eece00b00a46c11ddd01mr4018597ejb.50.1710831477846;
        Mon, 18 Mar 2024 23:57:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe8W4rxWk1HBUws9HJcN3Gt6tuPLOzUx2clDG/sopbKziEHlsuK6XGj9oSKeqgDXzCCBt6Rg==
X-Received: by 2002:a17:906:eece:b0:a46:c11d:dd01 with SMTP id wu14-20020a170906eece00b00a46c11ddd01mr4018565ejb.50.1710831477263;
        Mon, 18 Mar 2024 23:57:57 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:ca2b:adb0:2501:10a9:c4b2])
        by smtp.gmail.com with ESMTPSA id bi20-20020a170906a25400b00a46b9e36636sm2331023ejb.0.2024.03.18.23.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:57:56 -0700 (PDT)
Date: Tue, 19 Mar 2024 02:57:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH vhost v3 1/4] virtio: find_vqs: pass struct instead of
 multi parameters
Message-ID: <20240319025726-mutt-send-email-mst@kernel.org>
References: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com>
 <20240312021013.88656-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvVgfgAxLoKeFTgy-1GR0W07ciPYFuqs6PiWtKCnXuWTw@mail.gmail.com>
 <1710395908.7915084-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsT2JqJ1r_kStUzW0+-f+qT0C05n2A+Yrjpc-mHMZD_mQ@mail.gmail.com>
 <1710487245.6843069-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEspzDTZP1yxkBz17MgU9meyfCUBDxG8mjm=acXHNxAxhg@mail.gmail.com>
 <1710741592.205804-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1710741592.205804-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_235803_237770_641B9273 
X-CRM114-Status: GOOD (  38.42  )
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

On Mon, Mar 18, 2024 at 01:59:52PM +0800, Xuan Zhuo wrote:
> On Mon, 18 Mar 2024 12:18:23 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Fri, Mar 15, 2024 at 3:26 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Fri, 15 Mar 2024 11:51:48 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > On Thu, Mar 14, 2024 at 2:00 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > >
> > > > > On Thu, 14 Mar 2024 11:12:24 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > > On Tue, Mar 12, 2024 at 10:10 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > > >
> > > > > > > Now, we pass multi parameters to find_vqs. These parameters
> > > > > > > may work for transport or work for vring.
> > > > > > >
> > > > > > > And find_vqs has multi implements in many places:
> > > > > > >
> > > > > > >  arch/um/drivers/virtio_uml.c
> > > > > > >  drivers/platform/mellanox/mlxbf-tmfifo.c
> > > > > > >  drivers/remoteproc/remoteproc_virtio.c
> > > > > > >  drivers/s390/virtio/virtio_ccw.c
> > > > > > >  drivers/virtio/virtio_mmio.c
> > > > > > >  drivers/virtio/virtio_pci_legacy.c
> > > > > > >  drivers/virtio/virtio_pci_modern.c
> > > > > > >  drivers/virtio/virtio_vdpa.c
> > > > > > >
> > > > > > > Every time, we try to add a new parameter, that is difficult.
> > > > > > > We must change every find_vqs implement.
> > > > > > >
> > > > > > > One the other side, if we want to pass a parameter to vring,
> > > > > > > we must change the call path from transport to vring.
> > > > > > > Too many functions need to be changed.
> > > > > > >
> > > > > > > So it is time to refactor the find_vqs. We pass a structure
> > > > > > > cfg to find_vqs(), that will be passed to vring by transport.
> > > > > > >
> > > > > > > Because the vp_modern_create_avq() use the "const char *names[]",
> > > > > > > and the virtio_uml.c changes the name in the subsequent commit, so
> > > > > > > change the "names" inside the virtio_vq_config from "const char *const
> > > > > > > *names" to "const char **names".
> > > > > > >
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> > > > > > > Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > > > > >
> > > > > > The name seems broken here.
> > > > >
> > > > > Email APP bug.
> > > > >
> > > > > I will fix.
> > > > >
> > > > >
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > >
> > > > > > >  typedef void vq_callback_t(struct virtqueue *);
> > > > > > >
> > > > > > > +/**
> > > > > > > + * struct virtio_vq_config - configure for find_vqs()
> > > > > > > + * @cfg_idx: Used by virtio core. The drivers should set this to 0.
> > > > > > > + *     During the initialization of each vq(vring setup), we need to know which
> > > > > > > + *     item in the array should be used at that time. But since the item in
> > > > > > > + *     names can be null, which causes some item of array to be skipped, we
> > > > > > > + *     cannot use vq.index as the current id. So add a cfg_idx to let vring
> > > > > > > + *     know how to get the current configuration from the array when
> > > > > > > + *     initializing vq.
> > > > > >
> > > > > > So this design is not good. If it is not something that the driver
> > > > > > needs to care about, the core needs to hide it from the API.
> > > > >
> > > > > The driver just ignore it. That will be beneficial to the virtio core.
> > > > > Otherwise, we must pass one more parameter everywhere.
> > > >
> > > > I don't get here, it's an internal logic and we've already done that.
> > >
> > >
> > > ## Then these must add one param "cfg_idx";
> > >
> > >  struct virtqueue *vring_create_virtqueue(struct virtio_device *vdev,
> > >                                          unsigned int index,
> > >                                          struct vq_transport_config *tp_cfg,
> > >                                          struct virtio_vq_config *cfg,
> > > -->                                      uint cfg_idx);
> > >
> > >  struct virtqueue *vring_new_virtqueue(struct virtio_device *vdev,
> > >                                       unsigned int index,
> > >                                       void *pages,
> > >                                       struct vq_transport_config *tp_cfg,
> > >                                       struct virtio_vq_config *cfg,
> > > -->                                      uint cfg_idx);
> > >
> > >
> > > ## The functions inside virtio_ring also need to add a new param, such as:
> > >
> > >  static struct virtqueue *vring_create_virtqueue_split(struct virtio_device *vdev,
> > >                                                       unsigned int index,
> > >                                                       struct vq_transport_config *tp_cfg,
> > >                                                       struct virtio_vq_config,
> > > -->                                                   uint cfg_idx);
> > >
> > >
> > >
> >
> > I guess what I'm missing is when could the index differ from cfg_idx?
> 
> 
>  @cfg_idx: Used by virtio core. The drivers should set this to 0.
>      During the initialization of each vq(vring setup), we need to know which
>      item in the array should be used at that time. But since the item in
>      names can be null, which causes some item of array to be skipped, we
>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>      cannot use vq.index as the current id. So add a cfg_idx to let vring
>      know how to get the current configuration from the array when
>      initializing vq.
> 
> 
> static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> 
> 	................
> 
> 	for (i = 0; i < nvqs; ++i) {
> 		if (!names[i]) {
> 			vqs[i] = NULL;
> 			continue;
> 		}
> 
> 		if (!callbacks[i])
> 			msix_vec = VIRTIO_MSI_NO_VECTOR;
> 		else if (vp_dev->per_vq_vectors)
> 			msix_vec = allocated_vectors++;
> 		else
> 			msix_vec = VP_MSIX_VQ_VECTOR;
> 		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
> 				     ctx ? ctx[i] : false,
> 				     msix_vec);
> 
> 
> Thanks.


Jason what do you think is the way to resolve this?

> >
> > Thanks
> >
> > > Thanks.
> > >
> > >
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > >
> > > >
> > >
> >


