Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7AFC54E49
	for <linux-um@archiver.kernel.org>; Mon, 26 Feb 2024 11:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MwTMNcm/OZxGXy6MTFKOugn5j6dLDR0+J9PuYt4fDWs=; b=1F/8o4ifOFl6OQFMwlF7R4INJq
	NQjqBs2mdg3eTPT4qOFTC1H8tTZFvkEFWI/kyXw40UwR0b/IT8WDA51xhqGpDAyftTlqN24yKcPBO
	zvG5dYUvmJ7Xr6gdgbvJTHdI9id2cGlYh85Q7v7nbbGQ6PPrygx0Nb+Y3It8oqHg7ButzQ5ZF6Jcm
	2ah3xPC95b5ySIlIA1oxBnCNod8Okr7Ktqya98EzAGEKL37TPfhsD3a9jo10JT4GR/JChOu/w3pJt
	yR+oFMWbDb8G1Fc03htaBCBRJcC2VnvY6kGGj2iiYYAMbQe3BCFe62qlt/aUe/JgWYN49fRMtZArw
	v/amMqEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reZby-00000000Rba-2tmR;
	Mon, 26 Feb 2024 11:57:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reZbu-00000000RZD-2Xoi
	for linux-um@lists.infradead.org;
	Mon, 26 Feb 2024 11:57:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708948649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MwTMNcm/OZxGXy6MTFKOugn5j6dLDR0+J9PuYt4fDWs=;
	b=blRy128nYHLdCZxG4jJoUa2ap2DEJ6w2mvf0PskQEkf6Zw2TlcFEzqM7dP9X1U5OMU7GwK
	ZJnc6kKoSMz5YJTmRmZ3XVoSiMlQyyEWh4xCEYFR1ApoxaN3LzloGzCNfnMFRgT9XXkU4i
	v/WcEsT+KkkxIxB38XQb/bDmLt6d99o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-AxqzFjdVMJCIfj9G-IyySg-1; Mon, 26 Feb 2024 06:57:28 -0500
X-MC-Unique: AxqzFjdVMJCIfj9G-IyySg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50e91f9d422so3876091e87.2
        for <linux-um@lists.infradead.org>; Mon, 26 Feb 2024 03:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708948646; x=1709553446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwTMNcm/OZxGXy6MTFKOugn5j6dLDR0+J9PuYt4fDWs=;
        b=wM7OzvSJilnSENLcHV3aCtUJNtH7fo0FYU/0B5gigcoVtVNVPruTiGoTuMFQHJ09bn
         7uHORjHEa8N/Co9oFirqUEvHgOjnxvlBBiJwPTI4gYKzmxqDEWAIz1MGysXS8i87R+P+
         8m/tAfgzj1R7x+IubWObR4089OsNgYBktBWYEAZKikQbeIrpTdW5ah5i7RPkbME1w6h9
         IKnplykI7JFad8naN4mCCaqo88Wcuf3nz4tgedBui0D6RhUiojVfQX0CWabTcQtsH+34
         42dfAAvMaOr1Be6Bcrb0rseqgwvAn115areR202Kp1qzc6SepeubfsQ+1z6fDlzimgWq
         MzTA==
X-Forwarded-Encrypted: i=1; AJvYcCWlZ1GaDtXD8FZ3156tNdNMDeMgHTmhW5Pk4CQabtyXfov1zHeQIpXXJw8D+WLJ8dDR+TsHoxvGl1ZF5pO56PV6BvpRAC0e6ArG+Dks
X-Gm-Message-State: AOJu0YwYcEcTfCnkYNbATnlu94sJjpnIvpbJk4rSf2pZqZCD8GJYi1yM
	uvShP9LYuE+GdF7mlfVzVRVqORmDxzCv/5kytjLaZbq7dfbc7d/6uh7YN49Ol1LJlLSgUJzGj8t
	1PSIExBOYymg4IDlqkJS0688W1PY0oWZ6QrZVEAkL58eRjg1zaQVdRDHuUyhHgg==
X-Received: by 2002:a05:6512:2206:b0:512:fbb0:3c55 with SMTP id h6-20020a056512220600b00512fbb03c55mr2652513lfu.17.1708948646533;
        Mon, 26 Feb 2024 03:57:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhlB+sQrxdk/wnezoDvCnQO/+FHCrT1btYEeq6+bycpFpncFqBUrdfh9u7XJ++FrnKpKlBAA==
X-Received: by 2002:a05:6512:2206:b0:512:fbb0:3c55 with SMTP id h6-20020a056512220600b00512fbb03c55mr2652497lfu.17.1708948646157;
        Mon, 26 Feb 2024 03:57:26 -0800 (PST)
Received: from redhat.com ([109.253.193.52])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b004128fa77216sm11737552wmz.1.2024.02.26.03.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:57:25 -0800 (PST)
Date: Mon, 26 Feb 2024 06:57:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH vhost v2 19/19] virtio_net: sq support premapped mode
Message-ID: <20240226065709-mutt-send-email-mst@kernel.org>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
 <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
 <20240225032330-mutt-send-email-mst@kernel.org>
 <1708946440.799724-1-xuanzhuo@linux.alibaba.com>
 <20240226063120-mutt-send-email-mst@kernel.org>
 <1708947209.1148863-1-xuanzhuo@linux.alibaba.com>
 <20240226063532-mutt-send-email-mst@kernel.org>
 <1708947549.7906592-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1708947549.7906592-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_035730_804925_E377CE0F 
X-CRM114-Status: GOOD (  18.86  )
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

On Mon, Feb 26, 2024 at 07:39:09PM +0800, Xuan Zhuo wrote:
> On Mon, 26 Feb 2024 06:36:53 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Feb 26, 2024 at 07:33:29PM +0800, Xuan Zhuo wrote:
> > > > what is dma_map_direct? can't find it in the tree.
> > >
> > > YES.
> > >
> > >
> > > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > > index 58db8fd70471..5a8f7a927aa1 100644
> > > --- a/kernel/dma/mapping.c
> > > +++ b/kernel/dma/mapping.c
> > > @@ -144,6 +144,18 @@ static inline bool dma_map_direct(struct device *dev,
> > >         return dma_go_direct(dev, *dev->dma_mask, ops);
> > >  }
> > >
> > > +bool dma_is_direct(struct device *dev)
> > > +{
> > > +       if (!dma_map_direct(dev, ops))
> > > +               return false;
> > > +
> > > +       if (is_swiotlb_force_bounce(dev))
> > > +               return false;
> > > +
> > > +       return true;
> > > +}
> > > +EXPORT_SYMBOL(dma_unmap_page_attrs);
> > > +
> > >
> > > Thanks.
> >
> >
> > where is it? linux-next?
> 
> 
> I see it in the vhost branch kernel/dma/mapping.c.
> 
> Maybe you miss it.
> 
> Thanks.
> 

which hash?

> >
> > --
> > MST
> >


