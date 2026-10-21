Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D3606A319
	for <linux-um@archiver.kernel.org>; Wed, 21 Oct 2026 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Y1GEDhug;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FUmztXpR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xlUjPkBFZR5E69M180zZ7SvybteIZBcwvq7YyxzDeRI=; b=Y1GEDhughrTXBZhYRKMavL2tXH
	uCb+fKxjVSjtLQJRSdmGWe0di3R9uLaDhkK3D3Mp5JvY6hW3hN85RKl4Bd0jwO6eF5xmZpPnCcxlS
	9Iq2x6nBrO1L6NMZmsX0b5RwmKQirvucgHDmXsoTPSS0gW+g97sMUWm8dB3TasbqUi8JTL6PcpMmK
	dUyQSTkGcDQsdCNJBwvzUZEmio3KbYgSl7DPbFDEmaOo3vCFmFNflKhkhsF5YY/LD24aK4XZ4nqGq
	IO8465es0WkWj8v/Ytxd1fGAo8GCwkMQ6PqhNvqEWsuP8Etas8bIZmBBjcwm1k/jJQE/YmgHxBNSo
	HZ63gpjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJYs5-0000000CLi5-26Ej;
	Wed, 21 Oct 2026 16:08:57 +0000
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJYs3-0000000CLgz-25wc
	for linux-um@lists.infradead.org;
	Wed, 21 Oct 2026 16:08:56 +0000
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so51013241.0
        for <linux-um@lists.infradead.org>; Wed, 21 Oct 2026 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598934; x=1793203734; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xlUjPkBFZR5E69M180zZ7SvybteIZBcwvq7YyxzDeRI=;
        b=FUmztXpR33MtDfaBwW73FbaQVdwbsVF2jPPlyrvzZcR2VTkDaWd13VP6sBaZS4j/yt
         TVAluwksD7xjHNhmhFso62lbxG8ZSzK+HhU+49DhupVsWOTz/RrFFiUN2Iqt4kzmZEcs
         L4aqyzWT5i/hZ/mRUkSOQpglnieGk54xJOjqeD+3h0OFbPM+M7PmV5AdPSYNQsQnta0r
         PTuzc/6ofFm3tMvUCb84/NBCKTh2ru/vknqW7xHiA11fXd0YuuLxuMQcCFKIE5lC/9Vo
         rnP2bUi3JBO9Z6ROvrXhAzAkWZ3/0Y7/bLSnVjOa9AuCKCdbTqk55pljWPXk+rCpqo4i
         KZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598934; x=1793203734;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xlUjPkBFZR5E69M180zZ7SvybteIZBcwvq7YyxzDeRI=;
        b=tWmwQfH/GG8K98QXUrLFaOGPD/NLV0pu1mdcHSJtI0yK2/ypeewrRO7HO2knnnW5pp
         5muCryEkGk3od3wAM3rONBXYY3Vwrqol6fn6HEMv5sHQuCjzgI8bKVJFU5XYgFTbYu72
         /YzASV7CEY0CQ0O94gzH6n3A80Y5HS5fp7r8kMd8EBR4r2sYboP+3eeTovuaCTkRuU+N
         k46y+8Y9N2dNgxKBbOUTaFcxd9Jx14dJtdZG7dehESUZVhzHGg0zhZIjkWgih1SXiSit
         sU6qV5kyKcrmAIEjsNK/Z2WWDzJPb+mQFI9qbNeSQizNFokXrq1hg5L5zhyJzECzs4A1
         0RsA==
X-Forwarded-Encrypted: i=1; AKwUvByc3MOGDnrYg6x1lPq10WiCYJtin7X0bynsaEAY2BoZUqBuIZ3dKpXxwU46V9krpUdS4lV+f2gfww==@lists.infradead.org
X-Gm-Message-State: AFq9FYJOI6TBJnjpbB7RsO3YiZBD9T8rD8RLmaR0mL1F9Az6RUJOBaPv
	bTW96t6QvDHqWLxH+P1CD6P+RIdRnmxOw9UTeoBbnOfSMgNC8eD+nJFt
X-Gm-Gg: AYBFou264wE3d2ADuiRvzu32YsNe23EH8MgTn7mPku4f/ono0UKU7IRhzq0BgjkViAm
	ewHDMtHuV877nHJvcoNhAiaesz/z4zv2PPpsRaKNJg6s1yjK31s4m9BcWxQSUVbcppht2/M5X/3
	pNBdvc8bMR80QNXs3TBX40JFjr5ZUNIX0D3s4MNomRcIxNVw/3RrY/YfaM9j2Hul/K8ivIF83Yx
	g4wBr2qr9u3QEIm4+qQh7WiJIzDxw8JzWpQ90rzW+bDbOrwYA6MU55AoO8XlJ1/P4s7AMFVprVm
	LxSQkzzMRuY+t9E1byQaSF6RXHxICI2VMMCtWd8puNsJYeLbTyjUv4DJGHthTF7XBbwQ+3EvMWL
	DmLTqAFXVf9ZXabxzlexvjA8yeKsUK23+NOZ0r94+YLMYunb/tDkWsHcXsEuhqHZs+PNSlWU+lj
	yMEMSiUi6mrNd02BixhIYa6cWjaOHT37EpImHzFM5D7sOzOTT8eNiwBvOkie5OhyhCu8tc1Rfam
	+kvbaH2jm/Sb8TGzptdi29+VRYI+5Zz3q6XvbDOKsxSwee36y5pXpi4ouKqwJqhgRxmTfqNFL31
	2rEXUcrcpmK0Re+f+w5EYHYnWmNtc/rAXW1N1evwWriJh2VqCVpsUyHNK0eyiOCnuZuZ3qe3Im7
	QWobJQ08sI4v5NBshFAQ=
X-Received: by 2002:a05:6102:21cd:b0:7ca:9674:a58f with SMTP id ada2fe7eead31-7cc7bcdf51amr1136476137.32.1792598934205;
        Wed, 21 Oct 2026 09:08:54 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d0e0ba56sm3638029241.1.2026.10.21.09.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:08:52 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:08:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
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
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 linux-um@lists.infradead.org
Message-ID: <willemdebruijn.kernel.186235776c7fc@gmail.com>
In-Reply-To: <26741a9a64c28e8de6d13e04972d296d89e1c95d.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
 <26741a9a64c28e8de6d13e04972d296d89e1c95d.1792565282.git.mst@redhat.com>
Subject: Re: [PATCH net v4 2/7] um: vector: trim skbs before verifying the
 header
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_090855_557558_C79CF1D0 
X-CRM114-Status: UNSURE (   8.73  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Michael S. Tsirkin wrote:
> The vector receive path over-allocates the skb and only trims it
> to the received length after the transport header is verified.
> 
> A follow up patch will complete the packet checksum in software within
> virtio_net_hdr_to_skb so we need the packet trimmed (otherwise the
> checksum would be computed incorrectly over the unreceived tail of the
> buffer).
> 
> Trim first, so the import sees the packet as it was received.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

