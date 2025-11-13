Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C97CCD6E73
	for <linux-um@archiver.kernel.org>; Thu, 13 Nov 2025 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ccPBcVEYfv3CKsEVYsFhFk4zVwAZCORA96fhkulkBm4=; b=H6DpBzn3sEH21ujmOp4FDjEMJr
	e4lGCk2GZUAGUFcd5rX49b4oxIntNb61B1WzUo5T/rQeBqmAK3WIXWSTCfQ73Nj0tc7W9Hq8BpE1K
	YgEhCRoiONWYm5JdUXIbK4cwkv5qtWVsa5tnSNRjX/pSu3TyCxCKJsOQJlPg1v2RDPG2OBR96UU0Q
	2ZO1o4yOAiCLbfVN7aeadklxhVMa2Ma04ZnB/WFYdInWeLGRq1DUp+oPgOpC3eD80zL/NKW0x8rZu
	cNxccCc1ft1HVn6RQy/6LhwLnj0J/ZauDjVQQKLGZwzLBpETfOdaqrGQ6YkyWkWQezrN44WrZd620
	rW1n03sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJYeX-0000000Ae3M-46H3;
	Thu, 13 Nov 2025 14:50:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJYeT-0000000Ae2Z-47WH
	for linux-um@lists.infradead.org;
	Thu, 13 Nov 2025 14:50:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763045420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccPBcVEYfv3CKsEVYsFhFk4zVwAZCORA96fhkulkBm4=;
	b=AyGJ+RVzubab4ACwUSsCC1wCyW8h2JNJnYrbAGrujceegOyH/9xnq3EZyJ4CQPpfqMWRqv
	eSh6P5nivZtyT4GODU7jCjkeh9D+HvoiWgCICOpbu6tchLZn4s+T8h5QdLscQlDysxrDBc
	aQgVtBpo/QXchDVyy3UBcSl8iG877fk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-kq8JxMyNMka8FPEmpg1PfA-1; Thu, 13 Nov 2025 09:50:18 -0500
X-MC-Unique: kq8JxMyNMka8FPEmpg1PfA-1
X-Mimecast-MFC-AGG-ID: kq8JxMyNMka8FPEmpg1PfA_1763045417
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b70bca184ccso124023566b.2
        for <linux-um@lists.infradead.org>; Thu, 13 Nov 2025 06:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763045416; x=1763650216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccPBcVEYfv3CKsEVYsFhFk4zVwAZCORA96fhkulkBm4=;
        b=f25+dwknhphV55ajZrwPEn8+MMmf7saTs9WlCSJrq1ohiPR6+lDz955Xq7P9++TjRl
         UNUbSqk8iGIylMnnol5wN5NnZJT2NHrciVa/zPfQSgaJ/SABWn/soIqXSrqaD8X+MBTx
         clZ+5diN/SrLXGj79/eQ3E+k7D7eGFtU8QJGO/LoEO35wzUg+kSd75nTWGpMild5oINI
         m4qeW3vqOLA5tbg5YOyXAsn2VDnGMKVvuNbX7sAhFEyXf5hCmghwEdNCUf9QvFl6xYQh
         Z64PnS5syFlM9YN2OzKdNcNgiCZP3FoNrbg27t6YsNng5LWRX+/vG3BRzEwnyrbLDhuQ
         lfsg==
X-Forwarded-Encrypted: i=1; AJvYcCWPZSQ6xrZNxaaCHA0IPVvw4uZEvbfgjFrh8ZJ0lT+BgoOGWGce5DNYTFBpenFmL9Tku3p2AGi+Zg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxq/JLt29dCqwHkWd5urXmo4Wy2+LK6RW1ZHfSlp+aIwIrXnXYN
	3T3EfUSiUzUClNM/s3nXyiNAmCsJkfxnMCqiDXJkx2e4t1qm6D8M3l/x0O4hsfTcLqgd7JpMIk4
	Oy0Blg6vtmEjHQB7yRRW1hRTHUQTeMHDYShWDvMwNJDg1D6RuAqamBqSB1uGedvuvPw==
X-Gm-Gg: ASbGncs+tLPqwRsM8CiD2IOo2jrf007Lg7jKhwTViLzuzltlkvDvDMVG07jp592RtcX
	U4N4cmTpVu7x24xX2lgtHAznMc20w6SHxPV1ZuRxUucFKYYznOaQFwZ1wXBukxxYM86eiqUrXXn
	wxUdFLd9vtnUVYl/zHNn26BInxYm1tPbBI1x393iFVR1VLjXIVLVBB2HX42TFvF61xp4Vgvlzc9
	Y5TXMZdZlmM9DZOOVEoa6nAQ2QhaN5enH96wY7xDzQ+kmChF6EjOU4TSLMekkwLYmZabb+seSJn
	AQX66Z4i6d1leL9Xz2FWtGpqYjO6MrmoGcTKUT8C52gadZlBU9td6Qctb9G/KzY0NjSGcDBgJms
	q7V36ZolrIyei
X-Received: by 2002:a17:907:6092:b0:b6d:62e4:a63a with SMTP id a640c23a62f3a-b7331aa9775mr765257566b.40.1763045416535;
        Thu, 13 Nov 2025 06:50:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd5TszTx9Ftbc+1tpBg2R5bDY4Ip4/CQe2Mmx4GrIHNGWKqsCGbjONvF+Dgw0TZ/pVKl41bg==
X-Received: by 2002:a17:907:6092:b0:b6d:62e4:a63a with SMTP id a640c23a62f3a-b7331aa9775mr765254466b.40.1763045416035;
        Thu, 13 Nov 2025 06:50:16 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734ff36ac6sm175932366b.74.2025.11.13.06.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:50:15 -0800 (PST)
Message-ID: <f79bf201-c4fe-41a9-9ccb-b93271d83183@redhat.com>
Date: Thu, 13 Nov 2025 15:50:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/2] virtio-net: correct hdr_len handling for
 tunnel gso
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
 <20251111111212.102083-3-xuanzhuo@linux.alibaba.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251111111212.102083-3-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fe-10yJuNwMdS1D-CXXDv0eYi_vTb8iY5L-XxKQksY0_1763045417
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_065022_122048_03552B7E 
X-CRM114-Status: GOOD (  18.32  )
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
> The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
> GSO tunneling.") introduces support for the UDP GSO tunnel feature in
> virtio-net.
> 
> The virtio spec says:
> 
>     If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
>     VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
>     all the headers up to and including the inner transport.
> 
> The commit did not update the hdr_len to include the inner transport.
> 
> I observed that the "hdr_len" is 116 for this packet:
> 
>     17:36:18.241105 52:55:00:d1:27:0a > 2e:2c:df:46:a9:e1, ethertype IPv4 (0x0800), length 2912: (tos 0x0, ttl 64, id 45197, offset 0, flags [none], proto UDP (17), length 2898)
>         192.168.122.100.50613 > 192.168.122.1.4789: [bad udp cksum 0x8106 -> 0x26a0!] VXLAN, flags [I] (0x08), vni 1
>     fa:c3:ba:82:05:ee > ce:85:0c:31:77:e5, ethertype IPv4 (0x0800), length 2862: (tos 0x0, ttl 64, id 14678, offset 0, flags [DF], proto TCP (6), length 2848)
>         192.168.3.1.49880 > 192.168.3.2.9898: Flags [P.], cksum 0x9266 (incorrect -> 0xaa20), seq 515667:518463, ack 1, win 64, options [nop,nop,TS val 2990048824 ecr 2798801412], length 2796
> 
> 116 = 14(mac) + 20(ip) + 8(udp) + 8(vxlan) + 14(inner mac) + 20(inner ip) + 32(innner tcp)
> 
> Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/linux/virtio_net.h | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 3cd8b2ebc197..432b17979d17 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -232,12 +232,23 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  			return -EINVAL;
>  
>  		if (hdrlen_negotiated) {
> -			hdr_len = skb_transport_offset(skb);
> +			if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +					       SKB_GSO_UDP_TUNNEL_CSUM)) {

I'm personally not a huge fan of adding UDP tunnel specific check to the
generic code, did you tried something along the lines suggested here:

https://lore.kernel.org/netdev/CAF6piCLkv6kFqoq7OQfJ=Su9AVHSQ9J7DzaumOSf5xuf9w-kyA@mail.gmail.com/

?

Thanks,

Paolo


