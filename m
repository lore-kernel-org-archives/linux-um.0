Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE52EE7718F
	for <linux-um@archiver.kernel.org>; Sun, 22 Dec 2024 10:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ONVNbxYIwyadSLDvwLNaPGVW+13KFD/yyNlBVYXNzc=; b=0cuJC3BKpHLO6YMWivs2yqfeei
	bcGQOMkTkKXi5/sZIW+D1BoLCDjCX5Jmcx9ND8GOm6n6c48ZzKX0ylu2iB1ArzuI0dtCh9i8/NUXU
	HZNZrE85el5OxSionPslOXMqhmqFPMF9++tfitlbSAoyI0Ru3Z4eTH7V/ZecZWHhYXJ3vtYl1bzY7
	Sk0Fe+knPfcM5lgxZ1lPjPBfFpZXjMZI7TEYo6qDBleIqxmzF7FSACzvMPobPQ1jQVs8Ko0wX4GC2
	iMk8Et1snQxbsegKPnzKYH+Zh84+ug5vq3uyTC/aPdgw/NqARPG79EToDt6LxedEc5jIS4T9uef1I
	qO8h8/0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPJ7G-00000008921-1Htl;
	Sun, 22 Dec 2024 10:23:18 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPJ7C-0000000890V-1Jps;
	Sun, 22 Dec 2024 10:23:15 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-6f26c517979so23703327b3.2;
        Sun, 22 Dec 2024 02:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734862993; x=1735467793; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ONVNbxYIwyadSLDvwLNaPGVW+13KFD/yyNlBVYXNzc=;
        b=P1ucsyMWXboylQvZHlT2H9t1AZOTzneSnKdDJ95cg+sfqdWffkaFgYbbBhp4gOisYt
         rapKKSWQ++BfqcWGVfaxx4C/M45laHUvPS7skG6jMhtC2CG6olVM2XCo0XdktJ2T+Y6V
         ORry0vZ4fpxUzWlP5rZoxILoGUUDF2vC/HMI7RP5ZKmvW7UTMLOlDTRhXVWx2KJ2L07r
         JcOJ+ocDjaRZYb73vTLojDMAg4ItdZkm+3djR9odcNLWG7ZLjbBuI6mLOmOST9DBmvuu
         xT/f51bdOWRKLdi6tSBDirVptvPaAkEhibZ7qL7cjSWT9PQMjagAdiFokg0is39WY0L3
         6oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734862993; x=1735467793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ONVNbxYIwyadSLDvwLNaPGVW+13KFD/yyNlBVYXNzc=;
        b=GHLfkXPhVVXabIC7ftXVBQyfUm6jchKIV3DpvQzETIRcldaTKs7JcdlUMt1DZYSg5i
         KyLUPRI0Br8d8bLEjHyat866k+hGU5v84XpcenRo8YDS9i+DTETcUwrNjpqmyPVP/Z22
         IiA1SYRkuyT8ydD5+/pNTLD6Z2X3u5DeAuG0T5o4qMpW9Nz6517yFX7d4S/pQ/AdzVx/
         RbQaPeB0Kvpv4+/oBdmnIrwUTgrQFvkdiNUxvJ8x8RP50k8cZ1X6PCJhLqjR/T/XdqWG
         5dpuX/LR+NxhAEzTTm0xVgvRWxz3xj8D1UmiBRtvCNtKuOo82OptaejW5o1Smwqo3QDe
         kbdA==
X-Forwarded-Encrypted: i=1; AJvYcCV/bi/UzrCJdT0uJLCCLAzEBi74xSfIwe5utubmN6szA1ZxjbnGSWPy1BnjA8G/EbOIq3PJCrQ1hlnyTir33Kmn@lists.infradead.org, AJvYcCVhQv1ykkIcIzd2IJJKZVez7fD0sJewpQkM8FLZuVRAApyaujkiEh2t8fq9Fy0gsnliMkwfL+qpxWY=@lists.infradead.org, AJvYcCWMi+xI45+qCKIMqOlc34jAzLAlWyCLjHlFbsXXLg2TQcEK/93lR1BKNzivOahdZuDXtzApjJ8j5h1EcQY=@lists.infradead.org
X-Gm-Message-State: AOJu0YxBtHPajBIXN2iVAHfMVNNicd0LaZ63A1rT4qchFQz9A+pNYxJ2
	/lEt/BY7tWRahJl8w8OSLD71kPxZcomJ5AViDCA8axHfYbIQuRR1io96kGqCuJr21zlMGvpHyqa
	HJ/FAgwl4VFVp6ioBcd7gFtjc7kY=
X-Gm-Gg: ASbGncvqDhPvHw7bMUPT8sK90wAYGrwanCk1IC+lYkMeilqkmodRti83dboCXKNNmfp
	UJ0l6aTG4nmxrVkVjztQlMbcTdAeQDqMoN3ojI3o=
X-Google-Smtp-Source: AGHT+IHX0mjmsoNFu7Nk/P1ylkLtsHAmn22nfKbaHPnh1Btm1p2RULi24EAOG9MYK2JmawFo9lS/pEKQIPK2LOk3TLc=
X-Received: by 2002:a05:690c:360c:b0:6f2:9704:405c with SMTP id
 00721157ae682-6f3f8125edfmr74773997b3.15.1734862992817; Sun, 22 Dec 2024
 02:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20241222054331.2705948-1-guoweikang.kernel@gmail.com> <Z2fknmnNtiZbCc7x@kernel.org>
In-Reply-To: <Z2fknmnNtiZbCc7x@kernel.org>
From: Weikang Guo <guoweikang.kernel@gmail.com>
Date: Sun, 22 Dec 2024 18:23:02 +0800
Message-ID: <CAOm6qn=L0GzX4z4Mak1LH6R4wD282dz6qafMFmA39ADaBuLJJQ@mail.gmail.com>
Subject: Re: [PATCH v6] mm/memblock: Add memblock_alloc_or_panic interface
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
	devicetree@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241222_022314_383619_8387E1E9 
X-CRM114-Status: GOOD (  15.96  )
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

Mike Rapoport <rppt@kernel.org> wrote on Sunday, 22 December 2024 18:06
>
> On Sun, Dec 22, 2024 at 01:43:31PM +0800, Guo Weikang wrote:
> > Before SLUB initialization, various subsystems used memblock_alloc to
> > allocate memory. In most cases, when memory allocation fails, an immediate
> > panic is required. To simplify this behavior and reduce repetitive checks,
> > introduce `memblock_alloc_or_panic`. This function ensures that memory
> > allocation failures result in a panic automatically, improving code
> > readability and consistency across subsystems that require this behavior.
> >
> > Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
> > ---
>
> ...
>
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index 673d5cae7c81..73af7ca3fa1c 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -417,6 +417,12 @@ static __always_inline void *memblock_alloc(phys_addr_t size, phys_addr_t align)
> >                                     MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
> >  }
> >
> > +void *__memblock_alloc_or_panic(phys_addr_t size, phys_addr_t align,
> > +                                    const char *func);
>
> Please align this line with the first parameter to the function.
> Other than that
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>

Got it!  Thanks for the feedback!

> > +
> > +#define memblock_alloc_or_panic(size, align)    \
> > +      __memblock_alloc_or_panic(size, align, __func__)
> > +
> >  static inline void *memblock_alloc_raw(phys_addr_t size,
> >                                              phys_addr_t align)
> >  {
>
>
> --
> Sincerely yours,
> Mike.

Best regards.
Guo

