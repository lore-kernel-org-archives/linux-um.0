Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E294C2BA1B
	for <linux-um@archiver.kernel.org>; Wed, 12 Mar 2025 16:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JChFXqPXVY1XHtpbP2WqOfMeQnLS1qQftUfTh17+lXU=; b=23aaCThW1MbHUDej0gq929m3bo
	+PD5dbDLc6k24/lp7MLFXJ0DizLHFuonPpFBGwdAglZD0vPbuk1hsU4w3RQxhj+JeRIl0iffqCN8w
	yURhJnubc1FBph3AxY8h7wKPl2OI/AOS5cSEyWYT9W7q24xFKx8nUfWH1Geq0omyf0c1TYoXXCCnV
	oI3gsf7usELYDp6ouQSl+VDHibOCWSkOipKKVZO+yePShroYp3crSV7ucMHW3+RAWklyjDT0DcosY
	CAV95VBvS8zWdheFSDf5YK4//yAPz6tlBs4HvN2E4QBfAaDv2/L/EUMqlQEVy+GkxGG7oAU4c+ixM
	UeUuhJsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsOY3-00000008yD6-0Ypu;
	Wed, 12 Mar 2025 16:03:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsOSI-00000008xD0-2xSG;
	Wed, 12 Mar 2025 15:57:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 33AA55C5C57;
	Wed, 12 Mar 2025 15:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA41C4CEFE;
	Wed, 12 Mar 2025 15:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741795033;
	bh=dgU35NJAC9FuhPfl4fCxI5+qb1wmL7e+GyilvA+NxwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VMGDPNzrQPf5TkD0b7NrkaL9vBedP++HcJIYppS3OacGh+lmMlyllNbJ65T8EUwpe
	 X6mgQAvFxmpr+7NeL+U8J5eO9mUFyF9iC/Bpw3Fnv2dGtL6Hrt/Yx6uH52UPkON/Bd
	 bMd4vd1sat3O7CafhieqmZ6kqMEcz/ppjRlQKe5fcS7fyHE/3Y4vyt7IpKYAo5CVFc
	 NGaHqUjovj3IqQIA6D2VmMJyyRyouA92R+HwQ7lUhQMLRtbPXzmj+6/9l+YNIMzd2o
	 aGu6LYyHU+u7IYNYk6FT81OA0rsZ70e5lk7oXpt1fRBo8+yNkDj8UUhHY3Of+SO/GN
	 Rivwxuyc+GVag==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5499614d3d2so6195228e87.3;
        Wed, 12 Mar 2025 08:57:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDpKijEiTc5m6/dpbUX8P9r9FJ8+iWx0lv1N3th78Lyd0eqjstLqEZiSedrdag7gB9Xjx701zNPonLW2Syglw=@lists.infradead.org, AJvYcCWeezissyP0W3GGoaojS6zh2DcmlSp0WGzZAluy21SatDehCoW8CGwo2yKE4kTfE7IikA9kSvMQLBX/UQo=@lists.infradead.org, AJvYcCWl52U4DK6+nzOz70711VB/1msvOEdEhNEW20AEcwjKFwuXu+eQ0juKDaq9RJlpEBV5xWAruFUpcAGpgRe1ULYa@lists.infradead.org, AJvYcCXJ85ZGjBqOc2cqANn40kLZa7zgXUatybK4zf3xKNc2I89aPJICL99wKN4N3z3HzlOPS2NPekBmO5Y=@lists.infradead.org
X-Gm-Message-State: AOJu0YxIQt+MCWYzGrzIof0saOs8lQIBZeKlZO2o5BXvEYskqFuAKZ1v
	91vgjz9tWOGty7ZiCMqXc9IjDfE3w2mwj5CmsOJLGxtzmdYuSlN0W1p80wFndMuETjJW7O9ZWGa
	gK4X2hOQk4y2aIgSXSkilpxg3jcU=
X-Google-Smtp-Source: AGHT+IHd+FrUHToN8zCIkYvgOINETMZJki/NvRa0TX9T0SvIe4EkJVM+k58lts/E3WmtqFbt0GpXCZ7ftrMtmqZt6y8=
X-Received: by 2002:a05:6512:3e1a:b0:549:8e54:da9c with SMTP id
 2adb3069b0e04-54990e2becamr8141673e87.4.1741795031214; Wed, 12 Mar 2025
 08:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250306185124.3147510-1-rppt@kernel.org> <20250306185124.3147510-8-rppt@kernel.org>
 <20250307152815.9880Gbd-hca@linux.ibm.com> <Z8_Qawg0dGtZdys7@kernel.org>
In-Reply-To: <Z8_Qawg0dGtZdys7@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 12 Mar 2025 16:56:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHS1YbnYVqVgsyfFSpg9kJM599Yp9TO8AP6--Nbgk7dHQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jrq0NRixaZgOe6Zrlj_W8SN3MQrS2p8OQe5yMSfjVPvuZ4c51CBlAcj7NU
Message-ID: <CAMj1kXHS1YbnYVqVgsyfFSpg9kJM599Yp9TO8AP6--Nbgk7dHQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] s390: make setup_zero_pages() use memblock
To: Mike Rapoport <rppt@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, 
	Brian Cain <bcain@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Guo Ren <guoren@kernel.org>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_085714_858394_EF08A519 
X-CRM114-Status: GOOD (  31.25  )
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

On Tue, 11 Mar 2025 at 06:56, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Fri, Mar 07, 2025 at 04:28:15PM +0100, Heiko Carstens wrote:
> > On Thu, Mar 06, 2025 at 08:51:17PM +0200, Mike Rapoport wrote:
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > >
> > > Allocating the zero pages from memblock is simpler because the memory is
> > > already reserved.
> > >
> > > This will also help with pulling out memblock_free_all() to the generic
> > > code and reducing code duplication in arch::mem_init().
> > >
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > ---
> > >  arch/s390/mm/init.c | 14 +++-----------
> > >  1 file changed, 3 insertions(+), 11 deletions(-)
> >
> > Acked-by: Heiko Carstens <hca@linux.ibm.com>
> >
> > > -   empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> > > +   empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE << order, order);
> > >     if (!empty_zero_page)
> > >             panic("Out of memory in setup_zero_pages");
> >
> > This could have been converted to memblock_alloc_or_panic(), but I
> > guess this can also be done at a later point in time.
>
> Duh, I should have remembered about memblock_alloc_or_panic() :)
>
> @Andrew, can you please pick this as a fixup?
>
> From 344fec8519e5152c25809c9277b54a68f9cde0e9 Mon Sep 17 00:00:00 2001
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Date: Tue, 11 Mar 2025 07:51:27 +0200
> Subject: [PATCH] s390: use memblock_alloc_or_panic() in setup_zero_page()
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/s390/mm/init.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index ab8ece3c41f1..c6a97329d7e7 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -81,9 +81,7 @@ static void __init setup_zero_pages(void)
>         while (order > 2 && (total_pages >> 10) < (1UL << order))
>                 order--;
>
> -       empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE << order, order);
> -       if (!empty_zero_page)
> -               panic("Out of memory in setup_zero_pages");
> +       empty_zero_page = (unsigned long)memblock_alloc_or_panic(PAGE_SIZE << order, order);
>

memblock_alloc_or_panic() takes the alignment is in bytes, no? So
shouldn't the second argument be BIT(order)?

