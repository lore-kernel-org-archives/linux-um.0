Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7115BE7719E
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 20:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KV+yP+i7I0yJqjdnPuT5zohhg/S0Da4STnyrBal2kA0=; b=KhN43IDXML3BzSTJyRU6NfMThh
	G63mnB/VcdtkldjlZ9Qu5iUDmuHjEoadgAEPopxp3PFzy+93hoptLfklKu8BkqbizET+PRNmKKHBA
	KaCE2UIKrFpiiayoLBaLpQBDuA6hsOifuQShcazPGOyDcP6UxpaKpq0OYhkQluVn6c3FxzbH60wVX
	1BmlFBFU22cBUVORXQDKKTkv5gfPBwQeOZJsddk+sSOYzBaVnqpwIjkaJ0zWDxeQPXLgbn2jItDrX
	IIXB/z5OpwMsq9nid6UFJUhT0uH5d8sW9ewfjf4kAy3piuId4MBmGgCuusVrqGA3JQfLL/1zTYDP3
	3JNkPKeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWLZ8-0000000GtDV-0tpg;
	Fri, 10 Jan 2025 20:25:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwm-0000000Gbfe-0lWY
	for linux-um@bombadil.infradead.org;
	Fri, 10 Jan 2025 18:41:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KV+yP+i7I0yJqjdnPuT5zohhg/S0Da4STnyrBal2kA0=; b=RHUVpqQ8DsY8/mWG3S4So1aOd4
	Vy0bn8eK5zodLR2JT5apLrtEVCdPd37qOO1Hn7FBRx/PD/hEVsJf1BdJ4Y4s+2HaK83Ttsww9DPFj
	K4d0Xl1H7mz9s0AvD+UVmNwp1b4SFwUvlVR/9dhm0M/ZmEE+CJ2KQLv2kkl9diKs0WcS9JOjDDl2h
	07Pzy6r57zV6VZ6Rjnjzg5GC1pkBtWLbxINIpoPyE6eDDYpScB1YBh76VIAL4VA2Hknq29CB/PRsy
	vjG2g95yOyaMwcYxR0IgDgLedLO5laa7D299Nh+VCisyiLSoPhq3Fzwk+LM0e6StCM19bYGCL+ZyP
	NuPIF9Kw==;
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwh-00000009sb9-29JS
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 18:41:26 +0000
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-436219070b4so11488035e9.1
        for <linux-um@lists.infradead.org>; Fri, 10 Jan 2025 10:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534482; x=1737139282; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KV+yP+i7I0yJqjdnPuT5zohhg/S0Da4STnyrBal2kA0=;
        b=T+Y+7zuTZ3uuB41Q0pbed2FlPJmpU3v9IcNl3GFgW1sZqpevwd2McPQiXQWbMMNHID
         C4ywAzuswJq6jwtg/qQ2Kw3XwnZ66dMc+mwLC5k3BFTyR9Phu4nvCnniESGSKBQ2DA6S
         7Z6oiuxSfBlEWCTNKTBFR6lITATLON0DZAOoIKVWMhLH8Vgkv7h4VWNbUv5TVBFiBZQL
         vrF9huerFv7J8ueHsPBxQTP9GWu3uOjMtFBgEZdiUfZ3L3YI4MrrpZD5K3oayST5j+df
         wq8Xp8xwX9xKtOrlErcwOoQxjP1ZE5rA/iZyemrvc/NAW+drCDJyqHlR1+htuJTM8wa9
         IL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534482; x=1737139282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KV+yP+i7I0yJqjdnPuT5zohhg/S0Da4STnyrBal2kA0=;
        b=vNwMBDfaGLvG9kp85/HZDVGt7s2eVw8dBO5PQmkni6w94X3rOslA5dvHEWKxlwTool
         JCnby8cURFw34W7KeLVNcawz54ywWwE+2RIl6cpaalPhPFJ5mwGBzKhxB6yQ5oxRluM9
         GAiB9wLid/KjHyDZEqmTyhe1JBUFC3u7wgUuFtJEH5SHXFxYsaxwIWMDfWZAH85Gxvdp
         rhq9PMI4Rvp+utJJatW8pphhSHphfmPFM8KHeNSDMYFzGjXqxc38pn7rY+wUstQTih9G
         jRxE00KjJHb49XBB5S9BUa2mQ+FTn6DDW6SWxWgH/NpvohqS6XQRTA+bUL+Dzfmgm4jl
         NW6A==
X-Forwarded-Encrypted: i=1; AJvYcCWUggGAcUOoUMMHxW6YqN41otBPod/l92aLcS94sASGwsfVd15tWk2vEE45tQ1NH74mgxmVSPw0Iw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyDbPtaASnlvP+luxQc1pwTxWO49vvZwyLUTOPHlRXd17M4W9Hp
	EiL81dAn3PQutxrzvf2L4X3nKmLGGQXxh0/CXd12fTnvNR1qXGU3w3lzhr65KSv3ptHzBLfaB9e
	H6juFj7Hp9w==
X-Google-Smtp-Source: AGHT+IGysxF4lj+Pa3edYCQyxcx2uUdgDB4x/aH3it4KUk62HUjYx0xS9V+RTFKPnAfHJUfpiQOrJBNcPZbgiA==
X-Received: from wmbfl22.prod.google.com ([2002:a05:600c:b96:b0:436:6fa7:621])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5117:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-436e26ddc53mr94187935e9.25.1736534481726;
 Fri, 10 Jan 2025 10:41:21 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:42 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-16-8419288bc805@google.com>
Subject: [PATCH RFC v2 16/29] mm: asi: Map kernel text and static data as nonsensitive
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
X-CRM114-CacheID: sfid-20250110_184123_762862_72ED7A58 
X-CRM114-Status: GOOD (  28.01  )
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

Basically we need to map the kernel code and all its static variables.
Per-CPU variables need to be treated specially as described in the
comments. The cpu_entry_area is similar - this needs to be
nonsensitive so that the CPU can access the GDT etc when handling
a page fault.

Under 5-level paging, most of the kernel memory comes under a single PGD
entry (see Documentation/x86/x86_64/mm.rst. Basically, the mapping is
for this big region is the same as under 4-level, just wrapped in an
outer PGD entry). For that region, the "clone" logic is moved down one
step of the paging hierarchy.

Note that the p4d_alloc in asi_clone_p4d won't actually be used in
practice; the relevant PGD entry will always have been populated by
prior asi_map calls so this code would "work" if we just wrote
p4d_offset (but asi_clone_p4d would be broken if viewed in isolation).

The vmemmap area is not under this single PGD, it has its own 2-PGD
area, so we still use asi_clone_pgd for that one.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/asi.c                 | 105 +++++++++++++++++++++++++++++++++++++-
 include/asm-generic/vmlinux.lds.h |  11 ++++
 2 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index b951f2100b8bdea5738ded16166255deb29faf57..bc2cf0475a0e7344a66d81453f55034b2fc77eef 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -7,7 +7,6 @@
 #include <linux/init.h>
 #include <linux/pgtable.h>
 
-#include <asm/asi.h>
 #include <asm/cmdline.h>
 #include <asm/cpufeature.h>
 #include <asm/page.h>
@@ -186,8 +185,68 @@ void __init asi_check_boottime_disable(void)
 		pr_info("ASI enablement ignored due to incomplete implementation.\n");
 }
 
+/*
+ * Map data by sharing sub-PGD pagetables with the unrestricted mapping. This is
+ * more efficient than asi_map, but only works when you know the whole top-level
+ * page needs to be mapped in the restricted tables. Note that the size of the
+ * mappings this creates differs between 4 and 5-level paging.
+ */
+static void asi_clone_pgd(pgd_t *dst_table, pgd_t *src_table, size_t addr)
+{
+	pgd_t *src = pgd_offset_pgd(src_table, addr);
+	pgd_t *dst = pgd_offset_pgd(dst_table, addr);
+
+	if (!pgd_val(*dst))
+		set_pgd(dst, *src);
+	else
+		WARN_ON_ONCE(pgd_val(*dst) != pgd_val(*src));
+}
+
+/*
+ * For 4-level paging this is exactly the same as asi_clone_pgd. For 5-level
+ * paging it clones one level lower. So this always creates a mapping of the
+ * same size.
+ */
+static void asi_clone_p4d(pgd_t *dst_table, pgd_t *src_table, size_t addr)
+{
+	pgd_t *src_pgd = pgd_offset_pgd(src_table, addr);
+	pgd_t *dst_pgd = pgd_offset_pgd(dst_table, addr);
+	p4d_t *src_p4d = p4d_alloc(&init_mm, src_pgd, addr);
+	p4d_t *dst_p4d = p4d_alloc(&init_mm, dst_pgd, addr);
+
+	if (!p4d_val(*dst_p4d))
+		set_p4d(dst_p4d, *src_p4d);
+	else
+		WARN_ON_ONCE(p4d_val(*dst_p4d) != p4d_val(*src_p4d));
+}
+
+/*
+ * percpu_addr is where the linker put the percpu variable. asi_map_percpu finds
+ * the place where the percpu allocator copied the data during boot.
+ *
+ * This is necessary even when the page allocator defaults to
+ * global-nonsensitive, because the percpu allocator uses the memblock allocator
+ * for early allocations.
+ */
+static int asi_map_percpu(struct asi *asi, void *percpu_addr, size_t len)
+{
+	int cpu, err;
+	void *ptr;
+
+	for_each_possible_cpu(cpu) {
+		ptr = per_cpu_ptr(percpu_addr, cpu);
+		err = asi_map(asi, ptr, len);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int __init asi_global_init(void)
 {
+	int err;
+
 	if (!boot_cpu_has(X86_FEATURE_ASI))
 		return 0;
 
@@ -207,6 +266,46 @@ static int __init asi_global_init(void)
 				  VMALLOC_START, VMALLOC_END,
 				  "ASI Global Non-sensitive vmalloc");
 
+	/* Map all kernel text and static data */
+	err = asi_map(ASI_GLOBAL_NONSENSITIVE, (void *)__START_KERNEL,
+		      (size_t)_end - __START_KERNEL);
+	if (WARN_ON(err))
+		return err;
+	err = asi_map(ASI_GLOBAL_NONSENSITIVE, (void *)FIXADDR_START,
+		      FIXADDR_SIZE);
+	if (WARN_ON(err))
+		return err;
+	/* Map all static percpu data */
+	err = asi_map_percpu(
+		ASI_GLOBAL_NONSENSITIVE,
+		__per_cpu_start, __per_cpu_end - __per_cpu_start);
+	if (WARN_ON(err))
+		return err;
+
+	/*
+	 * The next areas are mapped using shared sub-P4D paging structures
+	 * (asi_clone_p4d instead of asi_map), since we know the whole P4D will
+	 * be mapped.
+	 */
+	asi_clone_p4d(asi_global_nonsensitive_pgd, init_mm.pgd,
+		      CPU_ENTRY_AREA_BASE);
+#ifdef CONFIG_X86_ESPFIX64
+	asi_clone_p4d(asi_global_nonsensitive_pgd, init_mm.pgd,
+		      ESPFIX_BASE_ADDR);
+#endif
+	/*
+	 * The vmemmap area actually _must_ be cloned via shared paging
+	 * structures, since mappings can potentially change dynamically when
+	 * hugetlbfs pages are created or broken down.
+	 *
+	 * We always clone 2 PGDs, this is a corrolary of the sizes of struct
+	 * page, a page, and the physical address space.
+	 */
+	WARN_ON(sizeof(struct page) * MAXMEM / PAGE_SIZE != 2 * (1UL << PGDIR_SHIFT));
+	asi_clone_pgd(asi_global_nonsensitive_pgd, init_mm.pgd, VMEMMAP_START);
+	asi_clone_pgd(asi_global_nonsensitive_pgd, init_mm.pgd,
+		      VMEMMAP_START + (1UL << PGDIR_SHIFT));
+
 	return 0;
 }
 subsys_initcall(asi_global_init)
@@ -599,6 +698,10 @@ static bool follow_physaddr(
  * Map the given range into the ASI page tables. The source of the mapping is
  * the regular unrestricted page tables. Can be used to map any kernel memory.
  *
+ * In contrast to some internal ASI logic (asi_clone_pgd and asi_clone_p4d) this
+ * never shares pagetables between restricted and unrestricted address spaces,
+ * instead it creates wholly new equivalent mappings.
+ *
  * The caller MUST ensure that the source mapping will not change during this
  * function. For dynamic kernel memory, this is generally ensured by mapping the
  * memory within the allocator.
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index eeadbaeccf88b73af40efe5221760a7cb37058d2..18f6c0448baf5dfbd0721ba9a6d89000fa86f061 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1022,6 +1022,16 @@
 	COMMON_DISCARDS							\
 	}
 
+/*
+ * ASI maps certain sections with certain sensitivity levels, so they need to
+ * have a page-aligned size.
+ */
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+#define ASI_ALIGN() ALIGN(PAGE_SIZE)
+#else
+#define ASI_ALIGN() .
+#endif
+
 /**
  * PERCPU_INPUT - the percpu input sections
  * @cacheline: cacheline size
@@ -1043,6 +1053,7 @@
 	*(.data..percpu)						\
 	*(.data..percpu..shared_aligned)				\
 	PERCPU_DECRYPTED_SECTION					\
+	. = ASI_ALIGN();						\
 	__per_cpu_end = .;
 
 /**

-- 
2.47.1.613.gc27f4b7a9f-goog


