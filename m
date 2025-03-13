Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A08C282DE
	for <linux-um@archiver.kernel.org>; Thu, 13 Mar 2025 17:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ii1IFZdoC6n5uv3UgvYeObshpXYt3dV3HzZ5zG8DvA=; b=rULFITPljejjDp5vA4LW5+YVCu
	nQM4f63eul91ZkNtLYT2DKBiGxGEbjsyD4Rw0/cG3QTs694ojdQZOFSQUR0bW0ld9My69aOhkzqNv
	BWmkvMP/D933p3EtzEbCimPwAyF1KkOk1GUFEFR5NgpMc0kzeJEoYV8dxzaqxQiEUiV4pOqmuNSca
	xYeb6LYRmeXzSPggewBKxYf0SfNt1E62MQfIOQNGj1cUrGpDl0vz6hXllwtzZGJs61Rqy48Owvrqk
	Iuh3XW3GtjnCE0TGRBYTUa6sZ9hdv35UhGBbW/4iZqVGzPwbTsjbAd9j+bfYW9hsYaXGT7egx2wIU
	To3tfMyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsm8K-0000000BwZw-2pl6;
	Thu, 13 Mar 2025 17:14:12 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tskRL-0000000BeN4-3NGe;
	Thu, 13 Mar 2025 15:25:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1ii1IFZdoC6n5uv3UgvYeObshpXYt3dV3HzZ5zG8DvA=; b=lRuOWyxbyyOyqnZlaNedgwwAl6
	hyx5l1fpq6QPKQrvJNM1x+ia67WOMO3so0oE8pnQNX0bmRqxzQEUeoc8VjmF4c2S3Qo+R6GxOpTqC
	u9JAwgH4CDkJM9r1njHakdLcfgWnzJaHxMwYMDVbB76kPIAXeR5jc3MquxaU31tXngqgbbw1ENzbf
	6PfNSYqCaSsw7A5SN1DMXJW4jCeMfx6Y9rBrX+G/sfvJvhd24CU8OvcypfEZ/drzJ7SVRtnXq720T
	S+wPbvflM87pFlP3yui+FZaKGm9RnGlt9CbbdAlMP5tWFECGQNIf5si5gBf08LcHCc/UzQaIReTCL
	tBthwRRw==;
Received: from mail-ed1-f45.google.com ([209.85.208.45])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tskRI-00000002j1y-3HCA;
	Thu, 13 Mar 2025 15:25:42 +0000
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so2111559a12.1;
        Thu, 13 Mar 2025 08:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741879538; x=1742484338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ii1IFZdoC6n5uv3UgvYeObshpXYt3dV3HzZ5zG8DvA=;
        b=dEp9bakR/d5OgnG87WobSwOCGt1zUZ+ZTJ5ianqdU0nuFzfLKoZJzER0CDI9KZdtlo
         APqT8yfxaVsVgWlbJozNztBX+GyCaOIvMLIKH0hJ3NWLYhKZL7gQ1Kev63LucBSFBe9D
         S7BUGTPPckYj8Bvpe4lzcl264XI3eGCUzrAG67oZ5B5D+of/3vvLFB6RSqG2x3jt53fX
         aZMUserp8awZ34KIAkd69DVzRaGSk94+W2ZJ8juy4CNmj8mL+om/sbRPEZ9q3CZbGmRN
         TvTl9jrqN/2V+LSUqgNCU+VkQ1Ic6tBIR4ojpaYe6CNBSQdFxwtgIx84LxQs1QKKzmkP
         L37g==
X-Forwarded-Encrypted: i=1; AJvYcCUjHb02O418z9XhwZPhATdpe3m+/PAlEfsMbdDN4H269QzhzF1jNDLkgtIA76IXBqTPeBk2KdZUi8s=@lists.infradead.org, AJvYcCVJdF3Sgl5Ax0I8m/5V3d+gT0BBTTp6BXulV5n32+ksTN0ifevk487ifNE96X13zpZXAa7V8sL3ihCPUbA=@lists.infradead.org, AJvYcCVjCUrIS58u4TEOemdzmGiOewHH8Jk7BAKmomRits3lNRxxLjyfLEs/70eNJ5OMqFflNp8mg2xnYJrMC4IaI3SK@lists.infradead.org, AJvYcCX0dyR/D4bmX6FqDh6yAMHLeMhNHZj/EcnN8vYJiJiAn+kspXMpD9utY7QHvORmlkNjgXTT8fATyGJhXLeRuG8=@lists.infradead.org
X-Gm-Message-State: AOJu0YwUkMNHRj/L5iyVTOqTbs5TF6cRs3WgnL88Ed8o3o4b9Eehkap0
	6NMKB4MHARhUY9tOHi4ZM3NUg9Aq4TT3EUKP+YN9iHHK8fHMceVu/sLlJf1ep5E=
X-Gm-Gg: ASbGncv0+OIBUWlU9ymIjMieJ+nDNODBK/0HsUCj/e6JzFHHnhVMqZRTKwoepMHEbmg
	WBOMrnCSltqiAqkdYunRY6YRobJW1qchffHPVr5LxTNlk3K43teH0uWsFAgmULHTVxxslD7cjpp
	FRVDnZg9vJc1edJz5JuXGFJ2g5gOHupp0K/ibe/CZbTTALXrPEJo2OGMFT1UYvrOELV5xhyErvx
	EQe5jFR+tR6mrl9RoaN43Xr4NsxVBnzuQhnEvtV2Vmy7BTX3LwjYaq1uivl76lALN5tI6xSb7D1
	UiVVVQMLK3zl7sm/tVO3dtffbC6FVh+cxGOKygAd3tyPrEsB9zhVYbyUjCwUSrtLxawUr1yipw6
	XjmQIlbw=
X-Google-Smtp-Source: AGHT+IFUOtWBI6NaleiIpQzNbPm2FUEIxsccumL8465K+O7e52a2EisYzv+KU+18QlzYziVsq7ktqA==
X-Received: by 2002:a05:6402:26cc:b0:5e4:a1e8:3ef1 with SMTP id 4fb4d7f45d1cf-5e814e73895mr3417803a12.9.1741879537856;
        Thu, 13 Mar 2025 08:25:37 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad9cbbsm807983a12.54.2025.03.13.08.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 08:25:36 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso3910426a12.1;
        Thu, 13 Mar 2025 08:25:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQFpvhkCI/1lYgflKHvG5Hg2EXzwp6FdptwPqrNM96H5l56jefHEOB6THa+u4v7px7FS1bk6shhi7hnnDMltUn@lists.infradead.org, AJvYcCVG1ZONmH1kwb9zv1m7zU95fZbSBXLw18P90hZTBj1Yiuy0xN3+dJezkvTE1zCef4cR6ugjk+qoUEEOB7U=@lists.infradead.org, AJvYcCXb+BDSlTjUtAyngyitN+I+lQXzUsnTGUhJYMV50DQVCuS8q2kLaR0DwYKNozmBlADzukjT9EWg/lo=@lists.infradead.org, AJvYcCXviQE4N3QyB8tP0YPyE9gCut9DDX2lJNhBNz6tilLUoBtQEh0B8nM+TesDDPXn342IKJIx3MzzceYH/BQXPYA=@lists.infradead.org
X-Received: by 2002:a17:907:9626:b0:ac3:d1c:89ce with SMTP id
 a640c23a62f3a-ac312305664mr252326866b.9.1741879178133; Thu, 13 Mar 2025
 08:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250313135003.836600-1-rppt@kernel.org> <20250313135003.836600-14-rppt@kernel.org>
In-Reply-To: <20250313135003.836600-14-rppt@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Mar 2025 16:19:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWCBL_cg1NgbHCA3e9GTob_P9mTuN_Tepvigci6rxDmbg@mail.gmail.com>
X-Gm-Features: AQ5f1Jr9qHWq5jtnIT3-BmFGhQQ_nRM0uVNr9PeQK5Y9eEomJSZyndfwbc1wpbs
Message-ID: <CAMuHMdWCBL_cg1NgbHCA3e9GTob_P9mTuN_Tepvigci6rxDmbg@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] arch, mm: make releasing of memory to page
 allocator more explicit
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Mark Brown <broonie@kernel.org>, Matt Turner <mattst88@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
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
X-CRM114-CacheID: sfid-20250313_152540_971635_0E836091 
X-CRM114-Status: GOOD (  21.25  )
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

On Thu, 13 Mar 2025 at 14:53, Mike Rapoport <rppt@kernel.org> wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> The point where the memory is released from memblock to the buddy allocator
> is hidden inside arch-specific mem_init()s and the call to
> memblock_free_all() is needlessly duplicated in every artiste cure and
> after introduction of arch_mm_preinit() hook, mem_init() implementation on
> many architecture only contains the call to memblock_free_all().
>
> Pull memblock_free_all() call into mm_core_init() and drop mem_init() on
> relevant architectures to make it more explicit where the free memory is
> released from memblock to the buddy allocator and to reduce code
> duplication in architecture specific code.
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>     # x86
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  arch/m68k/mm/init.c          |  2 --

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

