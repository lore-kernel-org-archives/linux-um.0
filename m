Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A641CE784BE
	for <linux-um@archiver.kernel.org>; Sun, 28 Dec 2025 12:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5tzZHLZRN3jOrlP1D8SLHHdCfMJ27h3Izx64Fi3A5HE=; b=bPTi2P7lFgJvXRlUDLMjiiUUds
	mwf5sTJTJUMU/VRwhW8712IJEkt3r1oKwBKbe/nV2fSln/qxlfUmIi4U9MhcshhUbs4TfqMIFd16c
	N2pGxAng/mG81j7rImdGP+KudazzvfGIp44yui7975LSUVKYE9IetKIyk1OtfipwnRGB19f5KTqOM
	JmcSjnhKu/N/EIMwEQUy9HeQmVRbKLI7IYokGpjwga1ANxug5zgfJ/ZyY8SHzzA1IwDApptIrxWWs
	+0/gtTZGE0EreQixSV3lMWsI5jLORb5neqFtMgwmRSFPwcmd7HaNCJY+jSThq5qmXs+G9Kn0iV1jG
	n+31r4EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZq7D-00000002icp-1cZU;
	Sun, 28 Dec 2025 12:43:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZq7B-00000002ibS-3GGP;
	Sun, 28 Dec 2025 12:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5tzZHLZRN3jOrlP1D8SLHHdCfMJ27h3Izx64Fi3A5HE=; b=FUxRBmnh+mLD14TEFQIk1CRqpr
	MdX4RVDCGnTz9H1RNqnaOAxaUzXCVP1DTDOZlHin0+SP0zKw1zhxP9ym1w3Jkh7Lm7tQfbmLcB1fq
	oZUq9AFpNApT/E59NG+m/I0D92LGsgT9r8/GeVn7+hEKGNf51p5rrBkL37h1PlrsQrDeGoYuuJ2lW
	WEbhvdeW2S8bLmvif0fLzBOWvnJ4kkACIhD2eiSp4xMzYm2MEYujzk0BI2kwXo7SKZ5e5rpUV3ABW
	kawkwc8rFNRrn2EEMwS9Ym6lakBx+gyGvxpphXw7TLfxigmX3NptU9Tet41E/4Kt5fbmoIndkNFd9
	8bjJ4LIQ==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZq77-000000023wO-0spp;
	Sun, 28 Dec 2025 12:43:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DB29041B29;
	Sun, 28 Dec 2025 12:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18212C113D0;
	Sun, 28 Dec 2025 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766925791;
	bh=YC7hFXptZV2vdW9aMAEwYEJyXUoPJivVkcdf9qZf+do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QrkxuRjeoBqT45eWaWTb4GyN5mvdPvm7P/ypq3b7ackOraR4PTpHd9pRbZ6i6kO4N
	 97hmQlJlJx3RR4oGwFEqSIecIjyWdldzVJrezh4/O3IlJFDwvEfZFQhdWYY4O7Ps+s
	 kACkB1HXzlzU/AMGBfP0XWzLsCttaOuvlAqNZVnnfZmNdk1yb7CdgatEFSlqpjw4yV
	 1izKUT566ScNJsmJy6w6R3+EgIwlD+sdx2tXndUSgJ8SgT+cdpxegWpGNdiSHyMHE/
	 N572Ve1tnKWow+M2vFlpUlHDmcNe3iyu6yt5R86wUIb2hZT7G3KKfbWLkf7toUIKdF
	 em9WX24oSmkWA==
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
Subject: [PATCH 12/28] openrisc: introduce arch_zone_limits_init()
Date: Sun, 28 Dec 2025 14:39:42 +0200
Message-ID: <20251228124001.3624742-13-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228124001.3624742-1-rppt@kernel.org>
References: <20251228124001.3624742-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251228_124313_593608_80829940 
X-CRM114-Status: GOOD (  11.52  )
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
---
 arch/openrisc/mm/init.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 9382d9a0ec78..67de93e7a685 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -39,15 +39,19 @@
 
 int mem_init_done;
 
-static void __init zone_sizes_init(void)
+void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
 {
-	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
-
 	/*
 	 * We use only ZONE_NORMAL
 	 */
-	max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+}
+
+static void __init zone_sizes_init(void)
+{
+	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 
+	arch_zone_limits_init(max_zone_pfn);
 	free_area_init(max_zone_pfn);
 }
 
-- 
2.51.0


