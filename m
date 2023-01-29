Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0C4C05027
	for <linux-um@archiver.kernel.org>; Sun, 29 Jan 2023 12:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tv4+9lMXmRImyVSrwf1T9lIWC/LUGkGuhKPa1X1ZbtY=; b=V2IpyRTXOzGq4p
	mvGgKYVbiLeY/WU7wfuAus4TAPxi3THSmGWt5AO6u/9aMscz1eNhGdy5jigBawrLrYSvlcaiGXSOH
	waXO4xW/VJywXLeXB6zVmCmW1ZOxrEQ9eW683oTAKQ+8H2isG8TUwSwq5dAITIH9tfL+/briVLWYd
	Z5rAF5qI99jrNWF3uIpAmNQz15kSwlRT+nG5b2pfH58Gzb6k8Ulx9OhtAgEur85HCAUfG+v62BfSa
	b7hzv3cm7l84amngmYYhlKb0vr2lSUw2K6p82BRsVg+rUiObj2ZaGe1vwDPRfwTY1RSvc56dSvdrX
	Z7N4qU7RGqqDtFZRgNNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pM71r-001RbR-9E; Sun, 29 Jan 2023 12:43:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pM71Z-001RTL-HQ; Sun, 29 Jan 2023 12:43:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B6AB160D3D;
	Sun, 29 Jan 2023 12:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C73C433A7;
	Sun, 29 Jan 2023 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674996188;
	bh=cgWDMwNotrvgtwLOXkxr022OhYpC4uBm5qKZZMTCdc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOlDKwso6wRfZVylh618GS0Ouplr5vx0EbZPPHD3xUb+8QoPpiFEHadR57onqorCd
	 YVV0X4T7n8gLAlDCcDoHkjHy+WzsJoiwhi5dfYlZ0/SJbhBTB4CLpq8O6xDe8ABdAj
	 ibLF/6hCOLr13VOj/azi035hOFFfeFmuDXjRvCo9nQzUAZ1DneDknyLVqg+z3u91Hb
	 JSM0yS+mjSe2REo/FRs3DbdIX7npqpWYBVELIqlPxuJWRXDIEj2eP/ud0TKhe2R7e/
	 shdVeHbLA/9GwBZjKAbCX1zbNI+chUKkqGr1E/I9bnpduDb0l68n12sXR48UTQjqrn
	 2HPElfopuZj9Q==
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
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Vineet Gupta <vgupta@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
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
Subject: [PATCH v2 1/4] arm: include asm-generic/memory_model.h from page.h rather than memory.h
Date: Sun, 29 Jan 2023 14:42:32 +0200
Message-Id: <20230129124235.209895-2-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230129124235.209895-1-rppt@kernel.org>
References: <20230129124235.209895-1-rppt@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230129_044309_680005_BF358FA6 
X-CRM114-Status: GOOD (  12.83  )
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

Makes it consistent with other architectures and allows for generic
definition of pfn_valid() in asm-generic/memory_model.h with clear override
in arch/arm/include/asm/page.h

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/arm/include/asm/memory.h | 2 --
 arch/arm/include/asm/page.h   | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index d8eef4bd8c71..62e9df024445 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -386,6 +386,4 @@ static inline unsigned long __virt_to_idmap(unsigned long x)
 
 #endif
 
-#include <asm-generic/memory_model.h>
-
 #endif
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 5fcc8a600e36..74bb5947b387 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -158,6 +158,7 @@ typedef struct page *pgtable_t;
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 extern int pfn_valid(unsigned long);
+#define pfn_valid pfn_valid
 #endif
 
 #include <asm/memory.h>
@@ -167,5 +168,6 @@ extern int pfn_valid(unsigned long);
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
 
 #include <asm-generic/getorder.h>
+#include <asm-generic/memory_model.h>
 
 #endif
-- 
2.35.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
