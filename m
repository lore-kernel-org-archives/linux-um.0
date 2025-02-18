Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C641DC02198
	for <linux-um@archiver.kernel.org>; Tue, 18 Feb 2025 08:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K6Hz8bZDs78uyXHgQQ8oUf4o6rHFlSQuKCrUj7YwByY=; b=xcr4Vf/MgTmJYDmgx/ec7mIBIb
	futxP8dn0OxXgkh1B93QZ0J5fLLobzGIvGYCxtOK8N6tRYL5NiGoaH/i/UOJcwpPvq42YGgcFP02G
	YUKtTJmeDIL/yb1JQGNfcFtytyAcePqr8jdzEBI7ZVinpNwKTIUkOpd0kZpDTqf1G6In5Qq8m+5O+
	R4+/sE38hcgdi4cefQuSYseWGoldiAW9/zzQG7Ck7zVNtREOEMSEGvCixhpbrLJuqGDcAPYlCKSs/
	uVNvNajxLve+fwtb/nWGZ/TUqkVyCifaMKU2OBQm86zgcdJdxxDB/le/XMkAvoKf9ZMjom+d08Rhn
	nOgmV0cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkIns-00000007E9i-28zp;
	Tue, 18 Feb 2025 08:18:04 +0000
Received: from mail-ua1-f44.google.com ([209.85.222.44])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkIlh-00000007DTC-3uqR
	for linux-um@lists.infradead.org;
	Tue, 18 Feb 2025 08:15:51 +0000
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-868ddc4c6b6so1879866241.2
        for <linux-um@lists.infradead.org>; Tue, 18 Feb 2025 00:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739866547; x=1740471347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6Hz8bZDs78uyXHgQQ8oUf4o6rHFlSQuKCrUj7YwByY=;
        b=EbLt6r+xFXg03bzUjllebtGc10q2iixsrkiQqgMipPhI+5tgHwA1UvJz3vr8x94qXJ
         AvYYFZaMguKTfDlsqPKNpvdCLBu0CZT1kF2IshWTYyj5MW4Rk/uD3JhOrk/7l1QFOyhG
         Ov8eP6Gz/NcCVhhzhUEom2s8GBvrx4cY7bHoHCL4rGhsq0LGV48nkQ41R96dWFZ1klzy
         /Wr5mgLxD6JusaGZ3R8NtVK/cybGc8khE3f15mP2Ri3fIf5DdqINIQv/qRf/zbQlDFIN
         YGHD9fLm4RfUMedOj6AM2iXNWR4LVXUxd9UXt4zSQyP4kIJSEb0bjG01ciXWhehNZHBS
         D+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUff1cUK0ABYzvZm56hGJwZLTB7aABBGLUI4yXM4ZJfs2uCvyNOsiMxxMsv7FYEHknHVIrd7Zx8hw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzf98eZjQJ4yxSU8D5WOdZhRlq/ns3KlYMOKek8tDoUj3me+bCm
	T0XqhiQA2gkKAo7hDHQz2r1RM+TvdFK/bHdSr8YKaBtf8k0/i/sExxJzjUneg04=
X-Gm-Gg: ASbGncvTyqOuQaC3GX6y3fC5RorF0wVpRy+HbRhNyz+pFPpAE8zWBpeb9sUwyT8YsL0
	o7h2YtWXf6eeeolu3IRohvEw5jlh+NYmCga+Za2jGNVuU/zMc+LK9OtWc46p2T2vCXg13pX3KnE
	mix0NGjqaGeQl6ZoCxhqbezpwitiLkHLcK0xdue+5Wpbbwlegg7aPHfODqiN9P1yd9yGyFRofvp
	i0nbrHA7ErNW1BP1FiFpMFJhrq8x8Rbjh9+7Bq/ydVjZE5QWCd6+03uG6JS2HDYqer5iwsbdbwx
	pxJ9BgXb9tEbz/RRbWXKCKFkffhmiFqmKb0xsxF+xGbSg2VlEWd6tw==
X-Google-Smtp-Source: AGHT+IE0C775gUw99duXSqI22/iHt3EcbUt8wRqaapQitjKAmgpcHlH9a7AB12GQl3Hh6joq+u4uXg==
X-Received: by 2002:a05:6102:419f:b0:4bb:edc9:f949 with SMTP id ada2fe7eead31-4bd3fcc7f1cmr6594261137.10.1739866547007;
        Tue, 18 Feb 2025 00:15:47 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bc68dd766bsm2019950137.20.2025.02.18.00.15.46
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:15:46 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-867120d67baso1771397241.0
        for <linux-um@lists.infradead.org>; Tue, 18 Feb 2025 00:15:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQV3Oi6rS0V/OoSYVCoPraq9iFtY7RCKSH8TXkVUSesXYSzRFZAttLuFCLClJp0J3o8YU4Z8LXXQ==@lists.infradead.org
X-Received: by 2002:a05:6102:d94:b0:4bb:b843:95e6 with SMTP id
 ada2fe7eead31-4bd3fc9869amr6525145137.7.1739866546228; Tue, 18 Feb 2025
 00:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20250217190836.435039-1-willy@infradead.org> <20250217190836.435039-3-willy@infradead.org>
In-Reply-To: <20250217190836.435039-3-willy@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Feb 2025 09:15:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVGGPVxz6spuFhqZV5YONji+hOi2ALjBkD2Yt-xrb8R9w@mail.gmail.com>
X-Gm-Features: AWEUYZlUk2UQkMyt8RR6rg-cBVbuU2v1FebOMuVIYEMfkPb3IlGZ86jcKmJ0Nps
Message-ID: <CAMuHMdVGGPVxz6spuFhqZV5YONji+hOi2ALjBkD2Yt-xrb8R9w@mail.gmail.com>
Subject: Re: [PATCH 2/7] mm: Introduce a common definition of mk_pte()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_001549_969445_C02DF4AA 
X-CRM114-Status: GOOD (  15.42  )
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

On Mon, 17 Feb 2025 at 20:09, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Most architectures simply call pfn_pte().  Centralise that as the normal
> definition and remove the definition of mk_pte() from the architectures
> which have either that exact definition or something similar.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

>  arch/m68k/include/asm/mcf_pgtable.h      | 6 ------
>  arch/m68k/include/asm/motorola_pgtable.h | 6 ------
>  arch/m68k/include/asm/sun3_pgtable.h     | 6 ------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

