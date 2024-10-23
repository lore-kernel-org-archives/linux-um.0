Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D97CFA455
	for <linux-um@archiver.kernel.org>; Wed, 23 Oct 2024 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BZgydcd83RnoD+nKZMyd/RhTFE33DpavMZJgDUUSvXs=; b=lT1kTyj0MzLkNLQTWaqzcVyxUW
	bxOlw9Fjo3Xrrrsk809DR2Qt7R+LRY3EzQUhaJQxjmAumZCgfqrZlFW137ymxzBeKh+yzZS4f98nL
	Axz0gbkbRiheU9otX0+q6lvLx++lPv81nkkuEG6Ptay1BTORf+7CusUwsIVcwKK4AJepV/576g5SI
	2juJsCSLi7ldcRQLK5XnM76vAZXz/UvmyXePlDImzWAqNYXq8MB22NVzDz0Jmr6fOTSD1wGCDWkad
	hoBltQLs3aTPu7SSFSsm2id/u4WsRfArT7WF0DhW//HjgFQb9SK29H63ABqF/drbWVCknNRgobWT2
	aZ0KEkLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3esw-0000000FJdv-3oBJ;
	Wed, 23 Oct 2024 17:11:02 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3eEG-0000000FAQo-0Rhb;
	Wed, 23 Oct 2024 16:29:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C2671A43420;
	Wed, 23 Oct 2024 16:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC030C4CEEA;
	Wed, 23 Oct 2024 16:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729700938;
	bh=WkgLYLP14z9R0rX0arj7V8bSL3F01OjsGvulzgdJGig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IiFeeafB3NRoVAeVBviHseyoM42juLPWXAdhm7ufrL2maTLAnIohm/6mhkJlMvJfx
	 eDLHET0+TzAnfxNuUnNvXwm+e3KPlOmfSQ/Y8Q3XLK5ZYEPZJDhUg2e3VX2j5lC7El
	 zXxMilXQJ+Ff83lvU3th5yV3MRzHvxuZE+QqpDeT7qaAEqUbpjexyDTgaGqJH5IpKu
	 PCfqrtFRlDZkd7zkFSBGBynjtpcJgNbGklm6P7OW+iDSX6GIb538OjsWHvGPu3X71Z
	 u4oqjsGtC1QQA8ihFJa1sw37OIgFvMEPBD65b21tNDc50GwHsKf1RJWB8M5RLMLh0J
	 H0RQDTjm4JP8w==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>
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
	Suren Baghdasaryan <surenb@google.com>,
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
Subject: [PATCH v7 5/8] arch: introduce set_direct_map_valid_noflush()
Date: Wed, 23 Oct 2024 19:27:08 +0300
Message-ID: <20241023162711.2579610-6-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023162711.2579610-1-rppt@kernel.org>
References: <20241023162711.2579610-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_092900_294586_CFA47E60 
X-CRM114-Status: GOOD (  15.87  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Tested-by: kdevops <kdevops@lists.linux.dev>
---
 arch/arm64/include/asm/set_memory.h     |  1 +
 arch/arm64/mm/pageattr.c                | 10 ++++++++++
 arch/loongarch/include/asm/set_memory.h |  1 +
 arch/loongarch/mm/pageattr.c            | 19 +++++++++++++++++++
 arch/riscv/include/asm/set_memory.h     |  1 +
 arch/riscv/mm/pageattr.c                | 15 +++++++++++++++
 arch/s390/include/asm/set_memory.h      |  1 +
 arch/s390/mm/pageattr.c                 | 11 +++++++++++
 arch/x86/include/asm/set_memory.h       |  1 +
 arch/x86/mm/pat/set_memory.c            |  8 ++++++++
 include/linux/set_memory.h              |  6 ++++++
 11 files changed, 74 insertions(+)

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
index ffd8d76021d4..bf8678248444 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -216,3 +216,22 @@ int set_direct_map_invalid_noflush(struct page *page)
 
 	return __set_memory(addr, 1, __pgprot(0), __pgprot(_PAGE_PRESENT | _PAGE_VALID));
 }
+
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	pgprot_t set, clear;
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


