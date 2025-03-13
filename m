Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECC5C35FF4
	for <linux-um@archiver.kernel.org>; Thu, 13 Mar 2025 13:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U1P6C6yM63AogMuHE2GRwhThOWgbajmcPUTFZpTW0zk=; b=ZgH8weZvndG843CU/wNX4WJpdV
	dMNYqVZwFrG1TGK8eDxwDYgO7fY1XctvSJ01zw1WexUIV0KYUVCRZnIWX/d1CrlNmqH4/FQo6Qzrn
	sVu4vi708SomYBsqwPCI2UQH5um5gWV7w9BFbEmlW6tdNQoQ/rr4JrvmBh3C6ZO42C1PjlgIFdsTj
	axyTsFOwt/WPZKw/gGdn1m+KqKC6hpI2gh0T6Z4UkbU1NVIvi7x5gwJap07zR1U3yMqp4nkuDmOSm
	Hgrfk3ylrUr8R+quh0EliOfM0rxrN9ERAyeOS46avzzMebZX+cdTyJViapg+j6sWzvT80+rP1E408
	LO5H997w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsizs-0000000BRs0-3qoD;
	Thu, 13 Mar 2025 13:53:16 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsiyO-0000000BR7m-2J3z;
	Thu, 13 Mar 2025 13:51:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C8BB0A474DA;
	Thu, 13 Mar 2025 13:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A398C4CEEA;
	Thu, 13 Mar 2025 13:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873903;
	bh=uD5faVqJ7G6OTY8H5Svd8uEX7wWQ143lrl+QSf2xljc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tAvAkADl38NVbSZKILqjquMXN3H24XBk/B6I41lcVbP00o/57lseGod9pdeTReVMs
	 cGwlYVhuGgyWlrhDCI2daJ1ZuH+VeJ81cIRRK9frKmoiVueFr/N/mjUPeYtEx8wJ8T
	 nBs3CkwbMReqveisUvVZBC22mbfZgYYmTbCh29QOQKxl3NVOzvvN3jvxoRqmAwnVch
	 0ZqbY3ubQTUgmI2m+/Okv6ac4OZYKAK3inE5/1A+FzyXOEE0bOdUpCjBHuKjnqgp9K
	 6yHOo0+C4guHPMqoX35CH+VdOKq/D8Ff1oyIUB7Oo0RhP3dSOBxqfGBVfIxIiCRB+o
	 mLZqPSEOGfNGg==
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
Subject: [PATCH v2 06/13] nios2: move pr_debug() about memory start and end to setup_arch()
Date: Thu, 13 Mar 2025 15:49:56 +0200
Message-ID: <20250313135003.836600-7-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313135003.836600-1-rppt@kernel.org>
References: <20250313135003.836600-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_065144_710618_A41A08CC 
X-CRM114-Status: GOOD (  12.16  )
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


