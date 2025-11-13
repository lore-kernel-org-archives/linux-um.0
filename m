Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21685CD6E6C
	for <linux-um@archiver.kernel.org>; Thu, 13 Nov 2025 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C6ZlE/8wFoMWAmPveb7rTnuh4QFvGSZOBJ0lkY75WHA=; b=l8c6D2BQaOIHchwSGRgIOA94ci
	0RC83ja+Go80GDmeuRoaPLM4ToihinsiVj+MKFv1QR8m/EQ0YC58+XNiYSNRwpyWpbMNcYus4Qgb/
	vKLCQNSBIlSg2bYTzsvWuwIQXofIkPDJe6V1R5nmdQJ2inAQixzopfS6MwyRC1nyQe2hWRzmBqXQ8
	fQ0RipODn0VDXZhh3U40vmPPQChV57cOBMm2XWDLDM4+veI6Obq+OzymJnVOkJlMmr60Ji/GjGOz7
	fRewgsJV3GvrAO7MIlU3DoKk3p5pOHkhdWNF2Wm0IugCtdP/JQbarZzJNR1G0CjPlqukH19uG3XVE
	Wbns6wfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJYUJ-0000000AcrV-2wt1;
	Thu, 13 Nov 2025 14:39:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJYUE-0000000Acqe-0qg7
	for linux-um@lists.infradead.org;
	Thu, 13 Nov 2025 14:39:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763044783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6ZlE/8wFoMWAmPveb7rTnuh4QFvGSZOBJ0lkY75WHA=;
	b=aD0yq6Nf/JuXQeJmwadG1xbLLxcS6AR+Aw9a9tWB+57bJ+UaSs4xnOJOpngw+FJcFznqmk
	88Orl5ckAXXKOL2fkY3kXedQHPcLpH9ero8vhF+OwgJzkrMDSTOwOqR5T/Zm+HBJrCFay2
	UXBlipk2Bb/PLO5iHdNDy1WvST/79ME=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-LpEhHUyaMdOzUX7-l3v95Q-1; Thu, 13 Nov 2025 09:39:39 -0500
X-MC-Unique: LpEhHUyaMdOzUX7-l3v95Q-1
X-Mimecast-MFC-AGG-ID: LpEhHUyaMdOzUX7-l3v95Q_1763044778
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c7b0ae36so518757f8f.0
        for <linux-um@lists.infradead.org>; Thu, 13 Nov 2025 06:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763044778; x=1763649578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6ZlE/8wFoMWAmPveb7rTnuh4QFvGSZOBJ0lkY75WHA=;
        b=RqECwMY6El3K8spLLEGaLEtYP16KRAQHIVkHVA7SlccJm1eLxOqSA7KmnHcLq0JJh6
         oL5wFAEGtWd7+YT4HS62wcOPNhi56JyYpzxEu6CQrWrbwgKTtPcE3kS0wRmOeem6W0Y5
         MZEhd7RoPsmYiADM4fcbjf3X0m5xP/7g4yJQP78IeBpzPLmJUnGaBsR854ZGSb33JE4F
         fZY+5yT4wfS2MNiRtr9PgrrP6huUL+vTMQb5auPQua87E4tUBZJPuRGw7Bg+sBYYngiZ
         N+QG1JttvW1F13IJShea/ZAH8IMWAepK28fdbVGtAX+WP7l2fbnZG0+vKE11W48P+iq5
         eIVg==
X-Forwarded-Encrypted: i=1; AJvYcCXB0ACAX6qgfQq75yBpkrS/R3wafr0v9i6tMd/BajbwfowUzcz8i9MH8uuroRz99iozm+N3B7ph9A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxluEuHuYrKkqEn+XoiYlxATzvOJPik7Tyo3eLioQD7pgL5PhN8
	pDaqSIJ6564z3tXAXEklo1GWltL9+NgWXziADzjvMPnLAtLYMCLD6lfQi4NxDxFQzGfMHbKaaAK
	/l6My1D52dIqVR1q/Ovv09Rgwy/pvOjnxK3HTyJ4KbIpDz8rs6TLsjJwpFcZ0v2CHTw==
X-Gm-Gg: ASbGnctPeeoeOypr4rcnqYvlSwZulFPiB50iFSaHW54c9eRX0N8zSiZLCtL8GrkLxl3
	jaAIyDuMHoph23cZy0aN+uFy2rfC83U0W9xoP/RGrrO+OqIgZXXBMzZVfP5fVHYmc60TeVWIRb8
	xQgaPfg/5GWxAX1RBXSQrfG/At2LWv93gzQY4twQo62iEKZbBEvRE1oPWXdI07HtOx/vmzQHqJc
	MdjQQsrVDNPkPTMafxpgLiuS1s5jzIXBFKhpNxiAGhcTyJAKwxaN5Rku3JHUes/Dvcvzttjk3A6
	Hpi/WcfpxUtpn9nV4GuIfoJ2l0FQwSYoGljDLtYmpFKd+bv3UMajVS715XGvoktXk5VMONUioNL
	+7ihmPTnDXrlz
X-Received: by 2002:a05:6000:2911:b0:429:cc35:7032 with SMTP id ffacd0b85a97d-42b52821778mr3447032f8f.23.1763044778218;
        Thu, 13 Nov 2025 06:39:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGec5SZJzkrdZIMQyF+gi07hDcBuVbPd+9nb9X5ZfZ31kZtvs0xZMBq40lgAX06ufK4If5sPw==
X-Received: by 2002:a05:6000:2911:b0:429:cc35:7032 with SMTP id ffacd0b85a97d-42b52821778mr3446995f8f.23.1763044777793;
        Thu, 13 Nov 2025 06:39:37 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f29c5fsm4196462f8f.46.2025.11.13.06.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:39:37 -0800 (PST)
Message-ID: <25b05194-63cd-4265-8d2c-e174d801fc3a@redhat.com>
Date: Thu, 13 Nov 2025 15:39:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/2] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>, linux-um@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
 <20251111111212.102083-2-xuanzhuo@linux.alibaba.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251111111212.102083-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 01Al39uUhR3cPkWyQioykNK2ynZ5-BM03UWhGoNRALI_1763044778
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_063946_659770_B4D0F6F1 
X-CRM114-Status: GOOD (  14.57  )
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

On 11/11/25 12:12 PM, Xuan Zhuo wrote:
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

IMHO this looks like more a new feature - namely,
VIRTIO_NET_F_GUEST_HDRLEN support - than a fix.

[...]
> @@ -2361,7 +2362,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (vnet_hdr_sz &&
>  	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
>  				    sizeof(struct virtio_net_hdr),
> -				    vio_le(), true, 0)) {
> +				    vio_le(), true, false, 0)) {
>  		if (po->tp_version == TPACKET_V3)
>  			prb_clear_blk_fill_status(&po->rx_ring);
>  		goto drop_n_account;
To reduce the diffstat, what about creating a __virtio_net_hdr_from_skb()
variant (please find a better name) allowing the extra `hdrlen_negotiated`
argument, define virtio_net_hdr_from_skb() as a wrapper of such helper
withthe extra arg == false, and use the helper in the few places that
really could use hdrlen?


