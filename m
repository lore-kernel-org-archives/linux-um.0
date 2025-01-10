Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ABBE7719C
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 20:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Aw/CnxStV8mvixiIOCl4TLOf7+c8cjSAdFrfDhkuuHg=; b=G572d3edgo9vLbHAD8Nh8ueuJ3
	0EOEWn33RyhwSy4nHeQT97Qj9FwZsLRJidDvYDbnG5kxISUjjNUpIS8tfRaSlyZfS/nnzzDLNG//U
	Vl+qEaEPGMKj+8S+ZRd/CvSH0BY3LKv7TaeX8BY21TfrOqZuf1jTVZF6TNyULwcvJbS4uW0/mKSPO
	L3j1K2s11s4t7+l3tZ2UROLGDV5kXjadlQsjIrw/dEYYms3cos4tCwvW7PPvjsb1c72YfMVSpEQII
	2H87jjRtJp7RTkZpbqvT2xW0CsgRVqqyhVFllEgbYbVTaqd6buzWxh5Nq9z2gOMssKGyW16nadenc
	RDuFKPjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWLZ5-0000000GtCT-0xq9;
	Fri, 10 Jan 2025 20:25:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwk-0000000Gbf8-00RH
	for linux-um@bombadil.infradead.org;
	Fri, 10 Jan 2025 18:41:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Aw/CnxStV8mvixiIOCl4TLOf7+c8cjSAdFrfDhkuuHg=; b=ZAMQvj9T5BWP7UD7vh8g6yunZ8
	m4a0aF4cy8GfWceN/po9RKjrCYydPV1f1DL6CEFWxAgdwQq5rxbeUsmlZce9/TY+RwAQIUwMQi+Z9
	Z0DXdluh72mf2HvUySahaCpGRe/Oo8Xn8pORHcPZLUOv0CO+kUaqlguTHhODfAE2YNBbbPgKlt1J/
	hKQAfav1n/fD7G9G1XhpPov04iOTwlY5F+YRkFRoT0N+U7tCxkX1/rX7Jbv0l2i0rIEOi4V1+sS81
	KQlZ+HmdcDrwUlu4tywPh1qbFXOkSfQXmUCgvD1KnGAQZwKvWLaTShkr4AaRIkx0waiNBVDv3Yv94
	mzFfhiGg==;
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
	by casper.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwg-0000000EBLN-2Emf
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 18:41:24 +0000
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-385ed79291eso1665596f8f.0
        for <linux-um@lists.infradead.org>; Fri, 10 Jan 2025 10:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534480; x=1737139280; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw/CnxStV8mvixiIOCl4TLOf7+c8cjSAdFrfDhkuuHg=;
        b=MbwMKC84jL1fBfsW25q7irDAw5uGepFOeva/nmxTl44zib7HxRE7cGiJcGbHC/c9AT
         onDVtm7LGfcUQRhvQrNMGBMfepqbCVUTyLXjdndPdStB7+6bJSPj9NtIwNlAuNE4E5qL
         bIUtIgLVwGNQWAtCVDTbVpcKx9F4UETBcmla5OIscIbHEhQxqOfKR9narGfx2k1X/G98
         U99MjejPaA6OcgYHNe5PpaisKzocFbDGxrXMG3BnYMHy1rj22mJsodGmqPIxYeMe34DL
         jdLBwNS90OhQIl8FvUmf9rPOGZ71YRLFKCy78jpMzfL+I2OJmoxs1z8whebKUJq+fogP
         AfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534480; x=1737139280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw/CnxStV8mvixiIOCl4TLOf7+c8cjSAdFrfDhkuuHg=;
        b=OzpFK9ucHq00SzxnD+3X8GvZRP5fG8YbCOb2gN7sdY+sCtyU7ErO8sAawgAdpk69et
         dKqSMftrCZXV+WXBcNfI3XPmMSD1vTOz9x+0ZvcmOuvnYgz6ZRM/n0a6idO/O3INUp+d
         bw/XOzPO7v507BKmjYBSQuK413heKwdTZ84vY/3dbM/ze1UY7lJfna+/UabWt8OtEqPA
         hxCLV4cQoBk+GMIkIIgUXYAKQKS9hftqfzDIfVJDEj8fBOs2EVky4Llhx4UwLx8Aw6/5
         4tP3cF79Rkj46h/P5NjKHHfONatEC0PTfDt2Wj0EGS2j4HZ6qkcxjnjkUY7J1cpjK1o5
         mZ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxtui1fEXBYt1xOcf1K/ZO8CJX0A1RE5alzpMdzbbf4Nei4ZVjEwjZJYOSw/5zhqGd/foy6mK2ZA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yynmn/9piBjKG6l+w5cCG9kMAIizKRnckTifK53BFIEUSXqu1WI
	o3RavHM7oudfeGGyvg72ULjtluvFABE2k/3HO74oixuzrX3phRh3jr+CccZ8Qu6zeX9OTwzgyRZ
	OVyc7vBjBnw==
X-Google-Smtp-Source: AGHT+IEfIL+1aAzwB4pbtK9eyCgzXtWnxn8Tg5skOTY2l9Jdg/lcArfVr7lNF3vncmrBkENqt6o7go6KThD7+Q==
X-Received: from wmqe1.prod.google.com ([2002:a05:600c:4e41:b0:434:a050:ddcf])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1547:b0:386:34af:9bae with SMTP id ffacd0b85a97d-38a8b0b7fd0mr6975597f8f.4.1736534479521;
 Fri, 10 Jan 2025 10:41:19 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:41 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-15-8419288bc805@google.com>
Subject: [PATCH TEMP WORKAROUND RFC v2 15/29] mm: asi: Workaround missing
 partial-unmap support
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <rppt@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_184122_606760_6E37EBB4 
X-CRM114-Status: GOOD (  22.37  )
X-Mailman-Approved-At: Fri, 10 Jan 2025 12:24:52 -0800
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

This is a hack, no need to review it carefully. asi_unmap() doesn't
currently work unless it corresponds exactly to an asi_map() of the
exact same region.

This is mostly harmless (it's only a functional problem if you wanna
touch those pages from the ASI critical section) but it's messy. For
now, working around the only practical case that appears by moving the
asi_map call up the call stack in the page allocator, to the place where
we know the actual size the mapping is supposed to end up at.

This just removes the main case where that happens. Later, a proper
solution for partial unmaps will be needed.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e98fdfbadddb1f7d71e9e050b63255b2008d167..f96e95032450be90b6567f67915b0b941fc431d8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4604,22 +4604,20 @@ void __init page_alloc_init_asi(void)
 	}
 }
 
-static int asi_map_alloced_pages(struct page *page, uint order, gfp_t gfp_mask)
+static int asi_map_alloced_pages(struct page *page, size_t size, gfp_t gfp_mask)
 {
 
 	if (!static_asi_enabled())
 		return 0;
 
 	if (!(gfp_mask & __GFP_SENSITIVE)) {
-		int err = asi_map_gfp(
-			ASI_GLOBAL_NONSENSITIVE, page_to_virt(page),
-			PAGE_SIZE * (1 << order), gfp_mask);
+		int err = asi_map_gfp(ASI_GLOBAL_NONSENSITIVE, page_to_virt(page), size, gfp_mask);
 		uint i;
 
 		if (err)
 			return err;
 
-		for (i = 0; i < (1 << order); i++)
+		for (i = 0; i < (size >> PAGE_SHIFT); i++)
 			__SetPageGlobalNonSensitive(page + i);
 	}
 
@@ -4629,7 +4627,7 @@ static int asi_map_alloced_pages(struct page *page, uint order, gfp_t gfp_mask)
 #else /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
 
 static inline
-int asi_map_alloced_pages(struct page *pages, uint order, gfp_t gfp_mask)
+int asi_map_alloced_pages(struct page *pages, size_t size, gfp_t gfp_mask)
 {
 	return 0;
 }
@@ -4896,7 +4894,7 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
 	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
 	kmsan_alloc_page(page, order, alloc_gfp);
 
-	if (page && unlikely(asi_map_alloced_pages(page, order, gfp))) {
+	if (page && unlikely(asi_map_alloced_pages(page, PAGE_SIZE << order, gfp))) {
 		__free_pages(page, order);
 		page = NULL;
 	}
@@ -5118,12 +5116,13 @@ void page_frag_free(void *addr)
 }
 EXPORT_SYMBOL(page_frag_free);
 
-static void *make_alloc_exact(unsigned long addr, unsigned int order,
-		size_t size)
+static void *finish_exact_alloc(unsigned long addr, unsigned int order,
+		size_t size, gfp_t gfp_mask)
 {
 	if (addr) {
 		unsigned long nr = DIV_ROUND_UP(size, PAGE_SIZE);
 		struct page *page = virt_to_page((void *)addr);
+		struct page *first = page;
 		struct page *last = page + nr;
 
 		split_page_owner(page, order, 0);
@@ -5132,9 +5131,22 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		while (page < --last)
 			set_page_refcounted(last);
 
-		last = page + (1UL << order);
+		last = page + (1 << order);
 		for (page += nr; page < last; page++)
 			__free_pages_ok(page, 0, FPI_TO_TAIL);
+
+		/*
+		 * ASI doesn't support partially undoing calls to asi_map, so
+		 * we can only safely free sub-allocations if they were made
+		 * with __GFP_SENSITIVE in the first place. Users of this need
+		 * to map with forced __GFP_SENSITIVE and then here we'll make a
+		 * second asi_map_alloced_pages() call to do any mapping that's
+		 * necessary, but with the exact size.
+		 */
+		if (unlikely(asi_map_alloced_pages(first, nr << PAGE_SHIFT, gfp_mask))) {
+			free_pages_exact(first, size);
+			return NULL;
+		}
 	}
 	return (void *)addr;
 }
@@ -5162,8 +5174,8 @@ void *alloc_pages_exact_noprof(size_t size, gfp_t gfp_mask)
 	if (WARN_ON_ONCE(gfp_mask & (__GFP_COMP | __GFP_HIGHMEM)))
 		gfp_mask &= ~(__GFP_COMP | __GFP_HIGHMEM);
 
-	addr = get_free_pages_noprof(gfp_mask, order);
-	return make_alloc_exact(addr, order, size);
+	addr = get_free_pages_noprof(gfp_mask | __GFP_SENSITIVE, order);
+	return finish_exact_alloc(addr, order, size, gfp_mask);
 }
 EXPORT_SYMBOL(alloc_pages_exact_noprof);
 
@@ -5187,10 +5199,10 @@ void * __meminit alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_ma
 	if (WARN_ON_ONCE(gfp_mask & (__GFP_COMP | __GFP_HIGHMEM)))
 		gfp_mask &= ~(__GFP_COMP | __GFP_HIGHMEM);
 
-	p = alloc_pages_node_noprof(nid, gfp_mask, order);
+	p = alloc_pages_node_noprof(nid, gfp_mask | __GFP_SENSITIVE, order);
 	if (!p)
 		return NULL;
-	return make_alloc_exact((unsigned long)page_address(p), order, size);
+	return finish_exact_alloc((unsigned long)page_address(p), order, size, gfp_mask);
 }
 
 /**

-- 
2.47.1.613.gc27f4b7a9f-goog


