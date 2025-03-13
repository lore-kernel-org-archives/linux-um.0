Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCB4C282EC
	for <linux-um@archiver.kernel.org>; Thu, 13 Mar 2025 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7TYJ6KyIQxESiqIgrQq9aalozrIFDpJ0ZJXqNbTPqlI=; b=d/tAAJNtIaCwXzEmqg5pUFA/lB
	1sv5+st7WsRoe7bdTKt25WDRyP4MeFypYRzUkXiKEghfgBjRatcN/cLsWzMZpdZwi970BX4PpjTXl
	3N9CzOXd/3OUMnloPmRDXKgkSQvUwUC+8asRhWSAcOb45RG033ChdCWFqerWqcrhPOa568YEJKzUC
	DeTMkgbbtj164ftZQ5y3LhslD/RzEBh1N+bs7dtXjV160MV8Z/lsDLY+/nenrnKGAeFkjF3kG7ycc
	+ozQOFOd44WTgGPYPj/afCp0Fvl7Y2Isr4ThUOfOco7SL9KELDR1Xk4kZHsn3NPD0EyTeVz66Pjbx
	o+ytbw1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsizr-0000000BRp5-11iw;
	Thu, 13 Mar 2025 13:53:15 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsiyB-0000000BR1L-0UB8;
	Thu, 13 Mar 2025 13:51:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5E455A474CE;
	Thu, 13 Mar 2025 13:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015EFC4CEF6;
	Thu, 13 Mar 2025 13:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873889;
	bh=jdWrizGlyiZZhCc1iHfNv1CsWigRieeHlQFrymlBBDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3KxN3gI6tZkgmfjdGzHSgAamoBrtMk5mafHWD0jowj5KlnVnY175VGFXMIdiBWWr
	 B0id/FlW6EUwL50nPhHTxSa3ZYicRa5WCcAVJ1jqVKXm0jic0tczSIN1xHSKcWjdiQ
	 D4zIM9VOnf83gFmBpmn6LKIQhS824VfdxG6Q7Sc5wumpzMv1OC7V7+rYxBizu7Teaz
	 KU/I5rcojMcKt4TssZCQ8zpDNAQK4H9oQKTruuXHVBrx+VpKg8pt85mDQsZo+8ivk2
	 OY1XX/aha854nOI4DZr2fH95T6QTV9et5NHe2RoD4T67D7uTt3ju/gRHLM1ghupdhu
	 a92GRhFxvI5eA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v2 05/13] MIPS: make setup_zero_pages() use memblock
Date: Thu, 13 Mar 2025 15:49:55 +0200
Message-ID: <20250313135003.836600-6-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313135003.836600-1-rppt@kernel.org>
References: <20250313135003.836600-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_065131_287945_E80ED6BD 
X-CRM114-Status: GOOD (  16.07  )
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

Allocating the zero pages from memblock is simpler because the memory is
already reserved.

This will also help with pulling out memblock_free_all() to the generic
code and reducing code duplication in arch::mem_init().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/mips/include/asm/mmzone.h |  2 --
 arch/mips/mm/init.c            | 18 +++++-------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/mmzone.h b/arch/mips/include/asm/mmzone.h
index 14226ea42036..602a21aee9d4 100644
--- a/arch/mips/include/asm/mmzone.h
+++ b/arch/mips/include/asm/mmzone.h
@@ -20,6 +20,4 @@
 #define nid_to_addrbase(nid) 0
 #endif
 
-extern void setup_zero_pages(void);
-
 #endif /* _ASM_MMZONE_H_ */
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 3db6082c611e..820e35a59d4d 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -59,24 +59,16 @@ EXPORT_SYMBOL(zero_page_mask);
 /*
  * Not static inline because used by IP27 special magic initialization code
  */
-void setup_zero_pages(void)
+static void __init setup_zero_pages(void)
 {
-	unsigned int order, i;
-	struct page *page;
+	unsigned int order;
 
 	if (cpu_has_vce)
 		order = 3;
 	else
 		order = 0;
 
-	empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!empty_zero_page)
-		panic("Oh boy, that early out of memory?");
-
-	page = virt_to_page((void *)empty_zero_page);
-	split_page(page, order);
-	for (i = 0; i < (1 << order); i++, page++)
-		mark_page_reserved(page);
+	empty_zero_page = (unsigned long)memblock_alloc_or_panic(PAGE_SIZE << order, PAGE_SIZE);
 
 	zero_page_mask = ((PAGE_SIZE << order) - 1) & PAGE_MASK;
 }
@@ -470,9 +462,9 @@ void __init mem_init(void)
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT) && (PFN_PTE_SHIFT > PAGE_SHIFT));
 
 	maar_init();
-	memblock_free_all();
 	setup_zero_pages();	/* Setup zeroed pages.  */
 	mem_init_free_highmem();
+	memblock_free_all();
 
 #ifdef CONFIG_64BIT
 	if ((unsigned long) &_text > (unsigned long) CKSEG0)
@@ -486,8 +478,8 @@ void __init mem_init(void)
 void __init mem_init(void)
 {
 	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
-	memblock_free_all();
 	setup_zero_pages();	/* This comes from node 0 */
+	memblock_free_all();
 }
 #endif /* !CONFIG_NUMA */
 
-- 
2.47.2


