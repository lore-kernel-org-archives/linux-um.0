Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D47E7718B
	for <linux-um@archiver.kernel.org>; Mon, 23 Dec 2024 07:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0v6aG1YFkKVxPZgrKFkppCnD7setaclMAdKcShBz7Ms=; b=1sGiroTrpV4DjAEnxqjYBM5VIz
	0/3rFkdCFN4pCrBKLh9hIII6ilzgFXhyhzEw8a1rc6DnDfi1/Bf+ieTHJqKxWoEv1CiYI2IFVn/oE
	Ua/bELmVtoIeixCoglikXjOXZ/MORf4EWU3QTvmV+2K49XtOSaNmJja+OqXW7J174IAMn2HExcPSh
	989KUMpPEFN3NoWhUQnY44vG6nUguiQYXw7g7jGVD7CeL3v3QVSRfTOuwL8HeYOSWaUWbKkv0gN9C
	4HB6Rxq5k1JSPcoM8QSNKKms7zfOIavevo2ZDLoRrErLYySxzB1i423a30dLOwelj9COc2hIifCi3
	Gyw5U9SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPcvJ-00000009WRK-2j41;
	Mon, 23 Dec 2024 07:32:17 +0000
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPcvF-00000009WPp-1qGl;
	Mon, 23 Dec 2024 07:32:14 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-6f00b10bc1dso29183577b3.3;
        Sun, 22 Dec 2024 23:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734939132; x=1735543932; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0v6aG1YFkKVxPZgrKFkppCnD7setaclMAdKcShBz7Ms=;
        b=TBoRixMe7yiXIK102IH5/X9GnwOOq0sdoxZ7sWKMI+lickah4VHwey/KwAR9owrbZf
         r4sdLZQTIQsnqDb6+TOyWkxzOt5vdjUGja8txzq36AXIlTaHzp4HkuRICYMIKdQ6RpcW
         N/yXiPTgII7sTr2hiO1hny9rLuXm5LWTY12fT2d2QntrpMFhfiqUKppQ3IG2mlkyEtUE
         +/iN3+9PqZoAk+s153Ht63ky5MSa2A3EAp59X9i3MYso/nqsBGOKJMtPNDI3F84qVjaP
         ztnRhoqKPRha4QQfH2Y5r3gvtVyBsZCy424XZ9hGU9AmKODxoOfUxl3WLsrd6sfz7QWX
         KpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734939132; x=1735543932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0v6aG1YFkKVxPZgrKFkppCnD7setaclMAdKcShBz7Ms=;
        b=l4iKsGmcMocFKoqEeLgbpH3FdiSIPR7sc8WWY2TpYWDY4skugGs42zqMqtwVMC82FG
         IU/epvkK3qyeTLOYevYDf17F6mlAHzP6d6JSCi77UT+6Gc7f4Qe8UlDZg537rcLLlNR9
         SQiJD8uJs5zSiig0jLeRvdY2sYhHAIxG5uE4vjPQq24cTCCFXET9XKQpvBw4ZpIQunuI
         lzfGpA9z/FRmfZmSriThHLODBjnng+o7oPvm5xT4fxAlajBaB/zywDuSS1avCZ00SLlS
         y/woKn7fFUmmB0ZH3fXfGJ84UE9+zLfoopRXCgGpHgRlOJZqtFNxPxTZ7Pm833ObdGn+
         +R4w==
X-Forwarded-Encrypted: i=1; AJvYcCUgmZt+HwMRF9LKoPDsK3Y5zuNiwuNPvADcO3gr4frhxI4KSgQfnN9QDCqhE4HPno7L8kb1pL+WDOTuTXNzJ6Xg@lists.infradead.org, AJvYcCV5w8AYNpfMZG5fvcseO1PPcLLBk/W9h/l12XT+/O3QzyVEqNs23lrMuYj59uTKOMfLQAKyk0AZef0=@lists.infradead.org, AJvYcCX5V7gy8lOIz6ZQLqnD2c70YOZWm+vrnx+9tHWWEnQPOcNyKHN4U7o1P91PsX7rIjKfoj35jlX/R/orbo4=@lists.infradead.org
X-Gm-Message-State: AOJu0YxXfVYtyKt9FBJdxhAG3lROzF5roFIYmvP10vsHU9sEIVsY/6ue
	jm26RJJL/ajr0CnGUE7/X7JeYHuJm8oeTzNj/wb25G/+ua9xCNudvxkvJwRb72WuJk6vv3I7JXb
	ZY0yN10MzmtfsZ9yMXp5bkjz/wAE=
X-Gm-Gg: ASbGncvqmyvDC7xWdmuTanaIRAQ9FMGARSi64aEYTLl08na/LZ0TW/gOGSmUD6d05of
	0ALnuaXA8UHAq0NsaGKEF8pcHjxIao/MXPHADWGc=
X-Google-Smtp-Source: AGHT+IE9Zx6rrSxmo/TfVMJEMfCSEvv5kTOAJj2WU/ZWv6yREWR2EgA4NDWJv08ZAUMMHtBOTiCxaj5H+lZ0CIJRFqw=
X-Received: by 2002:a05:690c:6e0c:b0:6ef:6b56:fb46 with SMTP id
 00721157ae682-6f3f824cb08mr87351047b3.40.1734939131915; Sun, 22 Dec 2024
 23:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20241222111537.2720303-1-guoweikang.kernel@gmail.com> <Z2kNTjO8hXzN66bX@kernel.org>
In-Reply-To: <Z2kNTjO8hXzN66bX@kernel.org>
From: Weikang Guo <guoweikang.kernel@gmail.com>
Date: Mon, 23 Dec 2024 15:32:01 +0800
Message-ID: <CAOm6qnkRUMnVGj7tnem822nRpJ8R6kFVf6B4W9MhMSBQY8X7Kg@mail.gmail.com>
Subject: Re: [PATCH v7] mm/memblock: Add memblock_alloc_or_panic interface
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Sam Creasey <sammy@sammy.net>, 
	Huacai Chen <chenhuacai@kernel.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	rafael.j.wysocki@intel.com, Palmer Dabbelt <palmer@rivosinc.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Easwar Hariharan <eahariha@linux.microsoft.com>, 
	Johannes Berg <johannes.berg@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@intel.com>, Christian Brauner <brauner@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	WANG Xuerui <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Helge Deller <deller@gmx.de>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Geoff Levand <geoff@infradead.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, kasan-dev@googlegroups.com, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241222_233213_520111_E9E97C1C 
X-CRM114-Status: GOOD (  20.38  )
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

Mike Rapoport <rppt@kernel.org> wrote on Monday 23 December 2024 at 15:12
>
> On Sun, Dec 22, 2024 at 07:15:37PM +0800, Guo Weikang wrote:
> > Before SLUB initialization, various subsystems used memblock_alloc to
> > allocate memory. In most cases, when memory allocation fails, an immediate
> > panic is required. To simplify this behavior and reduce repetitive checks,
> > introduce `memblock_alloc_or_panic`. This function ensures that memory
> > allocation failures result in a panic automatically, improving code
> > readability and consistency across subsystems that require this behavior.
> >
> > Changelog:
> > ----------
> > v1: initial version
> > v2: add __memblock_alloc_or_panic support panic output caller
> > v3: panic output phys_addr_t use printk's %pap
> > v4: make __memblock_alloc_or_panic out-of-line, move to memblock.c
> > v6: Fix CI compile error
> > Links to CI: https://lore.kernel.org/oe-kbuild-all/202412221000.r1NzXJUO-lkp@intel.com/
> > v6: Fix CI compile warinigs
> > Links to CI: https://lore.kernel.org/oe-kbuild-all/202412221259.JuGNAUCq-lkp@intel.com/
> > v7: add chagelog and adjust function declaration alignment format
> > ----------
> >
> > Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
> > Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Acked-by: Xi Ruoyao <xry111@xry111.site>
>
> If people commented on your patch it does not mean you should add
> Reviewed-by or Acked-by tags for them. Wait for explicit tags from the
> reviewers.

First of all, thank you for your reminder and patience. In fact, this
is the first time I received a patch discussion when submitting a
patch.
About Reviewed-by or Acked-by tags, I will not add it myself in the
future. Regarding this patch, do I need to provide a new patch to
update it? Or will you modify it?  Looking forward to your reply

>
> And don't respin that often, "Reviewers are busy people and may not get to
> your patch right away" [1].
>

OK, I will be more patient and update after confirming that there are
no more comments.

> [1] https://docs.kernel.org/process/submitting-patches.html
>
>
> --
> Sincerely yours,
> Mike.


--
Best regards,
Guo

