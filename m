Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6487FC982EA
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 10:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A/yNGk5DmsVVa7FPt1z8YmmINF36yskI05CuGhzTjCI=; b=Itkg+7v5qWZm7YX597r04SgBdX
	xaMOgWt3BsrAfaAr5g+nBmex+kWYNZizupjWlZWjSxwFhOS4qnId639QnfNQ6iJYyc2sZ9vZa2rzr
	uxi8tp0+y7z4QsbB4yeN1QAHTTnF13EdbVUn65f2mPzBs7vceS5cTL484k3aGWOm8xFEM1lQ8ty7l
	tP4G4y3/UfoeCCVCp3EPaVp22hvtzqpvVjPrPeEXO5ZpThGlm4hrHoXW9DEgyIDD3qVbQUdk8f5mT
	vzLliFlVV8P6fLn0vSBS4gV3Ru3ZW1c2+kn9wP+cqTSoodnS3SNQkvi1atK/wvfj30zKb2jFuDvqv
	9qUBMvLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9K6M-00000007sgM-3oQZ;
	Wed, 23 Sep 2026 10:21:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9K6K-00000007sfs-21oL
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 10:21:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790158878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/yNGk5DmsVVa7FPt1z8YmmINF36yskI05CuGhzTjCI=;
	b=JgyfKQEWOLHWK6f9mkuE+DPHhem11MsDaT741M8hQoAVe1KDDTwdoDDDYbe6k+uPVMD2CE
	+4+S7a5T/AlH8FWZXE3uvOWToiw3ogflTqlyW5EETBYYmkNo3jRCQo1kcpguvuQOztXc8w
	v6kvqzJ7NK6E3F3nMc7wKUF9n1QdcTw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-p9MPdflNNViDWxBn4EqlYw-1; Wed, 23 Sep 2026 06:21:16 -0400
X-MC-Unique: p9MPdflNNViDWxBn4EqlYw-1
X-Mimecast-MFC-AGG-ID: p9MPdflNNViDWxBn4EqlYw_1790158875
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso5251135e9.2
        for <linux-um@lists.infradead.org>; Wed, 23 Sep 2026 03:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790158875; x=1790763675;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/yNGk5DmsVVa7FPt1z8YmmINF36yskI05CuGhzTjCI=;
        b=xUJGnhx/8uIhavYnCI8IHPQaEG7Tbyi1k5yA02OQoLxvIRkktQ3C7jkLsN2JBf20lH
         zEiuG6T5AUIZkLDjy7ARETIOpM/aaFPIMwBgahIlD/7lS0RDdKjcAyLOeOzZxoIUyh8g
         XWfKjFKc2NQwBp/enRTcHB+nyF+NBmZkUyUUluEzjlNCI4HxZQCFsES7sZJ+4+rsInyS
         eNBrkYOBphX3rqEMQtn/8Yfv7alM3JUHDJL7Dapl+p7/E+/47SKhwIprSZHL8wo42i/w
         U+hHyDq2VtfQyMnn6hFnV+2gIDtgz9GFcMCzw3YNEdZe/N6SFfUjMMu2nL1ZDyruqOPz
         dobw==
X-Forwarded-Encrypted: i=1; AKwUvBxax1JuO4IFlXHpNMsO1BHtEl8brlI2r5Z9HgGheZpi9WT5Tj4qYQg0A6kGPfsb2ELxfUZU+iPooQ==@lists.infradead.org
X-Gm-Message-State: AFuF++lQUALAXHMxyQfI/8wcLoEqpnYuKk12wq6QOq8qT0Qs37wCTNL6
	FO0YMfrTd1hWieQSnHrB1PENRYbMlbZLDvzqwEuU2D29KvB5skKoyhP8hJgOusm4fGSZynkmvHj
	04j3erHp2CxQZVyYU8flVebMT/sxcTLw6RE2juUmPxYPKzmdbm3w3pPs76AtHmWIzJ7WuD50+LA
	==
X-Gm-Gg: AYBFou0PZvuLdkQqnXKdtGKzLzYFBqq5Mkxe29tbkA7e8nYZjFOITV8+DdSNSBsaA3k
	kYA83h+avsCC6JNFSUAnCBxKCQB7+qgf7nM1CWSFM+dbg+rKfst9W6DxHbBWCcBhBYC4Gc8njmo
	GAZ08sxwHD8P0fjRbz6FKXsqXWGSrmQzSqj4Ox6169qtsIWyza6TifRQXRwhTi+PV1L04T24HKs
	Ln6WZ2rwTzz4SfEpnzWoM+Fn5xxmIBkYk/q3H7mXLfgasXG/qf+UnfnEhZ5AsUj9DfMAcnVT01U
	TbAtpvfDmQXRRNhdP38Y9IQk0oEeZ78Nk8zraGe7Dg8nPlfzt/bkV6yFPH9JClzUvDQk9Q==
X-Received: by 2002:a05:600c:4712:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-49fdf24f928mr27542225e9.30.1790158875136;
        Wed, 23 Sep 2026 03:21:15 -0700 (PDT)
X-Received: by 2002:a05:600c:4712:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-49fdf24f928mr27541455e9.30.1790158874532;
        Wed, 23 Sep 2026 03:21:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf9691e2sm57317795e9.1.2026.09.23.03.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:21:13 -0700 (PDT)
Date: Wed, 23 Sep 2026 06:21:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paulos Yibelo <habte.yibelo@gmail.com>, netdev@vger.kernel.org,
	richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net, jasowangio@gmail.com,
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch, pablo@netfilter.org, fw@strlen.de,
	phil@nwl.cc, razor@blackwall.org, idosch@nvidia.com,
	dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-um@lists.infradead.org, virtualization@lists.linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
Message-ID: <20260923061215-mutt-send-email-mst@kernel.org>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
 <20260922030310.8684-2-habte.yibelo@gmail.com>
 <willemdebruijn.kernel.259bc7096258d@gmail.com>
 <willemdebruijn.kernel.2cdfef118aa1d@gmail.com>
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.2cdfef118aa1d@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4784wIQATrfaujht5lNO-QMQ8cB3veUlGLsO98BXQ08_1790158875
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_032120_624300_BCC7A100 
X-CRM114-Status: GOOD (  33.00  )
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

On Tue, Sep 22, 2026 at 09:27:26PM -0400, Willem de Bruijn wrote:
> Willem de Bruijn wrote:
> > Paulos Yibelo wrote:
> > > __virtio_net_hdr_to_skb() checks a minimum network-header length for
> > > CHECKSUM_PARTIAL packets. Its checksum start is relative to skb->data,
> > > but some callers have not established skb->network_header when they
> > > convert the virtio header.
> > > 
> > > Pass the data-relative L3 origin explicitly. Ethernet receive paths
> > > parse the frame and nested VLAN headers without changing skb state.
> > > AF_PACKET uses the frame's actual L3 origin even when the socket
> > > protocol is ETH_P_IP and the raw frame carries VLAN tags. Non-Ethernet
> > > AF_PACKET devices retain their established skb network offset.
> > > 
> > > Also pass the actual L3 protocol so IPv6 packets use the 40-byte base
> > > header minimum even without TCPv6 GSO. IFF_TUN obtains that protocol
> > > from the packet before skb->protocol is set. Name the Ethernet parser
> > > accordingly, use the same origin for tunnel validation, and propagate
> > > conversion failures in UML.
> > > 
> > > The bound remains a minimum; fragmentation paths separately validate
> > > the parsed IPv4 or IPv6 header length before completing a checksum.
> > > 
> > > Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_net_hdr_to_skb()")
> > > Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> > > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > > Link: https://lore.kernel.org/netdev/20260920004733.6473-2-habte.yibelo@gmail.com/
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: LLM
> > > Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > > ---
> > >  arch/um/drivers/vector_transports.c | 13 ++++-
> > >  drivers/net/tun_vnet.h              | 52 ++++++++++++++++-
> > >  drivers/net/virtio_net.c            | 10 +++-
> > >  include/linux/virtio_net.h          | 87 ++++++++++++++++++++++++-----
> > >  net/packet/af_packet.c              | 24 +++++++-
> > >  5 files changed, 163 insertions(+), 23 deletions(-)
> > 
> > The fix may still miss the case IPv4 packets have options.
> > 
> > This version is a very large patch.
> > 
> > Untested shorter first suggestion by bot, which looks plausible as a
> > starting point for discussion.
> 
> Cleaned up some more:
> 
>     diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
>     index f4c652b1fa44..c24607af2aad 100644
>     --- a/drivers/net/tun_vnet.h
>     +++ b/drivers/net/tun_vnet.h
>     @@ -180,6 +180,9 @@ static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>      static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
>                            const struct virtio_net_hdr *hdr)
>      {
>     +    if ((flags & TUN_TYPE_MASK) == IFF_TUN)
>     +        skb_reset_network_header(skb);
>     +
>          return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
>      }
>      
>     @@ -199,6 +202,9 @@ tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features,
>                  struct sk_buff *skb,
>                  const struct virtio_net_hdr_v1_hash_tunnel *hdr)
>      {
>     +    if ((flags & TUN_TYPE_MASK) == IFF_TUN)
>     +        skb_reset_network_header(skb);
>     +
> 
>     diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>     index c381b916c1b5..02c448de0802 100644
>     --- a/include/linux/virtio_net.h
>     +++ b/include/linux/virtio_net.h
>     @@ -48,6 +48,42 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>          return 0;
>      }
>      
>     +static inline int virtio_net_hdr_nh_min_len(const struct sk_buff *skb,
>     +                        unsigned int nh_min_len)
>     +{
>     +    int thoff = skb_transport_offset(skb);
>     +    __be16 proto;
>     +    int nhoff;
>     +
>     +    if (skb_network_header_was_set(skb)) {
>     +        nhoff = skb_network_offset(skb);
>     +        proto = skb->protocol;
>     +    } else {
>     +        if (unlikely(thoff < ETH_HLEN))
>     +            return -EINVAL;
>     +        nhoff = ETH_HLEN;
>     +        proto = eth_hdr(skb)->h_proto;
>     +    }
>     +
>     +    if (eth_type_vlan(proto)) {
>     +        proto = __vlan_get_protocol(skb, proto, &nhoff);
>     +        if (!proto)
>     +            return -EINVAL;
>     +    }
>     +
>     +    if (proto == htons(ETH_P_IP)) {
>     +        const struct iphdr *iph = (void *)(skb->data + nhoff);
>     +
>     +        if (unlikely(thoff < nhoff + sizeof(*iph)))
>     +            return -EINVAL;
>     +        nh_min_len = max_t(u32, iph->ihl * 4, sizeof(*iph));
>     +    } else if (proto == htons(ETH_P_IPV6)) {
>     +        nh_min_len = sizeof(struct ipv6hdr);
>     +    }
>     +
>     +    return nhoff + nh_min_len;
>     +}
>     +
>      static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>                            const struct virtio_net_hdr *hdr,
>                            bool little_endian, u8 hdr_gso_type)
>     @@ -98,13 +134,15 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>              u32 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
>              u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
>              u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
>     +        int min_thoff;
>      
>              if (!pskb_may_pull(skb, needed))
>                  return -EINVAL;
>      
>              if (!skb_partial_csum_set(skb, start, off))
>                  return -EINVAL;
>     -        if (skb_transport_offset(skb) < nh_min_len)
>     +        min_thoff = virtio_net_hdr_nh_min_len(skb, nh_min_len);
>     +        if (min_thoff < 0 || skb_transport_offset(skb) < min_thoff)
>                  return -EINVAL;


Certainly looks much better. But I'd like to ask, generally:
doesn't the net stack need to protect against weird packets?

It seems likely that not all drivers validate headers defensively,
and incoming packets can easily become outgoing ones.
So do we even need virtio specific validation, or is it enough to
validate everything in the net stack, where we are poking at the
header anyway?

Or maybe it's more a defense in depth thing?

My worries:
- more poking at the header, more cache misses, where we really
  do not need that
- future protocol extensions that now will require surgery in
  virtio, instead of just being passed through to the host

What do others think?

-- 
MST


