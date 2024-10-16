Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0A8D2A523
	for <linux-um@archiver.kernel.org>; Wed, 16 Oct 2024 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xNOEBHIW89c1j/jhsHn9BJm63iz+XQaKnsI8oRx93vU=; b=2CX/tEaOvfaltwvOAw5hV7bsNX
	TOgYrk8FFHRWBkBY31umbuUHTsXqNd5yRm1udyFsex32LFTEG+Y/mObN8ARzQ5B5mZ4rABgK57nUQ
	tpv2xz5VFtJu/OIasU2K0a+8FUqIyE8Sh/Xi/RnZgjKQGWg7vbtE99dWQIRupChK/edC8POq9VLRK
	4XrPu9B7L7w4a7bcbDmMvJ7yHt1xqD5CD2zzmdD8Jr6pXCrExNxF+f+vB//46YHzQ28MlIjh62NtL
	8T15KdSLbWGmtVBSz2QsChtoNmq6fgLm1REzJwD7SmLVgDiH2pYnvbu5jt9oNiNfsNrok/tiD8ENw
	crm8dqsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t15G1-0000000C7a0-2QZu;
	Wed, 16 Oct 2024 14:44:13 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t15D6-0000000C6bY-2T2q;
	Wed, 16 Oct 2024 14:41:14 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso23916931fa.2;
        Wed, 16 Oct 2024 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729089669; x=1729694469; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNOEBHIW89c1j/jhsHn9BJm63iz+XQaKnsI8oRx93vU=;
        b=VtAOGDdqpC7YkHc6ScUARAIEg5EN5HLTsyphhkAHKb+yCBm8YLY6kqjbkYKrmI2u0W
         4g+cywvwpYkKuuMwlaEoDKBTFqKbpWQbg2FjCCPCIpcRGb9PiZ5msWBxw8CvaO2sty9i
         2Gy/hoAwF3ecVT3fixNclEL9ob08YqZ/2OrTLI/Aj/zCy9MTk6kZJZqO4SWNdyl1ndE/
         /Mq065zf95GZ6iT02N/GwbCuCvlcud5HQkPm4W8zyUbEggqtjn/MWrBo8+7Vfo0fUnrr
         oZYMyRwxyk2lRNwzNz5FKogsMgujCW12FBexGSlpMUpdb1H3S2Re+f9e/y770FOz0+rz
         9W6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729089669; x=1729694469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNOEBHIW89c1j/jhsHn9BJm63iz+XQaKnsI8oRx93vU=;
        b=fSsSVyGr1z3ELVRr6muHPBynxLPsG3GpRH1Sl22zuNb3Ws4p3spZnArKyQOt4nK9OX
         Hsj6gxQqO1bsZQoVg5n4HPuP8+KHVYfX78ZG9hpED2tfIRI3+pApu7I+Oi7v1bwTP49B
         KKdoZ6LPzVew11lAxGd1sros0HtRwC52nyoe3RkaKZ9p9FyoLLp+lZw+zMmuvyqyFftd
         +KQf0eZ8cspgJX+Q3kCLFQGLuabncDbU4+73oq+Qli30nWRepJOthv5ay7R7jPDE5czY
         dv8eOJ7v0ZHdvzE7H/cPQdCaWN18TwNkJkVMlIQj+RXWmG/s3gkMW6oWvKrSy0HGY1Kn
         bpZw==
X-Forwarded-Encrypted: i=1; AJvYcCVYY4YQkmPnFi7tUWG+FkTZ8ASn14QqF29QuWivBna7vzyeE6nYbqFI/OgH8gOi5K5xRQdMulAN/+48Yyw=@lists.infradead.org, AJvYcCVlNApeKsMJ1WlMBhfhpkduERnbWtQMMcJKV6VjedOHtSDc5oKs3nxPHDMrCylg9NL7t7a9NyfIpfj9Ndfp+muh@lists.infradead.org, AJvYcCX0o0Fo8tNo2xyQ6L03zYCaNyTYTElPIILMj8BRPm1FuMyXEIThTyRmDF0SG2E0AtQwp8M32kR7cJA=@lists.infradead.org, AJvYcCXtWHhrMWT7Y0WmVyqv7b7NXjaHYKmJWXWoRPUT6HmtetSH6zLzta1gbL5e8zmnRIWwR/71SiKUrd3sWrYSuj8=@lists.infradead.org
X-Gm-Message-State: AOJu0Yyj/uHTriKkpMWuR/Mnb8Unmkk/jQ9iGrUzUZ+p2Tk0jMXU6gFl
	XGxjZebqbRbM4xA8Li0XWSnqUNE5zE8+D4MyPKb4saXXCSzQv627
X-Google-Smtp-Source: AGHT+IEQ2b77do+Ei5H+uRLYrEtNQq0NK3oK0wCc+2cFtuWRuK/aQBOOdJJvL1LeKTNOBzUMcJr/yQ==
X-Received: by 2002:a05:651c:1989:b0:2fb:6181:8ca1 with SMTP id 38308e7fff4ca-2fb61b37a76mr33036831fa.6.1729089669341;
        Wed, 16 Oct 2024 07:41:09 -0700 (PDT)
Received: from pc636 (host-95-203-1-67.mobileonline.telia.com. [95.203.1.67])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb5d1d0244sm4327361fa.139.2024.10.16.07.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 07:41:08 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Oct 2024 16:41:03 +0200
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 1/8] mm: vmalloc: group declarations depending on
 CONFIG_MMU together
Message-ID: <Zw_QfzopOv7pCZc_@pc636>
References: <20241016122424.1655560-1-rppt@kernel.org>
 <20241016122424.1655560-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016122424.1655560-2-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_074112_791007_B55CCD46 
X-CRM114-Status: GOOD (  23.65  )
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

On Wed, Oct 16, 2024 at 03:24:17PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> There are a couple of declarations that depend on CONFIG_MMU in
> include/linux/vmalloc.h spread all over the file.
> 
> Group them all together to improve code readability.
> 
> No functional changes.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/vmalloc.h | 60 +++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index ad2ce7a6ab7a..27408f21e501 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -134,12 +134,6 @@ extern void vm_unmap_ram(const void *mem, unsigned int count);
>  extern void *vm_map_ram(struct page **pages, unsigned int count, int node);
>  extern void vm_unmap_aliases(void);
>  
> -#ifdef CONFIG_MMU
> -extern unsigned long vmalloc_nr_pages(void);
> -#else
> -static inline unsigned long vmalloc_nr_pages(void) { return 0; }
> -#endif
> -
>  extern void *vmalloc_noprof(unsigned long size) __alloc_size(1);
>  #define vmalloc(...)		alloc_hooks(vmalloc_noprof(__VA_ARGS__))
>  
> @@ -266,12 +260,29 @@ static inline bool is_vm_area_hugepages(const void *addr)
>  #endif
>  }
>  
> +/* for /proc/kcore */
> +long vread_iter(struct iov_iter *iter, const char *addr, size_t count);
> +
> +/*
> + *	Internals.  Don't use..
> + */
> +__init void vm_area_add_early(struct vm_struct *vm);
> +__init void vm_area_register_early(struct vm_struct *vm, size_t align);
> +
> +int register_vmap_purge_notifier(struct notifier_block *nb);
> +int unregister_vmap_purge_notifier(struct notifier_block *nb);
> +
>  #ifdef CONFIG_MMU
> +#define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
> +
> +unsigned long vmalloc_nr_pages(void);
> +
>  int vm_area_map_pages(struct vm_struct *area, unsigned long start,
>  		      unsigned long end, struct page **pages);
>  void vm_area_unmap_pages(struct vm_struct *area, unsigned long start,
>  			 unsigned long end);
>  void vunmap_range(unsigned long addr, unsigned long end);
> +
>  static inline void set_vm_flush_reset_perms(void *addr)
>  {
>  	struct vm_struct *vm = find_vm_area(addr);
> @@ -279,24 +290,14 @@ static inline void set_vm_flush_reset_perms(void *addr)
>  	if (vm)
>  		vm->flags |= VM_FLUSH_RESET_PERMS;
>  }
> +#else  /* !CONFIG_MMU */
> +#define VMALLOC_TOTAL 0UL
>  
> -#else
> -static inline void set_vm_flush_reset_perms(void *addr)
> -{
> -}
> -#endif
> -
> -/* for /proc/kcore */
> -extern long vread_iter(struct iov_iter *iter, const char *addr, size_t count);
> -
> -/*
> - *	Internals.  Don't use..
> - */
> -extern __init void vm_area_add_early(struct vm_struct *vm);
> -extern __init void vm_area_register_early(struct vm_struct *vm, size_t align);
> +static inline unsigned long vmalloc_nr_pages(void) { return 0; }
> +static inline void set_vm_flush_reset_perms(void *addr) {}
> +#endif /* CONFIG_MMU */
>  
> -#ifdef CONFIG_SMP
> -# ifdef CONFIG_MMU
> +#if defined(CONFIG_MMU) && defined(CONFIG_SMP)
>  struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  				     const size_t *sizes, int nr_vms,
>  				     size_t align);
> @@ -311,22 +312,9 @@ pcpu_get_vm_areas(const unsigned long *offsets,
>  	return NULL;
>  }
>  
> -static inline void
> -pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> -{
> -}
> -# endif
> -#endif
> -
> -#ifdef CONFIG_MMU
> -#define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
> -#else
> -#define VMALLOC_TOTAL 0UL
> +static inline void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms) {}
>  #endif
>  
> -int register_vmap_purge_notifier(struct notifier_block *nb);
> -int unregister_vmap_purge_notifier(struct notifier_block *nb);
> -
>  #if defined(CONFIG_MMU) && defined(CONFIG_PRINTK)
>  bool vmalloc_dump_obj(void *object);
>  #else
> -- 
> 2.43.0
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

