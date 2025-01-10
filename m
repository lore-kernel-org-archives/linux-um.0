Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDA7E7719D
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 20:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+fqV4f6s/Eo+EZ+PE2OCyE0kBm/vfnsLcFKRz+1otrE=; b=Dtse05SkwcwaO5LxkOlhcDq52i
	foXcAguErmPgpIkzC27oYP+G6y3bJu011Vyprm5B4V+eK7DpdOLhzRJMJF2E1y4j7aoXizt2vrvxm
	pteRlwkpb7JsZHUB4XKowyzP5bF44oE1jr4HqVQ6sC16CT0qrwP+gsScD0pnVkeAJxSa9LatIbKRA
	DpJgUw8SVYAXuxDGfSSA4Ahwi7EeiZhqdnuCFBzWwHqDP4CLqBjwVI/KZNuFtEidB6gfOQbLOx0Fv
	THyf6+h0bQb8FiigMN5dIL0vFWHYI3bifGmpdep77xiVN5kgjD6bIU/M3Rytv0xngRUVOWYRVImRO
	i4VQn5Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWLZC-0000000GtGD-0FBh;
	Fri, 10 Jan 2025 20:25:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwo-0000000GbiY-3krR
	for linux-um@bombadil.infradead.org;
	Fri, 10 Jan 2025 18:41:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+fqV4f6s/Eo+EZ+PE2OCyE0kBm/vfnsLcFKRz+1otrE=; b=qFmCiq4cmQJA0eQGQavshFGcmT
	p/t3LPYbwmqV4gmJVEHLAMrOAmee10IdJGhOVvS1uxMFqjDjxWvGVFwtvgu4yS/jBEWwQpzF0cnav
	G0iIhZbgM31+w2XRAv+Rd/eWIBE8pDN5QK+bLTbHyqFPBdm/kRUQKyDWvBevPcuKyAFypFyTeE52K
	J6ddXOoacYo0nmzY0vYTAtPoMOQ97acQROSpwo2pWU9oetVhvlqvMxApz9wBKL4Vl93dOHg5VJ5+B
	Lev/eoeeask4UBL4QHG5lncFb00vLoI7PXIuVDWCZyqxkZGkKvYPpV/kWJZvCKi4vGJ+vmazdSznU
	lajkJhzQ==;
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
	by casper.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwl-0000000EBPO-3bsw
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 18:41:29 +0000
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-38a684a096eso995699f8f.2
        for <linux-um@lists.infradead.org>; Fri, 10 Jan 2025 10:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534486; x=1737139286; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fqV4f6s/Eo+EZ+PE2OCyE0kBm/vfnsLcFKRz+1otrE=;
        b=EavjCIYG0dDEOr3FhAz1S0PJOpbg5+xopl3JoU7RHAMpSjBt02AHaVfJV5NCnZdx4J
         GBvEfWJoV5jwnFH3ltm40pNX9jMvW9Y3uGXzxMElmv1rt+lTAhCQuvqswJUAFFdmZ6sJ
         Bjjh8nwLxcqJQRz0t/62Z2VBZDkX3e9fy5WpLpqe7zPYzU5dyYCqD0bglHXwnY2zRM0h
         6FFPcWIj3pX2JABqkynPof4fBg5CyvvumxMmzOl2DYHoKrNtbOLH3kDjkJddzFVhzZX0
         FJ7CEBMDOXpGrqIOlkawhzvmhRWQtWGB68dRWwutCbPhLTzgSSs/KMJ8PJFpX2c1rsWn
         p/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534486; x=1737139286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fqV4f6s/Eo+EZ+PE2OCyE0kBm/vfnsLcFKRz+1otrE=;
        b=PYDhPNTP4tk/jB8FkJVP5S1YWR/GfqJrMsAuaw5JvMhBHmovXUik05MCD2y3rDTjEh
         sIUYASmeGIMZFMDl3DXUBh+LRbj2SmTZGZwcQI5mJWvK/ZGNjqMk72Q3oM1ciD9Y7Udd
         kujqtk5O5rpse7dQm9qf+yo3kHyuC5FztrhyvCvDaP402nzqeLLjvsq6+9eJ2Ea4T7tr
         PUY/dZxdgQgiueksTsdW0lZ0TQ+9imSb8laGxvSAaSsSCPEgdE7O7ZhVGBHuu+bZ8Gjj
         jTtVX+O39XmphaylgkHCIOL1IQS/f8MlFNMA5xAGBY7gmep1t6Jrkx2pFe+g+ygEHyH8
         zYLg==
X-Forwarded-Encrypted: i=1; AJvYcCU3KIGWFCP6lkU8jsxP0ngElCtii682/JGCnvC1BcNt2S3B/0Mt4/wvd8VeKq89dzDFGRb9ktHE4A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyBvgFBQ/6qN5aZH/3PElhacPjq5SrI37ulb/BI8lLIzwnfKfNq
	4pjs+/AleNK1ak8xq69G/v2v0YminMwG6bAsGhZ72TR1gum1ByVobXXXKgOuuu5jfwsPo+OHDeJ
	6/yzhOI+uYQ==
X-Google-Smtp-Source: AGHT+IFgJUpClA++DtJe4xQ45Yc9kKsVSyJCXKqF0cxpPlCBfuMButRzIe/JLM7ynzshFcOsnG5hhjluySNsEA==
X-Received: from wrbeh5.prod.google.com ([2002:a05:6000:4105:b0:382:4235:c487])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:8b5b:0:b0:38a:88bc:aea4 with SMTP id ffacd0b85a97d-38a88bcaebfmr7355114f8f.30.1736534486264;
 Fri, 10 Jan 2025 10:41:26 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:44 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-18-8419288bc805@google.com>
Subject: [PATCH RFC v2 18/29] mm: asi: Map dynamic percpu memory as nonsensitive
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
	Brendan Jackman <jackmanb@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_184127_909000_44AB423C 
X-CRM114-Status: GOOD (  20.95  )
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

From: Reiji Watanabe <reijiw@google.com>

Currently, all dynamic percpu memory is implicitly (and
unintentionally) treated as sensitive memory.

Unconditionally map pages for dynamically allocated percpu
memory as global nonsensitive memory, other than pages that
are allocated for pcpu_{first,reserved}_chunk during early
boot via memblock allocator (these will be taken care by the
following patch).

We don't support sensitive percpu memory allocation yet.

Co-developed-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>

WIP: Drop VM_SENSITIVE checks from percpu code
---
 mm/percpu-vm.c | 50 ++++++++++++++++++++++++++++++++++++++++++++------
 mm/percpu.c    |  4 ++--
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index cd69caf6aa8d8eded2395eb4bc4051b78ec6aa33..2935d7fbac41548819a94dcc60566bd18cde819a 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -132,11 +132,20 @@ static void pcpu_pre_unmap_flush(struct pcpu_chunk *chunk,
 		pcpu_chunk_addr(chunk, pcpu_high_unit_cpu, page_end));
 }
 
-static void __pcpu_unmap_pages(unsigned long addr, int nr_pages)
+static void ___pcpu_unmap_pages(unsigned long addr, int nr_pages)
 {
 	vunmap_range_noflush(addr, addr + (nr_pages << PAGE_SHIFT));
 }
 
+static void __pcpu_unmap_pages(unsigned long addr, int nr_pages,
+			       unsigned long vm_flags)
+{
+	unsigned long size = nr_pages << PAGE_SHIFT;
+
+	asi_unmap(ASI_GLOBAL_NONSENSITIVE, (void *)addr, size);
+	___pcpu_unmap_pages(addr, nr_pages);
+}
+
 /**
  * pcpu_unmap_pages - unmap pages out of a pcpu_chunk
  * @chunk: chunk of interest
@@ -153,6 +162,8 @@ static void __pcpu_unmap_pages(unsigned long addr, int nr_pages)
 static void pcpu_unmap_pages(struct pcpu_chunk *chunk,
 			     struct page **pages, int page_start, int page_end)
 {
+	struct vm_struct **vms = (struct vm_struct **)chunk->data;
+	unsigned long vm_flags = vms ? vms[0]->flags : VM_ALLOC;
 	unsigned int cpu;
 	int i;
 
@@ -165,7 +176,7 @@ static void pcpu_unmap_pages(struct pcpu_chunk *chunk,
 			pages[pcpu_page_idx(cpu, i)] = page;
 		}
 		__pcpu_unmap_pages(pcpu_chunk_addr(chunk, cpu, page_start),
-				   page_end - page_start);
+				   page_end - page_start, vm_flags);
 	}
 }
 
@@ -190,13 +201,38 @@ static void pcpu_post_unmap_tlb_flush(struct pcpu_chunk *chunk,
 		pcpu_chunk_addr(chunk, pcpu_high_unit_cpu, page_end));
 }
 
-static int __pcpu_map_pages(unsigned long addr, struct page **pages,
-			    int nr_pages)
+/*
+ * __pcpu_map_pages() should not be called during the percpu initialization,
+ * as asi_map() depends on the page allocator (which isn't available yet
+ * during percpu initialization).  Instead, ___pcpu_map_pages() can be used
+ * during the percpu initialization. But, any pages that are mapped with
+ * ___pcpu_map_pages() will be treated as sensitive memory, unless
+ * they are explicitly mapped with asi_map() later.
+ */
+static int ___pcpu_map_pages(unsigned long addr, struct page **pages,
+			     int nr_pages)
 {
 	return vmap_pages_range_noflush(addr, addr + (nr_pages << PAGE_SHIFT),
 					PAGE_KERNEL, pages, PAGE_SHIFT);
 }
 
+static int __pcpu_map_pages(unsigned long addr, struct page **pages,
+			    int nr_pages, unsigned long vm_flags)
+{
+	unsigned long size = nr_pages << PAGE_SHIFT;
+	int err;
+
+	err = ___pcpu_map_pages(addr, pages, nr_pages);
+	if (err)
+		return err;
+
+	/*
+	 * If this fails, pcpu_map_pages()->__pcpu_unmap_pages() will call
+	 * asi_unmap() and clean up any partial mappings.
+	 */
+	return asi_map(ASI_GLOBAL_NONSENSITIVE, (void *)addr, size);
+}
+
 /**
  * pcpu_map_pages - map pages into a pcpu_chunk
  * @chunk: chunk of interest
@@ -214,13 +250,15 @@ static int __pcpu_map_pages(unsigned long addr, struct page **pages,
 static int pcpu_map_pages(struct pcpu_chunk *chunk,
 			  struct page **pages, int page_start, int page_end)
 {
+	struct vm_struct **vms = (struct vm_struct **)chunk->data;
+	unsigned long vm_flags = vms ? vms[0]->flags : VM_ALLOC;
 	unsigned int cpu, tcpu;
 	int i, err;
 
 	for_each_possible_cpu(cpu) {
 		err = __pcpu_map_pages(pcpu_chunk_addr(chunk, cpu, page_start),
 				       &pages[pcpu_page_idx(cpu, page_start)],
-				       page_end - page_start);
+				       page_end - page_start, vm_flags);
 		if (err < 0)
 			goto err;
 
@@ -232,7 +270,7 @@ static int pcpu_map_pages(struct pcpu_chunk *chunk,
 err:
 	for_each_possible_cpu(tcpu) {
 		__pcpu_unmap_pages(pcpu_chunk_addr(chunk, tcpu, page_start),
-				   page_end - page_start);
+				   page_end - page_start, vm_flags);
 		if (tcpu == cpu)
 			break;
 	}
diff --git a/mm/percpu.c b/mm/percpu.c
index da21680ff294cb53dfb42bf0d3b3bbd2654d2cfa..c2d913c579bf07892957ac7f601a6a71defadc4b 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3273,8 +3273,8 @@ int __init pcpu_page_first_chunk(size_t reserved_size, pcpu_fc_cpu_to_node_fn_t
 			pcpu_populate_pte(unit_addr + (i << PAGE_SHIFT));
 
 		/* pte already populated, the following shouldn't fail */
-		rc = __pcpu_map_pages(unit_addr, &pages[unit * unit_pages],
-				      unit_pages);
+		rc = ___pcpu_map_pages(unit_addr, &pages[unit * unit_pages],
+				       unit_pages);
 		if (rc < 0)
 			panic("failed to map percpu area, err=%d\n", rc);
 

-- 
2.47.1.613.gc27f4b7a9f-goog


