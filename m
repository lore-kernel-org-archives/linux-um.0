Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447BAC5B569
	for <linux-um@archiver.kernel.org>; Tue, 11 Aug 2026 06:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0iZRfAdzYvTsaTTh/J3ab87cNtJMKi7JiQC3Jqumorg=; b=QUhwSY19qIqks3yi4VHNClUE+0
	NHqQm9Cb7tpo27x3s8XnXaBAAeHEsHQOLaCji+ChcQpXazmFKEjCqNWi1UZvjpsQzEWqOJxr5KHpz
	NcI6SP6gDt1ww9aoRd45659UUOD6pi4ct+iTfsb1UYI1HPjInl0+f14Tzo2FLamkhSUcy2GIr7yD8
	BBpg4vHx9I8rfnbP8zThl1teDoqz53U+jZa/ksYmQxKKAwVwO53VusXQ/hEYSVKhDL3Z6Kg0M6V2s
	3Il6cJ8uTspkHkwSUb+R6JcRW2pq5KZzD/zFMjJKJt5rlz0KdUT1nd2S8cq6ck1iiA6/EQkok02v3
	VmrJQjxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtgJN-0000000DSGN-3l0j;
	Tue, 11 Aug 2026 06:50:09 +0000
Received: from mail-vs1-f51.google.com ([209.85.217.51])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtgJC-0000000DSET-2pqe
	for linux-um@lists.infradead.org;
	Tue, 11 Aug 2026 06:49:59 +0000
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-74ab6c88052so767245137.2
        for <linux-um@lists.infradead.org>; Mon, 10 Aug 2026 23:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786430997; x=1787035797;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0iZRfAdzYvTsaTTh/J3ab87cNtJMKi7JiQC3Jqumorg=;
        b=dl1OxsYUhT52ilO05tMcd9AzSjovvPD1svXYNGhoM0yOfbjlD9RT10OWfyQqc1QZLW
         cezAGjeg9GuYV+KKPjt2VaDYy8hZU+MhL5AQGzzbAMCF0aLjSDElpYDDWiT8mg0lV+DI
         6/tMQbar6rEBtMU/li9tbnLB9DIFcaQdPpxHfjlf05TveItaIYHi0cH5M5XfrWLJ3ABv
         Nby5hsz3Ul18wEMim486zu/uZS6HKJuZVFRjrhEkxwemTVshqfyQlDjq3qi28Z/WohfM
         +9UbBQVBNO8Auh/CStAJB6TnmuTkLsX87BwO6bpbSd+c2BeEvZrZfYaiJpe6pi/5DyWV
         4CTA==
X-Forwarded-Encrypted: i=1; AHgh+RqTx2Ofxq1xVsRmomCbWT+gN6zOGdgZwxvYWOYWbsw8HARSY9hmZ3rwij+Xj4/7yyRv76JAXpkeCQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyLMmV+kI/8mr3pJ1aOv5FM73g4msXq7ol0l98evX58np6+gl+V
	oUmdp55oK5Z4u2RQwghLlXwkqHYsc4k4QLQkbTw90A3dBswZCFigL2U6Q9AQSCx3
X-Gm-Gg: AR+sD13CFw7I+2ThSLUQKKD3rJcLc9blVKzRrxBtTMo69ZTdK7rTy6hkrXCrjC9hwST
	ks7c40FLh/pBBkbQ/Ll21d14jT2aIyJpJdDkOUmIQoO+KVMr9zlg2onarfYwGPa1p/eCi5KF+oN
	ilH3R3pq8Q3xhqHiMAKPwa5WmpH7MOD6GDbFoELjweC/Q1vSjjQtw9EjlAZokZsO1/qUbv6Nfr9
	/jD3PYgZcI5PBmd5jWdMzckC1AW5/Lyx00ZT4qMnaz+7LKUBW/NLAP0MsK3j7AxZhMDWx48wd3i
	qojfnLdx5vHg/L5lYcBUwnRUBO0iZm++fotys2noba5McLmKUSpgz//VuvShSpnqG24kdo80fJi
	vi4ntTrPoI1RfnJa6sjWyYTeOP6QuP1xwJDRJnyeINmzH9Bk/o0vpyf+dEvLu/+cOCs9MCJ3Hb6
	Fl+NmgjdzRnhLj9ULAA28N0aFWAoXlCK59W4p17xF3J6tdLVkkeViG7OWPRO0ZGMTmkrCqCmSpi
	uCWa3SWxEGVViU8WmQPgEAmCA==
X-Received: by 2002:a05:6102:6890:b0:74d:ce65:4739 with SMTP id ada2fe7eead31-76b55a86a60mr282181137.8.1786430997180;
        Mon, 10 Aug 2026 23:49:57 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-76b62e8115asm192604137.1.2026.08.10.23.49.55
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 23:49:56 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-74ac3ea9c60so675604137.1
        for <linux-um@lists.infradead.org>; Mon, 10 Aug 2026 23:49:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpQaKjz/JII+mf+ryE+kzuwzp1o1/U3hxIj3loytyGNjbLwV2pIzXVNHJ+SVWpZxJ5DXx/z5aQ3PA==@lists.infradead.org
X-Received: by 2002:a05:6102:c4a:b0:738:ecd7:1984 with SMTP id
 ada2fe7eead31-76b54a7a17fmr283026137.3.1786430995503; Mon, 10 Aug 2026
 23:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260811042119.3652929-1-anshuman.khandual@arm.com> <20260811042119.3652929-7-anshuman.khandual@arm.com>
In-Reply-To: <20260811042119.3652929-7-anshuman.khandual@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Aug 2026 08:49:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
X-Gm-Features: AUfX_mwgji-OqM2d70As4nCfmG84npBMa5IuhuEcV5XEKzcXYS3fe_Pqx16lD20
Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
Subject: Re: [RFC V2 6/6] mm: Drop pxd_ERROR()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_234958_716784_46AB69F2 
X-CRM114-Status: GOOD (  19.96  )
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

Hi Anshuman,

Thanks for your patch!

On Tue, 11 Aug 2026 at 06:22, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> pxd_ERROR() has been used in generic mm just to print the page table entry
> in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> pxd_ERROR() macros have been provided by all platforms which basically did
> the same thing.
>
> Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> page table entries thus completely dropping dependency on platform provided
> pxd_ERROR() macros which can then be dropped off. First move all required
> helpers in core MM into a header file which could then be used else where.

Oh, the "x" in "pxd" is a wildcard?
Except that is not, as it does not match "pte" ;-)

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
>  arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
>  arch/m68k/include/asm/sun3_pgtable.h          |  7 ----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

