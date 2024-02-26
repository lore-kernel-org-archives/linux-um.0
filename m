Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D06C54E49
	for <linux-um@archiver.kernel.org>; Mon, 26 Feb 2024 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mh5I4GCxt/ZTY2nu4KYLIfaFGNU1YmGIejbkntTuIBM=; b=nUu9HHPrzW8ly5ox9dqgo5kG2B
	imp4TPWFowQCmirMn67+o5RwS4JmeXfx42XMSkfNZqltDZGGjnJG3mWFIqNd/iwJgOQgzcYECQm2l
	Ps53iwxfb3NKIfcPA8jPjGLA6MLwbB8wNBle6noPA2mugt/Gwk+YTY3R+RGEaFc25Slv5M0EYxBdn
	PWgJ2hYcIZKFLUPygBzBKAEyv7TTg67QxjYowSeqnQJGYaJuPPHRIoRHdzvb7LR3k7vpdb7Hf8gNL
	TKuIext0zpjs3YuQi9TaGvdDioD6/wi4Q5dcIuEcUhsdD03oWD82qvTMOb3iGQpudyOs7U6dNeWFJ
	p13OvM6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reZkm-00000000UQa-0mwF;
	Mon, 26 Feb 2024 12:06:40 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reZki-00000000UPr-0ptv
	for linux-um@lists.infradead.org;
	Mon, 26 Feb 2024 12:06:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708949194; h=Message-ID:Subject:Date:From:To;
	bh=mh5I4GCxt/ZTY2nu4KYLIfaFGNU1YmGIejbkntTuIBM=;
	b=kxx7CLeW9vltgZFAwyLHcKOCjwt0rNhnzZU6bD+av1bQiBjRZv0YDQ4f91njCUix5+IrDFsRYHxx/cg3vz4j7pXXlLSLIHbt8AoVF9Ly3kI2X53E9OxQtcwlPc4lmuT+KEQxP7eE7uje2kLXdtLpK98migrJaUBaSI7rUkxoM1w=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0W1Iu-rX_1708949189;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1Iu-rX_1708949189)
          by smtp.aliyun-inc.com;
          Mon, 26 Feb 2024 20:06:30 +0800
Message-ID: <1708949183.5224328-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v2 19/19] virtio_net: sq support premapped mode
Date: Mon, 26 Feb 2024 20:06:23 +0800
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
 <1708947549.7906592-2-xuanzhuo@linux.alibaba.com>
 <20240226065709-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240226065709-mutt-send-email-mst@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_040636_588374_28BEA1C9 
X-CRM114-Status: GOOD (  14.86  )
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

On Mon, 26 Feb 2024 06:57:17 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Feb 26, 2024 at 07:39:09PM +0800, Xuan Zhuo wrote:
> > On Mon, 26 Feb 2024 06:36:53 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Mon, Feb 26, 2024 at 07:33:29PM +0800, Xuan Zhuo wrote:
> > > > > what is dma_map_direct? can't find it in the tree.
> > > >
> > > > YES.
> > > >
> > > >
> > > > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > > > index 58db8fd70471..5a8f7a927aa1 100644
> > > > --- a/kernel/dma/mapping.c
> > > > +++ b/kernel/dma/mapping.c
> > > > @@ -144,6 +144,18 @@ static inline bool dma_map_direct(struct device *dev,
> > > >         return dma_go_direct(dev, *dev->dma_mask, ops);
> > > >  }
> > > >
> > > > +bool dma_is_direct(struct device *dev)
> > > > +{
> > > > +       if (!dma_map_direct(dev, ops))
> > > > +               return false;
> > > > +
> > > > +       if (is_swiotlb_force_bounce(dev))
> > > > +               return false;
> > > > +
> > > > +       return true;
> > > > +}
> > > > +EXPORT_SYMBOL(dma_unmap_page_attrs);
> > > > +
> > > >
> > > > Thanks.
> > >
> > >
> > > where is it? linux-next?
> >
> >
> > I see it in the vhost branch kernel/dma/mapping.c.
> >
> > Maybe you miss it.
> >
> > Thanks.
> >
>
> which hash?

fd0b29af02bb75acc94eb08c06e2c10cbce2ea67

>
> > >
> > > --
> > > MST
> > >
>

