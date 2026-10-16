Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A541BCCA462
	for <linux-um@archiver.kernel.org>; Fri, 16 Oct 2026 09:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rr7WSuKask2p1j98eCEcwTF9HIf7GILCC9to1Tz+WQ4=; b=jVVFyCPgpKh3jUepH4T136PqeZ
	JOhbmjsk2zS38Nb87F/X1LmsXLur0uHjIWYqJZcbrZN6gPiptkKmxwrGRLANOdbxKLPVxZKwuF3+J
	T4U9SW1U2u2bDcchZqSkoLboC2aMMUZKJZkOa0wE/i0kaQdrrL0yCurQqs59xHaFfyO9tQ9DXiJ4S
	gmw6KEJIclMHiTyzNtrXZzbDRKN/f2wymjmAqokqW8albqxV3pdrE4CE/rbpM3eot3jXqRpJjNDba
	nXH3Xu82Ym4KJF+bZaY35Q8foSM8sAaUljNm57MUt9tx3kpoyjtTOGezjy6Z4JbLSxMQ4sRJP0ICU
	anCelzpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHedS-00000002XnM-3ELI;
	Fri, 16 Oct 2026 09:53:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHedQ-00000002Xms-2zQC
	for linux-um@lists.infradead.org;
	Fri, 16 Oct 2026 09:53:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792144435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rr7WSuKask2p1j98eCEcwTF9HIf7GILCC9to1Tz+WQ4=;
	b=e37xVH6F1LHHZQIMO6wnThnuHgHCWiB9JdN8v6O+Vz57Ne48ip06K6iIAVO2r4vdvte1c2
	dEly1eClthdoiTRlYXk1jlfAq1biMYK1HCs2T+n3UePNNeTXPx6EwnSc3aF6qPml96WWhT
	yWot0EpLG4bylWwdkOiHQaAbffsFlyw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Qz-smX29MgGHRhA8Eig3DQ-1; Fri, 16 Oct 2026 09:53:54 +0000
X-MC-Unique: Qz-smX29MgGHRhA8Eig3DQ-1
X-Mimecast-MFC-AGG-ID: Qz-smX29MgGHRhA8Eig3DQ_1792144433
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dea677afcso644525f8f.1
        for <linux-um@lists.infradead.org>; Fri, 16 Oct 2026 02:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144433; x=1792749233;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rr7WSuKask2p1j98eCEcwTF9HIf7GILCC9to1Tz+WQ4=;
        b=Bp3eTVJAFqkvzgLpqu4sRVAaFM5zgWYor0Fjc9lrfXGAB2oK40i4Dt/QMRiF6H8F/g
         5dFdSbaJg9wXZ5LioqzNJNUlJIGH9JCF8jM/7h0iXiJPxJ1ZlMfvep50Ma7dfyWQ7u3U
         +3bKKNgntk4Ne2YM2teV4KsyrZ9cy2DVXCB94aSJMtHZn8sf752x9ErwTPH6yQkyD/iR
         hnA635/+w7gOb/RF9fv5SEjct9C+WFfQS01kMpY80wTe+YYtZvcHOXcYXNhCUPL7MNba
         4RsJvVWMCyNcVy2QJzcHeMS4maiCT5ivCXVTEpAgy8kJOL3Y8i3/6Yk2byS2uUOtlgSZ
         kDLQ==
X-Forwarded-Encrypted: i=1; AKwUvByUtHXcTWWBN3pooAzyUMUvDCo2YzKYPFBUxzFHzDfi61JZx/FTRbh0s1JzoUVTAfF71u8feRPckg==@lists.infradead.org
X-Gm-Message-State: AFq9FYIvj0t9QmnrKnJp8+Ln+aq+s6yCSuGME/vPsRHQWbPtIwSXU8Rl
	Ul9fU3ecy7+df8mE4JN2A2bX+dmwLT24KIpi7YUoBEcqOSpupeOmInqLB5LvvWzxQ41DIIFH4ia
	kdx3xsViedGhS8izG2L8Z5/kiGKxkMGbUIJ4rRltaOAve3BWZT6RdD6h4ok1TuqrAeQ==
X-Gm-Gg: AYBFou0DlmZigxzF14JCqoLyNtSbIIOFWQLCeL/uYKRcUeP+NlcmKoTWnfzaJEjrnuJ
	Yr5rBpPatF0IbkJOo7dbEBVls/ryLRMgKdxEfx/jfg04kUkB7P46ohuvQ7wLpttnSXafPWBKkCi
	2nHfbYVCPVw9h3XHlFWxZVIFu+/aF7rnRMLTP8mj//BnRD72dtsjH+DyOEzZPCKyaphUJHD5o14
	+0ur6eTK5K12fEP0R+/s2Y3XfpCChKq+uxITbKOgEQWWxoG6+ese472FMiEpEb6GXbDPp0VKyPi
	M9Aqi3XjrNh5ew1VkrUw9XEl6AGWFwc+0PCvNmYpoJwDXgkEKt7N+ehBfUdgl9TS1JUnAA==
X-Received: by 2002:a05:6000:26d3:b0:48d:f4ef:62e7 with SMTP id ffacd0b85a97d-48dfaca5f59mr6434756f8f.0.1792144432682;
        Fri, 16 Oct 2026 02:53:52 -0700 (PDT)
X-Received: by 2002:a05:6000:26d3:b0:48d:f4ef:62e7 with SMTP id ffacd0b85a97d-48dfaca5f59mr6434697f8f.0.1792144432170;
        Fri, 16 Oct 2026 02:53:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a72sm4456837f8f.4.2026.10.16.02.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:53:51 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:53:48 -0400
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
Message-ID: <20261016055312-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
 <20261015085119-mutt-send-email-mst@kernel.org>
 <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
 <20261016054142-mutt-send-email-mst@kernel.org>
 <18ba10ec7aa6659ee4711f8dd3f3138e314e4af6.camel@sipsolutions.net>
 <20261016054558-mutt-send-email-mst@kernel.org>
 <77e9eb61d0e81ead5d5840abb95ffbd695a4e513.camel@sipsolutions.net>
MIME-Version: 1.0
In-Reply-To: <77e9eb61d0e81ead5d5840abb95ffbd695a4e513.camel@sipsolutions.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dLkPZ_FBBGfZh-9-uDGwc_B8IlJm3CtrsVPJidrEmwg_1792144433
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_025356_826472_FDEC40FC 
X-CRM114-Status: GOOD (  11.70  )
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

On Fri, Oct 16, 2026 at 11:49:14AM +0200, Johannes Berg wrote:
> On Fri, 2026-10-16 at 05:47 -0400, Michael S. Tsirkin wrote:
> > > > 
> > > Right, but virtio_net_hdr_to_skb() cannot return 1, only 0 on success
> > > and -ERROR on failure?
> > 
> > After this patchset, it can, to signal slow path software checksum.
> > I'm changing callers first so that changing the function itself
> > does not break bisect. I should mention this in the commit log.
> 
> Oh, OK, that I clearly missed, but also was only CC'ed on patches 2 and
> 3 :)
> 
> johannes

Right, I am trying not to spam too widely.
Indeed, this is why commit log should explain.

-- 
MST


