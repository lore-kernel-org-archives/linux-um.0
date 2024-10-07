Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61360CFB442
	for <linux-um@archiver.kernel.org>; Mon,  7 Oct 2024 06:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3M5tZmZR587g2tYwNpnjlAQqKJk5qTehs9EZKmH7WvU=; b=sG1iOc6ZK79zqoFp/meJAOkhm0
	d0LAdeDCrO6ms3tWadNMlWZqs5Lax8vJtOLpsyzgSR+W6NUhW9pKbZViMUaERH3mep1944G/M2mqw
	6QSrX4RSQwE5WWl8rclY3hf7kjjoveXE1xvymZL9DaCWlNKVWcTE4nhHe0wxpvGoaANbKnyPTEhbC
	FlqCM03ph6+hvjDJTHUUlV03nRO/BPom+SfaA6F58S1uPOz5hgp+IedNB3EoSk5EhPsB8rhSPhQFB
	b5Rwi+GThZYJE18v0EEsDNE9iwHiSMjaTbFVLkw3Qo5GyZTQRGZ6wltT79jKS+jmuY+JE+7QSuZJ+
	T3ISDxKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxhKF-00000001SH6-39Ed;
	Mon, 07 Oct 2024 06:34:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxhGT-00000001Qiv-3IZE;
	Mon, 07 Oct 2024 06:30:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DB0FA5C004D;
	Mon,  7 Oct 2024 06:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D1EC4CEC7;
	Mon,  7 Oct 2024 06:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728282640;
	bh=wNNekRGAbZryYx39DSPhNWVfD+rXqj7AYYB/EQ4dkrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5NZOr0r+MDPPbXGYRdga5lmfK4ACI5iUhFae2QKUPlVVPSY6vfta0uCYsjQAsMnw
	 BfgIe7WB1uPxSKyBoiQsUh2UjsbNnYe8+4jXZO/sF+t3Njd7bAjWngf0gZz3P0BHWU
	 0I5QGuRGsjvvcQpZKz73XkGRrZt7IYal3+qtG0pe1j5vent2TJWtBtEkNHryQPx1lR
	 bX3sxw7tPO6YTjySBX7aI2GH4qLQ1UUCmm+mC7W14pTtGyu0S01J5d7H4iOvw3Clwe
	 j7ijmmCQCH9z1EMT3k8MNebCpKk8OsGRV0ON9qfRA1O0ccYghTrJ7qqoPJkFksAxEU
	 vVrd/p7JdkH2g==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v4 5/8] arch: introduce set_direct_map_valid_noflush()
Date: Mon,  7 Oct 2024 09:28:55 +0300
Message-ID: <20241007062858.44248-6-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007062858.44248-1-rppt@kernel.org>
References: <20241007062858.44248-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241006_233041_970863_9528F229 
X-CRM114-Status: GOOD (  16.14  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Add an API that will allow updates of the direct/linear map for a set of
physically contiguous pages.

It will be used in the following patches.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm64/include/asm/set_memory.h     |  1 +
 arch/arm64/mm/pageattr.c                | 10 ++++++++++
 arch/loongarch/include/asm/set_memory.h |  1 +
 arch/loongarch/mm/pageattr.c            | 21 +++++++++++++++++++++
 arch/riscv/include/asm/set_memory.h     |  1 +
 arch/riscv/mm/pageattr.c                | 15 +++++++++++++++
 arch/s390/include/asm/set_memory.h      |  1 +
 arch/s390/mm/pageattr.c                 | 11 +++++++++++
 arch/x86/include/asm/set_memory.h       |  1 +
 arch/x86/mm/pat/set_memory.c            |  8 ++++++++
 include/linux/set_memory.h              |  6 ++++++
 11 files changed, 76 insertions(+)

diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index 917761feeffd..98088c043606 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -13,6 +13,7 @@ int set_memory_valid(unsigned long addr, int numpages, int enable);
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
 #endif /* _ASM_ARM64_SET_MEMORY_H */
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 0e270a1c51e6..01225900293a 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -192,6 +192,16 @@ int set_direct_map_default_noflush(struct page *page)
 				   PAGE_SIZE, change_page_range, &data);
 }
 
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+
+	if (!can_set_direct_map())
+		return 0;
+
+	return set_memory_valid(addr, nr, valid);
+}
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/include/asm/set_memory.h
index d70505b6676c..55dfaefd02c8 100644
--- a/arch/loongarch/include/asm/set_memory.h
+++ b/arch/loongarch/include/asm/set_memory.h
@@ -17,5 +17,6 @@ int set_memory_rw(unsigned long addr, int numpages);
 bool kernel_page_present(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 int set_direct_map_invalid_noflush(struct page *page);
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 
 #endif /* _ASM_LOONGARCH_SET_MEMORY_H */
diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
index ffd8d76021d4..f14b40c968b4 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -216,3 +216,24 @@ int set_direct_map_invalid_noflush(struct page *page)
 
 	return __set_memory(addr, 1, __pgprot(0), __pgprot(_PAGE_PRESENT | _PAGE_VALID));
 }
+
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	pgprot_t set, clear;
+
+	return __set_memory((unsigned long)page_address(page), nr, set, clear);
+
+	if (addr < vm_map_base)
+		return 0;
+
+	if (valid) {
+		set = PAGE_KERNEL;
+		clear = __pgprot(0);
+	} else {
+		set = __pgprot(0);
+		clear = __pgprot(_PAGE_PRESENT | _PAGE_VALID);
+	}
+
+	return __set_memory(addr, 1, set, clear);
+}
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index ab92fc84e1fc..ea263d3683ef 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -42,6 +42,7 @@ static inline int set_kernel_memory(char *startp, char *endp,
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 271d01a5ba4d..d815448758a1 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -386,6 +386,21 @@ int set_direct_map_default_noflush(struct page *page)
 			    PAGE_KERNEL, __pgprot(_PAGE_EXEC));
 }
 
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
+{
+	pgprot_t set, clear;
+
+	if (valid) {
+		set = PAGE_KERNEL;
+		clear = __pgprot(_PAGE_EXEC);
+	} else {
+		set = __pgprot(0);
+		clear = __pgprot(_PAGE_PRESENT);
+	}
+
+	return __set_memory((unsigned long)page_address(page), nr, set, clear);
+}
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void *data)
 {
diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set_memory.h
index 06fbabe2f66c..240bcfbdcdce 100644
--- a/arch/s390/include/asm/set_memory.h
+++ b/arch/s390/include/asm/set_memory.h
@@ -62,5 +62,6 @@ __SET_MEMORY_FUNC(set_memory_4k, SET_MEMORY_4K)
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 
 #endif
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 5f805ad42d4c..4c7ee74aa130 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -406,6 +406,17 @@ int set_direct_map_default_noflush(struct page *page)
 	return __set_memory((unsigned long)page_to_virt(page), 1, SET_MEMORY_DEF);
 }
 
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
+{
+	unsigned long flags;
+
+	if (valid)
+		flags = SET_MEMORY_DEF;
+	else
+		flags = SET_MEMORY_INV;
+
+	return __set_memory((unsigned long)page_to_virt(page), nr, flags);
+}
 #if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
 
 static void ipte_range(pte_t *pte, unsigned long address, int nr)
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 4b2abce2e3e7..cc62ef70ccc0 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -89,6 +89,7 @@ int set_pages_rw(struct page *page, int numpages);
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
 extern int kernel_set_to_readonly;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 44f7b2ea6a07..069e421c2247 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2444,6 +2444,14 @@ int set_direct_map_default_noflush(struct page *page)
 	return __set_pages_p(page, 1);
 }
 
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
+{
+	if (valid)
+		return __set_pages_p(page, nr);
+
+	return __set_pages_np(page, nr);
+}
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index e7aec20fb44f..3030d9245f5a 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -34,6 +34,12 @@ static inline int set_direct_map_default_noflush(struct page *page)
 	return 0;
 }
 
+static inline int set_direct_map_valid_noflush(struct page *page,
+					       unsigned nr, bool valid)
+{
+	return 0;
+}
+
 static inline bool kernel_page_present(struct page *page)
 {
 	return true;
-- 
2.43.0


