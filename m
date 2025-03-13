Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2416C2BA1B
	for <linux-um@archiver.kernel.org>; Thu, 13 Mar 2025 13:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+UjMwhEht30vCR6c5BWARp/0Kl/5L2IcrBToHAC3ydk=; b=FabU2ncX4MNqkqBtjeI+R52/x9
	US46vIvGTbnSS+QHXdAudkxuCujOt2N87Miawb4qmfU8Imw2mO+TIemjJemCbNQcVWtQEzhsOSJA/
	MzRebU03MEYMvVudRSlfbH8vy1mk/pl1QYXHOdBOGLhB5Z05Ee5DZvHSq0/+x4JRBW+Bcv0pFSxBW
	OVzrhVGyOO6XOPvJGQkTupRA4LfbQ5UwQTcJPlT9vujdipJ5riBNco+HH/lc7bPq+39UE4BWJz1Zh
	AIq2ZMzuTQU5CcuSZPOIBKl4JiN+7iJ6C4aqBpL2K9l/dvMlkgTONp1jLvhoMiu8ddZsb4T8zzEKU
	U6OmZKow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsizk-0000000BRf6-28D1;
	Thu, 13 Mar 2025 13:53:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsixO-0000000BQly-40w2;
	Thu, 13 Mar 2025 13:50:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+UjMwhEht30vCR6c5BWARp/0Kl/5L2IcrBToHAC3ydk=; b=oWUD6hirmwC6iOcUEe2sREDQNP
	sjJwOzaRvT+bI4fggfezC1JijxicSrdztxkUWKB8nSM3bOowhadYyp1DhAUkgjV5XpmI6Xj6YT5ap
	tbyelr/jZdFWYxWajLJCpcprPicaUCDyyV8nTj9cihFsr6tX/11fkFJberaAFlluDRlT7xMiT4/Px
	Ybx07apdtF6YFi42PIy5cTi766zC6NAtRtXG9wHn3JWQl/F9/v5Y8DzLNXTGUsqhYlOYPJr9dRs8A
	mbaQncpGnvxbKkdG70zu5Zzd+Tx/rmYXkOu7sJYfpcQIKMuJU8P0xoXwC4LqQ7gJ1OMTxJM4unwL8
	nPzHohUQ==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsixK-00000002eOu-46VM;
	Thu, 13 Mar 2025 13:50:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B00B25C5DAE;
	Thu, 13 Mar 2025 13:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EA7C4CEEB;
	Thu, 13 Mar 2025 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873836;
	bh=xXhNVtoRAjb56OLfL+MIUyuiC6fNrGdmFypg4AHZHss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vM8kjhflpGv3ifczYRBjucOLjPNbTjYEFQMj1aEp0KsLhRKStFJlWIGjAEJLt2da+
	 HjtiQkCtGzrOP1Lfase8Tm5L6D5Mn8i2K2X8xlpqdSbVd+khSOen+r9N4+2Ckwctvl
	 vd45q3fsT5VFequdtDMR6RGd84DUAVt5h+T7EQZSGqGj3wc9JcT8Kf80HGB1m/4qV/
	 YmMUDr49NOXjSCqI/uf+x2MqyPp4kBxltU4mmCjCvwKgvY2LEte6vnTXfX463yflwU
	 D9m/XyUzL5ubJawlpBJuZyq0tgbiYauzm+IdYU+m35MKZ0/I3YkEYIrUzw4+S42UjY
	 9rlNZpu0kjehA==
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
Subject: [PATCH v2 01/13] arm: mem_init: use memblock_phys_free() to free DMA memory on SA1111
Date: Thu, 13 Mar 2025 15:49:51 +0200
Message-ID: <20250313135003.836600-2-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313135003.836600-1-rppt@kernel.org>
References: <20250313135003.836600-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_135039_409942_0A599DB8 
X-CRM114-Status: GOOD (  12.90  )
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


