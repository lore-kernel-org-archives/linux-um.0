Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D125C28B24
	for <linux-um@archiver.kernel.org>; Thu,  6 Mar 2025 18:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f/Tjv7nZ1RGU38sSJe49qG5HH8eeGxe0gmVd2kGHllo=; b=QPhAgVwOwG3THPK/U6ip3ZwaE0
	4sKHep9I1gqW57IUfRREZ2RptKOuRJP8dOocfM9md6xTI0ZL2jfUJ0Q804BpUwMSUMFGhPCl67mJn
	V1Hwcq38AkXwpjr04ZQ4qYyGO1Ms3N9Kf+CthAWdLfdLsgXaoEeBZHk4SolHcqafwq90YG46PJtwQ
	YNpoLT29nhvXOTlrQxa65Ms6yEDN8aZZImvZbGTrtU5aRRIaSpLjvAi2febdPEnl3syn5boZJNrqM
	gwc7ioV8WjtNmrYcyU5rDWxmHVCdBhUPMDBnqm1CHuvF0BQmS5kH2YaxPumOmkuz/gcCghTl8t1L3
	3snPn7+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqGKo-0000000Bv6Z-0mps;
	Thu, 06 Mar 2025 18:52:42 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqGKk-0000000Bv3F-3neq;
	Thu, 06 Mar 2025 18:52:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 66E49A44F0F;
	Thu,  6 Mar 2025 18:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1376FC4CEE0;
	Thu,  6 Mar 2025 18:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741287157;
	bh=nkBe6+9DINra8ChNyXeYcesTu6mPwjeTN1yq3Y1szbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=siKQU+HDCfw0PGVcuQLowpSBXONSMtUVdFxiCr/6hU+NHY+VBHRlc1vAUMT5hpJZB
	 PiVwReKljb7dtz57q/YhNgC/pOTwxkZOQVhOO7p43ve+TVnLWWN7d0SfMwaPKZXUnC
	 kE9KWupqvpjakTaBQB38YsWY/YDt6tkSLuS44omo3I/wMLF2pVop/8yqmSFOQUynyz
	 OAbvzs0UwLJMMvu3PP28iy00klBtAdZ7IDinGxb0rWjVk4O5ozTiq+E/5xe7lZMfHj
	 qz1b46GsbuZHpSH/b+emJTc8g80OT8hpp/EeqCWWu0ZThETTwxlc70LZLmOMcV9Az+
	 ArY7HhgOILFsA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
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
Subject: [PATCH 04/13] MIPS: consolidate mem_init() for NUMA machines
Date: Thu,  6 Mar 2025 20:51:14 +0200
Message-ID: <20250306185124.3147510-5-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306185124.3147510-1-rppt@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_105239_070616_3EFD90EF 
X-CRM114-Status: GOOD (  10.75  )
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

Both MIPS systems that support numa (loongsoon3 and sgi-ip27) have
identical mem_init() for NUMA case.

Move that into arch/mips/mm/init.c and drop duplicate per-machine
definitions.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/mips/loongson64/numa.c      | 7 -------
 arch/mips/mm/init.c              | 7 +++++++
 arch/mips/sgi-ip27/ip27-memory.c | 9 ---------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
index 8388400d052f..95d5f553ce19 100644
--- a/arch/mips/loongson64/numa.c
+++ b/arch/mips/loongson64/numa.c
@@ -164,13 +164,6 @@ void __init paging_init(void)
 	free_area_init(zones_size);
 }
 
-void __init mem_init(void)
-{
-	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
-	memblock_free_all();
-	setup_zero_pages();	/* This comes from node 0 */
-}
-
 /* All PCI device belongs to logical Node-0 */
 int pcibus_to_node(struct pci_bus *bus)
 {
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 4583d1a2a73e..3db6082c611e 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -482,6 +482,13 @@ void __init mem_init(void)
 				0x80000000 - 4, KCORE_TEXT);
 #endif
 }
+#else  /* CONFIG_NUMA */
+void __init mem_init(void)
+{
+	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
+	memblock_free_all();
+	setup_zero_pages();	/* This comes from node 0 */
+}
 #endif /* !CONFIG_NUMA */
 
 void free_init_pages(const char *what, unsigned long begin, unsigned long end)
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 1963313f55d8..2b3e46e2e607 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -406,8 +406,6 @@ void __init prom_meminit(void)
 	}
 }
 
-extern void setup_zero_pages(void);
-
 void __init paging_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES] = {0, };
@@ -416,10 +414,3 @@ void __init paging_init(void)
 	zones_size[ZONE_NORMAL] = max_low_pfn;
 	free_area_init(zones_size);
 }
-
-void __init mem_init(void)
-{
-	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
-	memblock_free_all();
-	setup_zero_pages();	/* This comes from node 0 */
-}
-- 
2.47.2


