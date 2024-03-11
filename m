Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B038C54791
	for <linux-um@archiver.kernel.org>; Mon, 11 Mar 2024 02:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IjggKy7HR74Lw2lFaJO8aNhkimYBeigCUfT94zbJh7Y=; b=FRW+tJvRTlYU73NetnA/dBsu/5
	ICkhyYVZ+YwjZ7S0396Qtx6Ao+Xq/v1d9Lxf3xXZgx3qdU5gPv/vRuDCkD2IsYe/PLKm/JK1Z58Ug
	349j4yOW6AErewtvflc7bXdydbN6JOO8ktat00y0vj8q0h7RnqN57gomo6W8auNE0tcYtd7NluWEs
	yUgg0hGvI0XrqPr2KbOcu59fdo0Bgytb/npF3ZwiHCItl18CVj71e5TygxCmpQEsHdi/8V+ADKiTT
	eUZjh0gVfM1+HiVpsAQspYB28aSbc66AwTr0DCUVawtOa16rhvkyhA+ZDAdbdQQVBxRGE75cIMZoU
	F8peI7sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjVLk-0000000HWZS-0mfT;
	Mon, 11 Mar 2024 02:25:12 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjVLg-0000000HWYS-1Pdm
	for linux-um@lists.infradead.org;
	Mon, 11 Mar 2024 02:25:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710123900; h=Message-ID:Subject:Date:From:To;
	bh=IjggKy7HR74Lw2lFaJO8aNhkimYBeigCUfT94zbJh7Y=;
	b=peHY19esr8GZu3ZFrKHE8JGArjyzDGiliiRylykqu+Wopec8Yu9ro/Djkhy/1NZAQw7urykcPmByq0/GA05fbwdt39EP5SZZ6Y9cJS4DybBNukqH0jOeKG2e78Gjm/B+koQJkOMhFHkBCurwYac2Y4q9DTjjXQdaGTIFdkUg2AU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W29MS6c_1710123896;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W29MS6c_1710123896)
          by smtp.aliyun-inc.com;
          Mon, 11 Mar 2024 10:24:57 +0800
Message-ID: <1710123875.2753754-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v1 2/4] virtio: vring_create_virtqueue: pass struct instead of multi parameters
Date: Mon, 11 Mar 2024 10:24:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Hans de Goede <hdegoede@redhat.com>,
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
 Jason Wang <jasowang@redhat.com>,
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org
References: <20240306114615.88770-1-xuanzhuo@linux.alibaba.com>
 <20240306114615.88770-3-xuanzhuo@linux.alibaba.com>
 <8f77a787-0bb7-96ad-0dac-f8ef36879ae3@linux.intel.com>
In-Reply-To: <8f77a787-0bb7-96ad-0dac-f8ef36879ae3@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240310_192508_903966_0D227BE9 
X-CRM114-Status: GOOD (  16.91  )
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

On Fri, 8 Mar 2024 12:19:21 +0200 (EET), =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com> wrote:
> On Wed, 6 Mar 2024, Xuan Zhuo wrote:
>
> > Now, we pass multi parameters to vring_create_virtqueue. These parameters
> > may from transport or from driver.
> >
> > vring_create_virtqueue is called by many places.
> > Every time, we try to add a new parameter, that is difficult.
> >
> > If parameters from the driver, that should directly be passed to vring.
> > Then the vring can access the config from driver directly.
> >
> > If parameters from the transport, we squish the parameters to a
> > structure. That will be helpful to add new parameter.
> >
> > Because the virtio_uml.c changes the name, so change the "names" inside
> > the virtio_vq_config from "const char *const *names" to
> > "const char **names".
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Johannes Berg <johannes@sipsolutions.net>
>
> > @@ -60,38 +61,25 @@ struct virtio_device;
> >  struct virtqueue;
> >  struct device;
> >
> > +struct vq_transport_config {
> > +	unsigned int num;
> > +	unsigned int vring_align;
> > +	bool weak_barriers;
> > +	bool may_reduce_num;
> > +	bool (*notify)(struct virtqueue *vq);
> > +	struct device *dma_dev;
> > +};
>
> kerneldoc is missing from this struct too.
>
> It would be generally helpful if you are proactive when somebody comments
> your series by checking if there are similar cases within your series,
> instead of waiting them to be pointed out for you specificly.

Sorry. I missed it.

Will fix in next version.

Thanks


>
> --
>  i.
>

