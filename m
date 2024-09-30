Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2DFCE835D
	for <linux-um@archiver.kernel.org>; Mon, 30 Sep 2024 17:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1uPwxLcg5Bq74tqCqqhr1kbUuC1X8WKeLcVZP/gaR94=; b=3toYz8vH1i5qcdrTwROrEWYguc
	5SjZpPYennxTU/ChPTaEWyC8NasntnZxOqJVvt9GvgBhei5689UvwXUkjlcPYKjo8BBSOrU2KFWPY
	3ukyBfoQsYKn6H44NKmbhemDLMzrakiT09P9ugSAoQgud0w1TelrNNpF5oZUNdYKOfw+kP3B4awrw
	OYwpoG79eP3Y4GktxvhgbdWghvzmWcDJBWJFO865JxQ+av7E/iS6Wv8HvGUoVZan7+SoDwB8+BHlc
	znzgKWM+pGvaqqtj3lF+2NAmV1aZr1dRXXcSVNqVsdc3EcsTBgBwm9HeTAtlbzC1yDhKrN/Tew4ah
	E9FFTmzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svKgL-00000000RM2-0S0G;
	Mon, 30 Sep 2024 17:59:37 +0000
Received: from mail-oi1-f179.google.com ([209.85.167.179])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svKf8-00000000RFs-1Xpd;
	Mon, 30 Sep 2024 17:58:23 +0000
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e03c736466so2996347b6e.1;
        Mon, 30 Sep 2024 10:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719101; x=1728323901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uPwxLcg5Bq74tqCqqhr1kbUuC1X8WKeLcVZP/gaR94=;
        b=TkRLq4DM8Bm09pkRwoN2Vt4jvkUBRYWy2DwLhixsbtaXlo4DTK0KCb7FvU4H4Ja5YG
         lYge3Yimlt5DCUA5CjO6AKkxmzipfzKCIwNSXQMNudPkonZ9fJIelLoDH22M2a5qre9x
         mYOUn9XCjYkSNaNTcvoyFIhxv1Fpmx3Bv1ZLJyg2Zy4afhT8ddMVJ21c8uwJP1ZDco9Q
         lPUy8L0UThYTk6poLX5wPdiwh9L6JtXnSSBo3B2eTOXB91/S2z46IAIAUBoKmlZFI6il
         /Y9suc0RP2DSIH3QPHrSfflm8zrECxm3hd+pmKYPQFCC/zuIuFX+uEdGEOPSvXMFMLVA
         ED0w==
X-Forwarded-Encrypted: i=1; AJvYcCUY5a4uQ59gchCm17D5hy2ntIiCMmAyLcuo1o7Q8RgH+2G0J6LcDcZaDykNRv8zZCG6c8z38Nb63/8=@lists.infradead.org, AJvYcCUvnpqnqcD3LH5nM1TpbaB04TRcdd+GbJdDkEC+pqjPD/VN/LpdLznFkw8utvUlSknBES4RJcHYPvalehCsImtg@lists.infradead.org
X-Gm-Message-State: AOJu0YzpP9DReT0a/iZ6d6QmaBpYtH2GHGjhKjrBRNuPO8blSH7KC3Bx
	+Dzd+mK0xdYqfFwqMozSBOOQkZj2ZYHP6TML190B/T5nsw6RDjM9StsORfvr
X-Google-Smtp-Source: AGHT+IEARP20PB/7EnBHYBhvSj6u6xD+gfTMsN9mrsO3yOHYed5Bewb4yrfb/4CoSoPd7Z3ebnM5nw==
X-Received: by 2002:a05:6808:3a17:b0:3e3:a317:8e2e with SMTP id 5614622812f47-3e3a3178f78mr4055431b6e.20.1727719100977;
        Mon, 30 Sep 2024 10:58:20 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e3935c6809sm2563130b6e.48.2024.09.30.10.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 10:58:20 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-711009878ccso2965266a34.2;
        Mon, 30 Sep 2024 10:58:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXMFLEyGr/wMcCWJcItxNZF5wJXxhLKOSS3GRr0s0efqQqf7dMKUpAYgcPBhLmaD0yJ+XdiusQ3UrDr375Uf+/@lists.infradead.org, AJvYcCVa5h7hBplX7XTIh1PA7BvIBjGr75bfTNbjArlxcbIoSrNWgGLk0/Onz6iTgI02svkfByBbZJ5SzvQ=@lists.infradead.org
X-Received: by 2002:a05:690c:d1b:b0:6dd:ba22:d946 with SMTP id
 00721157ae682-6e247561690mr104291347b3.13.1727718756479; Mon, 30 Sep 2024
 10:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240930132321.2785718-1-jvetter@kalrayinc.com> <20240930132321.2785718-9-jvetter@kalrayinc.com>
In-Reply-To: <20240930132321.2785718-9-jvetter@kalrayinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Sep 2024 19:52:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWpiS-MgQZ8YyX=PDvQ+ZvS5TdMV5wn11MKFZVT7CHDhg@mail.gmail.com>
Message-ID: <CAMuHMdWpiS-MgQZ8YyX=PDvQ+ZvS5TdMV5wn11MKFZVT7CHDhg@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] sh: Align prototypes of IO memcpy/memset
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Yann Sionneau <ysionneau@kalrayinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240930_105822_426781_D8685BB1 
X-CRM114-Status: GOOD (  16.82  )
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

On Mon, Sep 30, 2024 at 3:25=E2=80=AFPM Julian Vetter <jvetter@kalrayinc.co=
m> wrote:
> Align the prototypes of the memcpy_{from,to}io and memset_io functions
> with the new ones from iomap_copy.c and remove function declarations,
> because they are now declared in asm-generic/io.h.
>
> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> ---
> Changes for v7:
> - New patch

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

