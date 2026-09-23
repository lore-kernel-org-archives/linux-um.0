Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D23C982FA
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 01:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lWen8M3Dy9y4fMx+Bf5KiQ+THttX5a/EDRsfysX8uYE=; b=xOC3Z9UtpYKIfWdutwg7dwvrML
	43QkstXsGBeQrpZivEF8mMZzLqyylPmHghpw0EAaBg5ioUGxXf8m9p0nkubwg4CM8C/YC8e0uFmbj
	yqaEDpGwdoc3dMlTZoxVmxOhM4Cene758qioj1wz9HeA0C+xYDG+fv93ZIWOzJpcGtcsjvaibcAkl
	u3UC/FFWe63+ETSt0VKRzZctCJ3cOiWVI8yPL/b/OYHngQBE8CgMMhwVw/32gXsuArRcXJMw4YVR6
	c8EwSDeMe2DoT2yvDTPl6dEjkKwuftHzQ6O/IdhNV4FKTs4CW9wQJN/8g0yB8QzQdHDMq0EhRI8Em
	FErOiqOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Blk-00000006qcC-1Vrf;
	Wed, 23 Sep 2026 01:27:32 +0000
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Blh-00000006qbo-1ors
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 01:27:30 +0000
Received: by mail-yx2-x0f.google.com with SMTP id 00721157ae682-85d45ae011cso7022517b3.2
        for <linux-um@lists.infradead.org>; Tue, 22 Sep 2026 18:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790126848; x=1790731648; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lWen8M3Dy9y4fMx+Bf5KiQ+THttX5a/EDRsfysX8uYE=;
        b=sfGpsjTv0UFP2EBUK042RZ6yTVncJPOJ81ct3jOtiSmYPkS5JdMIH1Mib7TLNKH2kI
         ITyjLNv4sNtxtUoKQqWPjSXbkGPfCK5TUIz7Rp2iadedI7k5LkeJWNsrcvRUjR3iE0Pj
         Rqqksn/1h7XaWRmatgS3q1ZoW8/EgK23VkmNgo9eHd9/JrP4bSKCdbnHJaI1W1LeM5bK
         m0n9F132OV5HJfJS4aJg2mSzR4ni0AePtprdGEGIv5yWHr2RuusJvtP7EUSvG1rqyqWI
         +He/jr0RwSERn8kw0LsfQbmeGdxeCTljhmi15Jzlf0b/ZHhzz1n04G1X60Ss7Naf5hgG
         TMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790126848; x=1790731648;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lWen8M3Dy9y4fMx+Bf5KiQ+THttX5a/EDRsfysX8uYE=;
        b=Q0iOLhPL3YdwZn+za/FcN05Z/7dtsN5Qmx26PiRqIsNzRwSIPyl7jSdZFGlkwB+eBB
         2DTqBXl691m8SbOeHaN5lUEvk7fHeyb4sp2s3Rj8tkIHuor7J861VJzO6fWymFyPggf/
         2o6wJcOKXF/Emqbalp3v4Id8ApARJ8Ne9lKhDCHH1dQE8ZCu3d08AoDRA+ThT+cfP0jN
         VQbv5Kg9SVwnypdsfJrADZfQawBDgn5Os+aA6bcVFWBpNBf3DFOFJeOcUxKuL/cHS4eS
         TRQxgYirR8832j8UgJUynrtHa/LTKi5eHDw4Jv/P3iRnDoY3YAZHu0sLqk4ecMTrh+Y+
         3DaA==
X-Forwarded-Encrypted: i=1; AKwUvBzpxNv3lG5hZMUhZMsm68i/FVDY872Mw1Hel10nb5hd8V0GgT5IDUzyumGWFj4Jj+acv5KZqfZGmA==@lists.infradead.org
X-Gm-Message-State: AFuF++mQa8xzApXDHe257ZQ3MbltB0L0/GujNc6eQ+VPbiiPImQsRp6F
	4kcdB2pkrB1Sub52HRA0bY6SjiqwUGRsYP8fVBGPpzsKr8CZCQEPMUYG
X-Gm-Gg: AYBFou1jdu3jPsK50JLtWyZ+ekpJnV5CROnVoZywFUI/7tgEWUDuCGqYTkJgKwreJT4
	8xb61QgwmT4660Q0GfmwLwREQXuyYWApV7vHcaBzq+iMvOpGMr9CFMRcNa5pR5F0X1FHAo6RoXs
	hY3i4jOa//Dqd1dHRsyzIO/NwqGxGlmJ3NoU5uP7HBkS0oY0p2DzSgSeCYJW62NOXKwNkj4pZ2v
	SPEP+B3iUlzr0uKjJqNCLvIiUZXGCSK7q4UrRXkx4s+uIwLhAr9AoT6ANA+UneBU6OCB7+ZWk9T
	XwY/ML6/DfRHJsU9Dbzh0Xma1zGYa1gRknokY3V1kZdeVDXowa6oBnuJ9eebDyzwrh3ekFz+xqI
	063xbNOCK/2g6wmWsmV0Pf8xcjCaA93QFj7skdQkUttIVdmeKe2ICjy8M47eGmI0LlKWQHwIvcX
	4HC6gF7Jym0LeOYLtX14G8Qo+6Vm5AAe9eDRuMoybQHWRjaUt7R4pL1d4eHz3/2hMHWQzNrBJBI
	0XcSyWBfp9djyZ0wqt2PlD0O/jOxrlbEzU/DYorwCUa7o/8OFIF
X-Received: by 2002:a05:690c:a703:b0:87c:32da:de03 with SMTP id 00721157ae682-8a45bb75aeemr4672467b3.69.1790126848128;
        Tue, 22 Sep 2026 18:27:28 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a465dc9ebcsm4427937b3.20.2026.09.22.18.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 18:27:27 -0700 (PDT)
Date: Tue, 22 Sep 2026 21:27:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Paulos Yibelo <habte.yibelo@gmail.com>, 
 netdev@vger.kernel.org
Cc: richard@nod.at, 
 anton.ivanov@cambridgegreys.com, 
 johannes@sipsolutions.net, 
 willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 xuanzhuo@linux.alibaba.com, 
 andrew+netdev@lunn.ch, 
 pablo@netfilter.org, 
 fw@strlen.de, 
 phil@nwl.cc, 
 razor@blackwall.org, 
 idosch@nvidia.com, 
 dsahern@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 linux-um@lists.infradead.org, 
 virtualization@lists.linux.dev, 
 netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, 
 bridge@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2cdfef118aa1d@gmail.com>
In-Reply-To: <willemdebruijn.kernel.259bc7096258d@gmail.com>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
 <20260922030310.8684-2-habte.yibelo@gmail.com>
 <willemdebruijn.kernel.259bc7096258d@gmail.com>
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_182729_502270_F96BD7DA 
X-CRM114-Status: GOOD (  22.16  )
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

Willem de Bruijn wrote:
> Paulos Yibelo wrote:
> > __virtio_net_hdr_to_skb() checks a minimum network-header length for
> > CHECKSUM_PARTIAL packets. Its checksum start is relative to skb->data,
> > but some callers have not established skb->network_header when they
> > convert the virtio header.
> > 
> > Pass the data-relative L3 origin explicitly. Ethernet receive paths
> > parse the frame and nested VLAN headers without changing skb state.
> > AF_PACKET uses the frame's actual L3 origin even when the socket
> > protocol is ETH_P_IP and the raw frame carries VLAN tags. Non-Ethernet
> > AF_PACKET devices retain their established skb network offset.
> > 
> > Also pass the actual L3 protocol so IPv6 packets use the 40-byte base
> > header minimum even without TCPv6 GSO. IFF_TUN obtains that protocol
> > from the packet before skb->protocol is set. Name the Ethernet parser
> > accordingly, use the same origin for tunnel validation, and propagate
> > conversion failures in UML.
> > 
> > The bound remains a minimum; fragmentation paths separately validate
> > the parsed IPv4 or IPv6 header length before completing a checksum.
> > 
> > Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_net_hdr_to_skb()")
> > Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > Link: https://lore.kernel.org/netdev/20260920004733.6473-2-habte.yibelo@gmail.com/
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > ---
> >  arch/um/drivers/vector_transports.c | 13 ++++-
> >  drivers/net/tun_vnet.h              | 52 ++++++++++++++++-
> >  drivers/net/virtio_net.c            | 10 +++-
> >  include/linux/virtio_net.h          | 87 ++++++++++++++++++++++++-----
> >  net/packet/af_packet.c              | 24 +++++++-
> >  5 files changed, 163 insertions(+), 23 deletions(-)
> 
> The fix may still miss the case IPv4 packets have options.
> 
> This version is a very large patch.
> 
> Untested shorter first suggestion by bot, which looks plausible as a
> starting point for discussion.

Cleaned up some more:

    diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
    index f4c652b1fa44..c24607af2aad 100644
    --- a/drivers/net/tun_vnet.h
    +++ b/drivers/net/tun_vnet.h
    @@ -180,6 +180,9 @@ static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
     static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
                           const struct virtio_net_hdr *hdr)
     {
    +    if ((flags & TUN_TYPE_MASK) == IFF_TUN)
    +        skb_reset_network_header(skb);
    +
         return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
     }
     
    @@ -199,6 +202,9 @@ tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features,
                 struct sk_buff *skb,
                 const struct virtio_net_hdr_v1_hash_tunnel *hdr)
     {
    +    if ((flags & TUN_TYPE_MASK) == IFF_TUN)
    +        skb_reset_network_header(skb);
    +

    diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
    index c381b916c1b5..02c448de0802 100644
    --- a/include/linux/virtio_net.h
    +++ b/include/linux/virtio_net.h
    @@ -48,6 +48,42 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
         return 0;
     }
     
    +static inline int virtio_net_hdr_nh_min_len(const struct sk_buff *skb,
    +                        unsigned int nh_min_len)
    +{
    +    int thoff = skb_transport_offset(skb);
    +    __be16 proto;
    +    int nhoff;
    +
    +    if (skb_network_header_was_set(skb)) {
    +        nhoff = skb_network_offset(skb);
    +        proto = skb->protocol;
    +    } else {
    +        if (unlikely(thoff < ETH_HLEN))
    +            return -EINVAL;
    +        nhoff = ETH_HLEN;
    +        proto = eth_hdr(skb)->h_proto;
    +    }
    +
    +    if (eth_type_vlan(proto)) {
    +        proto = __vlan_get_protocol(skb, proto, &nhoff);
    +        if (!proto)
    +            return -EINVAL;
    +    }
    +
    +    if (proto == htons(ETH_P_IP)) {
    +        const struct iphdr *iph = (void *)(skb->data + nhoff);
    +
    +        if (unlikely(thoff < nhoff + sizeof(*iph)))
    +            return -EINVAL;
    +        nh_min_len = max_t(u32, iph->ihl * 4, sizeof(*iph));
    +    } else if (proto == htons(ETH_P_IPV6)) {
    +        nh_min_len = sizeof(struct ipv6hdr);
    +    }
    +
    +    return nhoff + nh_min_len;
    +}
    +
     static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
                           const struct virtio_net_hdr *hdr,
                           bool little_endian, u8 hdr_gso_type)
    @@ -98,13 +134,15 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
             u32 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
             u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
             u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
    +        int min_thoff;
     
             if (!pskb_may_pull(skb, needed))
                 return -EINVAL;
     
             if (!skb_partial_csum_set(skb, start, off))
                 return -EINVAL;
    -        if (skb_transport_offset(skb) < nh_min_len)
    +        min_thoff = virtio_net_hdr_nh_min_len(skb, nh_min_len);
    +        if (min_thoff < 0 || skb_transport_offset(skb) < min_thoff)
                 return -EINVAL;

