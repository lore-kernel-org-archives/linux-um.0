Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD33D2502F
	for <linux-um@archiver.kernel.org>; Sun, 11 Jan 2026 08:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Amvc2bHxtbhQlfK6qJaZpELNOKeDaTKBZTuouOmWWwU=; b=tdw1oYeYnvN9vjL8aBK/oRM1tL
	H9DsgTaiql73bG2vhG/84mOnqT+oRnA5+m9KY1+gIJIBQSZ7BX2gZ/e9Jo1VFESYqDrGFIIAWntTa
	AT7xZMIW2nE2y4TlpV6NvowU368icURxXSv0/zRPY8vx8q9kBIRpqTydgc7BOVlmMfyUxuTqxvazT
	e7qL40wW78u5gD48n7bIL0f7RSvB+PmhveA1zHbcMsFADQ2CT5WxTshYjRaUGFTM2myqskUQrCIpX
	2Nu4G93s2IW6hFtgg9PWBXZP6RzoPUzbq9ZZEnTsqHW4arCtaeTh4+0CqGfDTlQfxSsAzVmteVkOd
	3cmg5LbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veqkW-00000003zUo-3pF0;
	Sun, 11 Jan 2026 08:24:36 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veqkU-00000003zSQ-02DU;
	Sun, 11 Jan 2026 08:24:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Amvc2bHxtbhQlfK6qJaZpELNOKeDaTKBZTuouOmWWwU=; b=FQD1a1qNyXcnAJwhRLZrIjC2U3
	1KtEqd3mcp4i3mgXyNj58OhveLB1wh7DYJD9XIszdFOeQwmv4WV87CeFxKXROLGGgBRxUXNE6+f9K
	zCjJR8x2Fw5HGJ4FBCu/JTDJ2zqP5ETsfzUiwKFYgxCV2xYaA3nU/+KeXMdfXK+mX7hUUZQ+s2HMh
	5Ty+8K9jfTaZqM6GZvWqXC3kB3Y/oReNqZRVDMoyC3iR0sr6H5P71Vh4sdc9wb8QhEsWzEdVaYlD6
	Odf1xbq8mwZU9KT5wV+KgWgYeWXZfdgp6XMIdVCwneLnth8RqhWoTL+JR7rzyKZ9+ii3c/9kppKU8
	M25B1feg==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by casper.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veqkQ-00000001dms-3hGt;
	Sun, 11 Jan 2026 08:24:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5C2BE40317;
	Sun, 11 Jan 2026 08:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99471C19424;
	Sun, 11 Jan 2026 08:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768119865;
	bh=5jwx79jcXEjB7Ff6jLyMimZz3LM3kE0UW0s3xt/n05M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2z8eOMb9eyd4wabnDTuPvI6RxfYEY/JPPF9DcHEsS4Bxx7OOqdDRpJwLjy5GTef4
	 JX3E3wK7FvEIEDc+4gp2ac5AR8qx6fjBRr7EvCDi9BOZG7dYlNGVKk3+1A2sXe4uV3
	 QtSlpeZBvuA3HQTAUWNJ1nKZb94PTMd5ay5D7adLCwYMblGK44uysSp4hLaaLnxOBU
	 cjDBn8SojAUPdfeQin51Je8ea3GoefARGfhe5urhFjWdwoln4droQx6NMI0XAK1yr9
	 zLzlOIoym+7m3KxOZ+uROjUszAp6pkozGohHu0HDMUT+/UAiR82BRRKgyi2q6NIqVy
	 jwTaGvloNEqfw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Klara Modin <klarasmodin@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org
Subject: [PATCH v3 12/29] nios2: introduce arch_zone_limits_init()
Date: Sun, 11 Jan 2026 10:20:46 +0200
Message-ID: <20260111082105.290734-13-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260111082105.290734-1-rppt@kernel.org>
References: <20260111082105.290734-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260111_082431_220559_E56ADE85 
X-CRM114-Status: GOOD (  13.28  )
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

Move calculations of zone limits to a dedicated arch_zone_limits_init()
function.

Later MM core will use this function as an architecture specific callback
during nodes and zones initialization and thus there won't be a need to
call free_area_init() from every architecture.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/nios2/mm/init.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index 94efa3de3933..2cb666a65d9e 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -38,6 +38,11 @@
 
 pgd_t *pgd_current;
 
+void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
+{
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+}
+
 /*
  * paging_init() continues the virtual memory environment setup which
  * was begun by the code in arch/head.S.
@@ -51,8 +56,7 @@ void __init paging_init(void)
 	pagetable_init();
 	pgd_current = swapper_pg_dir;
 
-	max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
-
+	arch_zone_limits_init(max_zone_pfn);
 	/* pass the memory from the bootmem allocator to the main allocator */
 	free_area_init(max_zone_pfn);
 
-- 
2.51.0


