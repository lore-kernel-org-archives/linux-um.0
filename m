Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C991BCC6B34
	for <linux-um@archiver.kernel.org>; Thu, 15 Oct 2026 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wcpnk+xBeaA1jme1SdTW5ccMBBDrq+w8aENCxtFQmP0=; b=oYbOLwRX6EvYojw5lu5/CY2WQY
	1h7KTI4UBP2d+AkzmuXq74KGf/YTrY36tGSeG7NA8DBWbyHy1iCFayANgRbpJNKbIr6/97l1wy9hO
	1HEVoo58wJH80nG3l6uXUx/OxNLBlu9fA9XlSAbj5bCDrEW952a6u+5Af8ByRThA2GuVsC+udYgoM
	xRhNFQPhfnyNR+Yd4RxJkcnbDfW8CjdA5Mba3xlRXdYYa0n+6GXZtVEzDSZnJrcY0sPOkhPEYd5gN
	QC7/iN1GMmh7zf+f6tWQzdHagygpF8gONpuuSkEw2tdJm5wiIGMXevk/xLZNDmV1hZ7rpEVsYVO9w
	gwboLj7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHKwR-00000000ATy-1kVu;
	Thu, 15 Oct 2026 12:52:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHKwN-00000000ATX-1nJU
	for linux-um@lists.infradead.org;
	Thu, 15 Oct 2026 12:52:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcpnk+xBeaA1jme1SdTW5ccMBBDrq+w8aENCxtFQmP0=;
	b=ByzE9tDlhZuR7BUm/yMYbFh6PnZfxcQD02n4Ol/2e7zNKnLrlU3LoIrvXv9nDdljK4P83L
	ssbc3as+3Ihd3zVr/xC4G4sYDTfXdU1l+QYDNKqzz0M0HIaWJ7kW8jVC935rs8YG55EVhI
	cUbzHYbP4QNOyXkLP5Eu5j8ZU2+P3pU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-KbkKmzyzNPKC92eAvFCDGw-1; Thu, 15 Oct 2026 12:52:07 +0000
X-MC-Unique: KbkKmzyzNPKC92eAvFCDGw-1
X-Mimecast-MFC-AGG-ID: KbkKmzyzNPKC92eAvFCDGw_1792068726
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48afe000b94so1397325f8f.3
        for <linux-um@lists.infradead.org>; Thu, 15 Oct 2026 05:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068726; x=1792673526;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wcpnk+xBeaA1jme1SdTW5ccMBBDrq+w8aENCxtFQmP0=;
        b=mK8kqIuKChmN2kOy+nZ+/Iy1OSmsNXQbibYcv7A9m/1QUqOHj1JPLnaq4KrcDnnav5
         89hK+4b+zLBAjgirCH2swaBYPW0em1ysqcwIH0CwDst7Jb0gA/gJ4IItAXPI1iCR7do0
         3yWyx95PnbDSV+eMu9fcINsqJ+Pjj7NF1wLD7MU5b3fVI9wZa7ZddVNOaonOo3q7iWGt
         PN0COUtLqPYyS2gTpdo8Yf8M46luh6oIS4o0rDtYwwYH/15rafapdFQ2OOxAa3GUKKNd
         vK4xi+bmPC1O6vdpA6Ni/hdXa6T5DShLHrXy2Ti3UvKiP/CYGnOoQY/hSDQlpAwqFdfC
         Pv6w==
X-Forwarded-Encrypted: i=1; AKwUvBzq9inW55jyryWSIDBYAwQSblTYVZ2sKYLfyLWrLwt8EZH1g+NxSe5sQwO22pnTGNGbi5D0vqFaGw==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ/R2BFcFN5ARKNPc5y/p9fYgV6eFPledJjRAnRPo5UuUN7vR9e
	PuGTy9lMfjWUe491EmJqREfLNMWPmr0WcrLmAcSTevHY5uYFMAPbhHSBzEG+nGTthX3YS6fboe3
	ARVCodCqVwlKT47yVsoYnImLByjVjI9N6W8q/x2USB51ZthEGy/8uO7j/ijIuRem8Ow==
X-Gm-Gg: AYBFou01gGos/LmniSgohwP3+Hwz+ASwUuSk/eyTCJp293R2FSjm2E1X5D+FdpaJMBl
	07CCyvGx4M8JqiOKXhQu9XidJLHXSezlBajL99H1vMvv8UggHFGeEOlRnOJrUXQbDPLgTXPeYDy
	zbWMhPobqH7b6vc5XY2uHmX7Het9yKiyGHRwN3zGTPuWx0PN3peBIIQIW7THbYO3/3eSTfHoFgU
	HfuU/M2BlO92zCSKy2RyDQsw+cFFrVWGaF6NmqT+JC8UkSW6UPVcMceALieMt4EhrkGdjElkwKU
	Y9RBCn2cMyighyrdrQOe1jKGMV4x1yZd9rn3AhPGSHsYtMMQlH/x1yMd4oAqgNKS9/FIDA==
X-Received: by 2002:a05:6000:25f2:b0:488:5d44:6680 with SMTP id ffacd0b85a97d-48dbacdc419mr37642965f8f.36.1792068726327;
        Thu, 15 Oct 2026 05:52:06 -0700 (PDT)
X-Received: by 2002:a05:6000:25f2:b0:488:5d44:6680 with SMTP id ffacd0b85a97d-48dbacdc419mr37642912f8f.36.1792068725766;
        Thu, 15 Oct 2026 05:52:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaa9f9sm18793273f8f.19.2026.10.15.05.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:52:04 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:52:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
Message-ID: <20261015085119-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
MIME-Version: 1.0
In-Reply-To: <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: syAqAXNPlcYC0ypjQdtyTd2bOBwtDVqBXqQ0w4g8EgA_1792068726
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_055211_968069_821A6EDD 
X-CRM114-Status: GOOD (  19.57  )
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

On Thu, Oct 15, 2026 at 02:47:01PM +0200, Johannes Berg wrote:
> On Thu, 2026-10-15 at 08:41 -0400, Michael S. Tsirkin wrote:
> > virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> > it cannot make sense of, but the vector raw transport ignored
> > its return value: rejected packets went on into the stack with
> > their metadata unvalidated.
> > 
> > Propagate the failure.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  arch/um/drivers/vector_transports.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> > index e1fb2a76fdff..8b7548458663 100644
> > --- a/arch/um/drivers/vector_transports.c
> > +++ b/arch/um/drivers/vector_transports.c
> > @@ -210,7 +210,9 @@ static int raw_verify_header(
> >  		return 1;
> >  
> >  	skb_set_network_header(skb, ETH_HLEN);
> > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > +			virtio_legacy_is_little_endian()) < 0)
> > +		return -1;
> >  	return 0;
> > 
> 
> Seems it'd be simpler to just
> 
> 	return virtio_net_hdr_to_skb(...);
> 
> As far as I can tell, the function only returns -EINVAL or 0 (never a
> positive value), and the caller only cares about negative (error) or
> positive (no checksum needed), so that'd be equivalent?
> 
> johannes

if raw_verify_header can safely return any errno - i did not want to
audit it.

-- 
MST


