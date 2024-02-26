Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33CEC54E49
	for <linux-um@archiver.kernel.org>; Mon, 26 Feb 2024 11:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TxVGf/coUZ5OmjL3SRz1RS1u1/x5/bUIT0IsdytHcS0=; b=j9mnU9qrlrDcjcP9xzu2OGXeNC
	Rn8IaKGlz1f1Mm7VUOg5wgr7R1nqhEsJt9MteWTmM2ffNHy1miHvk86+b3Ty+CMBmprFjO2AeOzCh
	vUiZHsKaaxAPeqbdW2iNTPt7LkxnFeIPQDpo4mIs/qhC1WVqyjm3RJFs2qjTqsklRgDBBROEZwRNg
	eqO3TjrGUxfoPBixyGLY0zSaDQUERj2HqFKRLuFITFtQL6SrqZZCXI/QTjifPaQl6N9mD6bT8hWwc
	xvenGe4RmcmayqYu2om5XjaJylyTxdERa0FXwSzrXruFah4iwf5LWB9fIqF4lYguoPTAc3Xn0lHlK
	c4XQPtxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reZLB-00000000OR4-30tv;
	Mon, 26 Feb 2024 11:40:13 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reZL5-00000000ONL-2Y9a
	for linux-um@lists.infradead.org;
	Mon, 26 Feb 2024 11:40:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708947603; h=Message-ID:Subject:Date:From:To;
	bh=TxVGf/coUZ5OmjL3SRz1RS1u1/x5/bUIT0IsdytHcS0=;
	b=iMecl/8hcNVaETvUynwE0t+iNwMkIkTiH94BBh6f+Pruu7F6Ja+2DeG8oR1hO4pc0GOC18TJRFwOlgY0KOzirLzOcAe/aSIERQOKPV1qXS/qqtQdDGW9ByVNxPxTCEc2jzOvpsgZr9H4HAnkN/7bKJ+DXTwXm41OlRPwkr5HbEk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0W1IoY8c_1708947599;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1IoY8c_1708947599)
          by smtp.aliyun-inc.com;
          Mon, 26 Feb 2024 19:40:00 +0800
Message-ID: <1708947549.7906592-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v2 19/19] virtio_net: sq support premapped mode
Date: Mon, 26 Feb 2024 19:39:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 linux-um@lists.infradead.org,
 netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 bpf@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
 <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
 <20240225032330-mutt-send-email-mst@kernel.org>
 <1708946440.799724-1-xuanzhuo@linux.alibaba.com>
 <20240226063120-mutt-send-email-mst@kernel.org>
 <1708947209.1148863-1-xuanzhuo@linux.alibaba.com>
 <20240226063532-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240226063532-mutt-send-email-mst@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_034008_771519_F9EF04E2 
X-CRM114-Status: GOOD (  12.54  )
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

On Mon, 26 Feb 2024 06:36:53 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Feb 26, 2024 at 07:33:29PM +0800, Xuan Zhuo wrote:
> > > what is dma_map_direct? can't find it in the tree.
> >
> > YES.
> >
> >
> > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > index 58db8fd70471..5a8f7a927aa1 100644
> > --- a/kernel/dma/mapping.c
> > +++ b/kernel/dma/mapping.c
> > @@ -144,6 +144,18 @@ static inline bool dma_map_direct(struct device *dev,
> >         return dma_go_direct(dev, *dev->dma_mask, ops);
> >  }
> >
> > +bool dma_is_direct(struct device *dev)
> > +{
> > +       if (!dma_map_direct(dev, ops))
> > +               return false;
> > +
> > +       if (is_swiotlb_force_bounce(dev))
> > +               return false;
> > +
> > +       return true;
> > +}
> > +EXPORT_SYMBOL(dma_unmap_page_attrs);
> > +
> >
> > Thanks.
>
>
> where is it? linux-next?


I see it in the vhost branch kernel/dma/mapping.c.

Maybe you miss it.

Thanks.


>
> --
> MST
>

