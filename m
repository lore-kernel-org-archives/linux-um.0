Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D90CCF9E3
	for <linux-um@archiver.kernel.org>; Tue, 11 Nov 2025 11:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PjCGGcQyKaDkEEr1GFCr8tFawZ6AhFcGLUOM7JGRy/g=; b=rWyc7u000GCA+EeqasHrjAo+s4
	mjx2N9awDnyea00jxQcC94F1qn5INDOYumTwpE91LuIhY0sixdnYafSUABU9paTL16OFwxF3m0bYM
	MGDd0wdcabARQHUmzMN5pv28JVAX4uDw+/VP5Fls3S3mWr9C1O7ROp4F//hzji7qPztDRIwq1ztPM
	1/QQHzAlGEnZSBbHEHU/N8WkIF+wBXFuQLvxoBuaNKdzBUmTexBpjNoHzsiBd/NNUo1dvss03HllD
	voWwbIWSa2oc2bwI+3kNoxHMsmzQvvV1RorJ8MsR8MJy8T69p5Nwcy94XNr1IlY9mRSU/yeY07lxy
	C6MH1HDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vImeK-000000074n9-0quj;
	Tue, 11 Nov 2025 11:35:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vImeF-000000074m8-46I1
	for linux-um@lists.infradead.org;
	Tue, 11 Nov 2025 11:34:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762860890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjCGGcQyKaDkEEr1GFCr8tFawZ6AhFcGLUOM7JGRy/g=;
	b=IN0OT+Ht80y+1Rbz09FspsraVymXJmAlsHdQmE8Lfi7COp/x5SOsntFJhk28cqxg7UET//
	0THb41YaB5fJQ5ouHwTNK9h9dk9bpK1670vj772jqvcBWCeyc5BYMggbLcy8cLup/SgYO0
	878PJBZq6Av8HQAE1bAsqDVOjLxbEm0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-Q5vlVg0HPtiFwEk1g-7HCg-1; Tue, 11 Nov 2025 06:33:10 -0500
X-MC-Unique: Q5vlVg0HPtiFwEk1g-7HCg-1
X-Mimecast-MFC-AGG-ID: Q5vlVg0HPtiFwEk1g-7HCg_1762860789
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-475e032d81bso22794595e9.3
        for <linux-um@lists.infradead.org>; Tue, 11 Nov 2025 03:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762860789; x=1763465589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjCGGcQyKaDkEEr1GFCr8tFawZ6AhFcGLUOM7JGRy/g=;
        b=RSOJSs67o1aklDtEDZC2fhTjFW1sPK97syrnzvD/Sp9nhOMBTm+HSwFD0DheOUl2LS
         6xEjJveRm222iqvaPO/UVKn04TvUOzjcQIR4lISsvBAv/bsWRWvh5wBp210/uqyN39J3
         i4f4NjBP3y8uw2rikopYnl/QxFL0mD5tljmODYHXW0DyYI3Gj5Fgqwm/h9L3E16vxtY3
         OSH43aRuJeW4E1WSb6BUVTQLMWg9+jW2CkrtuOPBz7zaPRpich995vcww06HdE2c6YqO
         36aHXdvJ8lX5Qu5PYJANub41p/sOsm/Bys7jylkL8WNiLKpLylFEO3/Xl3BaAzJP3WcO
         0OqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmUIQHkYY5xcl9TQbwsZop+fZVe1vDVePFdxxH9O83460Qzf+EYu2fjjUA5btLKBt9CDnCxDWa6Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YyLqD/XKSNTRIXmOGa9ZfuCOnuruxtUQjdu1QT8KBaGGt3LVbwG
	CwWyU/nI+SDTVXN9dGNg0VEPbs2bs4Enm4jWYFPoIrL5COdEf63SZxTcg1IoSR7SBhJWtWKXZaA
	B0/2oy4SvQVkjbHsE8KsnE8QD/RFI9H967A2jd2/uryfc22TrQNT77MLCO/Q48oDQ7w==
X-Gm-Gg: ASbGncs0oezdf37W34MmXCTBkjxVEuQnAoIDpzY+HLVrJt2U+XkGuvPcyqYXpXTy1b/
	8MDYRnNi6Q9M0T7XzvWCmnRjUlBAqqedYB39SgAfBMeVbg7BTH9vgP4ObmN5vT4igb6tlAlbHBq
	ckGCAuhRrnaEuN9PWlzpm2nJB9ocaVV5120RqCiSfqJDlyhdNTrLPsgt7wiBYqxBtcVwDbspus1
	roa18VxJm/l2X+cjRi+x1unlLvaSugJtliztMsme1CTzRXRNSW9zDJ8BB5ryMbsYwk0EyTJ8CAG
	+oB/ka7uHTdmVtnG3z16awAGGGomvckZeRU+Pwxu/ARLJp7Ym4nTzhR1+5nxaZ2GWPE=
X-Received: by 2002:a05:600c:1c1c:b0:475:dac3:699f with SMTP id 5b1f17b1804b1-4777322f0c4mr107507875e9.9.1762860788977;
        Tue, 11 Nov 2025 03:33:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9ZCOmzxqJgcOY7n4UNMc5skj2Q4Gv3GNfnYtKyWdcU0NAs5MYuDVCV20onYhye1hP6smGaQ==
X-Received: by 2002:a05:600c:1c1c:b0:475:dac3:699f with SMTP id 5b1f17b1804b1-4777322f0c4mr107507485e9.9.1762860788450;
        Tue, 11 Nov 2025 03:33:08 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47781d3875csm17005245e9.3.2025.11.11.03.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:33:08 -0800 (PST)
Date: Tue, 11 Nov 2025 06:33:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	linux-um@lists.infradead.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net v5 1/2] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251111062859-mutt-send-email-mst@kernel.org>
References: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
 <20251111111212.102083-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20251111111212.102083-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cjxgjH7VzGkLhb07R6HYjzrI_tZqRoNt3ss_N0TMFt8_1762860789
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_033456_106372_A1AC73DF 
X-CRM114-Status: GOOD (  31.63  )
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

On Tue, Nov 11, 2025 at 07:12:11PM +0800, Xuan Zhuo wrote:
> The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> feature in virtio-net.
> 
> This feature requires virtio-net to set hdr_len to the actual header
> length of the packet when transmitting, the number of
> bytes from the start of the packet to the beginning of the
> transport-layer payload.
> 
> However, in practice, hdr_len was being set using skb_headlen(skb),
> which is clearly incorrect. This commit fixes that issue.
> 
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  arch/um/drivers/vector_transports.c |  1 +
>  drivers/net/tun_vnet.h              |  4 ++--
>  drivers/net/virtio_net.c            |  9 +++++++--
>  include/linux/virtio_net.h          | 26 +++++++++++++++++++++-----
>  net/packet/af_packet.c              |  5 +++--
>  5 files changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> index 0794d23f07cb..03c5baa1d0c1 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -121,6 +121,7 @@ static int raw_form_header(uint8_t *header,
>  		vheader,
>  		virtio_legacy_is_little_endian(),
>  		false,
> +		false,
>  		0
>  	);
>  
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 81662328b2c7..0d376bc70dd7 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -214,7 +214,7 @@ static inline int tun_vnet_hdr_from_skb(unsigned int flags,
>  
>  	if (virtio_net_hdr_from_skb(skb, hdr,
>  				    tun_vnet_is_little_endian(flags), true,
> -				    vlan_hlen)) {
> +				    false, vlan_hlen)) {
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
>  		if (net_ratelimit()) {
> @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
>  					tun_vnet_is_little_endian(flags),
> -					vlan_hlen)) {
> +					false, vlan_hlen)) {
>  		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0369dda5ed60..b335c88a8cd6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3317,9 +3317,13 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
>  	struct virtio_net_hdr_v1_hash_tunnel *hdr;
> -	int num_sg;
>  	unsigned hdr_len = vi->hdr_len;
> +	bool hdrlen_negotiated;
>  	bool can_push;
> +	int num_sg;
> +
> +	hdrlen_negotiated = virtio_has_feature(vi->vdev,
> +					       VIRTIO_NET_F_GUEST_HDRLEN);
>  
>  	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>  
> @@ -3339,7 +3343,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> -					virtio_is_little_endian(vi->vdev), 0))
> +					virtio_is_little_endian(vi->vdev),
> +					hdrlen_negotiated, 0))
>  		return -EPROTO;
>  
>  	if (vi->mergeable_rx_bufs)
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b673c31569f3..3cd8b2ebc197 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -211,16 +211,15 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  					  struct virtio_net_hdr *hdr,
>  					  bool little_endian,
>  					  bool has_data_valid,
> +					  bool hdrlen_negotiated,
>  					  int vlan_hlen)

Took me a while to figure out why does tun pass false here.

The reason is that this flag is really only dealing with guest
hdrlen.  so how about guest_hdrlen to mirror spec
or if you like xmit_hdrlen?





>  {
>  	memset(hdr, 0, sizeof(*hdr));   /* no info leak */
>  
>  	if (skb_is_gso(skb)) {
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
> +		u16 hdr_len;
>  
> -		/* This is a hint as to how much should be linear. */
> -		hdr->hdr_len = __cpu_to_virtio16(little_endian,
> -						 skb_headlen(skb));
>  		hdr->gso_size = __cpu_to_virtio16(little_endian,
>  						  sinfo->gso_size);
>  		if (sinfo->gso_type & SKB_GSO_TCPV4)
> @@ -231,6 +230,21 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
>  		else
>  			return -EINVAL;
> +
> +		if (hdrlen_negotiated) {
> +			hdr_len = skb_transport_offset(skb);
> +
> +			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> +				hdr_len += sizeof(struct udphdr);
> +			else
> +				hdr_len += tcp_hdrlen(skb);
> +		} else {
> +			/* This is a hint as to how much should be linear. */
> +			hdr_len = skb_headlen(skb);
> +		}
> +
> +		hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
> +
>  		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>  			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
>  	} else
> @@ -384,6 +398,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  			    struct virtio_net_hdr_v1_hash_tunnel *vhdr,
>  			    bool tnl_hdr_negotiated,
>  			    bool little_endian,
> +			    bool hdrlen_negotiated,
>  			    int vlan_hlen)
>  {
>  	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
> @@ -395,7 +410,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  						    SKB_GSO_UDP_TUNNEL_CSUM);
>  	if (!tnl_gso_type)
>  		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
> -					       vlan_hlen);
> +					       hdrlen_negotiated, vlan_hlen);
>  
>  	/* Tunnel support not negotiated but skb ask for it. */
>  	if (!tnl_hdr_negotiated)
> @@ -408,7 +423,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  
>  	/* Let the basic parsing deal with plain GSO features. */
>  	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
> -	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
> +	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, hdrlen_negotiated,
> +				      vlan_hlen);
>  	skb_shinfo(skb)->gso_type |= tnl_gso_type;
>  	if (ret)
>  		return ret;
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 173e6edda08f..6982f4ab1c73 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2093,7 +2093,8 @@ static int packet_rcv_vnet(struct msghdr *msg, const struct sk_buff *skb,
>  		return -EINVAL;
>  	*len -= vnet_hdr_sz;
>  
> -	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_hdr, vio_le(), true, 0))
> +	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_hdr,
> +				    vio_le(), true, false, 0))
>  		return -EINVAL;
>  
>  	return memcpy_to_msg(msg, (void *)&vnet_hdr, vnet_hdr_sz);
> @@ -2361,7 +2362,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (vnet_hdr_sz &&
>  	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
>  				    sizeof(struct virtio_net_hdr),
> -				    vio_le(), true, 0)) {
> +				    vio_le(), true, false, 0)) {
>  		if (po->tp_version == TPACKET_V3)
>  			prb_clear_blk_fill_status(&po->rx_ring);
>  		goto drop_n_account;
> -- 
> 2.32.0.3.g01195cf9f


