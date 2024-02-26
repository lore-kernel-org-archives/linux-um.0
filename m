Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46200C54E4A
	for <linux-um@archiver.kernel.org>; Mon, 26 Feb 2024 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DAlQVG6KdPaJyAOPbLA/63jFXJlJW1va0BU08U9am/8=; b=dEI0mE2emisXFipmT6ys+IuCcE
	NRwwh5L02yxZwDRrQS7U9oQVHjP059ZH9gpo0E+O3+5XyAsolujcrfEdjobGgXSo3GgniDD7jHp4C
	IuQKzmjP0xV2ftU13e8+etNHyiJyCYwwuUSIZx21GY0gKmC693PqwJt2vcMxe9JagS9nRrORGQdcf
	RatbTkCWIwzO+r9FldQ6MGhYyzvNu/+mHuzEh/pbSZTxXPeoepzulbLviyCAqo3vLooKqQeX64dGP
	1Z03jQDDBzG+za0f4GzIA4HFdR4RwwRX6mtHAkdipeWf3KMYdKz4DYCTpnyVBUjUdU4tNXR/EISVh
	W2ZAqYuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reZIG-00000000NYS-3AgI;
	Mon, 26 Feb 2024 11:37:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reZIC-00000000NVh-31mD
	for linux-um@lists.infradead.org;
	Mon, 26 Feb 2024 11:37:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708947427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAlQVG6KdPaJyAOPbLA/63jFXJlJW1va0BU08U9am/8=;
	b=IPvg8/EjHjNI2O1yqv9XTYddRSWx3rui14H5eyjyetXFjPvOjRFZsdYlcnGLBWrw1A8bJn
	TNEPXFbtxteqNF++wEH5ZvoCdyL3EKxYu1G+LfMswSpm6+odpkx9O+BWjgsjlb6rgdZP3Y
	8JG72eWcYCdw1J6uSg4CeEbKNVEdEkU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-tg6etEWvMAuCOxa7IYauXQ-1; Mon, 26 Feb 2024 06:37:05 -0500
X-MC-Unique: tg6etEWvMAuCOxa7IYauXQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412a6bdd67fso2447155e9.3
        for <linux-um@lists.infradead.org>; Mon, 26 Feb 2024 03:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947424; x=1709552224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAlQVG6KdPaJyAOPbLA/63jFXJlJW1va0BU08U9am/8=;
        b=E1PlL5vFlm3sooBApYO+lQSrhlVuIT/mxrYwlMrBwExAY4HHXk515u/PfvJCCM4daO
         L0bJVgmTxPyZ+5YGSps9HlnKP8idSibKbMLFLbJfd3qyCinRreUDZJ8hQWETSGjPdPNm
         6B5354TCd20d0PQcIGUtwW78auurE4G3M9Qpjh7v80d5PK3G8eU3MoHHigFSz3ICEKEh
         ovmcmkYrRSU4fhXe5Sdy1SVT8eOSA0O2nUUB87CkCEf6tIL2Ghw16/8yzp30c0G3yCbg
         B0KRAP0T8NZ6eK04kqt2sP9WQt/SbPlhMzAoYL0p38CTIw13zA1/3vKeJCHmanOWdURG
         z6TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOXZrSzr4IhK9DGTa1Dkg6jyYkd6uIpr/gdgLsLxXWbCqa49u9amkJ2od5kEynsE5h7ZaaQ68bTfprzokMdvI+1lszWw/dPrrTj81p
X-Gm-Message-State: AOJu0YzlOrwV2n4KeJWhKaRH37Joj6a65Qx4Bk5E+O+rZnz0bnDbZ89o
	IeedYvYufLe36qzgPgMcFAJo7udTCS+yYV6Pt7H0VqXho4jz9d0afnJ+olYd4IpkFxXdY3ymvE2
	aSxP+m8oi1D7kITYFQdROboSqcrbvq67SwfltlJqFE6lU+FMln8aLekkqyqI7Tg==
X-Received: by 2002:a05:600c:1d82:b0:412:a8d1:d3b6 with SMTP id p2-20020a05600c1d8200b00412a8d1d3b6mr379154wms.8.1708947424766;
        Mon, 26 Feb 2024 03:37:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvXe87LdVjv57x0ixL/iOJ9+IQcZQwZBW2BhhDacRcGH/iDCk0HMP0COfYaRJOaDiHQGYMqw==
X-Received: by 2002:a05:600c:1d82:b0:412:a8d1:d3b6 with SMTP id p2-20020a05600c1d8200b00412a8d1d3b6mr379072wms.8.1708947423449;
        Mon, 26 Feb 2024 03:37:03 -0800 (PST)
Received: from redhat.com ([109.253.193.52])
        by smtp.gmail.com with ESMTPSA id t20-20020adfa2d4000000b0033de1e1bddcsm1319266wra.26.2024.02.26.03.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:37:02 -0800 (PST)
Date: Mon, 26 Feb 2024 06:36:53 -0500
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
Message-ID: <20240226063532-mutt-send-email-mst@kernel.org>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
 <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
 <20240225032330-mutt-send-email-mst@kernel.org>
 <1708946440.799724-1-xuanzhuo@linux.alibaba.com>
 <20240226063120-mutt-send-email-mst@kernel.org>
 <1708947209.1148863-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1708947209.1148863-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_033708_917115_E5E894B5 
X-CRM114-Status: GOOD (  15.21  )
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

On Mon, Feb 26, 2024 at 07:33:29PM +0800, Xuan Zhuo wrote:
> > what is dma_map_direct? can't find it in the tree.
> 
> YES.
> 
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 58db8fd70471..5a8f7a927aa1 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -144,6 +144,18 @@ static inline bool dma_map_direct(struct device *dev,
>         return dma_go_direct(dev, *dev->dma_mask, ops);
>  }
> 
> +bool dma_is_direct(struct device *dev)
> +{
> +       if (!dma_map_direct(dev, ops))
> +               return false;
> +
> +       if (is_swiotlb_force_bounce(dev))
> +               return false;
> +
> +       return true;
> +}
> +EXPORT_SYMBOL(dma_unmap_page_attrs);
> +
> 
> Thanks.


where is it? linux-next?

-- 
MST


