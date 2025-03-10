Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01763C35FF1
	for <linux-um@archiver.kernel.org>; Mon, 10 Mar 2025 00:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qo3QDwLEv3AoewB0aMf+MMUU/5ebAyWrJ6FGDuRMIBU=; b=xNtF06YMTRSjK9pbCDzB/fna8F
	/S4sIVcWq6wOpBc42aXpaEo6dpESg4NuolInhcj9bVziiX0BY+iiQN6Kis6H0G4wQ/MXiqhRoXlWG
	wnTNyT5jSwkDwJ6mnbbvi4vfkxTCbYo3taQRA8AWYeblUhtNcE/H2ZfCTt/6oBxr8RO9+ldc3n+ee
	814XpwkrJVPCW7qlR6QJYWqlWbAeC3Ia908cQXA8wzBm9l84cRoN8HamIQUWunG9sFw7wmenSrjJD
	hbKlgGbuBcAzamg0ocOaHozxkn8X5NskG/7aorRHrDcycFmemG+uTkz2JlaZSQ8T1eseHzCPF1TV3
	sQKGqi9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trRFj-00000001LPy-0FLk;
	Mon, 10 Mar 2025 00:44:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trRFe-00000001LO8-2SiK;
	Mon, 10 Mar 2025 00:44:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1DE105C4D02;
	Mon, 10 Mar 2025 00:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C42C116B1;
	Mon, 10 Mar 2025 00:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741567452;
	bh=tXY/sDLcuj92SaFYz0hFOsAFXofDkFw5jSfwl2CB2dY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ObvShaOUSxV6KHNstZFYDIQ/YvNBDM9n6zuERhfLyE5VrWSOxguuiJxiPWhJwtMnU
	 Sk3Ii6GvpW3T2XpA2iDMWHxYYEztr4yFnzbIintQL/FG7KQnnK1yLX609LGJMWnAWL
	 KJ1fdsXIOipOOusrrgeKqUvfJXnacMmdeASVUHOse3Qimf8c2sOIXXVH5L0DTyu6Jy
	 cr4CmMcAVzeASAyCZbhthYmUKg72OM4gAsvhk90glp4CmG2au8jD1wc7OXUvCGzR4+
	 jO8xHrqvnZvljrpDl1fwta+13voMQl23Oo4RKAFvOc+7yMNoSejSoDdMzf1kGvI20U
	 2G6iH4fF4pFlg==
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-391342fc1f6so2681088f8f.1;
        Sun, 09 Mar 2025 17:44:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3+EuYUDhoYez++aErjrFpB+XhYAaLaeb7NttcWV6j44WPFnwHwc/PVodN56SHkNU/wx7Qbj6OLv0=@lists.infradead.org, AJvYcCW6DbMEJZn15J8tBsC9IMXdhdoYZjjOB7RkpNtBKr8tSvvMfl4daoyLWP/WTs66QKvWo2B25jjseTZvhe1VGSE=@lists.infradead.org, AJvYcCWMuwqgVP3q6zxjnQhTL7iY1uq7BVd9R+ElHG4rTsejyiqWL4CxXxqZy6tDnyIPGWSkgdcIwFKEkG9sK1IDC8ZK@lists.infradead.org, AJvYcCWsLwOk/FN0EVgVjd3VnzUupjg3de0XfnAhjzCaGsr+fv8SaEbIlb8kiJTopWOfW6CnUVmvbzcHDhlLRN0=@lists.infradead.org
X-Gm-Message-State: AOJu0YxetNZtILOW5ViGcLNJVMaXoQZ8Q9/v9QZ/oOMcCUGruush+S+W
	3RtVWlgLOZDdq20zrRvAQrK0S5+CxL5p8a2haSf13/DNWUwffOMiqPd1xoaxgEha/exISnB1nAX
	zAf7E2ltnyLe4PNJfL5hYPZadGjk=
X-Google-Smtp-Source: AGHT+IHp0xTG1Ng23HFO+vDoVdsoufkarKG1pMLa2Hgf32UrExuCoU7QvtsFi3JnHOAx4U/X+f6ME+7JOCYs321ZM0M=
X-Received: by 2002:a5d:6d8a:0:b0:391:1218:d5f7 with SMTP id
 ffacd0b85a97d-39132dacbd3mr7997015f8f.40.1741567450112; Sun, 09 Mar 2025
 17:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250306185124.3147510-1-rppt@kernel.org> <20250306185124.3147510-3-rppt@kernel.org>
In-Reply-To: <20250306185124.3147510-3-rppt@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 10 Mar 2025 08:43:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQBLMt01QjnhX1tCgHs6HJm1hZXQXgVjNkNS5Yt5t4UCQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpCBLojM2w9P1ED3pCe1VmP9TPz-dzItajSIbNDMlmKYLEeMGoNaHpCAZk
Message-ID: <CAJF2gTQBLMt01QjnhX1tCgHs6HJm1hZXQXgVjNkNS5Yt5t4UCQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] csky: move setup_initrd() to setup.c
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
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
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250309_174414_720113_734CD416 
X-CRM114-Status: GOOD (  22.53  )
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

Move setup_initrd from mem_init into memblock_init, that LGTM.

Acked by: Guo Ren (csky) <guoren@kernel.org>

On Fri, Mar 7, 2025 at 2:52=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Memory used by initrd should be reserved as soon as possible before
> there any memblock allocations that might overwrite that memory.
>
> This will also help with pulling out memblock_free_all() to the generic
> code and reducing code duplication in arch::mem_init().
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/csky/kernel/setup.c | 43 ++++++++++++++++++++++++++++++++++++++++
>  arch/csky/mm/init.c      | 43 ----------------------------------------
>  2 files changed, 43 insertions(+), 43 deletions(-)
>
> diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
> index fe715b707fd0..e0d6ca86ea8c 100644
> --- a/arch/csky/kernel/setup.c
> +++ b/arch/csky/kernel/setup.c
> @@ -12,6 +12,45 @@
>  #include <asm/mmu_context.h>
>  #include <asm/pgalloc.h>
>
> +#ifdef CONFIG_BLK_DEV_INITRD
> +static void __init setup_initrd(void)
> +{
> +       unsigned long size;
> +
> +       if (initrd_start >=3D initrd_end) {
> +               pr_err("initrd not found or empty");
> +               goto disable;
> +       }
> +
> +       if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
> +               pr_err("initrd extends beyond end of memory");
> +               goto disable;
> +       }
> +
> +       size =3D initrd_end - initrd_start;
> +
> +       if (memblock_is_region_reserved(__pa(initrd_start), size)) {
> +               pr_err("INITRD: 0x%08lx+0x%08lx overlaps in-use memory re=
gion",
> +                      __pa(initrd_start), size);
> +               goto disable;
> +       }
> +
> +       memblock_reserve(__pa(initrd_start), size);
> +
> +       pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
> +               (void *)(initrd_start), size);
> +
> +       initrd_below_start_ok =3D 1;
> +
> +       return;
> +
> +disable:
> +       initrd_start =3D initrd_end =3D 0;
> +
> +       pr_err(" - disabling initrd\n");
> +}
> +#endif
> +
>  static void __init csky_memblock_init(void)
>  {
>         unsigned long lowmem_size =3D PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET=
_OFFSET);
> @@ -40,6 +79,10 @@ static void __init csky_memblock_init(void)
>                 max_low_pfn =3D min_low_pfn + sseg_size;
>         }
>
> +#ifdef CONFIG_BLK_DEV_INITRD
> +       setup_initrd();
> +#endif
> +
>         max_zone_pfn[ZONE_NORMAL] =3D max_low_pfn;
>
>         mmu_init(min_low_pfn, max_low_pfn);
> diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
> index bde7cabd23df..ab51acbc19b2 100644
> --- a/arch/csky/mm/init.c
> +++ b/arch/csky/mm/init.c
> @@ -42,45 +42,6 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsig=
ned long)]
>                                                 __page_aligned_bss;
>  EXPORT_SYMBOL(empty_zero_page);
>
> -#ifdef CONFIG_BLK_DEV_INITRD
> -static void __init setup_initrd(void)
> -{
> -       unsigned long size;
> -
> -       if (initrd_start >=3D initrd_end) {
> -               pr_err("initrd not found or empty");
> -               goto disable;
> -       }
> -
> -       if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
> -               pr_err("initrd extends beyond end of memory");
> -               goto disable;
> -       }
> -
> -       size =3D initrd_end - initrd_start;
> -
> -       if (memblock_is_region_reserved(__pa(initrd_start), size)) {
> -               pr_err("INITRD: 0x%08lx+0x%08lx overlaps in-use memory re=
gion",
> -                      __pa(initrd_start), size);
> -               goto disable;
> -       }
> -
> -       memblock_reserve(__pa(initrd_start), size);
> -
> -       pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
> -               (void *)(initrd_start), size);
> -
> -       initrd_below_start_ok =3D 1;
> -
> -       return;
> -
> -disable:
> -       initrd_start =3D initrd_end =3D 0;
> -
> -       pr_err(" - disabling initrd\n");
> -}
> -#endif
> -
>  void __init mem_init(void)
>  {
>  #ifdef CONFIG_HIGHMEM
> @@ -92,10 +53,6 @@ void __init mem_init(void)
>  #endif
>         high_memory =3D (void *) __va(max_low_pfn << PAGE_SHIFT);
>
> -#ifdef CONFIG_BLK_DEV_INITRD
> -       setup_initrd();
> -#endif
> -
>         memblock_free_all();
>
>  #ifdef CONFIG_HIGHMEM
> --
> 2.47.2
>


--=20
Best Regards
 Guo Ren

