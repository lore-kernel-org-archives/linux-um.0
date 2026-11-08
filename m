Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E9606A33F
	for <linux-um@archiver.kernel.org>; Sun,  8 Nov 2026 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Xv+S+JXr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VLZwvokn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UtP2jccq3jxPhce0osraBRs1VaHXV/BGnZSpsO6ZWcc=; b=Xv+S+JXrPNV0zs
	+nzfm4lcyxJ5SOMSLSVjWfi9nwzmEA3fvYkWBdSJc3e0HSPdgIl3Q38PNOToRF5CL0yz5ROzPNJEZ
	Dgx1fF8nCuugWflEHuatPTBlJYQvLTxmNXpZwYfqTW3To9hEg21zugTC3Ro86lZOCyVj9k1DCCCuh
	gO4f7yAp67qKHnNd2BVaxI9EF9E2mIJYCO9vOHv8Ha5sUp8IMsj4Cg5YKgHjzxo069ovqxP/qqNH2
	X7iXG8pXJm6YygSptdBBU0JnP7RhcX1OL9FShda6SfLJifd11tYsUDfizzlYbzuQz8Cvv3dQXljBe
	9WVFYoWW6zDrPdnCM2tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9XN-0000000GaVp-10pg;
	Sun, 08 Nov 2026 20:30:49 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9XK-0000000GaUr-1bQV
	for linux-um@lists.infradead.org;
	Sun, 08 Nov 2026 20:30:47 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-4922523d1afso120897f8f.0
        for <linux-um@lists.infradead.org>; Sun, 08 Nov 2026 12:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794169844; x=1794774644; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UtP2jccq3jxPhce0osraBRs1VaHXV/BGnZSpsO6ZWcc=;
        b=VLZwvoknJ7SMoTaKBz0iHHDwgJ5VJmH8NQ7/oOmMXK/40cQKjgokl7+BUxMG3MeTP0
         53ReoCcVNdd5d9UjmEDAucMVa0nC72bLKZ6AxrU9rn4iiD4nWtOn1ZUUQoiDzyT9OR9j
         8eDiJ2xIaoFvo6YhD1sshSIT0lsWwgN5N0Ux3m1urV+BwU6njVjPwqgCgmX6nR447Zau
         ZqSFMx5Ry3nTKT8XxRFDH9gZ5yvKFgeShGVppwgnLyW8fOpdjqcPmy/ojRyOxyx6yrYW
         Jt/WrPz3YYmbUXxVV8/XI+mdnjsgykL3nhUBLIi5V6xiwZsQp+AwabbDFaLHTm+fUylS
         3swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794169844; x=1794774644;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UtP2jccq3jxPhce0osraBRs1VaHXV/BGnZSpsO6ZWcc=;
        b=UbRpJoi/4T/CN3I4caJo4EJ1J4L2jeW23K5vavZGaY76F6EgmSYJgiGOIowiWrJBCH
         oEb68OAn9tiNVWkVNpCPSJCWRiphqR5OOK3T5D8F6GGZe6UBTJ6Q1Q31a+ssl8wuW2fg
         M4iNMlMOmK05JaiH5o5BjElCW9qK9cPZMjOIAGPC7q1Ye9soG66ORhHPTVn2aJScYOMV
         y8khIrK7TgGy4hEW/wY1GffTER9rP1oLiV79tQPrG+CJAhIoAY0sD9KsZgGX84T6m2sW
         4dOwUh/EIqSynJZz1T9IdQT8lpnlCwEIOnJsLZmpFgN69gB8TrzxbPy1S8Q/tbWKJ79t
         BxHw==
X-Forwarded-Encrypted: i=1; AL+hErFlf91hiZgbmq6EXeZ5oz7NHv8CtFwV6Vz9cA5Rg1NBrAszLb6SN4KS1ouF0uGJNtrZ1Ak3PLRCxA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/lK6GjaqK9FeKwd08UGZZTrcXU3PQfgA4TRkPpvOx98HI4gOqW
	Atj94fKkwkjzIGrCVzuQ9UHDmSXVXEnb93M/bpHL5NhVO5Tok+mB0HuL
X-Gm-Gg: AYBFou3yIudMPK6C8EeJpwRrGQfq1kW03brdXV6DpgDV9TRm3swKvxXFK3BhF1UNZ9e
	pw+FGnyRr5+ETNPfjzQCvfzwxjHerh0anvdCnvcj74ddLzxczLaUhbw+s5YcgfqlXw1EODZAc7u
	jEY8eTblTvqh6FKVLMVsrRiv5dewz8WSfmJoBjeigVHV9gD7r0K6mu7D39UbOJBN5KL7qCjDJ4a
	wqkuJhDMzXiIhyrS6UhcpUE2GJfoL1mzPKh70WikpNnGZmC5vwjzTbfcD/xTvKJog80fAOaEfTT
	xYzq8p+4WSv+O5ISRc/7sF2gugqztOTmS1a3McYWJpRsbl3pFuj0RK1ubwXj6izUwT/h+WgUCI8
	YncAkHrzSPwaFPlkGqPEkkh+p6Rfqu6iVftE0YVPQhm23qaX9tVYHr5ZcSytRLZVBAm/kM1+X1/
	gJu1YLcwlEwaMYnKBHqK7/anyJqcKR9Lk1SODMJTsQzj+t1c2i9C6qCIzzqXYOytsr09K1mxi8r
	4Xj1kAprScw0re0Zp/Olo9rIi0wSbZEhBig9MkN5UuDByZWte2y4nYfJkAUhxu3vxhtbBJh9BK+
	8DufKjslX4YnIv0RfiCvjnuPC5SXanTDUAvM6aX1s/Sy/0nxAxqu2NJlgYrqXxY76aOCBcawp25
	9AsrHLl2pK30=
X-Received: by 2002:a05:600c:46d1:b0:4a1:e6c5:e44c with SMTP id 5b1f17b1804b1-4b960d9c44dmr45446805e9.10.1794169844378;
        Sun, 08 Nov 2026 12:30:44 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90f11172esm85799055e9.12.2026.11.08.12.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:30:44 -0800 (PST)
Date: Sun, 8 Nov 2026 20:30:42 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon
 <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Alexander Usyskin <alexander.usyskin@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH 3/7] x86: make CX8 usage unconditional
Message-ID: <20261108203042.7e36f15b@pumpkin>
In-Reply-To: <20261105163440.2381661-4-arnd@kernel.org>
References: <20261105163440.2381661-1-arnd@kernel.org>
	<20261105163440.2381661-4-arnd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_123046_477243_99802F07 
X-CRM114-Status: GOOD (  12.28  )
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 17:34:34 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> All supported CPUs now provide the cmpxchg8b instruction, so remove
> all compile-time and runtime checks for its presence and the fallback
> implementation, to assume it just works.

Is it worth doing a run-time check early on any (trying) to output
a message and fail to boot?

There are probably a few other things the kernel could rely on, but
probably ought to do a check 'just in case'.

One that springs to mind is whether 'find first set' leaves the dest
unchanged for zero. There is a comment that 'at least some 486 didn't'
but assuming it can make code smaller.
(Basically you can do a double-width operation by putting the result
from the low word in the destination before doing the high word.)
But it would be nice to have one test case during boot.

David

