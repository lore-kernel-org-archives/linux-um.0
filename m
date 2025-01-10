Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D130E7719F
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 20:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UzXM9zi9X6couWShNCb4EkjJb05AI+Oo7qUi6Mvjsww=; b=T4BvxjIYuCGy8Ce8yPHpz7+vje
	L2QGaltHu6dhiSpQuQtr5j1Vdmf1BOx00GEsV50vSlo8UrzBnOaGl9o46AUYHLVJVLamRUwxY6Rl1
	ShnwW16Z4f6ZYgnjtGdTcFUeCjXZlv60q5l3sSWJ5UshM/eLFOI16eAEYt8zmvHAuYClDn23Mr3U9
	OZwle+H6h3SOfeqwRtKfYfOv4k6O+N98OErcyFo45R1Ickb3NN7cC3CgJ81h5Rrd339+FFdb7GBKN
	BWOgqsbOf79qDTqIAQiEvrNT+IAwCa7co1mQdHVo8gf9IOVrOfGTlasubUuA+tkmNXWb5WJiNl9DA
	PRvIEy7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWLZ2-0000000Gt7J-0XDM;
	Fri, 10 Jan 2025 20:25:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwc-0000000GbXd-0OqG
	for linux-um@bombadil.infradead.org;
	Fri, 10 Jan 2025 18:41:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UzXM9zi9X6couWShNCb4EkjJb05AI+Oo7qUi6Mvjsww=; b=o3W6DmWFQpWK61ps5xDrZzrRpU
	qMtEdMYaK9q7lGoOFFBcP7UyPHOn/qgyr8/XcGDb+KeGbmU9kYCz4XAl5uQaeiVNwk/kBJvYOdSPe
	Zb+EF9u/A6NPw7OODYVEU+nhKLxWohrelZ6VEJ0nIMZaV2QOKvHA04IyJET+QrahPIL3K+I94OBXI
	ZoHXWNtGCnYcT2Sm/TXYBAMEXH+OL4uOTvyXPzJen+wmmHDBX0CpkB6yUld/wU72hX0pucwbPWIBL
	cMDq3jSBJ/hhumQdOU8RA7IflSJ4oUdxokQtoiMMzeyzWePCswZqbB0dO13WttTYm1L88u5hy+Wx1
	aV2CXLHg==;
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwY-00000009sW0-1f1d
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 18:41:16 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-43631d8d9c7so11982485e9.1
        for <linux-um@lists.infradead.org>; Fri, 10 Jan 2025 10:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534473; x=1737139273; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UzXM9zi9X6couWShNCb4EkjJb05AI+Oo7qUi6Mvjsww=;
        b=I1hf8nWTwD/El2vuVnper0o5meAFt2a2Eqm05UT5bRS7vPCGJjh60RyJKwVz4zZkTF
         zh81RMO4Is4WlvEhYhrMtEwSjo56jvPkHx4e9LVBats8gje4bRt7JDYKcT6YZNX9FF/v
         9XYtHyTc/lPlaYb57gd/R66jfNIqJUezxlnYbX/Gxx6d8zqkqfygq79Ys7en1PUgefeS
         5JCArAvyPkiPDtz1mV85pVzfXymXeCaShnlzi5BZI+PdCZSwIhrLufAy0zgaFNU04L4b
         ylQu/34rE8j+o48USbxr/AxykfSn1iGd2hHFB+hzg13BxlU6nfzHB+V4yZYojYQrxI/V
         eTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534473; x=1737139273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzXM9zi9X6couWShNCb4EkjJb05AI+Oo7qUi6Mvjsww=;
        b=jtLppL0Zz0XsH8lQ2c6TpFXO4BR1DPfWG7NcLZ5VNLwnDg0T7wcIwqzxFg/3/RQiWc
         h9qhp5cH8dKqwH2jC9pSvehs5mOc1KNyWjsPeKuiyulBv7QSnDmWlLZZp5hiXISN/Jtm
         EskQrQUfGXtprSY91JBtDNRRxmVfpCJIU4PO1dPmhBe0d6qNnYU2AkYPZg2H9gNcF+Hh
         TgVYGrOvqUtLm3p/38tX9DB/kgLQ8vKcj1Q6VrrVXBr387odWVTjgz2iLjGZ/RJaUrdt
         KQxo5N+L0pqWGWMdMGFVXR0Fx4xtSouRT9HXC+sFdSbcKUr9SBSaUbM/xWdsgKZE8Rcq
         RJSw==
X-Forwarded-Encrypted: i=1; AJvYcCULi/RAOTaxx6UDu0cKluc2Q6ClN/j7iYSyf4g0yZY2de1zIUzxpWfDe2QCsnc8PZRPp3pR0xkFgQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy5X5Y3rtG5WA7sbObRsmK5JKCZhFQ5nSu9G65SAqqhQxhOzfZ/
	kiyBqFZZ4PXCBsf/cMJ46/2pIM0cOnzx5gbhHCfb0EZbDWkbXunGRUxrEQvvGP2JuGyFJD6MJq7
	N7tzVMhSmAw==
X-Google-Smtp-Source: AGHT+IFDRv4zNENk63KYcLxYmQdIUcLs7zTtS/Sd8xMbR3tJqcykEbsngD0F8tGcq40UK8q2XIPTmnyPYnp+hA==
X-Received: from wmqe5.prod.google.com ([2002:a05:600c:4e45:b0:435:21e:7bec])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d2a:b0:435:edb0:5d27 with SMTP id 5b1f17b1804b1-436e8827fbcmr75837805e9.9.1736534472863;
 Fri, 10 Jan 2025 10:41:12 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:38 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-12-8419288bc805@google.com>
Subject: [PATCH RFC v2 12/29] mm: asi: Add basic infrastructure for global
 non-sensitive mappings
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
	Brendan Jackman <jackmanb@google.com>, Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_184114_567079_A0EC66D3 
X-CRM114-Status: GOOD (  25.43  )
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

From: Junaid Shahid <junaids@google.com>

A pseudo-PGD is added to store global non-sensitive ASI mappings.
Actual ASI PGDs copy entries from this pseudo-PGD during asi_init().

Memory can be mapped as globally non-sensitive by calling asi_map()
with ASI_GLOBAL_NONSENSITIVE.

Page tables allocated for global non-sensitive mappings are never
freed.

These page tables are shared between all domains and init_mm, so they
don't need special synchronization.

RFC note: A refactoring/prep commit should be split out of this patch.

Signed-off-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/asi.h |  3 +++
 arch/x86/mm/asi.c          | 37 +++++++++++++++++++++++++++++++++++++
 arch/x86/mm/init_64.c      | 25 ++++++++++++++++---------
 arch/x86/mm/mm_internal.h  |  3 +++
 include/asm-generic/asi.h  |  2 ++
 5 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index 33f18be0e268b3a6725196619cbb8d847c21e197..555edb5f292e4d6baba782f51d014aa48dc850b6 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -120,6 +120,9 @@ struct asi_taint_policy {
 	asi_taints_t set;
 };
 
+extern struct asi __asi_global_nonsensitive;
+#define ASI_GLOBAL_NONSENSITIVE	(&__asi_global_nonsensitive)
+
 /*
  * An ASI domain (struct asi) represents a restricted address space. The
  * unrestricted address space (and user address space under PTI) are not
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index f2d8fbc0366c289891903e1c2ac6c59b9476d95f..17391ec8b22e3c0903cd5ca29cbb03fcc4cbacce 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -13,6 +13,7 @@
 #include <asm/mmu_context.h>
 #include <asm/traps.h>
 
+#include "mm_internal.h"
 #include "../../../mm/internal.h"
 
 static struct asi_taint_policy *taint_policies[ASI_MAX_NUM_CLASSES];
@@ -26,6 +27,13 @@ const char *asi_class_names[] = {
 DEFINE_PER_CPU_ALIGNED(struct asi *, curr_asi);
 EXPORT_SYMBOL(curr_asi);
 
+static __aligned(PAGE_SIZE) pgd_t asi_global_nonsensitive_pgd[PTRS_PER_PGD];
+
+struct asi __asi_global_nonsensitive = {
+	.pgd = asi_global_nonsensitive_pgd,
+	.mm = &init_mm,
+};
+
 static inline bool asi_class_id_valid(enum asi_class_id class_id)
 {
 	return class_id >= 0 && class_id < ASI_MAX_NUM_CLASSES;
@@ -156,6 +164,31 @@ void __init asi_check_boottime_disable(void)
 		pr_info("ASI enablement ignored due to incomplete implementation.\n");
 }
 
+static int __init asi_global_init(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_ASI))
+		return 0;
+
+	/*
+	 * Lower-level pagetables for global nonsensitive mappings are shared,
+	 * but the PGD has to be copied into each domain during asi_init. To
+	 * avoid needing to synchronize new mappings into pre-existing domains
+	 * we just pre-allocate all of the relevant level N-1 entries so that
+	 * the global nonsensitive PGD already has pointers that can be copied
+	 * when new domains get asi_init()ed.
+	 */
+	preallocate_sub_pgd_pages(asi_global_nonsensitive_pgd,
+				  PAGE_OFFSET,
+				  PAGE_OFFSET + PFN_PHYS(max_pfn) - 1,
+				  "ASI Global Non-sensitive direct map");
+	preallocate_sub_pgd_pages(asi_global_nonsensitive_pgd,
+				  VMALLOC_START, VMALLOC_END,
+				  "ASI Global Non-sensitive vmalloc");
+
+	return 0;
+}
+subsys_initcall(asi_global_init)
+
 static void __asi_destroy(struct asi *asi)
 {
 	WARN_ON_ONCE(asi->ref_count <= 0);
@@ -170,6 +203,7 @@ int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_
 {
 	struct asi *asi;
 	int err = 0;
+	uint i;
 
 	*out_asi = NULL;
 
@@ -203,6 +237,9 @@ int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_
 	asi->mm = mm;
 	asi->class_id = class_id;
 
+	for (i = KERNEL_PGD_BOUNDARY; i < PTRS_PER_PGD; i++)
+		set_pgd(asi->pgd + i, asi_global_nonsensitive_pgd[i]);
+
 exit_unlock:
 	if (err)
 		__asi_destroy(asi);
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706fa9cd49169a54882014a72ad540cf..9d358a05c4e18ac6d5e115de111758ea6cdd37f2 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1288,18 +1288,15 @@ static void __init register_page_bootmem_info(void)
 #endif
 }
 
-/*
- * Pre-allocates page-table pages for the vmalloc area in the kernel page-table.
- * Only the level which needs to be synchronized between all page-tables is
- * allocated because the synchronization can be expensive.
- */
-static void __init preallocate_vmalloc_pages(void)
+/* Initialize empty pagetables at the level below PGD.  */
+void __init preallocate_sub_pgd_pages(pgd_t *pgd_table, ulong start,
+				      ulong end, const char *name)
 {
 	unsigned long addr;
 	const char *lvl;
 
-	for (addr = VMALLOC_START; addr <= VMEMORY_END; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
-		pgd_t *pgd = pgd_offset_k(addr);
+	for (addr = start; addr <= end; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
+		pgd_t *pgd = pgd_offset_pgd(pgd_table, addr);
 		p4d_t *p4d;
 		pud_t *pud;
 
@@ -1335,7 +1332,17 @@ static void __init preallocate_vmalloc_pages(void)
 	 * The pages have to be there now or they will be missing in
 	 * process page-tables later.
 	 */
-	panic("Failed to pre-allocate %s pages for vmalloc area\n", lvl);
+	panic("Failed to pre-allocate %s pages for %s area\n", lvl, name);
+}
+
+/*
+ * Pre-allocates page-table pages for the vmalloc area in the kernel page-table.
+ * Only the level which needs to be synchronized between all page-tables is
+ * allocated because the synchronization can be expensive.
+ */
+static void __init preallocate_vmalloc_pages(void)
+{
+	preallocate_sub_pgd_pages(init_mm.pgd, VMALLOC_START, VMEMORY_END, "vmalloc");
 }
 
 void __init mem_init(void)
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 3f37b5c80bb32ff34656a20789449da92e853eb6..1203a977edcd523589ad88a37aab01398a10a129 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -25,4 +25,7 @@ void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache);
 
 extern unsigned long tlb_single_page_flush_ceiling;
 
+extern void preallocate_sub_pgd_pages(pgd_t *pgd_table, ulong start,
+				      ulong end, const char *name);
+
 #endif	/* __X86_MM_INTERNAL_H */
diff --git a/include/asm-generic/asi.h b/include/asm-generic/asi.h
index 5be8f7d657ba0bc2196e333f62b084d0c9eef7b6..7867b8c23449058a1dd06308ab5351e0d210a489 100644
--- a/include/asm-generic/asi.h
+++ b/include/asm-generic/asi.h
@@ -23,6 +23,8 @@ typedef u8 asi_taints_t;
 
 #ifndef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
 
+#define ASI_GLOBAL_NONSENSITIVE		NULL
+
 struct asi_hooks {};
 struct asi {};
 

-- 
2.47.1.613.gc27f4b7a9f-goog


