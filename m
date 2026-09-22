Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE46C982FA
	for <linux-um@archiver.kernel.org>; Tue, 22 Sep 2026 22:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0qPZh/r/REXP5ZSy0nxs+oUBSRD0aY6qVWm9CYsML3E=; b=z3Sddk/aY8ypBAXFDVN+8KiX2l
	a80mg731Jn/U7vccfm4Fo4WL/5ymHlKTFCXsk8e2e2DEFzPRJ9uCUuepwAFDB9u/b6m0CFu2aKzWt
	vPBbhP72Gip04hCGL0Xn8MetsEepQSdFqUoz/t2uzGJJeC9SwnLGE14HuEeQiggYbiUCtUoA4MH/u
	ztJaC9ol2nY2cxyAyl1P1O5drwUPnjQ9FBjF7WUT1c/MXXoMvav53O660bjEBCyUrK4WMsyz83n8c
	NCSmWT7Yoxlx9vGQMZ3RURbAySTdgjGkzb657siqaL3x4gIFPUc2B8wMHpN34NDFeRPGmUKDbpZqm
	5gfgQONA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x98zs-00000006g7h-2oEE;
	Tue, 22 Sep 2026 22:29:56 +0000
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x98zp-00000006g71-2xaL
	for linux-um@lists.infradead.org;
	Tue, 22 Sep 2026 22:29:55 +0000
Received: by mail-yx2-x0f.google.com with SMTP id 00721157ae682-85d45ae011cso6224887b3.2
        for <linux-um@lists.infradead.org>; Tue, 22 Sep 2026 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790116191; x=1790720991; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0qPZh/r/REXP5ZSy0nxs+oUBSRD0aY6qVWm9CYsML3E=;
        b=cNxVCGiqX6yU5wqxgNE1qjsepXRm4JT9DgiL4LVhUE53G0sZDQfXzC0HHF1+6npMNK
         M8BhpVwfvKNSotXBfjdWRduAobeZSryRhO/RbqW4EwsGcY79IWmci5F6Ta4yek1kfOZ5
         8k1DNEUVxoh9fw5rhXn2hfhFGLySO/3EvK24lTAmPt7eMSK2efhdzgskuHT75x72q31N
         6qPJw6pPWnv40elXMTQUYDbLyPi/KvllSl64/a9L2OogQaR9BsLPuYn/XbDULWhREZ5g
         CszxadPo3uGR+hiZWiQCBi94ew52zv3FsTKRJzHBVoRY9UWAjjSqf0ol5Obn/fDROFN9
         bALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790116191; x=1790720991;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0qPZh/r/REXP5ZSy0nxs+oUBSRD0aY6qVWm9CYsML3E=;
        b=CCA++M8FJqGa0PjbBX2PTrTdognIgn5xSIlOMz4VwliHDaskokEKtB0mNSveNbJ/1P
         YL2wAdKVW2rW47DOoEZqb0OBdqRMKaoHbpeXDr+fkgAH4BFiU+OWnHF6YvtW86lT1VCp
         lIXjk32zVxjjJrTmzB3r+5O7nuu/c4F08+VBWCBKqQGdocaWRtQkIG8BIItip7Ujlk4P
         vsSZC2XMvcZZjfYFlaC6nnc8LhygtQ9oUjAGylLmoynxJvtzNmd7z6zHyXOErewnmU4g
         sZdNtzheYfPRYGIINcB8Kaco3tiRmy446vlsUyN6dmRHJtfTrLZukP3hSkHsuMN23TjJ
         Tz+w==
X-Forwarded-Encrypted: i=1; AKwUvBwPc7CanOq7J87t/z/eqAysZ1FrYlptsEU+aVYTjnSnXCGMNpfOCRSHyoPOIFKrQq++OLsJtMWmVA==@lists.infradead.org
X-Gm-Message-State: AFuF++mRXeATRDECqc16D61rpPC7c9jY7Lw2r/vdN3KJT2Lk5F8mX1oI
	A0JXZ9D2a4tFMsR445grsjcRZoWIeepQW5nrnOVE/rEi6yBt+RLm688W
X-Gm-Gg: AYBFou2SH7rXIzcLDXt8rZGuGJeVN4gv6HJyrt1TW7TstslN4Y1NMqn0VJecny4lP6Q
	u6ufhpDucJ7nDxiGJvRxy6bX7Irr4rgkquA54eV9Rrsb7kSmo98egnwTtZ0ZpVHF8cDVI3udtIU
	rouqNt5YAAt9gJmhw0nFEGyprHX3JxLJyVQeigoG6Y0tvrCfOMQzZqDBH0MmzIItzf+1azyVnd9
	F2VDtkGNJZE2EvKMCuTYos4CtBmrw5yr5y3w8df+wkCD4wT+9SvTQgeM6ftSvTYY0nfKxH8XOnP
	3QWHIUx05ezxTkPiAyk1qpzllG3guRdQ2U16JgLvckzHKc38HKQWPSpO0Va5/3vW1EHjOI1l68E
	+h7l20azp+2QGSiOeh6T919sdHdCaJYh1joIJ5UlpmKCGky0iyfdHjKcOv362GSusGmKTh3E64C
	INmEncylX0NH/wzin21I+qh921Jh1uKMqnBLJxTwWJW5Xduql41M7L9Y/v/fpDDLapWu5SmzOZr
	hkReKW3BUEtk8YviRUtPi1iCwBLFA70jvoY+T4DC1HK0MTIzLvQ
X-Received: by 2002:a05:690c:c:b0:873:5bb2:6c32 with SMTP id 00721157ae682-8a45bb75c4bmr5165927b3.57.1790116191128;
        Tue, 22 Sep 2026 15:29:51 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a465ec41acsm3153167b3.26.2026.09.22.15.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:29:50 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:29:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paulos Yibelo <habte.yibelo@gmail.com>, 
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
Message-ID: <willemdebruijn.kernel.259bc7096258d@gmail.com>
In-Reply-To: <20260922030310.8684-2-habte.yibelo@gmail.com>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
 <20260922030310.8684-2-habte.yibelo@gmail.com>
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_152953_770118_7948A57A 
X-CRM114-Status: GOOD (  22.90  )
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

Paulos Yibelo wrote:
> __virtio_net_hdr_to_skb() checks a minimum network-header length for
> CHECKSUM_PARTIAL packets. Its checksum start is relative to skb->data,
> but some callers have not established skb->network_header when they
> convert the virtio header.
> =

> Pass the data-relative L3 origin explicitly. Ethernet receive paths
> parse the frame and nested VLAN headers without changing skb state.
> AF_PACKET uses the frame's actual L3 origin even when the socket
> protocol is ETH_P_IP and the raw frame carries VLAN tags. Non-Ethernet
> AF_PACKET devices retain their established skb network offset.
> =

> Also pass the actual L3 protocol so IPv6 packets use the 40-byte base
> header minimum even without TCPv6 GSO. IFF_TUN obtains that protocol
> from the packet before skb->protocol is set. Name the Ethernet parser
> accordingly, use the same origin for tunnel validation, and propagate
> conversion failures in UML.
> =

> The bound remains a minimum; fragmentation paths separately validate
> the parsed IPv4 or IPv6 header length before completing a checksum.
> =

> Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_=
net_hdr_to_skb()")
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO t=
unneling.")
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Link: https://lore.kernel.org/netdev/20260920004733.6473-2-habte.yibelo=
@gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
> ---
>  arch/um/drivers/vector_transports.c | 13 ++++-
>  drivers/net/tun_vnet.h              | 52 ++++++++++++++++-
>  drivers/net/virtio_net.c            | 10 +++-
>  include/linux/virtio_net.h          | 87 ++++++++++++++++++++++++-----=

>  net/packet/af_packet.c              | 24 +++++++-
>  5 files changed, 163 insertions(+), 23 deletions(-)

The fix may still miss the case IPv4 packets have options.

This version is a very large patch.

Untested shorter first suggestion by bot, which looks plausible as a
starting point for discussion.

    --- a/drivers/net/tun_vnet.h
    +++ b/drivers/net/tun_vnet.h
    @@ -152,6 +152,9 @@ static inline int tun_vnet_hdr_to_skb(unsigned in=
t flags, struct sk_buff *skb,
                           const struct virtio_net_hdr *hdr)
     {
    +    if ((flags & TUN_TYPE_MASK) =3D=3D IFF_TUN)
    +        skb_reset_network_header(skb);
    +
         return virtio_net_hdr_to_skb(skb, hdr, tun_is_little_endian(flag=
s));
     }

    --- a/include/linux/virtio_net.h
    +++ b/include/linux/virtio_net.h
    @@ -71,9 +71,27 @@ static inline int __virtio_net_hdr_to_skb(struct s=
k_buff *skb,
             if (!pskb_may_pull(skb, needed))
                 return -EINVAL;
     =

    +        if (!skb_network_header_was_set(skb) ||
    +            (skb->dev && skb->dev->type =3D=3D ARPHRD_ETHER)) {
    +            int nhoff =3D ETH_HLEN;
    +
    +            if (unlikely(start < ETH_HLEN + nh_min_len))
    +                return -EINVAL;
    +            __vlan_get_protocol(skb, eth_hdr(skb)->h_proto, &nhoff);=

    +            nh_min_len +=3D nhoff;
    +        } else {
    +            nh_min_len +=3D skb_network_offset(skb);
    +        }
    +        if (unlikely(start < nh_min_len))
    +            return -EINVAL;
    +
    +        const struct iphdr *iph =3D (void *)(skb->data + nh_min_len =
- sizeof(*iph));
    +        if (iph->version =3D=3D 4)
    +            nh_min_len +=3D max_t(u32, iph->ihl * 4, sizeof(*iph)) -=
 sizeof(*iph);
    +        else if (iph->version =3D=3D 6)
                 /* ..here I don't trust the initial bug output, but the =
branch is clear.. */
    +        if (unlikely(start < nh_min_len))
    +            return -EINVAL;
    +
             if (!skb_partial_csum_set(skb, start, off))
                 return -EINVAL;
    -        if (skb_transport_offset(skb) < nh_min_len)
    -            return -EINVAL;
         }

    --- a/net/ipv4/ip_output.c
    +++ b/net/ipv4/ip_output.c
    @@ -772,7 +772,9 @@ int ip_do_fragment(struct net *net, struct sock *=
sk, struct sk_buff *skb,
         if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
             (!(dev->features & NETIF_F_CSUM_MASK) ||
    -         skb_checksum_help(skb)))
    +         skb_checksum_start_offset(skb) < (int)(iph->ihl * 4) ||
    +         skb_checksum_help(skb)))
             goto fail;
  =

And the summary of the problem:

  ### 1. What the Problem Is

  When userspace (AF_PACKET, TUN/TAP, vhost-net) or a device (virtio_net,=
 UML) injects a CHECKSUM_PARTIAL packet using struct virtio_net_hdr,
  virtio_net.h:47-119 validates hdr->csum_start:

    // include/linux/virtio_net.h:107 (added by commit 49d14b54a527)
    if (skb_transport_offset(skb) < nh_min_len)
        return -EINVAL;

  This validation has three bugs:

  1. Missing L2 + VLAN offset: skb_transport_offset(skb) (hdr->csum_start=
) is an offset from skb->data, which points to the L2 header (14
  bytes for Ethernet + 4 * n bytes for 802.1Q/802.1ad VLAN tags) on Ether=
net callers (virtio_net, IFF_TAP, PACKET_SOCK_DGRAM/SOCK_RAW).
  Comparing csum_start < 20 allows csum_start to land inside the L2 VLAN =
tags (14..21) or inside the L3 header (22..33).
  2. Wrong nh_min_len for IPv6 non-GSO: nh_min_len defaults to sizeof(str=
uct iphdr) (20) and is only raised to sizeof(struct ipv6hdr) (40)
  when gso_type is VIRTIO_NET_HDR_GSO_TCPV6. A non-GSO or GSO_UDP_L4 IPv6=
 packet is only checked against 20 bytes.
  3. Ignores IPv4 options (iph->ihl > 5): Even without an L2 header (IFF_=
TUN), an IPv4 header with options can be up to 60 bytes (ihl =3D 15),
  allowing csum_start =3D 20 to point 40 bytes inside the IPv4 options ar=
ea.

  This causes two kernel bugs downstream:

  =E2=80=A2 Bug A (WARN_ONCE / panic_on_warn in skb_checksum_help): With =
2 VLAN tags (22 bytes L2), csum_start =3D 20 passes 20 >=3D 20. Once
  eth_type_trans() + skb_vlan_untag() pull 22 bytes, skb_checksum_start_o=
ffset(skb) (csum_start - skb_headroom(skb)) becomes -2. In
  dev.c:3645, offset >=3D skb_headlen(skb) promotes signed -2 to 0xffffff=
feU, firing WARN_ONCE(1, ...) and crashing panic_on_warn=3D1 hosts.
  =E2=80=A2 Bug B (TOCTOU L3 Header Corruption -> OOB Read in ip_do_fragm=
ent): With csum_start =3D 20, csum_offset =3D 0 on TAP/AF_PACKET, csum_st=
art
  lands at byte 6 of struct iphdr (frag_off) or byte 0 (version/ihl on do=
uble-VLAN frames). In ip_output.c:774 and nf_conntrack_bridge.c:42,
  skb_checksum_help(skb) runs before hlen =3D iph->ihl * 4 is read. The 1=
6-bit checksum write corrupts iph->ihl (e.g. from 5 [20B] to 15 [60B])
  after ip_rcv_core() already validated it, causing ip_do_fragment() to r=
ead 60 bytes out-of-bounds from skb->data.

