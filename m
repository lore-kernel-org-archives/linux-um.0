Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9284FC369D9
	for <linux-um@archiver.kernel.org>; Sat,  3 May 2025 09:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tSLkgcB96XS9BX7vu/hw5jEpRm1hGRPZwIhYM/guD60=; b=vIiytaQFLk7U2gwtnBqayOnm2Y
	Z1etNweNaT84yPRtnnDvjMeRDAMP+Z8qABLuFgSi5grGmUBzlJcbtiuh+P3aIE7Jn3UiNFUs/rETb
	8xmcfV0uS5PttiWy/Oh6C+3bKIKTitesyTWvaL3UQwwE+5t5gMdIMJubA2gGiwaSaj69eih4FWFQh
	2UHQB4OZttc6GZ9dWJi/cS+jYk9Z6lnRLHtELFMygzyWsPHzpBLDswd3g2au1Tdbsc+j23h97d4PB
	e9qT/7DRdiQfGlffbjK3AHjdnx+mX6sruD/eicOI0TB1Akzo5ey5FmIEv0ulpGz8aU+husYhCD/Vn
	B0gkXLIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB9Ly-00000003hcR-01Lx;
	Sat, 03 May 2025 09:40:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB9Ls-00000003hbi-2mzX
	for linux-um@lists.infradead.org;
	Sat, 03 May 2025 09:40:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D5FD65C475F
	for <linux-um@lists.infradead.org>; Sat,  3 May 2025 09:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92CFC4AF0B
	for <linux-um@lists.infradead.org>; Sat,  3 May 2025 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746265206;
	bh=0d1jkdjxOeJfB6xqzQFiAHc4uIjGHruLnU9XnCJoIgE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i7+HXzBLYfTveb8gNBVJiQsWVMjVEdhDeiJra3G+F0xbDD64Rpv6zgcNlLYTTaPQD
	 c8ojFlapEcFdcF3XLx9hFh+3VOd/LH1EIAiGosqGJkxy7B1/i3ldWsubKERPiFkSWR
	 qRKrZklKke+fE8i8G9oAhhBJxkOXDhY2G/QJLyjsnNJxV5GXlzLJxJEcM4EM+l8cZV
	 2bvombdLB1ldtUYVmhf3G5SfOyX582v7iSJSEJhrMzGu5rBhgHj/Jkb1ISyG5UIAcs
	 432pNOVG51llFQjdYCI3jsy43kKsADRyVncZtcMrjE1UyeVWm6EtiIb3JFxu61E65B
	 6HwkT6h1qsxYg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30effbfaf61so31437691fa.0
        for <linux-um@lists.infradead.org>; Sat, 03 May 2025 02:40:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYZ67RLDPaGKEFmd30K0SSQrR+jY7Fn0tc1S6v1obq8rBuUVTHzba3qQ+Ert1GZROWaP3LMBUPOQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyoJUSGgAosUmRn3LQ8Mlh01vLaXRyyotoB3YQ0URZFi1wVOH71
	PhRxFg+UBGmbUkNZLJdF0v8O4qOJIoy7mkK8ShAjd8iUrXugYvsNyN2MHTPLEXQGFx6RShX98O8
	xaWsGFcTPnE0N5pVD9zv1tZYfsPI=
X-Google-Smtp-Source: AGHT+IE9EAiuUYo6KvN+ARqicpo4aM/gSPHQAiIJeqb+afi6OOpGnh/TXW54tKHBxiQX1e7w742MKNCXNjXTXGxERYw=
X-Received: by 2002:a2e:b8cb:0:b0:30b:f0fd:5136 with SMTP id
 38308e7fff4ca-31fbd521738mr25333291fa.18.1746265205431; Sat, 03 May 2025
 02:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250502224512.it.706-kees@kernel.org>
In-Reply-To: <20250502224512.it.706-kees@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 3 May 2025 18:39:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQCZMmAGfPTr1kgp5cNSdnLWMU5kC_duU0WzWnwZrqt2A@mail.gmail.com>
X-Gm-Features: ATxdqUHjgwA3zgCEhsY5zu77ZvtX7H9zd8h92syMTrpI0NC3HWoo72zkjE5p6x4
Message-ID: <CAK7LNAQCZMmAGfPTr1kgp5cNSdnLWMU5kC_duU0WzWnwZrqt2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Detect changed compiler dependencies for full rebuild
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Justin Stitt <justinstitt@google.com>, Marco Elver <elver@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250503_024008_752340_F8CCB8C4 
X-CRM114-Status: UNSURE (   8.95  )
X-CRM114-Notice: Please train this message.
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

On Sat, May 3, 2025 at 7:54=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
>  v2:
>   - switch from -include to -I with a -D gated include compiler-version.h
>  v1: https://lore.kernel.org/lkml/20250501193839.work.525-kees@kernel.org=
/


What do you think of my patch as a prerequisite?
https://lore.kernel.org/linux-kbuild/20250503084145.1994176-1-masahiroy@ker=
nel.org/T/#u
Perhaps, can you implement this series more simply?

My idea is to touch a single include/generated/global-rebuild.h
rather than multiple files such as gcc-plugins-deps.h, integer-wrap.h, etc.

When the file is touched, the entire kernel source tree will be rebuilt.
This may rebuild more than needed (e.g. vdso) but I do not think
it is a big deal.




--=20
Best Regards
Masahiro Yamada

