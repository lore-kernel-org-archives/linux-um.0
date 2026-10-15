Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C2ECC6B39
	for <linux-um@archiver.kernel.org>; Thu, 15 Oct 2026 17:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZZvyPedXovvZDXPLa62gGgR2ST9LAGqR+oO13yEpFUg=; b=HjKeNP2L8ujOjFBy9Rku/GNUxs
	KlYiJVJ4lnLXLHIDZw0CTP0l3AXn74xwu06vYzMX4vU5qpWeaHXdrH1AbNoaRMWZAGgHZV5N2cllK
	0TpYy67n4bepoFtppi8YfSTok6xgDLFs6PaV+SWMCC5z5SjUK4D8RdFLHYH39MTrxotSf6C0tPpPH
	VXG4OMYMKbisK8jEzyBeBeVk3zQQcPenoYLZOisuljCCQHvq9P1AB1pvFdm1UD/vnAItptLuvYbGu
	NZgPrHbM273XqdXt3blt6QuwcnvvjKzYYacTxwSCDsZNcn0dH8Fzur3gmekoVOG/rgzkW0JpPGAa+
	ADz0cywg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHP72-00000000yJs-0Oab;
	Thu, 15 Oct 2026 17:19:28 +0000
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHP6z-00000000yJ7-1z2b
	for linux-um@lists.infradead.org;
	Thu, 15 Oct 2026 17:19:26 +0000
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-5e82b413858so636139e0c.1
        for <linux-um@lists.infradead.org>; Thu, 15 Oct 2026 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792084764; x=1792689564; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZZvyPedXovvZDXPLa62gGgR2ST9LAGqR+oO13yEpFUg=;
        b=kMFxSNKBm3LILhCYP6X0MURcnKHoa+jONBq8RmpEQ9xFpfruV10jCOSnBB/luREbcF
         6/f01ZyRkul+Gn1C5dKojNC1sbrH/x2ij+6ctHCGBQxeKosuz8EBY7FMU66gpitrKBks
         YZWcMQq8E0IMiTDJdecFzLGUnl7ZKIkkqTv8KpMAza7unOTbYMRPgUesuXRsZh+e13tU
         17ye2YW5lzaInp42PUvZVQmHdI2ng70fEMjrtbAYZwtPxFBfY7y+R+K+B6zplKLtm1Jq
         g6LalzUkmxIOZWaZF5ZveKj5sth/nrlEBLOXPn9Yu2tjPpS1LN7luC3qBBmJiyF3qMIk
         GG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792084764; x=1792689564;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZvyPedXovvZDXPLa62gGgR2ST9LAGqR+oO13yEpFUg=;
        b=nURNuBxIgVzCc3gbIFz2y77F9V7GUXJAljH+cBkMCqSA/gWNce/iwooEyC7h8uTWAs
         ea35QufdeSEQKLCl6gAC0rM1jWL/Jo3UYmOQSP3cZk0LuRX77FrEadnZbYCfi8ziMZKv
         nPd0YuGtDdXUXl3ZKlPz6JR0/T6o30MXfALmSqQI35dIbXuHd3SHkZ9rSWMJkOC6uDlJ
         pgvN5uhtQVSEj1cj1QfzD8j7mxuRRJPnl9fpSIRiEbQDeS9dCuzZ5vaT6ZlhHmFJiRR0
         wJZrlnYm2E2hAfdrHTyqBm4uuCckwO91pyuSc720K+LgwTttQOUqrlZCJSf/v84Pw8lu
         5yDg==
X-Forwarded-Encrypted: i=1; AKwUvBysEnwXShGAFDpsVFBhbrVamOSHquNf8x1vRHjPh6YqMDuVUXxC3ZYFn+G2JdvpVJrWhDEKTvcxxQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYICQZxD52Bo/caP152pkY+huZgpOsA46nq4DB/OrycONhFoD+dF
	jTFB1JB9MwPowvZsJh1lklw2j8Lygz1Ij3UYXDcaSZ5R018Ns6lZXY/P
X-Gm-Gg: AYBFou3/96yYdhd+0rP0TfR0T123YiRrXAgzNA86Ymr9uynaqNdAEwkEbV+Bt1vL6N7
	M8tw8f8P8RqXzPgzuP/Y2P3uYJpWNCg8Lcs2suMsXgTbeM5Y1R0dJmK0orUUW97wpFaVCdT8xLL
	5uHs1iUKjHsBYLkBbt/MwTULVKNrL3+dYaDsZF7067YV1YDWm6p82DK9XKu7T5UHBt4iGAID40a
	Y82MUk3qnc0fz7kQFdzLJCG6s5djGdpZHoLwpO5kIJUE3PtKrHLJMGImTHcvAQHWgetTuOw3nr3
	Q0UE2voTbdXc3BlNPNBjey/JD1GGNyh4uStE+bu0NZubBU0ppcgJsHD7q7xmjGeJ+oYCjJxvuD+
	nvsmoNwBU1fXiFyxVR7t09BeAJh1ZAfhDWrXhz+hoVYqjr0e0VPmt/sr6jr9IL9pycnhTTQU6/R
	ZT9/4PGGeyoLmZL6Diu7Qbzm9KhkIDwnVqLTbaVHpmnDf91JlyZtEsG4TLFN8tlKrwhMLSBTJQR
	UCupb483AenQgjo7OmIPB5K8xRsd1sdWUs7aAfizQZg/7FibGIEJZoc6OMIJsVh7LjeNpyKffFd
	SahmjK3ka0FCdYf9InoOHoTORiT6SDRHUNb54w+DhKkNTCHA
X-Received: by 2002:a05:6102:370c:b0:7c3:2b19:6266 with SMTP id ada2fe7eead31-7cb3739fd7amr4589811137.22.1792084763651;
        Thu, 15 Oct 2026 10:19:23 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9900490dd07sm12972678241.3.2026.10.15.10.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:19:23 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:19:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 linux-um@lists.infradead.org
Message-ID: <willemdebruijn.kernel.10294d16149b7@gmail.com>
In-Reply-To: <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_101925_523998_4BF8A648 
X-CRM114-Status: GOOD (  13.55  )
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

Michael S. Tsirkin wrote:
> virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> it cannot make sense of, but the vector raw transport ignored
> its return value: rejected packets went on into the stack with
> their metadata unvalidated.
> 
> Propagate the failure.
> 
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/um/drivers/vector_transports.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> index e1fb2a76fdff..8b7548458663 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -210,7 +210,9 @@ static int raw_verify_header(
>  		return 1;
>  
>  	skb_set_network_header(skb, ETH_HLEN);
> -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> +	if (virtio_net_hdr_to_skb(skb, vheader,
> +			virtio_legacy_is_little_endian()) < 0)
> +		return -1;

Should this return 1, like the above?

Not sure whether the verify_header return value is well defined beyond
just boolean.

