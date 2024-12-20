Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4138E7718C
	for <linux-um@archiver.kernel.org>; Fri, 20 Dec 2024 23:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EwcaWmbpAr7Tt6bNh0ZEoMJ/C6ZMgwB9Hii3xy1Ro3M=; b=Mk/jM9kdj7+n2VPSC2gBIsN+2c
	Oo+RmrEugrffPdmnRTYbWgBvmsCj8QGfFRKcIlc56rHC6Za0RbhNzrFkxO+4ocAxfE4mT3dp6Xjpz
	ivXPNRBQvdd5mVuRqgpcdhQp9gcYOec+ibiTdSza1sPScqsr7NthH0pXSupl2C9napqrojvnLVkvo
	nOj9IuNPlDR94j2KV1j8+BUyKep7ZnwP/6k5Ou1fCiQKFVoWu6eg/4aC1cuqjl7kXb8aB7VGv0uDF
	6lvzU76ZQaHwqPdJu2KKSLeQHV/KhWuSelRsidbQjSUbEM59crTQqlCVfHDxoEvUHobBsFgImMygo
	ptMJcSPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOm4m-00000006EsZ-0xYS;
	Fri, 20 Dec 2024 23:06:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOm4j-00000006ErS-02No;
	Fri, 20 Dec 2024 23:06:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 683895C3B27;
	Fri, 20 Dec 2024 23:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D4DC4CECD;
	Fri, 20 Dec 2024 23:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734735987;
	bh=rDnT4CiiEQHDei+WTY8t89wAldSK7/wzy9hzuNQ2FY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ko0NoC85TGcP1IppTBQ7r5GFZyBBTG2SpQ0tFrc/AJkG+/T9Itx2K+hPhmLUjOFT3
	 W/JopMsDfKdWQ+Sgte/CaZu5u4oCC9X7AhqHTGt1/QNG5SKrdk/OmLPnondMcorXOq
	 YK2sRjfqtNIqcRTWYGNAXSYWTaR7HQTBx80wOGXo=
Date: Fri, 20 Dec 2024 15:06:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Guo Weikang <guoweikang.kernel@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun
 Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Sam Creasey <sammy@sammy.net>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Huacai Chen <chenhuacai@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Oreoluwa Babatunde <quic_obabatun@quicinc.com>, rafael.j.wysocki@intel.com,
 Palmer Dabbelt <palmer@rivosinc.com>, Hanjun Guo <guohanjun@huawei.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>, Johannes Berg
 <johannes.berg@intel.com>, Ingo Molnar <mingo@kernel.org>, Dave Hansen
 <dave.hansen@intel.com>, Christian Brauner <brauner@kernel.org>, KP Singh
 <kpsingh@kernel.org>, Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>,
 WANG Xuerui <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson
 <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
 Helge Deller <deller@gmx.de>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Geoff
 Levand <geoff@infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson
 <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Len Brown <lenb@kernel.org>,
 Juergen Gross <jgross@suse.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Chris Zankel <chris@zankel.net>, Max Filippov
 <jcmvbkbc@gmail.com>, Tero Kristo <kristo@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Pavel Machek
 <pavel@ucw.cz>, Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Marco Elver <elver@google.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-omap@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH] mm/memblock: Add memblock_alloc_or_panic interface
Message-Id: <20241220150623.278e8fa9f073b66dc81edfe6@linux-foundation.org>
In-Reply-To: <20241220092638.2611414-1-guoweikang.kernel@gmail.com>
References: <20241220092638.2611414-1-guoweikang.kernel@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_150629_162170_73F4011F 
X-CRM114-Status: GOOD (  15.17  )
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

On Fri, 20 Dec 2024 17:26:38 +0800 Guo Weikang <guoweikang.kernel@gmail.com> wrote:

> Before SLUB initialization, various subsystems used memblock_alloc to
> allocate memory. In most cases, when memory allocation fails, an immediate
> panic is required. To simplify this behavior and reduce repetitive checks,
> introduce `memblock_alloc_or_panic`. This function ensures that memory
> allocation failures result in a panic automatically, improving code
> readability and consistency across subsystems that require this behavior.
> 

Seems nice.

> ...
>
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -417,6 +417,19 @@ static __always_inline void *memblock_alloc(phys_addr_t size, phys_addr_t align)
>  				      MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
>  }
>  
> +static __always_inline void *memblock_alloc_or_panic(phys_addr_t size, phys_addr_t align)

We lost the printing of the function name, but it's easy to retain with
something like

#define memblock_alloc_or_panic(size, align)	\
		__memblock_alloc_or_panic(size, align, __func__)

> +{
> +	void *addr = memblock_alloc(size, align);
> +
> +	if (unlikely(!addr))
> +#ifdef CONFIG_PHYS_ADDR_T_64BIT
> +		panic("%s: Failed to allocate %llu bytes\n", __func__, size);

Won't this always print "memblock_alloc_or_panic: Failed ..."?  Not
very useful.

> +#else
> +		panic("%s: Failed to allocate %u bytes\n", __func__, size);
> +#endif

We can avoid the ifdef with printk's "%pap"?

> +	return addr;
> +}


