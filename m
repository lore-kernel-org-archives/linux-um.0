Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EE0C54E94
	for <linux-um@archiver.kernel.org>; Wed, 25 Jan 2023 19:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XRs/T/IZNUEQmdmUMiFAgjrQ30IkhJwYQ1I6WN76cTs=; b=DMw8j8P95Cf9VL
	sySy5rttNh6Wr24IVuELzDWh+gRI0WPi2bZzYMTuo1YY2knPDIHR8X7J5t2XQH3DoT89ljNuDM+y2
	tHWjfVgi2wXL1QuFrOVkzdoy5q9kD9Bjl4lGsWh1eUt/Sq2wohT5Oy3o2lGMqPr0ka70QBpmyGv26
	yqN1y/F+JI7kmEkiVXT29dMTqioX3d+IfAuPTdde25YAHrz6zBCCNpcG9nBrpa0Z65HNfhgrtxDfu
	coWRBI72wzoBgSixrO3uxtL2//CmcIjwcs3MUt2MhKUhpA2XI8QhgujPg+xa72XnK7DaBfn67mQTi
	tX8BV0zl9GBf1YGaYVEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKl8M-008QTh-GA; Wed, 25 Jan 2023 19:08:34 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKl8I-008QS2-Qv; Wed, 25 Jan 2023 19:08:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5E7B5615BF;
	Wed, 25 Jan 2023 19:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85BCC433A7;
	Wed, 25 Jan 2023 19:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674673710;
	bh=e5RD+ChFYW/EecHl5ap2SmlVrekFipkC772OqZMuVGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VayjFvjTXPvWyL/99q0Q7Vo5BJQIU/QWsdqT9U6kg3Xi9+KratRvjQIvNgQZNC3ej
	 6x/V1dpkk1wIjhfkSpo4tsDE6LKiO+Z94AT9MrMhVBrrQvC4crABv3iZAhx0hPAdnc
	 G/Kplj04nGqfPkVb2pBjO0GqI2SeHuT5hhqCing4uoX5Nyi2JGI89yALKqEotm5cXW
	 IVAcb4mE1j1I4sF505IYGjEOjQNXyPndc4ldxqG2bG//O/g+ApLa4k300Bdp2RDaS6
	 +A5XNi3/uTO24fyw3WkB8WmX8CDXexEGrS2YKYpiYOPBhNL3AuJAnu+PeWPrPw3UmH
	 WPqMRKYef77Yg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Brian Cain <bcain@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Rich Felker <dalias@libc.org>,
	Richard Weinberger <richard@nod.at>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Vineet Gupta <vgupta@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux--csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linux-xtensa@linux-xtensa.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	openrisc@lists.librecores.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	"Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: [PATCH 1/3] m68k: use asm-generic/memory_model.h for both MMU and !MMU
Date: Wed, 25 Jan 2023 21:07:55 +0200
Message-Id: <20230125190757.22555-2-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230125190757.22555-1-rppt@kernel.org>
References: <20230125190757.22555-1-rppt@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230125_110830_968081_4A45C219 
X-CRM114-Status: GOOD (  13.46  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

The MMU variant uses generic definitions of page_to_pfn() and
pfn_to_page(), but !MMU defines them in include/asm/page_no.h for no
good reason.

Include asm-generic/memory_model.h in the common include/asm/page.h and
drop redundant definitions.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/m68k/include/asm/page.h    | 6 +-----
 arch/m68k/include/asm/page_mm.h | 1 -
 arch/m68k/include/asm/page_no.h | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index 2f1c54e4725d..a5993ad83ed8 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -62,11 +62,7 @@ extern unsigned long _ramend;
 #include <asm/page_no.h>
 #endif
 
-#ifndef CONFIG_MMU
-#define __phys_to_pfn(paddr)	((unsigned long)((paddr) >> PAGE_SHIFT))
-#define __pfn_to_phys(pfn)	PFN_PHYS(pfn)
-#endif
-
 #include <asm-generic/getorder.h>
+#include <asm-generic/memory_model.h>
 
 #endif /* _M68K_PAGE_H */
diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
index a5b459bcb7d8..3903db2e8da7 100644
--- a/arch/m68k/include/asm/page_mm.h
+++ b/arch/m68k/include/asm/page_mm.h
@@ -134,7 +134,6 @@ extern int m68k_virt_to_node_shift;
 })
 
 #define ARCH_PFN_OFFSET (m68k_memory[0].addr >> PAGE_SHIFT)
-#include <asm-generic/memory_model.h>
 
 #define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
 #define pfn_valid(pfn)		virt_addr_valid(pfn_to_virt(pfn))
diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
index c9d0d84158a4..0a8ccef777fd 100644
--- a/arch/m68k/include/asm/page_no.h
+++ b/arch/m68k/include/asm/page_no.h
@@ -26,8 +26,6 @@ extern unsigned long memory_end;
 #define virt_to_page(addr)	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))
 #define page_to_virt(page)	__va(((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET))
 
-#define pfn_to_page(pfn)	virt_to_page(pfn_to_virt(pfn))
-#define page_to_pfn(page)	virt_to_pfn(page_to_virt(page))
 #define pfn_valid(pfn)	        ((pfn) < max_mapnr)
 
 #define	virt_addr_valid(kaddr)	(((unsigned long)(kaddr) >= PAGE_OFFSET) && \
-- 
2.35.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
