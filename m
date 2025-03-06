Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2A7C28B25
	for <linux-um@archiver.kernel.org>; Thu,  6 Mar 2025 18:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+UjMwhEht30vCR6c5BWARp/0Kl/5L2IcrBToHAC3ydk=; b=rrRZqVE4J9ZhYGp1A01XwhvZ3K
	T6ChC3daRtKuKjT2DE8SBkGteJeuXQcl5VTI8T2mEtmUXn36o3sBqSqZnXKoEkBG5DvtRe/Xdd5SG
	kc0RnU7nYSyyr2GIkUcggxGYh4CbBi6LHvU5AjK07jzUiIO4ltcgN7MzhMRHIN+fJG/3Rje3NYAPT
	GIo66hVDhhKjidi1BbZ5jiz/uLXyaJ0YIqQK8paHlaEMy9iBoaJAJY04DEfUyI+Dl/zW+ibVllzRZ
	PKiMqYgIH9V3ntoV4n6ZivF/3r97RjnWZX33XkAkiDy2JAYHC44KhwmnE9+KSKK5Fd2eKlxtqicqP
	vGSRt0Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqGKB-0000000BudA-1CBv;
	Thu, 06 Mar 2025 18:52:03 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqGK7-0000000BuZf-1YcO;
	Thu, 06 Mar 2025 18:52:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 01C9AA45015;
	Thu,  6 Mar 2025 18:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A344CC4AF09;
	Thu,  6 Mar 2025 18:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741287118;
	bh=xXhNVtoRAjb56OLfL+MIUyuiC6fNrGdmFypg4AHZHss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mc3+5VBdIIu92zQEQScIdHtZDhsV8+TCREp8qojNXCswdu86fU2tpoEml4nZd+poR
	 eQ0aLJbVQzCZz9QzHALQCbJDJmU+0IljCo21Q5bN5Bm7RSinZHmM9kZn2YJ+28Da5R
	 F3c4gmZD4pIuuzDv9PqqG1EoltUBB5A6ciiMy22TEZs/vmhrtV3uwpgLjhtCkg5Rdv
	 BvwfrE5ADeSFTJF2WiyoCmebxERnGD71/MtMVpgpA/CV54VKWpKBskx5rbT/nROo1f
	 YwI/WFO7c+f3jMkR6/CwCcPcELWSYBwm/v51JOMhWtqAnUyjyq8a8lee+Mg1IXoDLQ
	 F1y1chgJwbe0w==
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
Subject: [PATCH 01/13] arm: mem_init: use memblock_phys_free() to free DMA memory on SA1111
Date: Thu,  6 Mar 2025 20:51:11 +0200
Message-ID: <20250306185124.3147510-2-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306185124.3147510-1-rppt@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_105159_568340_781916D6 
X-CRM114-Status: GOOD (  12.88  )
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

This will help to pull out memblock_free_all() to generic code.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm/mm/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 5345d218899a..9aec1cb2386f 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -277,14 +277,14 @@ void __init mem_init(void)
 
 	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
 
-	/* this will put all unused low memory onto the freelists */
-	memblock_free_all();
-
 #ifdef CONFIG_SA1111
 	/* now that our DMA memory is actually so designated, we can free it */
-	free_reserved_area(__va(PHYS_OFFSET), swapper_pg_dir, -1, NULL);
+	memblock_phys_free(PHYS_OFFSET, __pa(swapper_pg_dir) - PHYS_OFFSET);
 #endif
 
+	/* this will put all unused low memory onto the freelists */
+	memblock_free_all();
+
 	free_highpages();
 
 	/*
-- 
2.47.2


