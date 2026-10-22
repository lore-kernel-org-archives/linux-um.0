Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204E606A319
	for <linux-um@archiver.kernel.org>; Thu, 22 Oct 2026 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mpX5elA2;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TJoLc1PJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wIEEgL0wnyCgnfYBD3fqLb39KxnaLSOeClNdZ/a2t8c=; b=mpX5elA289TV8X
	6tmi4O/u1lpaikd532IYjaKruU+CKarlPwAshqR7QYIvYtirTITPx9ZxifPAdyxg+ERqg3NOhzoRP
	cBQGm44EAWcaE0p16q+wLgFjNgCj+z5Za8TknaP9FI2YwgccbWu4pMy8h14xwdj1P3y3gC/xnNyG9
	d1O/1TGQbEVFx6WsJsGmZ9GdnYG1InoxnNQl2krCf+gqlxmblQrU+nJmr42uWnX1dJmGad0U9Fi4P
	vV1+lxBU6hPGo6Ud0xnM/r88Nfh3pRdheMKdFC30SHMtMcocidLMjNBK8mtgQGOPPGkYGVLLL8swJ
	DmObY3bVZir9pizRBzuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJtvX-0000000EJiH-3CxG;
	Thu, 22 Oct 2026 14:37:55 +0000
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJtvV-0000000EJhJ-1cD3
	for linux-um@lists.infradead.org;
	Thu, 22 Oct 2026 14:37:54 +0000
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-5eaeb7fdda2so1688471e0c.3
        for <linux-um@lists.infradead.org>; Thu, 22 Oct 2026 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792679871; x=1793284671; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wIEEgL0wnyCgnfYBD3fqLb39KxnaLSOeClNdZ/a2t8c=;
        b=TJoLc1PJ4j3etaXKknbc/d02NrV1qd8wk08KrLGgTwrt8Mib6wuqHvaYf1mCxSeGfZ
         BwJiVdXNbXfAJvR3sEJcnLUDGQ4iOhexRKnH495GdIsDX1iySxNNtagg8Az2DW+FSJrO
         Z5BMn77b4LHqfgkE4Swa3JNVHzlXJoY9MDy0Sm9Dm5wtw2x7bkDu4re/36h9JATyLyno
         FGVROr7YEMCYNQIzD3p1yrfadXiku0XguQ68DrRXHTwAA9T/k7EMiv6HcQQFKzk/QJrK
         U2YrrHONdPL4DPF1qwMjgXQ8i8g8bxkZFYOE3JjRwdpc0TXQJIzo9Sd5YB8aMcZWmRes
         TB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792679871; x=1793284671;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wIEEgL0wnyCgnfYBD3fqLb39KxnaLSOeClNdZ/a2t8c=;
        b=Pgj6bKBWVe4C878dMXlfPJS6RTghqaVaGgbpo+2bDQWqdfl+DM37gV4BceMNP17abr
         tmiBYRFObKg718MskvvLHLFsPif8ZwFTjkAbdSluL0dVLyHaRyQT86ba0bwPuZGmCgvn
         c9WlwumOMlBVXT08ktJqdQL1pW98ktc0BpbFnFhfAbuM67eBL0xlhuLWKfDXOAeMVsAJ
         buYJOHoVaNVt1RRoGKvjsW0G5BMP0PyhyFDwLMxdB3uiT/rQzjy5FNZTd6dsd9tYDSNu
         US2YU413bEJT0o0rHuqB2vNHzXMMtLIaet/j2EMUjqqFVC0gEAODRicYQpMPyKUmOPSm
         SK6g==
X-Forwarded-Encrypted: i=1; AKwUvByU5CGr/+Tv+Buqj1PaDRuxhmpu3QD0++hFCvjZQy54dQx2RwgLORq9ZXkk/j8pyYQLmlsH8FdQfw==@lists.infradead.org
X-Gm-Message-State: AFq9FYJJFLp/NGCEBzRabHkhclEFCVpHBrxCcXi4VREAyhzvUeKmDPFv
	M6hQDmvI0bjXVb+SJKXfexOeuukzcq7WKpupRDHDQAvjWdxopoNEKG4C
X-Gm-Gg: AYBFou0Nx9SMvWXuPcsCoqhsd764UiXTrnCiET/FQe9PZOOdHJU+4ndEXsQF400SYYh
	bQFZ3gL6gGC9kC+QZBolJ/cyWyUOxQOfz6H8vdy4WgJo6SYPWF97wRjY7oavRGgymxOGoi+Zm7l
	tGxfy4Zz8Ne2HxXxvk/dmq6bOZQo7RRQ4gBCHni4ylC67/gm0axnpVZ3Jy95gRLKwI+WE0LaPVa
	pIAyLqA2Zaivr9MNNlJPIi8nAOPsIYM0DnrBjzm3wprrO6nvwqTD1/Uq1Cv9furOzMblqwo56HY
	Cf8MilIm0cRGKEv46Ttx6hdfTZh82PwmJrI1J+Ropv/yBizpE/8wt7crjh1yN1KPM374UGhkPtX
	WnbAlHaYCVHoF2E/bexNh7dsL6tfaQmWzaEkb/j21GrVzuKj0Yh5Hej+Nbd0+mZTiFx4WEpjrZz
	/PmF832cYiuTOVV4OCFP1yYhY/Cq6WfKHQv1e0/LkcINh+YVwRkY+HIvAJGttSQTpH3tA+7IvdW
	ZkByS5POdcXtBg3kY+6J8DdS5HO/rJvwSzLoDM3g+/ufU4K6D49x7FgPUL44YPbnOSDZFLImu3t
	sUslyvSAU7YmZih19QmFgPX0/CgnMZMi3CRFWXIxEFjWBpwn9AXRMlycHoicIn0IWjr5LvxHZTz
	2r9JifK3W4XkWxt0f1HY=
X-Received: by 2002:a05:6122:2984:b0:5d0:1207:b693 with SMTP id 71dfb90a1353d-5eaebc25d1bmr2672346e0c.1.1792679871554;
        Thu, 22 Oct 2026 07:37:51 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97be251sm6978325e0c.8.2026.10.22.07.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:37:51 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:37:50 -0400
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
 Simon Horman <horms@kernel.org>, 
 linux-um@lists.infradead.org
Message-ID: <willemdebruijn.kernel.27710620cf132@gmail.com>
In-Reply-To: <94796ee3c32e50665ecf70e2b390db1bc2773be9.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
 <94796ee3c32e50665ecf70e2b390db1bc2773be9.1792668082.git.mst@redhat.com>
Subject: Re: [PATCH net v5 1/7] net: account for ingress-resolved virtio net
 hdr state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_073753_435046_54B8CEF5 
X-CRM114-Status: GOOD (  11.87  )
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
> The following patch will add ingress resolution of uncommon virtio net
> hdr checksum metadata (software checksum completion at ingress) which
> adds performance overhead to the packet processing.
> 
> We should make it visible, so a hypothetical workload relying on
> uncommon metadata can be distinguished from none at all. This way issues
> in the parsing will be reported and not quietly pay the host-CPU
> checksum overhead instead of offload.
> 
> Flip every call to virtio_net_hdr_to_skb to test for negative errno
> only.  The um vector raw transport even ignored the return value
> altogether: rejected packets went on into the stack with their
> metadata unvalidated, so check it there as well.
> 
> Have tun count these events per device as rx_csum_sw, exposed via
> ethtool -S.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

