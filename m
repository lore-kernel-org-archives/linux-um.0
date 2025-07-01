Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851DCC83039
	for <linux-um@archiver.kernel.org>; Tue,  1 Jul 2025 08:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7VpN8/fIrEO+ZQqQOOW2BaQiAbw/BM8rxsgh68ZiqF0=; b=sxYU30o+tPWnTfk0pWTpY0W4LQ
	Cl6fOUGAgLKYYjxjDtny/Sj90B1JckN+iWZZ0f/WYz0Q92WxVo6gQxbetIjtILf+ceNstqvXiQ+GY
	Iy32en2/bmis2fr2/7rexLJYCR4QLlNZg/8JUZhJ/J3FYf2eBD3/x+G9A5UBne7QvXKP3EhsFf7x3
	r5uWqqyJ1lq1T2ljGf8iYhECLEQT/pnf5sQHdDD6JAqXfUyRaRIF9lfLkkXeg5GZnjTpNWkSHYjla
	1WGjcQJMefupUODhOnVSXWA0TEm2JlQeArsToOAC3cX2/aL3aatm+iMksiWCnEwhdWub9fAXfY1ws
	G/d0k6Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWWjJ-00000004TyP-3UhQ;
	Tue, 01 Jul 2025 08:52:41 +0000
Received: from mail-vs1-f41.google.com ([209.85.217.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWWKB-00000004Pap-3KM9
	for linux-um@lists.infradead.org;
	Tue, 01 Jul 2025 08:26:45 +0000
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4e9c8a2026bso797591137.3
        for <linux-um@lists.infradead.org>; Tue, 01 Jul 2025 01:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751358401; x=1751963201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VpN8/fIrEO+ZQqQOOW2BaQiAbw/BM8rxsgh68ZiqF0=;
        b=UH8kAnkVa2PB2XD897CID7N8Wdw+oz5sMRmJFjU8V9nS5GAefUewxiqVKiumwSy5IT
         ytRHCh31yN1UO9iGX/OLHFLtjurhxzF2ZbtqO6pKUdkNmk2SSvU5LvLFbS3SKDIspZ22
         PrVa/UrAB6WV1oWUCTVxSDEwNyfBRQgYU1Geyb5gz86DxylxPXrMSddGLADmBFfl8Cgm
         05qntQ/xeM9jl2uO4Vsy3cQdi/F835zHGz+1tly9iNrN5ju6CDvAwuJOZ3NJDi/e58X+
         3PRttV/Gx4DWUM9+3/BTx9Dlk68YtMiX71Uq2qQuv/lHU68j/tjFJtzsd5Vldy/C1Aa7
         CPcg==
X-Forwarded-Encrypted: i=1; AJvYcCUtVJDzLj1mjV4qetayrIf8c1Z8pSTutIUPU5nw8R5BaGg+FxJMpZ1NQxU8bhCzX/vIOLjUH9sN1A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyGyOgtOn6C2PKDVzL0NEx6ehxaObRk0CMd7qFp9KRTgyPgA1Eq
	lQTl++bmohqvMvrAMF3f5zWVM5I3yFiye0+dyiVFa3TVo1U/wccqVpDMLxGCbuvf
X-Gm-Gg: ASbGnctFbdYofloCAvRm6ftcWWq8EinqWbpMLfg+bX2f4v4EAbmsJY9dWfyzXtNhmbX
	QDTPFwnhh0V7mdDrC8ETSiqZFjXM2gbMQs2hqWdFZ9mHfXDKSyPv6sZDVb6tK4v2swwEsp5toSC
	5NW+Wyv/Is+86WYGDr/GoEqBU9GyBjl7sWKabq8UNK/R31YoXC7hqKLSVr8CegsVN14qlCY5aGD
	7mpeI30MJnluqdvR9UakRFVqMV/q1TtgVXgT78S2SVt4bD3FX71mq/sBweBl5somzqE7iS0ApEY
	gqIYAVsDAxkedEbrS26dq8Mi9lBoCGZBM1mgr/heuMXJhLXLVmwCK6fqNJagubCTWgtPkUbd27A
	pbFMDdfeylNpAf4luPmPUpks5
X-Google-Smtp-Source: AGHT+IGEOfFIw3+/jYfcx0HiY+6n3xHjr8UdzGy4wErjAXuUquqiPPQVNuxFO1RwXhhFnRT0UT2j9Q==
X-Received: by 2002:a05:6102:509e:b0:4e9:9281:85aa with SMTP id ada2fe7eead31-4ee4f4fbd4dmr9616764137.1.1751358400588;
        Tue, 01 Jul 2025 01:26:40 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4ee4cb6aec2sm1351156137.18.2025.07.01.01.26.39
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 01:26:39 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e9c8a2026bso797572137.3
        for <linux-um@lists.infradead.org>; Tue, 01 Jul 2025 01:26:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWMoX/NRQcXlD7vrkA7D50l8VLUQXuuvpVbTNewdOshvACcLEiQsQf3e0WdwnhM1D/nvN++7Ou0A==@lists.infradead.org
X-Received: by 2002:a05:6102:c11:b0:4cb:5d6c:9946 with SMTP id
 ada2fe7eead31-4ee4f6a0579mr11166716137.10.1751358398739; Tue, 01 Jul 2025
 01:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250628164740.353989-1-tiwei.btw@antgroup.com>
In-Reply-To: <20250628164740.353989-1-tiwei.btw@antgroup.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 1 Jul 2025 10:26:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUa1D3mLtNfOhE9RB7uWyf765-9kiQzG5ku05zz2f+zjw@mail.gmail.com>
X-Gm-Features: Ac12FXxODb9OvY-GrLispuh_17S5KRSLOGDLwmEhvdJD59RnjIAGhYopF21WlVk
Message-ID: <CAMuHMdUa1D3mLtNfOhE9RB7uWyf765-9kiQzG5ku05zz2f+zjw@mail.gmail.com>
Subject: Re: [PATCH] um: Turn HAS_IOPORT_MAP off
To: Tiwei Bie <tiwei.btw@antgroup.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	linux-um@lists.infradead.org, kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_012643_840604_F99AED97 
X-CRM114-Status: GOOD (  14.54  )
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

CC arnd

On Sat, 28 Jun 2025 at 18:48, Tiwei Bie <tiwei.btw@antgroup.com> wrote:
> Since we don't have port I/O support, we should turn HAS_IOPORT_MAP
> off as well. It will fix clang warnings like below:
>
> ./include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>  1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
>       |                                                   ~~~~~~~~~~ ^
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506271049.MtzHqdSd-lkp@intel.com/
> Fixes: b8c9c3b822fe ("um: stop using PCI port I/O")
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
> Strictly speaking, the -Wnull-pointer-arithmetic warnings reported
> by lkp has been fixed by commit b8c9c3b822fe ("um: stop using PCI
> port I/O"). But it introduced new -Wnull-pointer-arithmetic warnings,
> and this patch fixes the newly introduced warnings.
>
>  arch/um/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index f08e8a7fac93..76aa954520b1 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -54,6 +54,9 @@ config UML_IOMEM_EMULATION
>         select INDIRECT_IOMEM
>         select GENERIC_PCI_IOMAP
>
> +config NO_IOPORT_MAP
> +       def_bool y
> +
>  config ISA
>         bool
>

