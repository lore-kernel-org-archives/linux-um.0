Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C13FC7EE2C
	for <linux-um@archiver.kernel.org>; Sat, 29 Apr 2023 06:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fwKEZI+E8tP76FRjb2BNYMARaGCeoQk7pa+chaG0hw0=; b=47x/PX8mR+m9PY
	dwW6s7gbRbal9JkdffNdqcuBZ/jz/E3QMq35nWDLfhUcH659Yy/3gWglJfvlFCzRgmvTAPp87bfmN
	SDkyb1PDoq+Me1s51YMmgsc7am7MPf+44Bj0pp4rmvkoudLP9kd7Yan89E/3Dqfhrt70IKX5JUZhD
	IP0WyeuQDB2wvIKtSwkWDOjAODZqvpKupApJiUm6F/D5YrBSPN7XXXPdtpZ3FLGCxAZ5tAq8wc8YE
	1M8vqYCFYzdjNtCT/QPT37VPnCLb3hJjv1WSOSSRNaYl3rAGQ+iQZ/TYMDaPvWR0CDS04wXi8swVM
	mCe9+LCQVQszLPupb3dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pse9x-00CK9X-08;
	Sat, 29 Apr 2023 06:34:17 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pse9s-00CK8Y-2m;
	Sat, 29 Apr 2023 06:34:14 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a69f686345so5691535ad.2;
        Fri, 28 Apr 2023 23:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682750049; x=1685342049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSfv5t4C9cwppYox3U6KqaeYRJrwwcdMCKh0TKYZTfY=;
        b=jgX+OXrrHnH45akqNjdlWaQFYstsdbpondQ+fh3Msi1/HhjpsmZdFC+yLXih7hP/pU
         wgdNac4fjcTdjuh5YzDwrfXcFY7nTNG7NTG9OKleR4+VqZlwQQ+dJnUPCKUlMotuGhtK
         liEvH+GopRM8uHPlGBNbhx8erNYSKJLuBi7f6XaVH16Z1cWL+j0LVG8QPiLpBIa6TEeI
         zTS1Ra3qCsaeMXU1RmMnIP9HaQN5+5m2TcVeWF6195N9W4Nk/IP8if39MUVzKA4I+Dwp
         Z2dkFPBFVLF+hUJPQOTD2SFsOLbcA622JvdIeH4gIN3JC30Fskg+YIN5y8gJoIVRkgR5
         I3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682750049; x=1685342049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSfv5t4C9cwppYox3U6KqaeYRJrwwcdMCKh0TKYZTfY=;
        b=Okh6g1wQjvKR/WrSFClXa0SgIwiTMlt9zNp68vxXxOC+T7G11FwM9j5M56dC+gJcc/
         cxyk6X1/I+xwFW3yvlq7ya4HF5gn3gRDSK+Yrxsow6J07fHTOBfR2KJELXHsP2l9WLjG
         STX7G9AHkkMeI7a85LBu17tP6wMTCka7QoQNwkjQgvYkLJ1lf2xFntFCW5m9w2+xwFWp
         d01xDUXKBWYHQjf/Yrz8Lky9N6mIXpk7FiOk7ydZIOiNGAE+GnHaEONoelBIFoeD3oKI
         CtCO7F5XW744Qq4sUiBcgu3zAtmEK8V20o9VcAVqH04uo4bGEhT/vk2dI2V7OrgwdYxX
         uNFg==
X-Gm-Message-State: AC+VfDw75a/qGlyuuPx5ElklE1EduP3ZNcs4UJMz4gU80Pm6Xx7g9zvG
	XhqTSfaGCGZURg6IPWJDZtY=
X-Google-Smtp-Source: ACHHUZ7be5oOxy4XCSWaxNypq0CFCL78WwmFg5MLeuSZBRyfSzU6QkTnWKQW9hhiXBkCoxg5Uid8wg==
X-Received: by 2002:a17:903:2798:b0:1a9:7262:fe55 with SMTP id jw24-20020a170903279800b001a97262fe55mr7208130plb.13.1682750049387;
        Fri, 28 Apr 2023 23:34:09 -0700 (PDT)
Received: from wheely.local0.net (14-202-4-83.tpgi.com.au. [14.202.4.83])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902748a00b001a258041049sm14142470pll.32.2023.04.28.23.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 23:34:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org,
	Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	linux-openrisc@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] Remove HAVE_VIRT_CPU_ACCOUNTING_GEN option
Date: Sat, 29 Apr 2023 16:33:48 +1000
Message-Id: <20230429063348.125544-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_233412_903838_F12A64E5 
X-CRM114-Status: GOOD (  15.89  )
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

This option was created in commit 554b0004d0ec4 ("vtime: Add
HAVE_VIRT_CPU_ACCOUNTING_GEN Kconfig") for architectures to indicate
they support the 64-bit cputime_t required for VIRT_CPU_ACCOUNTING_GEN.

The cputime_t type has since been removed, so this doesn't have any
meaning. Remove it.

Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
Cc: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: Michal Simek <monstr@monstr.eu>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: linux-openrisc@vger.kernel.org
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Hi,

Could we tidy this? I don't know what tree it can go in, timers,
sched, asm-generic, probably doesn't matter.

The only thing this actually does is gate VIRT_CPU_ACCOUNTING_GEN and
NO_HZ_FULL so if your arch has some other issue that requires this
then the documentation needs to change. Any concerns from the archs?
I.e., 32-bit that does *not* define HAVE_VIRT_CPU_ACCOUNTING_GEN
which looks to be:

arc
hexagon
loongarch 32-bit with SMP
m68k
microblaze
mips 32-bit with SMP
nios2
openrisc
parisc 32-bit
riscv 32-bit
sh
sparc 32-bit
um 32-bit
x86 32-bit

Thanks,
Nick
--
 arch/Kconfig           | 11 -----------
 arch/arm/Kconfig       |  1 -
 arch/csky/Kconfig      |  1 -
 arch/loongarch/Kconfig |  1 -
 arch/mips/Kconfig      |  1 -
 arch/powerpc/Kconfig   |  1 -
 arch/xtensa/Kconfig    |  1 -
 init/Kconfig           |  1 -
 kernel/time/Kconfig    |  2 --
 9 files changed, 20 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 205fd23e0cad..b77b41d25e40 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -869,17 +869,6 @@ config HAVE_VIRT_CPU_ACCOUNTING_IDLE
 config ARCH_HAS_SCALED_CPUTIME
 	bool
 
-config HAVE_VIRT_CPU_ACCOUNTING_GEN
-	bool
-	default y if 64BIT
-	help
-	  With VIRT_CPU_ACCOUNTING_GEN, cputime_t becomes 64-bit.
-	  Before enabling this option, arch code must be audited
-	  to ensure there are no races in concurrent read/write of
-	  cputime_t. For example, reading/writing 64-bit cputime_t on
-	  some 32-bit arches may require multiple accesses, so proper
-	  locking is needed to protect against concurrent accesses.
-
 config HAVE_IRQ_TIME_ACCOUNTING
 	bool
 	help
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0fb4b218f665..9c05f25db4e4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -123,7 +123,6 @@ config ARM
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 00379a843c37..dd1decc2a22d 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -73,7 +73,6 @@ config CSKY
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_CONTEXT_TRACKING_USER
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DYNAMIC_FTRACE
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f44f6ea54e46..7dc71c89bfae 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -122,7 +122,6 @@ config LOONGARCH
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_TIF_NOHZ
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
 	select IRQ_FORCED_THREADING
 	select IRQ_LOONGARCH_CPU
 	select MMU_GATHER_MERGE_VMAS if MMU
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c2f5498d207f..d84cb8bbee53 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -87,7 +87,6 @@ config MIPS
 	select HAVE_SPARSE_SYSCALL_NR
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
 	select IRQ_FORCED_THREADING
 	select ISA if EISA
 	select MODULES_USE_ELF_REL if MODULES
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index acffffbd5d77..185195f349d9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -271,7 +271,6 @@ config PPC
 	select HAVE_STATIC_CALL			if PPC32
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select HUGETLB_PAGE_SIZE_VARIABLE	if PPC_BOOK3S_64 && HUGETLB_PAGE
 	select IOMMU_HELPER			if PPC64
 	select IRQ_DOMAIN
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 3c6e5471f025..04f1399d9ce8 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -47,7 +47,6 @@ config XTENSA
 	select HAVE_PERF_EVENTS
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select PERF_USE_VMALLOC
diff --git a/init/Kconfig b/init/Kconfig
index 32c24950c4ce..835fb5e78a8f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -504,7 +504,6 @@ config VIRT_CPU_ACCOUNTING_NATIVE
 config VIRT_CPU_ACCOUNTING_GEN
 	bool "Full dynticks CPU time accounting"
 	depends on HAVE_CONTEXT_TRACKING_USER
-	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	depends on GENERIC_CLOCKEVENTS
 	select VIRT_CPU_ACCOUNTING
 	select CONTEXT_TRACKING_USER
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index bae8f11070be..d4325dae1f03 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -121,8 +121,6 @@ config NO_HZ_FULL
 	# We need at least one periodic CPU for timekeeping
 	depends on SMP
 	depends on HAVE_CONTEXT_TRACKING_USER
-	# VIRT_CPU_ACCOUNTING_GEN dependency
-	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select NO_HZ_COMMON
 	select RCU_NOCB_CPU
 	select VIRT_CPU_ACCOUNTING_GEN
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
