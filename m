Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A55CED256
	for <linux-um@archiver.kernel.org>; Tue,  8 Oct 2024 02:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DT0ywLFKrUO3ulJ9Jiduz32szXhm1G71Y1Xb7Yo1Js8=; b=b0WGIVhq5bDPf1Eit5xQFxxSSN
	Ks5iHhceYe8FWiTA5Nz4iU9yK3LGmWOL50Ek4v0mpRRn/NwPbAEZ54kYWfvJMQvdBGwsiIbO4ekmL
	2Q5XZs/hE1Ugl9qw9lXFW8HwFYqTB2qL3Xgs/NvWW5H2k7O94TLxMY+9s3yfxUeHWhrpccAMzbUHE
	xy8PvE9mhBmq54hNAghvcStRfhPoiAa8dQ8mJ7V+YBUtGGZz96SUinEjLsNo93kRcTFfGDXIX0LeG
	ax9CZDSVG/eBd6Jz393DLdxyamQF+FkQFnznyqjLZ1nH2VFUPpziNOH/x32imVnNPF+Fu51SJ3Dlp
	4gM8OLig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxzhT-00000004GV8-08s4;
	Tue, 08 Oct 2024 02:11:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxzhM-00000004GRD-3WIA;
	Tue, 08 Oct 2024 02:11:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 241C95C5EA6;
	Tue,  8 Oct 2024 02:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC7BC4CED8;
	Tue,  8 Oct 2024 02:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728353498;
	bh=ecuISJm/aWL+tNMQ+twAVlW+4RZvWpoN2srrbXkDB94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sJVgAncTPsJH0dYu/FY7tpoM13FlZrkcGW302R2qV3rAtntuHnx6b6IBtsoGqJfUK
	 OJlF20yd3fT8v8p+RPUvLVZ1RAMX5W6IbxX8tZagSwZOA/94MMpuD4+qFDEILoEjsf
	 P9uAjzPBaX291VACffb+ISH0H3TDsmmxM/gNcXrwWMJ0mwOhLF9F36oQ6KMq+Kl+J3
	 cl4KezTj+ksZUrr54Ao44lrKdmPEUpk3T3kJ7LEHkgZvFjg/8ZeTWGIRfWaPxyNycf
	 uEqf34myc+g6AkPGGZi/bTzkGCJuh9wf939s4XdMc4f/DEpE3N6CmVgYLon7hKR9NJ
	 ZKCT4YfZMpMYg==
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so4654022f8f.1;
        Mon, 07 Oct 2024 19:11:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVN18iswLpN1xrP/jJrFSbxOgr327Afr9PBptceckKe0eazgdLdo72MQB80bqrNjrCn6ifO4nAi3Oc=@lists.infradead.org, AJvYcCWYtX2M714Qc9DTDZrKH3aYPVgtfP6D7acXeNSSBFeJt60wU7aZEc1DwjMlRgzDd99lx2q33xAWUMjcB70FMKI2@lists.infradead.org, AJvYcCXY6UAAI9kYX7zYTRUl2xQ2Gd2K0tQd9t0qDDuQsUagF3Hvsm2k8jRprRkviWhB70iljc/GahckMN8Epi4=@lists.infradead.org, AJvYcCXp2Jg8tP2WWTFoluF8o6ImJSFZBpBlLH04vknGAPcGysWTbe1Kam4r2prUD2gI1ngUL50SMMSZpAsOMPZKIHE=@lists.infradead.org
X-Gm-Message-State: AOJu0Yyo8J1eJyuVfpCRse/kQO8ZrQHfmG/9AcvmFhv9st/SXu2q8f7s
	ySqBoaOhUB6NsqHgAMwm/TZmDiYq+4VyQ2v7kjCLbHNCEnJQRQCqeFqvQlif7vRw58Bm6J15RjU
	sWF3nqh++3pK1n9DJ00Z5sBr2g/U=
X-Google-Smtp-Source: AGHT+IG9/HXDQPVy3roiGpnpx5nYoWEmk19PPS8Q+OmkGvZ1j1NxJVVRW61nrohcbFPxLB5t6MVKLRvfuhF1lJEIdu8=
X-Received: by 2002:a5d:6e0a:0:b0:374:ce15:9995 with SMTP id
 ffacd0b85a97d-37d0e78253cmr10508015f8f.34.1728353497103; Mon, 07 Oct 2024
 19:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241007062858.44248-1-rppt@kernel.org> <20241007062858.44248-6-rppt@kernel.org>
In-Reply-To: <20241007062858.44248-6-rppt@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 8 Oct 2024 10:11:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4u5qk-Zd8ctiooCv_hGKbDpXRAtTZMMsUab9bbLAnd5A@mail.gmail.com>
Message-ID: <CAAhV-H4u5qk-Zd8ctiooCv_hGKbDpXRAtTZMMsUab9bbLAnd5A@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] arch: introduce set_direct_map_valid_noflush()
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@infradead.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>, 
	Stafford Horne <shorne@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, 
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_191140_992896_238B16B6 
X-CRM114-Status: GOOD (  26.06  )
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

Hi, Mike,

On Mon, Oct 7, 2024 at 2:30=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Add an API that will allow updates of the direct/linear map for a set of
> physically contiguous pages.
>
> It will be used in the following patches.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/arm64/include/asm/set_memory.h     |  1 +
>  arch/arm64/mm/pageattr.c                | 10 ++++++++++
>  arch/loongarch/include/asm/set_memory.h |  1 +
>  arch/loongarch/mm/pageattr.c            | 21 +++++++++++++++++++++
>  arch/riscv/include/asm/set_memory.h     |  1 +
>  arch/riscv/mm/pageattr.c                | 15 +++++++++++++++
>  arch/s390/include/asm/set_memory.h      |  1 +
>  arch/s390/mm/pageattr.c                 | 11 +++++++++++
>  arch/x86/include/asm/set_memory.h       |  1 +
>  arch/x86/mm/pat/set_memory.c            |  8 ++++++++
>  include/linux/set_memory.h              |  6 ++++++
>  11 files changed, 76 insertions(+)
>
> diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm=
/set_memory.h
> index 917761feeffd..98088c043606 100644
> --- a/arch/arm64/include/asm/set_memory.h
> +++ b/arch/arm64/include/asm/set_memory.h
> @@ -13,6 +13,7 @@ int set_memory_valid(unsigned long addr, int numpages, =
int enable);
>
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
>  bool kernel_page_present(struct page *page);
>
>  #endif /* _ASM_ARM64_SET_MEMORY_H */
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 0e270a1c51e6..01225900293a 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -192,6 +192,16 @@ int set_direct_map_default_noflush(struct page *page=
)
>                                    PAGE_SIZE, change_page_range, &data);
>  }
>
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid)
> +{
> +       unsigned long addr =3D (unsigned long)page_address(page);
> +
> +       if (!can_set_direct_map())
> +               return 0;
> +
> +       return set_memory_valid(addr, nr, valid);
> +}
> +
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  void __kernel_map_pages(struct page *page, int numpages, int enable)
>  {
> diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/inc=
lude/asm/set_memory.h
> index d70505b6676c..55dfaefd02c8 100644
> --- a/arch/loongarch/include/asm/set_memory.h
> +++ b/arch/loongarch/include/asm/set_memory.h
> @@ -17,5 +17,6 @@ int set_memory_rw(unsigned long addr, int numpages);
>  bool kernel_page_present(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>  int set_direct_map_invalid_noflush(struct page *page);
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
>
>  #endif /* _ASM_LOONGARCH_SET_MEMORY_H */
> diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
> index ffd8d76021d4..f14b40c968b4 100644
> --- a/arch/loongarch/mm/pageattr.c
> +++ b/arch/loongarch/mm/pageattr.c
> @@ -216,3 +216,24 @@ int set_direct_map_invalid_noflush(struct page *page=
)
>
>         return __set_memory(addr, 1, __pgprot(0), __pgprot(_PAGE_PRESENT =
| _PAGE_VALID));
>  }
> +
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid)
> +{
> +       unsigned long addr =3D (unsigned long)page_address(page);
> +       pgprot_t set, clear;
> +
> +       return __set_memory((unsigned long)page_address(page), nr, set, c=
lear);
This line should be removed.

Huacai

> +
> +       if (addr < vm_map_base)
> +               return 0;
> +
> +       if (valid) {
> +               set =3D PAGE_KERNEL;
> +               clear =3D __pgprot(0);
> +       } else {
> +               set =3D __pgprot(0);
> +               clear =3D __pgprot(_PAGE_PRESENT | _PAGE_VALID);
> +       }
> +
> +       return __set_memory(addr, 1, set, clear);
> +}
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm=
/set_memory.h
> index ab92fc84e1fc..ea263d3683ef 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -42,6 +42,7 @@ static inline int set_kernel_memory(char *startp, char =
*endp,
>
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
>  bool kernel_page_present(struct page *page);
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 271d01a5ba4d..d815448758a1 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -386,6 +386,21 @@ int set_direct_map_default_noflush(struct page *page=
)
>                             PAGE_KERNEL, __pgprot(_PAGE_EXEC));
>  }
>
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid)
> +{
> +       pgprot_t set, clear;
> +
> +       if (valid) {
> +               set =3D PAGE_KERNEL;
> +               clear =3D __pgprot(_PAGE_EXEC);
> +       } else {
> +               set =3D __pgprot(0);
> +               clear =3D __pgprot(_PAGE_PRESENT);
> +       }
> +
> +       return __set_memory((unsigned long)page_address(page), nr, set, c=
lear);
> +}
> +
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void=
 *data)
>  {
> diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/s=
et_memory.h
> index 06fbabe2f66c..240bcfbdcdce 100644
> --- a/arch/s390/include/asm/set_memory.h
> +++ b/arch/s390/include/asm/set_memory.h
> @@ -62,5 +62,6 @@ __SET_MEMORY_FUNC(set_memory_4k, SET_MEMORY_4K)
>
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
>
>  #endif
> diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
> index 5f805ad42d4c..4c7ee74aa130 100644
> --- a/arch/s390/mm/pageattr.c
> +++ b/arch/s390/mm/pageattr.c
> @@ -406,6 +406,17 @@ int set_direct_map_default_noflush(struct page *page=
)
>         return __set_memory((unsigned long)page_to_virt(page), 1, SET_MEM=
ORY_DEF);
>  }
>
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid)
> +{
> +       unsigned long flags;
> +
> +       if (valid)
> +               flags =3D SET_MEMORY_DEF;
> +       else
> +               flags =3D SET_MEMORY_INV;
> +
> +       return __set_memory((unsigned long)page_to_virt(page), nr, flags)=
;
> +}
>  #if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
>
>  static void ipte_range(pte_t *pte, unsigned long address, int nr)
> diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set=
_memory.h
> index 4b2abce2e3e7..cc62ef70ccc0 100644
> --- a/arch/x86/include/asm/set_memory.h
> +++ b/arch/x86/include/asm/set_memory.h
> @@ -89,6 +89,7 @@ int set_pages_rw(struct page *page, int numpages);
>
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
>  bool kernel_page_present(struct page *page);
>
>  extern int kernel_set_to_readonly;
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 44f7b2ea6a07..069e421c2247 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2444,6 +2444,14 @@ int set_direct_map_default_noflush(struct page *pa=
ge)
>         return __set_pages_p(page, 1);
>  }
>
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid)
> +{
> +       if (valid)
> +               return __set_pages_p(page, nr);
> +
> +       return __set_pages_np(page, nr);
> +}
> +
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  void __kernel_map_pages(struct page *page, int numpages, int enable)
>  {
> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> index e7aec20fb44f..3030d9245f5a 100644
> --- a/include/linux/set_memory.h
> +++ b/include/linux/set_memory.h
> @@ -34,6 +34,12 @@ static inline int set_direct_map_default_noflush(struc=
t page *page)
>         return 0;
>  }
>
> +static inline int set_direct_map_valid_noflush(struct page *page,
> +                                              unsigned nr, bool valid)
> +{
> +       return 0;
> +}
> +
>  static inline bool kernel_page_present(struct page *page)
>  {
>         return true;
> --
> 2.43.0
>

