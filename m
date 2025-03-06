Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0000BC28B25
	for <linux-um@archiver.kernel.org>; Thu,  6 Mar 2025 20:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cjjeOY4XBjuFiJaanm3Vhggpqwt0qk0uWA9+wvm49V8=; b=ZmDQHot9HBfKpo3OYzSa+Y0TRY
	ou/NlYJEkzu4mWD0aRtlCPmyebvBGl6az6BEhLeUCt15UGsfvnNMNq1+ehgt2KnhRzienhJGR430c
	5QGoeD6DIphjJspjj9RyfwfDwAqIUvqNgAsw8Ky5uim43XG8M+M7Vb1x8QEjDLa7rqA6caQzFAXIZ
	2jOZfiTwrPGfDFSxbjXzW3jlFFnYVhA4fOTj8UtX9Ue2WwW0Z/QXR6yULCbmuOq1QCpYYhV2g+ABi
	R6/gL+df2SnTva3yl0mCBdnVIsAPKkOsMEZdpqKHIaQFoajhdkNzc3AU0PgSaGWPJYrhrYuwmecRl
	RtK5r+rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqHRs-0000000C54M-34Ke;
	Thu, 06 Mar 2025 20:04:04 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqGLO-0000000BvVZ-1K3L;
	Thu, 06 Mar 2025 18:53:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D0F5CA44F0F;
	Thu,  6 Mar 2025 18:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8163DC4CEE8;
	Thu,  6 Mar 2025 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741287197;
	bh=BkE0IFJXSKU77+xC0N2TBlUULdAjqoteouUfp8/gZ9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H78DLSl+IjdnXrOdxgT+/xt6JTBU4euW24C/yDa5I+IadYyC+HEIKf8v9/STSql0w
	 8Ci9p73t1w+Xz+YHbbWW0NqRvPAsTTGgkup9RJxFt3IWYCiwU8KzktKs78WPfgstEp
	 r3TBxtlGs5W73C+QSyCEERn1fqDTHnrNMca8jScShJM1AOJsNrVThziirlU9DWuCQI
	 NxI/6QapAZIvA0iPZvBo0oljP9L1r5qcoH4ZPCXNbth214GQA4i6M5RW8Tday7NHzb
	 PgoPccIN87hXyD3eA9w781HCQ9lk9kdOFTozIS7Gy/SywY4wv8FVfsBzQ613ahQ7F+
	 9OZnlgrDMKwRQ==
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
Subject: [PATCH 07/13] s390: make setup_zero_pages() use memblock
Date: Thu,  6 Mar 2025 20:51:17 +0200
Message-ID: <20250306185124.3147510-8-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306185124.3147510-1-rppt@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_105318_475221_9CE70132 
X-CRM114-Status: GOOD (  14.26  )
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
 arch/s390/mm/init.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index f2298f7a3f21..020aa2f78d01 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -73,8 +73,6 @@ static void __init setup_zero_pages(void)
 {
 	unsigned long total_pages = memblock_estimated_nr_free_pages();
 	unsigned int order;
-	struct page *page;
-	int i;
 
 	/* Latest machines require a mapping granularity of 512KB */
 	order = 7;
@@ -83,17 +81,10 @@ static void __init setup_zero_pages(void)
 	while (order > 2 && (total_pages >> 10) < (1UL << order))
 		order--;
 
-	empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
+	empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE << order, order);
 	if (!empty_zero_page)
 		panic("Out of memory in setup_zero_pages");
 
-	page = virt_to_page((void *) empty_zero_page);
-	split_page(page, order);
-	for (i = 1 << order; i > 0; i--) {
-		mark_page_reserved(page);
-		page++;
-	}
-
 	zero_page_mask = ((PAGE_SIZE << order) - 1) & PAGE_MASK;
 }
 
@@ -176,9 +167,10 @@ void __init mem_init(void)
 	pv_init();
 	kfence_split_mapping();
 
+	setup_zero_pages();	/* Setup zeroed pages. */
+
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-	setup_zero_pages();	/* Setup zeroed pages. */
 }
 
 unsigned long memory_block_size_bytes(void)
-- 
2.47.2


