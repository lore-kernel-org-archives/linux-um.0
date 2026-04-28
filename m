Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429BFFF8868
	for <linux-um@archiver.kernel.org>; Tue, 28 Apr 2026 09:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=; b=NdXUQ795zAljUzba8206oywy0j
	6rCrk2Fd7BRREgtFCFFBpqWC7ANUtc74fPlBGHBeNOEmzk2LDRB4sjNLpDbBCaqicA0DhLUYO6+Co
	qGPwv+Ehw7gHKMtwSa15XssfOMnFAL+Yy4brCYxZp6lZK9P0sIfEFImreomFkC2QmvkMTd4qgcGh+
	vfCt+Zbxg9voPlPKh/rffCA/DRhDuau/Q3Cp7+0mrxfHWB+xY8PK53zCdpZbV926N5+/cBAF9R6ex
	gUCN6C48kDJ8oSwGJ99JeSXm1sz6Gw36PPfuPkJExaEdOkeV9Tp6DTNTPVajUEdTHtwFoOJBJjVD+
	svNyr1Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHemq-000000015sU-2by8;
	Tue, 28 Apr 2026 09:31:24 +0000
Received: from mail-ed1-f49.google.com ([209.85.208.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHemo-000000015rT-0OF8
	for linux-um@lists.infradead.org;
	Tue, 28 Apr 2026 09:31:23 +0000
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-678a526f374so7377446a12.0
        for <linux-um@lists.infradead.org>; Tue, 28 Apr 2026 02:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368680; x=1777973480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=PFFomdRBHDX2twJ5kQfJDbSzWr9dYmnLNGhEC23ojCd9omLxXN3gS/7yDN89ceHqkb
         GJ3qtR7h9Y2zUdCDC3agRb9zk9dMaxry4mGIt6IBS1+9n/hHDDRnPUto598e98N8lffj
         /VsrUWPbHc5nU9lPLue27Phx9KGvyVTlzXOIBUaGfUKqsG71Yz87ObXzxFvDrZzhA9t3
         SgO9bWRbkj/1hvBkZEWVr1+txKaYB6kf+2Wigz4jUQGaFAi5GI5MtmaS7vou7+Ur7JUJ
         9GrpRvDMzL2Y++rS9toZ87ZiHZrDtet6R97K8fZO6Pam57c3kRNylCsYSSyhTNO9HuH1
         sQGw==
X-Forwarded-Encrypted: i=1; AFNElJ8Z3i0hx6MFG+xjeAEpHlFmizl27EbL4uRvBgGCDCslByhNCCBJ08JXLA7U6SOR0diWlxgWLQOK6w==@lists.infradead.org
X-Gm-Message-State: AOJu0YxK1T7bXmIjY9eMs6NHJ84yd6TisC19NJ83vi4AOCniE8zMju2o
	Vt8CJhA24+0B2rD6Tsa22GrZ8McmL+EXb4nurBADpxcFnMTctbuvwe6B2SK37989ww4=
X-Gm-Gg: AeBDietPAwk+j99F+JinusznGshFYB9aTEZCpAKyih1942LKmmkryJTxhMSswycfKoP
	mQ7uf3D51Y9A8KV+gyL+L8bS+rE9hmmg2UO0aqVfjIE8sUuMVVfDWZEnsCs6gSuzq2vsaF2TG7g
	w6Vt/jst/Tq0939cxRxfPF8rLeiF2cDV6hKEcyYjfiSu1TtQyl3HZojPItc+1eFyArZM1St3xoT
	xnspLH0NlBwNTwiEwEOzNfxO/7Aw3tb2iFGGck0NboTeVwgl6tjzFu5d8ATrKDy8fdl12nWtUr/
	YcOb013fSImQKm1BB9rw0ak0UpLdtvXC3bCm2TPwNcZCqH4CpKhkWSHhINrYJRVULJ8QjxAklEr
	WPtk/u6Twgx/IUQrn/gwI4u9O5BWWmCYHdgOFZavV4aSvtRQ0zGxBTBAUS1K2iWanurna0E4TwI
	QR156S3LgS7+0TJhlzT4LWSRuGM6Q8nWU2CKn8PSWrVBtvt1o17iHY7TVc62KeK47/haN3KRk=
X-Received: by 2002:a05:6402:540e:b0:674:b1b1:d039 with SMTP id 4fb4d7f45d1cf-679bb062b16mr1044458a12.11.1777368679550;
        Tue, 28 Apr 2026 02:31:19 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b67d5ffesm550227a12.9.2026.04.28.02.31.19
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:31:19 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so19505562a12.2
        for <linux-um@lists.infradead.org>; Tue, 28 Apr 2026 02:31:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+b+MlHbFHdLMYdKSn6odooxBYSU6zyX1IcdwgQSh6U0BV9o+KqvnwkDGjRCmjgTqrJFSTQ3XRNYQ==@lists.infradead.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_023122_140667_1283E209 
X-CRM114-Status: GOOD (  24.41  )
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

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

