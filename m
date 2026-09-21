Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1C9C982ED
	for <linux-um@archiver.kernel.org>; Mon, 21 Sep 2026 22:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AEt+ciqD7T2EQYKNoKayyfuhYvhsmv+e842rE5yabjs=; b=JQ+vXqsMuqBRNNwpdHH+R+3ZKi
	A2JXHIfE5XU+kCMHL6oW3F+rmz0g8MpTacRhNEHs7+NX0eFjB4seBQuL7X55QH8FDdpXq1qfX2JbV
	Ch8qqSzEL2WzRLUOYO6ij76c6lBx8N7sHFG0CA3wxw4byGoTVFJ7/JW/F3bVlH2C7IoE/GYaEf7Vl
	XNZzf7ZgkVGItCS9hMRmG9f76iMuZ37VRTsxS6oCo2ieXdM3b2y2wmIFI5JMjNoMdj+ItmsTT+Ncu
	/UFtBLX9mkg3L2obHNC0Rwd1CryKvywsvYLxs2ZWuJ8uAqb0vjnttgTo5fAfp5LwPXN5nkKLwbsnC
	eQVOGtPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8mEs-00000003XeE-0svX;
	Mon, 21 Sep 2026 22:11:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8mEp-00000003Xde-1Giv
	for linux-um@lists.infradead.org;
	Mon, 21 Sep 2026 22:11:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790028708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEt+ciqD7T2EQYKNoKayyfuhYvhsmv+e842rE5yabjs=;
	b=Yhdfh/nr/iQ6yDBnbJI7fnoXv5OO7Ji2RpLamsaqlTvljhEUdqNxiD6g0Va7aMoAiLIYev
	IBKysKPODTsTJN3xnZaheKZEfIS8BL3MHXyGcSoNM7kk+wR3QYRPSEFJj2CHn4ZPElDLFg
	g+cCZmeB8fKiATpuXYxdXXD9PEfdhiU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-NlVCO0QKPCu7zg4XDz_9zw-1; Mon, 21 Sep 2026 18:11:46 -0400
X-MC-Unique: NlVCO0QKPCu7zg4XDz_9zw-1
X-Mimecast-MFC-AGG-ID: NlVCO0QKPCu7zg4XDz_9zw_1790028706
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e65f2f1baso39760785e9.3
        for <linux-um@lists.infradead.org>; Mon, 21 Sep 2026 15:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790028705; x=1790633505;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AEt+ciqD7T2EQYKNoKayyfuhYvhsmv+e842rE5yabjs=;
        b=q2ELFoU8ab9cUcwXgqf/Vr+IraNqJrtyhnUMXT/fqWgzgnCGH/nRuE3FGzoXSObK3b
         QJUKevKVlIw5JCErgrdhhkzE0TXqipltjy0Do5yx9etwUx1dsRjV1QmKfy/5g9hxtvqc
         4S/husK2FMDzdSF+A4Wg8QE/806zZdP+LiI2EXDroHMNiQA6HbCjZJ+2LCfGxdMpDrNS
         pQ+BEK9rI6Z7AEsrma1+QseEMcPLf9SRW55W/J/N0H0BLkvOm4ZGu/UZfE0u3GHWLcfV
         e0l8lBrkE2Fat6Ggl1Fp/VW5aFwG+kSh0P78LYHe3bCwlQdeXZ5BuKBdx0879bycfwFD
         ZCEQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7oIAd2Wgq5KkyJj+6io+onUdl0eqDJUxZQSxTuCqtrQKYvVKPU2IZHAjvwaqgOpSx3aAHwnK0Iw==@lists.infradead.org
X-Gm-Message-State: AFuF++m5kqQWnultKRAEAJK50fCYsEq7Dubf8cO6senOOZWvvIylj8Ae
	BiSgP/1BiQr3T2h8Q6jjTz+B488lLwRm1Y6n6cIbxd1BH8sb33NpaIJRXrP2qvWMsJF6K3XiakD
	DuVVkBoe7UMTjqwp/yjLiTWYrGFxD7wNQdIIUIgsgII2vt/aM6e9NaBy1dXvNLyBRWw==
X-Gm-Gg: AYBFou2KRs6ucDi7npAAcdrDISAw0QITF0AqCBnPOmtrK5BZm/QKrkD2B3WnC7Exs/Q
	9wEkTwJX2rYB4TEHpX3bg1eM25U37x/1rqZ5lK4P8ySBEHticAbQms7T7A+FVKlzsU53EjiufKu
	PQTIOiv+JykmhBP16I5ZySLorD5axl6auTer2EyELYVM94Poi0qCYN9gvPg+5aCneHA86kdUkTK
	QV4DXh2vc0hlcXBt9JjIs/3iFpSbe3mfq9qsG5wA5Dlhs6IcEl97ecuxCXsH6ecFfQqmaov9TQl
	zzYkw8ryLl29TrEPuksHaxsHsBys3wzSvIjnP3l/gxcKAc2/wQ00w5O4SrdZJvXZWLGWSTqehNV
	5H6SnwupXM11Q+ghTxPWJF5g=
X-Received: by 2002:a05:600c:4f09:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49fc56692c6mr166467225e9.2.1790028705421;
        Mon, 21 Sep 2026 15:11:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4f09:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49fc56692c6mr166467095e9.2.1790028704912;
        Mon, 21 Sep 2026 15:11:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fda8f04f7sm2635925e9.0.2026.09.21.15.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 15:11:44 -0700 (PDT)
Date: Mon, 21 Sep 2026 18:11:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paulos Yibelo <habte.yibelo@gmail.com>
Cc: netdev@vger.kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net, willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
	pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, razor@blackwall.org,
	idosch@nvidia.com, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-um@lists.infradead.org,
	virtualization@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 1/2] net: validate virtio checksum start after
 network header
Message-ID: <20260921181115-mutt-send-email-mst@kernel.org>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
 <20260921025341.44846-1-habte.yibelo@gmail.com>
 <20260921025341.44846-2-habte.yibelo@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20260921025341.44846-2-habte.yibelo@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5BHtyOD_47HOuRJkw76Q6z7WotANR7kElDDQCv-bgs4_1790028706
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_151151_530331_5FB475BB 
X-CRM114-Status: GOOD (  34.17  )
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

On Sun, Sep 20, 2026 at 10:53:40PM -0400, Paulos Yibelo wrote:
> __virtio_net_hdr_to_skb() rejects a CHECKSUM_PARTIAL start smaller than
> an estimated minimum network-header length. Its input offsets are relative
> to skb->data.
> 
> Using skb_network_offset() here is unsafe. TUN/TAP, virtio-net, and UML
> parse a received virtio header before skb->network_header is established.
> On an skb with headroom, the resulting negative offset enlarges the
> apparent distance to the transport header and can admit a checksum start
> inside the network header.
> 
> Pass the data-relative L3 offset to the converter explicitly. IFF_TUN uses
> zero, AF_PACKET supplies its established network offset, and Ethernet
> receive paths parse Ethernet and nested VLAN headers with
> skb_header_pointer(), without changing skb state. Use the same origin for
> tunnel-offset validation, and make UML propagate conversion failures.
> 
> This does not require a virtual-machine guest. A TUN or TAP device with
> virtio-net header support is sufficient to reach these paths.
> 
> Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_net_hdr_to_skb()")
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Link: https://lore.kernel.org/netdev/20260920004733.6473-2-habte.yibelo@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>


v4 had assisted-by tag? same q for patch 2.

> ---
> Changes in v5:
> - Replace the not-yet-established skb network-header offset with an
>   explicit data-relative L3 origin.
> - Cover all in-tree callers, including Ethernet/VLAN receive paths,
>   tunnel metadata, and UML error propagation.
> - Drop the prior Acked-by and Reviewed-by tags because the code changed.
> 
> Changes in v4:
> - State that a TUN device is sufficient and no guest is required, as
>   noted by Michael S. Tsirkin.
> 
> Changes in v3:
> - Keep the network-relative comparison on one line for readability, as
>   requested by David Ahern.
> 
> Changes in v2:
> - Make nh_min_len an int and remove the casts, as suggested by Michael S.
>   Tsirkin.
> 
>  arch/um/drivers/vector_transports.c | 10 +++-
>  drivers/net/tun_vnet.h              | 28 ++++++++++-
>  drivers/net/virtio_net.c            |  8 ++-
>  include/linux/virtio_net.h          | 76 +++++++++++++++++++++++------
>  net/packet/af_packet.c              |  6 ++-
>  5 files changed, 106 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> index ddd127ee9..79bc05fc6 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -197,6 +197,7 @@ static int raw_verify_header(
>  	uint8_t *header, struct sk_buff *skb, struct vector_private *vp)
>  {
>  	struct virtio_net_hdr *vheader = (struct virtio_net_hdr *) header;
> +	int network_offset;
>  
>  	if ((vheader->gso_type != VIRTIO_NET_HDR_GSO_NONE) &&
>  		(vp->req_size != 65536)) {
> @@ -209,8 +210,13 @@ static int raw_verify_header(
>  	if ((vheader->flags & VIRTIO_NET_HDR_F_DATA_VALID) > 0)
>  		return 1;
>  
> -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> -	return 0;
> +	network_offset = virtio_net_hdr_get_l3_offset(skb, vheader);
> +	if (network_offset < 0)
> +		return network_offset;
> +
> +	return virtio_net_hdr_to_skb(skb, vheader,
> +				     virtio_legacy_is_little_endian(),
> +				     network_offset);
>  }
>  
>  static bool get_uint_param(
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index f4c652b1f..1c83c359d 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -177,10 +177,27 @@ static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>  	return __tun_vnet_hdr_put(sz, 0, iter, hdr);
>  }
>  
> +static inline int
> +tun_vnet_hdr_get_l3_offset(unsigned int flags, const struct sk_buff *skb,
> +			   const struct virtio_net_hdr *hdr)
> +{
> +	if ((flags & TUN_TYPE_MASK) != IFF_TAP)
> +		return 0;
> +
> +	return virtio_net_hdr_get_l3_offset(skb, hdr);
> +}
> +
>  static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
>  				      const struct virtio_net_hdr *hdr)
>  {
> -	return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
> +	int network_offset = tun_vnet_hdr_get_l3_offset(flags, skb, hdr);
> +
> +	if (network_offset < 0)
> +		return network_offset;
> +
> +	return virtio_net_hdr_to_skb(skb, hdr,
> +				     tun_vnet_is_little_endian(flags),
> +				     network_offset);
>  }
>  
>  /*
> @@ -199,10 +216,17 @@ tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features,
>  			struct sk_buff *skb,
>  			const struct virtio_net_hdr_v1_hash_tunnel *hdr)
>  {
> +	const struct virtio_net_hdr *vnet_hdr = (const struct virtio_net_hdr *)hdr;
> +	int network_offset = tun_vnet_hdr_get_l3_offset(flags, skb, vnet_hdr);
> +
> +	if (network_offset < 0)
> +		return network_offset;
> +
>  	return virtio_net_hdr_tnl_to_skb(skb, hdr,
>  				features & NETIF_F_GSO_UDP_TUNNEL,
>  				features & NETIF_F_GSO_UDP_TUNNEL_CSUM,
> -				tun_vnet_is_little_endian(flags));
> +				tun_vnet_is_little_endian(flags),
> +				network_offset);
>  }
>  
>  static inline int tun_vnet_hdr_from_skb(unsigned int flags,
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e34c52d05..059eeb18e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2502,6 +2502,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
>  {
>  	struct virtio_net_common_hdr *hdr;
>  	struct net_device *dev = vi->dev;
> +	int network_offset;
>  
>  	hdr = skb_vnet_common_hdr(skb);
>  	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> @@ -2515,9 +2516,12 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
>  		goto frame_err;
>  	}
>  
> -	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
> +	network_offset = virtio_net_hdr_get_l3_offset(skb, &hdr->hdr);
> +	if (network_offset < 0 ||
> +	    virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
>  				      vi->rx_tnl_csum,
> -				      virtio_is_little_endian(vi->vdev))) {
> +				      virtio_is_little_endian(vi->vdev),
> +				      network_offset)) {
>  		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
>  				     dev->name, hdr->hdr.gso_type,
>  				     hdr->hdr.gso_size, hdr->hdr.flags,
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index c381b916c..a4c005796 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -48,11 +48,49 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +/*
> + * Return the L3 offset of an Ethernet frame starting at skb->data.
> + * The offset is unused without NEEDS_CSUM, so avoid parsing and return zero.
> + */
> +static inline int
> +virtio_net_hdr_get_l3_offset(const struct sk_buff *skb,
> +			     const struct virtio_net_hdr *hdr)
> +{
> +	unsigned int parse_depth = VLAN_MAX_DEPTH;
> +	const struct ethhdr *eth;
> +	struct ethhdr ethbuf;
> +	__be16 protocol;
> +	int depth = ETH_HLEN;
> +
> +	if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> +		return 0;
> +
> +	eth = skb_header_pointer(skb, 0, sizeof(ethbuf), &ethbuf);
> +	if (!eth)
> +		return -EINVAL;
> +
> +	protocol = eth->h_proto;
> +	while (eth_type_vlan(protocol)) {
> +		const struct vlan_hdr *vh;
> +		struct vlan_hdr vhdr;
> +
> +		vh = skb_header_pointer(skb, depth, sizeof(vhdr), &vhdr);
> +		if (!vh || !--parse_depth)
> +			return -EINVAL;
> +
> +		protocol = vh->h_vlan_encapsulated_proto;
> +		depth += VLAN_HLEN;
> +	}
> +
> +	return depth;
> +}
> +
>  static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  					  const struct virtio_net_hdr *hdr,
> -					  bool little_endian, u8 hdr_gso_type)
> +					  bool little_endian, u8 hdr_gso_type,
> +					  int network_offset)
>  {
> -	unsigned int nh_min_len = sizeof(struct iphdr);
> +	int nh_min_len = sizeof(struct iphdr);
>  	unsigned int gso_type = 0;
>  	unsigned int thlen = 0;
>  	unsigned int p_off = 0;
> @@ -98,16 +136,20 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  		u32 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
>  		u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
>  		u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
> +		int transport_offset;
>  
>  		if (!pskb_may_pull(skb, needed))
>  			return -EINVAL;
>  
>  		if (!skb_partial_csum_set(skb, start, off))
>  			return -EINVAL;
> -		if (skb_transport_offset(skb) < nh_min_len)
> +
> +		transport_offset = skb_transport_offset(skb);
> +		if (transport_offset < nh_min_len || network_offset < 0 ||
> +		    network_offset > transport_offset - nh_min_len)
>  			return -EINVAL;
>  
> -		nh_min_len = skb_transport_offset(skb);
> +		nh_min_len = transport_offset;
>  		p_off = nh_min_len + thlen;
>  		if (!pskb_may_pull(skb, p_off))
>  			return -EINVAL;
> @@ -206,9 +248,11 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  
>  static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  					const struct virtio_net_hdr *hdr,
> -					bool little_endian)
> +					bool little_endian,
> +					int network_offset)
>  {
> -	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
> +	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type,
> +				       network_offset);
>  }
>  
>  /* This function must be called after virtio_net_hdr_from_skb(). */
> @@ -287,7 +331,7 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  	return 0;
>  }
>  
> -static inline unsigned int virtio_l3min(bool is_ipv6)
> +static inline int virtio_l3min(bool is_ipv6)
>  {
>  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
>  }
> @@ -297,18 +341,19 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
>  			  bool tnl_hdr_negotiated,
>  			  bool tnl_csum_negotiated,
> -			  bool little_endian)
> +			  bool little_endian, int network_offset)
>  {
>  	const struct virtio_net_hdr *hdr = (const struct virtio_net_hdr *)vhdr;
> -	unsigned int inner_nh, outer_th, inner_th;
> -	unsigned int inner_l3min, outer_l3min;
>  	u8 gso_inner_type, gso_tunnel_type;
>  	bool outer_isv6, inner_isv6;
> +	int inner_nh, outer_th, inner_th;
> +	int inner_l3min, outer_l3min;
>  	int ret;
>  
>  	gso_tunnel_type = hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL;
>  	if (!gso_tunnel_type)
> -		return virtio_net_hdr_to_skb(skb, hdr, little_endian);
> +		return virtio_net_hdr_to_skb(skb, hdr, little_endian,
> +					     network_offset);
>  
>  	/* Tunnel not supported/negotiated, but the hdr asks for it. */
>  	if (!tnl_hdr_negotiated)
> @@ -332,19 +377,22 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	outer_isv6 = gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
>  	inner_isv6 = gso_inner_type == VIRTIO_NET_HDR_GSO_TCPV6;
>  	inner_l3min = virtio_l3min(inner_isv6);
> -	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
> +	outer_l3min = virtio_l3min(outer_isv6);
>  
>  	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
>  	inner_nh = le16_to_cpu(vhdr->inner_nh_offset);
>  	outer_th = le16_to_cpu(vhdr->outer_th_offset);
> -	if (outer_th < outer_l3min ||
> +	if (network_offset < 0 ||
> +	    outer_th < outer_l3min ||
> +	    network_offset > outer_th - outer_l3min ||
>  	    inner_nh < outer_th + sizeof(struct udphdr) ||
>  	    inner_th < inner_nh + inner_l3min)
>  		return -EINVAL;
>  
>  	/* Let the basic parsing deal with plain GSO features. */
>  	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
> -				      hdr->gso_type & ~gso_tunnel_type);
> +				      hdr->gso_type & ~gso_tunnel_type,
> +				      network_offset);
>  	if (ret)
>  		return ret;
>  
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 50cae32ae..04c80e23d 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2901,7 +2901,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  		}
>  
>  		if (has_vnet_hdr) {
> -			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
> +			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le(),
> +						  skb_network_offset(skb))) {
>  				tp_len = -EINVAL;
>  				goto tpacket_error;
>  			}
> @@ -3103,7 +3104,8 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>  	packet_parse_headers(skb, sock);
>  
>  	if (vnet_hdr_sz) {
> -		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
> +		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le(),
> +					    skb_network_offset(skb));
>  		if (err)
>  			goto out_free;
>  		len += vnet_hdr_sz;
> -- 
> 2.46.0


