Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AC5CCA462
	for <linux-um@archiver.kernel.org>; Fri, 16 Oct 2026 09:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tbR14oJGPzfB2FN3IihSMtrRfZxHPOZ8SpBePeCP3+Q=; b=vSbFKHdt2RyVxehBpreV07lfdz
	y0QadUvPzFvJAxP6qu3laHM9J3ey8O2pHNs+0fZxSSN01xN+Cg1h62/5q3mMwHTpwfhiMq3w1jSbs
	LzTmhXlb5QEB5kPO6Z1uiYuQDrGIYSaO9faitn3Df0LITOgD00/3ZsX6eU2ZXOhBAbviI9O6W+JxT
	4ffgJA5LJEiydRX1QmE5OAMXw1TEOKJHcVN/c/rp2w1r7tzG1+Q37l8ZywkhL8bJyLTIu8XZ2JIXc
	m5lsnyDcdMo+D6H7+SMePM1BPffV/3290cI3/gHEALWT1/9gHrMLN7aAHtT6/MEnQsbnF/iKnG5/Q
	2UooRDog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHeXD-00000002XDK-3unc;
	Fri, 16 Oct 2026 09:47:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHeX8-00000002XBq-1vgn
	for linux-um@lists.infradead.org;
	Fri, 16 Oct 2026 09:47:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792144045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tbR14oJGPzfB2FN3IihSMtrRfZxHPOZ8SpBePeCP3+Q=;
	b=SpirS7H2hoFaZEvJJPAR5YehdVcEf29H7laxxlcLLkV+xHWU9fz6MAIgQS1EdX1mF1F9K3
	wfhMwUQJOvGdptwhK4x7KGauWxFqjaTdas9HB0cBTLxAfjiSwldWW++ykCSYsUFtah9J14
	Mm0VClD6NPgd9A6Su15CqepTnO3cfTI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-uCeOHKkiMdmfXvZ_aFLPsg-1; Fri, 16 Oct 2026 09:47:23 +0000
X-MC-Unique: uCeOHKkiMdmfXvZ_aFLPsg-1
X-Mimecast-MFC-AGG-ID: uCeOHKkiMdmfXvZ_aFLPsg_1792144042
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1b11e7837so31658495e9.1
        for <linux-um@lists.infradead.org>; Fri, 16 Oct 2026 02:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144042; x=1792748842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tbR14oJGPzfB2FN3IihSMtrRfZxHPOZ8SpBePeCP3+Q=;
        b=VsjI8bew90eBqTBZzpmTEhNWKXmVTLx+ppioWkf7TyvFhc/sYtwSJ3u21n0yaTQ3Wj
         lHtR6l7TrKEWQenEa3A/IEhfMwRqGtjf4QIvEe+/UPuBFVXOGiw6Dqe4iq4WTi8YeA9H
         WwHxjodQMhSioGcMDv/DkdIASjTCOZdxuTG0Y4WxYqIeLB/pgiW56BgT5LnkA8sRaVjr
         cY2GYWZOcL1R2GKmH/Ycat8OLWj7FYpWcM16xTstmlBiWe/czylS2MyL3H7JfVHVI11o
         DqRdiJeJhw6yycjUq3iJzZ4SQbhN24+b+hK+1Zf4ce5CrTcL865wBog+Jj6K1+Rf2Hg+
         4v0w==
X-Forwarded-Encrypted: i=1; AKwUvByzqTNZJmc4JKraPcCZ3/BcrwY6rVbY1RptixIvuq1s2tkCQAygvPiUwnREG6PFyAmVo8EXko53iQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ8K40s/KwZ8DsWBybfkpkXJgOc5EaO0Btz5Obyh6OQBhoLt4N/
	1vO8sh9hfWwoFIBcgUrMIau+ITFttwPW4/Ezstl7ZRRtxJedM63kVz2+T8+WguH/W/l8NIVw8D6
	eDMdO1h/yOo5v6rJ5Hu/BST8oe/gDc5PLvvxSW170Rd2pWG2QhfHg5rO983gTtD//GA==
X-Gm-Gg: AYBFou2rzL4zxf4ete7F9Oml49wRRq4M3jFJP+O0vYpQLFCpvPY75WH85yXs5UySnfn
	ZIIcghnZcJvzdQav7/t+Lk59PnyvHPAmhXjwi4h0ZQDZS6ruf8c/Lt7NPwhE7H7HQY93wyzi9aw
	reVzEAZEohjN0EBHYhKmQmOwkFngIMI+J54qcVZbCkn+FrWm/LWeFMfj5Qns94WauiVzJl/4Je3
	TwOlyp/SVInVFIAbU/iWE/nrfAeyMFGdsUIs1btHr4zgHYQ2r5JQd4d3KbrBpH16pEujNhtwAFa
	P/Upkd03Rm+4n734WWpYiQoEbJpaUpaUkEo98wMVlm5Xn/03GqExzby3tgqykwAFTqnDSw==
X-Received: by 2002:a05:600d:82ea:b0:4a1:cedc:ab49 with SMTP id 5b1f17b1804b1-4a1cedcacd6mr26955385e9.31.1792144042070;
        Fri, 16 Oct 2026 02:47:22 -0700 (PDT)
X-Received: by 2002:a05:600d:82ea:b0:4a1:cedc:ab49 with SMTP id 5b1f17b1804b1-4a1cedcacd6mr26955045e9.31.1792144041692;
        Fri, 16 Oct 2026 02:47:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8d12sm4029612f8f.36.2026.10.16.02.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:47:21 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:47:16 -0400
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
Message-ID: <20261016054558-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
 <20261015085119-mutt-send-email-mst@kernel.org>
 <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
 <20261016054142-mutt-send-email-mst@kernel.org>
 <18ba10ec7aa6659ee4711f8dd3f3138e314e4af6.camel@sipsolutions.net>
MIME-Version: 1.0
In-Reply-To: <18ba10ec7aa6659ee4711f8dd3f3138e314e4af6.camel@sipsolutions.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JgwOS0GaDmO4tjARkBCARCYzH8lBXhr4eSvj9W4eGpA_1792144042
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_024726_582416_79CAE724 
X-CRM114-Status: GOOD (  24.68  )
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

On Fri, Oct 16, 2026 at 11:44:16AM +0200, Johannes Berg wrote:
> On Fri, 2026-10-16 at 05:43 -0400, Michael S. Tsirkin wrote:
> > 
> > > > > > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> > > > > > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > > > > > +			virtio_legacy_is_little_endian()) < 0)
> > > > > > +		return -1;
> > > > > >  	return 0;
> > > > > > 
> > > > > 
> > > > > Seems it'd be simpler to just
> > > > > 
> > > > > 	return virtio_net_hdr_to_skb(...);
> > > > > 
> > > > > As far as I can tell, the function only returns -EINVAL or 0 (never a
> > > > > positive value), and the caller only cares about negative (error) or
> > > > > positive (no checksum needed), so that'd be equivalent?
> > > > > 
> > > > > johannes
> > > > 
> > > > if raw_verify_header can safely return any errno - i did not want to
> > > > audit it.
> > > 
> > > You already used an LLM and still didn't want to? ;-)
> > > 
> > > I checked briefly (by hand) and it seems fine, it's assigned to the
> > > function pointer, which only has two callers on the _kern.c side.
> > > 
> > > johannes
> > 
> > 
> >                                header_check = vp->verify_header(
> >                                         mmsg_vector->msg_hdr.msg_iov->iov_base,
> >                                         skb,
> >                                         vp
> >                                 );
> >                                 if (header_check < 0) {
> >                                 /* Overlay header failed to verify - discard.
> >                                  * We can actually keep this skb and reuse it,
> >                                  * but that will make the prep logic too
> >                                  * complex.
> >                                  */
> >                                         dev_kfree_skb_irq(skb);
> >                                         vp->estats.rx_encaps_errors++;
> >                                         (*skbuff_vector) = NULL;
> >                                         mmsg_vector++;
> >                                         skbuff_vector++;
> >                                         continue;
> >                                 }
> >                                 if (header_check > 0) {
> >                                         vp->estats.rx_csum_offload_good++;
> >                                         skb->ip_summed = CHECKSUM_UNNECESSARY;
> >                                 }
> > 
> > 
> > 
> > so any negative is fine, but if we return 1 then it will force to CHECKSUM_UNNECESSARY
> > which I am not sure is what was intended?
> > 
> Right, but virtio_net_hdr_to_skb() cannot return 1, only 0 on success
> and -ERROR on failure?
> 
> johannes

After this patchset, it can, to signal slow path software checksum.
I'm changing callers first so that changing the function itself
does not break bisect. I should mention this in the commit log.

-- 
MST


