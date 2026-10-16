Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7D8CCA462
	for <linux-um@archiver.kernel.org>; Fri, 16 Oct 2026 09:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UvLeihu7ioIdym0eRq5JcGIMM6YkZ/1Kjyy9X0VEuuI=; b=leTiccugDx0oB1NdOM9Zo9uJOK
	JDtfi6QeFdGvzMgjrTJf72xAde5kxejvXGsqKhgm47t1ZyKmLxN7SFD5kH3iQ7NWpRZ1P+1WfJwpa
	k5AHH7MtmqzSnlK9CBclhU+z87uLGxpWVdWxAOqn+lSpOZExMYUDGPkXLBICScWIF/zZNHUHHshR/
	DHftBJYyWxvnnkPZwStRF8602N3CQfV346MGu/Ea3ne3oBEupmfQN2KjTZfefitDrX8SKGFme4FhK
	vJR719fu8CkuZhpGyjg5WeuBzKMnycafvHcBLOlfesh+QcqChM8USCCqrVpwNSLQWH0KgPYepGvRj
	tK4IwUqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHeQk-00000002W64-2Pyq;
	Fri, 16 Oct 2026 09:40:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHeQh-00000002W3m-0gL5
	for linux-um@lists.infradead.org;
	Fri, 16 Oct 2026 09:40:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792143646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UvLeihu7ioIdym0eRq5JcGIMM6YkZ/1Kjyy9X0VEuuI=;
	b=EQFaKQjp2JExAMfWZ1XZWNa8YlxA5GgG2caacgr8rh5OjrE1ZC1/Fc2Z/wgAjz+rGE9644
	W5PNg4FWIJDiGjdro1x72PXAisVK+kMNin2qBoMnidMuXu7NNZ2feEZfQYLlgr7WHjYQpD
	VGSTxf/GNwHpSCXOESjm5fz0TxbxrEo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-9WxHetC2Ox-pjoRJ2XERHw-1; Fri, 16 Oct 2026 09:40:44 +0000
X-MC-Unique: 9WxHetC2Ox-pjoRJ2XERHw-1
X-Mimecast-MFC-AGG-ID: 9WxHetC2Ox-pjoRJ2XERHw_1792143644
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b02e93a1eso5178093f8f.1
        for <linux-um@lists.infradead.org>; Fri, 16 Oct 2026 02:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143643; x=1792748443;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UvLeihu7ioIdym0eRq5JcGIMM6YkZ/1Kjyy9X0VEuuI=;
        b=FQ88dgItZKetvvJZa7Uahbn7Pb4r/GDhXS8mr42tJXBr/SfdWfN5wB4RKdvxecQ3lM
         3dyzCnLmYKnBunBCba7KrrqpbWXcc/ntaHKu+ViFjSNKSsf5IqSwRBEeqleKRAOT2W/i
         TW4QAuxLc+uH3tRwpkaDK+oG5n8U9R1tY9ZqKm4NWSpt0oLMS5b2Grl2I6JutlaqYoXu
         nlvPKrHfdzaQmfwk7U2atPGuwz/aPOZIaqnKAMWbBg6DW6IzjpTZWAD7aADBuna97DdE
         dfWsJMhPc2F4atRjCobfxr95T1Mt/h21zfYNxG1jufTK9LdAQHJfUqiZg7G7We0DRllb
         zjCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQbxh3VfC2Ru5ovJINoKNWHaHcGK6yeQFYkRQuG+y74xNorhjRmBU2ZgfoCc25AzmlS44soX/T1A==@lists.infradead.org
X-Gm-Message-State: AFq9FYJebNJRjRdS0IsqjchBW2VHUBqTOdPVcO4lfGXFswCmYXR9g6KC
	IFHBOm3Zykkjx86SRlWgwLfDIslOC7PXhemTATb6AZid15ZdGzfL1JxbLHnStweFrj840jXxNS0
	Q/NllJSSj5Ok74H+/3wQRlfXBFcTtBbJSG+wWiHZ+zk27qlHpO9id17JeOdfMgYjAmA==
X-Gm-Gg: AYBFou0uLUL9OpLRzxjByW64ZylrVt2oLcnGdBzka1hnUvWQygn39XwlAPgmyqOqkvT
	vNbn6mpb/FFZ+e3cWJZnXeLXUF2ReoYQtwvmMOB0nFhB3O/SlzQwW8JzAngbx7j2kmSpHvstVdK
	kV1WAFnHyTJWkN+t1lb10YQF5dzzP2RGQaJu8EAD340zj6xdzk+Fw6Cm09OydKfkaO3rSbTL1Bk
	m+7PWPyzVHF9PsyI1ddmZvSuUS0y/QPSoVO9MVrKKtMB+gycjkyydh7cic+aZuuKrp6X6iVlpVG
	l0V2M1OLEuvS0PceSWnnULN2ssNOL2NY2vDTa18cQNiKsiD2zNu7Z+6QRiKzkItlgp8fqQ==
X-Received: by 2002:a05:6000:2212:b0:488:84ba:ae2e with SMTP id ffacd0b85a97d-48dba6f54ccmr42368073f8f.0.1792143643382;
        Fri, 16 Oct 2026 02:40:43 -0700 (PDT)
X-Received: by 2002:a05:6000:2212:b0:488:84ba:ae2e with SMTP id ffacd0b85a97d-48dba6f54ccmr42368022f8f.0.1792143642782;
        Fri, 16 Oct 2026 02:40:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a64sm4255797f8f.6.2026.10.16.02.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:40:42 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:40:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
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
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
Message-ID: <20261016053930-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <willemdebruijn.kernel.10294d16149b7@gmail.com>
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.10294d16149b7@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uX5zaBCwLL7jW-6lAACEuUsjCIc6uwnaEgROuY3so3Q_1792143644
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_024047_276185_BBD68B84 
X-CRM114-Status: GOOD (  16.65  )
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

On Thu, Oct 15, 2026 at 01:19:22PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
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
> 
> Should this return 1, like the above?
> 
> Not sure whether the verify_header return value is well defined beyond
> just boolean.

                                header_check = vp->verify_header(
                                        vp->header_rxbuffer, skb, vp);

                              if (header_check < 0) {
                                        dev_kfree_skb_irq(skb);
                                        vp->dev->stats.rx_dropped++;
                                        vp->estats.rx_encaps_errors++;
                                        return 0;
                                }
                                if (header_check > 0) {
                                        vp->estats.rx_csum_offload_good++;
                                        skb->ip_summed = CHECKSUM_UNNECESSARY;
                                }


apparently? maybe i misunderstand.

-- 
MST


