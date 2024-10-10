Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810F5D24450
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 20:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I0EZ6HkQ9I7eF0DetXqDrQTnXavDC1PLwU47uVpLkD4=; b=A28YWdydrz7UvLI92/VAdgZA6A
	IO9zmbGgcQh4z6qbuGzpH0E/EvSJzr/DGTezsj2QzDhJvsF/qEkKqXTwKMrpXuXySUpI/YcyMJfvG
	WvE2ntehEUxp88rIpXJ75zrrbvfVHrZUUtlm3NDoViNu22cmuo1JCGu5BdGY5+SqbXW2zFQRuJCdq
	UyV/ZK2WmODgUQb0EC+UcKfps2K4TIGlJpm/R/vCQRuV6ksjQlvlqiBVHF6rW9kpCTpFZBkDaEt7U
	1rbSCc/w0KBG3BT7uE0Z9Alj3l/cEEoeDWUM17GY0NGsA6XPAIbxhGZK550tLcWDjqkGaz45EgXU8
	2cHxwqbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syzsM-0000000EHpr-2Yhn;
	Thu, 10 Oct 2024 20:35:10 +0000
Received: from bout3.ijzerbout.nl ([2a01:7c8:fff8:2b8:5054:ff:fe86:f72d])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syy14-0000000DvXa-0O8D;
	Thu, 10 Oct 2024 18:36:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1728585350; bh=eO8i66PrBt/aJfIHr67M2yWYkbNNStHt47cJJCQ8lLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TnwSfC3B0BzzbrbBXfYCTvLzIQE1VFcC2vDoODjZOiRbhCpvxs+nfBrgLRAmHbBcp
	 5nDkTl4JQCQ0Wy/pLIF9/vFfww5UJ7PllGdlDfCRY4FgF60cuMAONiSY28SXpZ/fah
	 ofsTg0sJAj3lUJpCxa6onaZfbwwGyEE3F+sIl/MzmrdHNasu+qZYD2CQrQKKnIrTre
	 jEGUntoI51WphR4XjRXlRX68PsX4ZEqW4Lig8ApC7stf8X5g23ZhKSrvK2T2Yg2D5A
	 bDv/1YoYnX+4WK7gSe7xgNsbMfMhOH2hPirF455+QlQzq1JgcpZmps0ommzymfrvIp
	 q2yGRxotng1Sc5OlnXZIYfIyoPLe78QPg5yomWhS/7EpKy8gm5XCv2fZL2X1/G4BTR
	 HL2kBhQM874WRNw9Pe4sCOauh/y6zMseb5uFaaTGvb5Bwf1+uMfTKAYUXYiqB6xWHZ
	 FMRiB8gbs1uwwHzedLTctQNTtkBO6P4IZltp+SoRTwdUBuk2Am+I+Y/c5xNGGQwcTo
	 dfQXGkuiHFMt18pGbziRX9AoIhYRkcXuQB6IdBahXiHe06KoZakmU5fKhn5ggdgeZF
	 sIwBjRHZR9oCPZjKzUyfzG6lTzteD6iFNQ1wWMF1seN66YAyRB45H5n//oQ2UNHpBx
	 anTYx1ofeL2gjEtOuPaxF2ZM=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id DF155167DD7;
	Thu, 10 Oct 2024 20:35:47 +0200 (CEST)
Message-ID: <936057f4-e461-4977-85e7-6100127c9574@ijzerbout.nl>
Date: Thu, 10 Oct 2024 20:35:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] execmem: add support for cache of large ROX pages
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christoph Hellwig <hch@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dinh Nguyen
 <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Song Liu <song@kernel.org>, Stafford Horne <shorne@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
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
 sparclinux@vger.kernel.org, x86@kernel.org
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-8-rppt@kernel.org>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241009180816.83591-8-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_113602_625043_A49316A0 
X-CRM114-Status: GOOD (  19.01  )
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

Op 09-10-2024 om 20:08 schreef Mike Rapoport:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Using large pages to map text areas reduces iTLB pressure and improves
> performance.
>
> Extend execmem_alloc() with an ability to use huge pages with ROX
> permissions as a cache for smaller allocations.
>
> To populate the cache, a writable large page is allocated from vmalloc with
> VM_ALLOW_HUGE_VMAP, filled with invalid instructions and then remapped as
> ROX.
>
> Portions of that large page are handed out to execmem_alloc() callers
> without any changes to the permissions.
>
> When the memory is freed with execmem_free() it is invalidated again so
> that it won't contain stale instructions.
>
> The cache is enabled when an architecture sets EXECMEM_ROX_CACHE flag in
> definition of an execmem_range.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   include/linux/execmem.h |   2 +
>   mm/execmem.c            | 317 +++++++++++++++++++++++++++++++++++++++-
>   mm/internal.h           |   1 +
>   mm/vmalloc.c            |   5 +
>   4 files changed, 320 insertions(+), 5 deletions(-)
> [...]
> +static void execmem_cache_clean(struct work_struct *work)
> +{
> +	struct maple_tree *free_areas = &execmem_cache.free_areas;
> +	struct mutex *mutex = &execmem_cache.mutex;
> +	MA_STATE(mas, free_areas, 0, ULONG_MAX);
> +	void *area;
> +
> +	mutex_lock(mutex);
> +	mas_for_each(&mas, area, ULONG_MAX) {
> +		size_t size;
> +
No need to check for !area, because it is already guaranteed by the 
while loop condition (mas_for_each)
> +		if (!area)
> +			continue;
> +
> +		size = mas_range_len(&mas);
> +
> +		if (IS_ALIGNED(size, PMD_SIZE) &&
> +		    IS_ALIGNED(mas.index, PMD_SIZE)) {
> +			struct vm_struct *vm = find_vm_area(area);
> +
> +			execmem_set_direct_map_valid(vm, true);
> +			mas_store_gfp(&mas, NULL, GFP_KERNEL);
> +			vfree(area);
> +		}
> +	}
> +	mutex_unlock(mutex);
> +}
>

