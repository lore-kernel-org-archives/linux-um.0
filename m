Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CFBC28B24
	for <linux-um@archiver.kernel.org>; Thu,  6 Mar 2025 20:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U1P6C6yM63AogMuHE2GRwhThOWgbajmcPUTFZpTW0zk=; b=ZsP4mlx5hMCMKj93a7VNGi+sQG
	1+STMKnACnP069cWyi5T6nM5rIEQu73s5nRnagTEeINubEySQi8br8MB8uLOVYXgF0dzG87z+FM8r
	fgnmSMRg/ZuHXs9Av9EOqxYhhi8cHb1cXOziByAF/XgqRe0uDOgZpnMB+oolg53dQVAX1NyN3gamh
	+V8LNwXnp112sqXo+SiJujdQYd3rUuf9QXWu3WJHMp7pwF1eBXnKPTwixB0nEwIC/M9qF6lXKmH9I
	0PxiA/eckyD4X2hJZOp1Y5lifSLcJisLpuY02nzORCgQLAqemVyBNzOHyHRmw8OwOTAZbGj8su4Vz
	7P8fl/wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqHRq-0000000C52C-42gz;
	Thu, 06 Mar 2025 20:04:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqGLF-0000000BvPb-0RVB;
	Thu, 06 Mar 2025 18:53:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=U1P6C6yM63AogMuHE2GRwhThOWgbajmcPUTFZpTW0zk=; b=NguLlyMgZgV76yTEKV/EB0qkZG
	qmiymsCoQ4Z3x0aBQbxke+9a2kKJngeGdsWu0d/8eg9XJMN+70Kk8bcdUt7UnuzlYB5MiFKMsnP4n
	fNrHKtIqfz1EcskfKiwZCvtUp8IP3DrYaDrWcurnBzk5qtpxzamRWJ2HyQlf8Mw0pnVNxgXvoYeZe
	JgcMghx6ZOe/7Z4PlYQ+g6VuuRn3O6CdZu2dtNsQcDy+WmBGvr4u9jc6vzR4BKgEgx/os2pHDxQrH
	1r4vxbPDlofp/DNL1WfngE2/bCGPjFR1tyite6E8lxFKueU4TXMQFJn9zEToIaxV+ZreNolQjtE2+
	ZpiAKILw==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqGLC-00000001CjZ-0I2H;
	Thu, 06 Mar 2025 18:53:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 867595C58B7;
	Thu,  6 Mar 2025 18:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFD1C4CEEB;
	Thu,  6 Mar 2025 18:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741287184;
	bh=uD5faVqJ7G6OTY8H5Svd8uEX7wWQ143lrl+QSf2xljc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Giroq7hT2g3vsvEZ2g+QDA6pleXlCgJ831y/Fi3Wjhg80Qvyzg+4WeJi56qeahcuZ
	 BnB/BJAkrOWMctvhyQiwDEOKAODheMIY8JlcVpXK5m/bif8P0mWEql2C7GcEAP8YDq
	 y5I3KMdkU9l7AIEqGFvXGvfoPMAU64jJ7mxxyGtY4aMTIFjIzONPRhlRs09lt/nZQC
	 Dfy3fEyUNo74jl61ggLHzXPiXbsdY95YwK3QPmGVyWMPsISrjHbonWwydEU9fwsHjj
	 Cokp3+w/v07caKL3v7HrEl6YuLcjwgCcPlwVGGWzrWhcdLmjUmXtBEydZY3rL4XdE2
	 sLgtFWbfjejNg==
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
Subject: [PATCH 06/13] nios2: move pr_debug() about memory start and end to setup_arch()
Date: Thu,  6 Mar 2025 20:51:16 +0200
Message-ID: <20250306185124.3147510-7-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306185124.3147510-1-rppt@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_185306_421106_E2B6C180 
X-CRM114-Status: GOOD (  11.70  )
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

This will help with pulling out memblock_free_all() to the generic
code and reducing code duplication in arch::mem_init().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/nios2/kernel/setup.c | 2 ++
 arch/nios2/mm/init.c      | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index da122a5fa43b..a4cffbfc1399 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -149,6 +149,8 @@ void __init setup_arch(char **cmdline_p)
 	memory_start = memblock_start_of_DRAM();
 	memory_end = memblock_end_of_DRAM();
 
+	pr_debug("%s: start=%lx, end=%lx\n", __func__, memory_start, memory_end);
+
 	setup_initial_init_mm(_stext, _etext, _edata, _end);
 	init_task.thread.kregs = &fake_regs;
 
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index a2278485de19..aa692ad30044 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -65,8 +65,6 @@ void __init mem_init(void)
 	unsigned long end_mem   = memory_end; /* this must not include
 						kernel stack at top */
 
-	pr_debug("mem_init: start=%lx, end=%lx\n", memory_start, memory_end);
-
 	end_mem &= PAGE_MASK;
 	high_memory = __va(end_mem);
 
-- 
2.47.2


