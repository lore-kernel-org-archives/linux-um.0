Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC228C61CE5
	for <linux-um@archiver.kernel.org>; Mon,  2 Jun 2025 18:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qt+0qDW6EKkdlAhHlMyIy0ahWAGdjkmXchXoPPYqy1w=; b=lMM9JMr3MVsDMfJZzzw/Zuu7aP
	GNJh48hn2UR9RY1Jwvg2MWZd2SubznGkq6FjMJXb5KHMEz76wPG+S1jkqlFRiyZUd6hQaanDBWXxa
	cpHE96xBfw1NG3kMM1zJEdX/cd200bVQENESu86RNaFQgvTmcE18DXEwFz2kY+Qr3qm+iWX3TlA5R
	ivxRWIl64McXeMne1i43s2p0hMni0d27DWUABlsvruRVcDdXo9DVC9JxGqYS/+KsfKsI62Qf264hi
	+E5Bd8vpJoROTZ9MaBp6tAYPrExBPkqzz4tMv9jl3Yft5Nm1n3pqXv+IAwl6cae7Q9m5aRv0+JbO/
	hldh+05Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM9ey-00000008E3b-1l5P;
	Mon, 02 Jun 2025 18:13:20 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM9eu-00000008Dzn-2HpX;
	Mon, 02 Jun 2025 18:13:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6D8B0A5039F;
	Mon,  2 Jun 2025 18:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE857C4AF09;
	Mon,  2 Jun 2025 18:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748887995;
	bh=qa8AH5yyfN8ivCtH6KKbi6UjJPoeSHgACfvx6p82UVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZO0XGW5lLK29yuyQZLKbuTypO2yfiYLAXvTsMKfnOxyqa4WDKkEHhfMJJ32sfLEos
	 DOeLzEnkkke0Wq5C4YoX2/jZu6moJANqPLz69FVX7r3tAHs00Oav+icyQFKU4yz31A
	 hsNWbFIPLueyYmwueGhnoBxCd++gZFKL53bgn5p8xjCcS5AUwfR7UnE8rJFcBTU6Fn
	 F05mRWCFBYs9CRS71Q2IcDcIk5NLmyVNTQmkQrxDw0g2evWhhIMvRlhrES6h2bnCOz
	 o1yoxPs0siFs4nmCCsV63K5LBV8qAHR8pX6ddAclgCQbjlF2Rm1QE69mW2bzvdvNbp
	 a3xbz3896LL1g==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andreas Larsson <andreas@gaisler.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chris Zankel <chris@zankel.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonas Bonn <jonas@southpole.se>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rich Felker <dalias@libc.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 2/2] arch: use always-$(KBUILD_BUILTIN) for vmlinux.lds
Date: Tue,  3 Jun 2025 03:12:54 +0900
Message-ID: <20250602181256.529033-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602181256.529033-1-masahiroy@kernel.org>
References: <20250602181256.529033-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_111316_706273_34AC8F62 
X-CRM114-Status: GOOD (  12.07  )
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

The extra-y syntax is deprecated. Instead, use always-$(KBUILD_BUILTIN),
which behaves equivalently.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/alpha/kernel/Makefile      | 2 +-
 arch/arc/kernel/Makefile        | 2 +-
 arch/arm/kernel/Makefile        | 2 +-
 arch/arm64/kernel/Makefile      | 2 +-
 arch/csky/kernel/Makefile       | 2 +-
 arch/hexagon/kernel/Makefile    | 2 +-
 arch/loongarch/kernel/Makefile  | 2 +-
 arch/m68k/kernel/Makefile       | 2 +-
 arch/microblaze/kernel/Makefile | 2 +-
 arch/mips/kernel/Makefile       | 2 +-
 arch/nios2/kernel/Makefile      | 2 +-
 arch/openrisc/kernel/Makefile   | 2 +-
 arch/parisc/kernel/Makefile     | 2 +-
 arch/powerpc/kernel/Makefile    | 2 +-
 arch/riscv/kernel/Makefile      | 2 +-
 arch/s390/kernel/Makefile       | 2 +-
 arch/sh/kernel/Makefile         | 2 +-
 arch/sparc/kernel/Makefile      | 2 +-
 arch/um/kernel/Makefile         | 2 +-
 arch/x86/kernel/Makefile        | 2 +-
 arch/xtensa/kernel/Makefile     | 2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index b6c862dff1f6..187cd8df2faf 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y		:= vmlinux.lds
+always-$(KBUILD_BUILTIN)	:= vmlinux.lds
 asflags-y	:= $(KBUILD_CFLAGS)
 ccflags-y	:= -Wno-sign-compare
 
diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
index 95fbf9364c67..fa94fff02419 100644
--- a/arch/arc/kernel/Makefile
+++ b/arch/arc/kernel/Makefile
@@ -26,4 +26,4 @@ ifdef CONFIG_ISA_ARCOMPACT
 CFLAGS_fpu.o   += -mdpfp
 endif
 
-extra-y := vmlinux.lds
+always-$(KBUILD_BUILTIN) := vmlinux.lds
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index b3333d070390..afc9de7ef9a1 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -104,4 +104,4 @@ obj-$(CONFIG_HAVE_ARM_SMCCC)	+= smccc-call.o
 
 obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) += spectre.o
 
-extra-y := vmlinux.lds
+always-$(KBUILD_BUILTIN) := vmlinux.lds
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 71c29a2a2f19..2920b0a51403 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -78,7 +78,7 @@ $(obj)/vdso32-wrap.o: $(obj)/vdso32/vdso.so
 
 obj-y					+= probes/
 obj-y					+= head.o
-extra-y					+= vmlinux.lds
+always-$(KBUILD_BUILTIN)		+= vmlinux.lds
 
 ifeq ($(CONFIG_DEBUG_EFI),y)
 AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index de1c3472e8f0..a406a4ac2378 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-extra-y := vmlinux.lds
+always-$(KBUILD_BUILTIN) := vmlinux.lds
 
 obj-y += head.o entry.o atomic.o signal.o traps.o irq.o time.o vdso.o vdso/
 obj-y += power.o syscall.o syscall_table.o setup.o
diff --git a/arch/hexagon/kernel/Makefile b/arch/hexagon/kernel/Makefile
index 3fdf937eb572..8e0fb4a62315 100644
--- a/arch/hexagon/kernel/Makefile
+++ b/arch/hexagon/kernel/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-extra-y := vmlinux.lds
+always-$(KBUILD_BUILTIN) := vmlinux.lds
 
 obj-y += head.o
 obj-$(CONFIG_SMP) += smp.o
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index f9dcaa60033d..6f5a4574a911 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -5,7 +5,7 @@
 
 OBJECT_FILES_NON_STANDARD_head.o := y
 
-extra-y		:= vmlinux.lds
+always-$(KBUILD_BUILTIN)	:= vmlinux.lds
 
 obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
 		   traps.o irq.o idle.o process.o dma.o mem.o reset.o switch.o \
diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index 6c732ed3998b..57c1b3e8d60e 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y			+= vmlinux.lds
+always-$(KBUILD_BUILTIN)	+= vmlinux.lds
 
 obj-$(CONFIG_MMU_MOTOROLA)	:= head.o
 obj-$(CONFIG_SUN3)		:= sun3-head.o
diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index 85c4d29ef43e..241e466e7333 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -11,7 +11,7 @@ CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_process.o = -pg
 endif
 
-extra-y := vmlinux.lds
+always-$(KBUILD_BUILTIN) := vmlinux.lds
 
 obj-y += head.o dma.o exceptions.o \
 	hw_exception_handler.o irq.o \
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index ecf3278a32f7..95a1e674fd67 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the Linux/MIPS kernel.
 #
 
-extra-y		:= vmlinux.lds
+always-$(KBUILD_BUILTIN)	:= vmlinux.lds
 
 obj-y		+= head.o branch.o cmpxchg.o elf.o entry.o genex.o idle.o irq.o \
 		   process.o prom.o ptrace.o reset.o setup.o signal.o \
diff --git a/arch/nios2/kernel/Makefile b/arch/nios2/kernel/Makefile
index 78a913181fa1..4dce965a7b73 100644
--- a/arch/nios2/kernel/Makefile
+++ b/arch/nios2/kernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the nios2 linux kernel.
 #
 
-extra-y	+= vmlinux.lds
+always-$(KBUILD_BUILTIN)	+= vmlinux.lds
 
 obj-y	+= head.o
 obj-y	+= cpuinfo.o
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index e4c7d9bdd598..58e6a1b525b7 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y	:= vmlinux.lds
+always-$(KBUILD_BUILTIN)	:= vmlinux.lds
 
 obj-y	:= head.o setup.o or32_ksyms.o process.o dma.o \
 	   traps.o time.o irq.o entry.o ptrace.o signal.o \
diff --git a/arch/parisc/kernel/Makefile b/arch/parisc/kernel/Makefile
index 5ab0467be70a..d5055ba33722 100644
--- a/arch/parisc/kernel/Makefile
+++ b/arch/parisc/kernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for arch/parisc/kernel
 #
 
-extra-y		:= vmlinux.lds
+always-$(KBUILD_BUILTIN)		:= vmlinux.lds
 
 obj-y		:= head.o cache.o pacache.o setup.o pdt.o traps.o time.o irq.o \
 		   syscall.o entry.o sys_parisc.o firmware.o \
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index db367fee08b2..ac01cedad107 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -126,7 +126,7 @@ obj-$(CONFIG_PPC_BOOK3S_32)	+= head_book3s_32.o
 obj-$(CONFIG_44x)		+= head_44x.o
 obj-$(CONFIG_PPC_8xx)		+= head_8xx.o
 obj-$(CONFIG_PPC_85xx)		+= head_85xx.o
-extra-y				+= vmlinux.lds
+always-$(KBUILD_BUILTIN)	+= vmlinux.lds
 
 obj-$(CONFIG_RELOCATABLE)	+= reloc_$(BITS).o
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f7480c9c6f8d..48dcaf2efae8 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -43,7 +43,7 @@ CFLAGS_sbi_ecall.o += -D__NO_FORTIFY
 endif
 endif
 
-extra-y += vmlinux.lds
+always-$(KBUILD_BUILTIN) += vmlinux.lds
 
 obj-y	+= head.o
 obj-y	+= soc.o
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index db5f3a3faefb..ea5ed6654050 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -46,7 +46,7 @@ obj-y	+= nospec-branch.o ipl_vmparm.o machine_kexec_reloc.o unwind_bc.o
 obj-y	+= smp.o text_amode31.o stacktrace.o abs_lowcore.o facility.o uv.o wti.o
 obj-y	+= diag/
 
-extra-y				+= vmlinux.lds
+always-$(KBUILD_BUILTIN)	+= vmlinux.lds
 
 obj-$(CONFIG_SYSFS)		+= nospec-sysfs.o
 CFLAGS_REMOVE_nospec-branch.o	+= $(CC_FLAGS_EXPOLINE)
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index 7b453592adaf..5ef123bc63f8 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the Linux/SuperH kernel.
 #
 
-extra-y	:= vmlinux.lds
+always-$(KBUILD_BUILTIN)	:= vmlinux.lds
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 58ea4ef9b622..2859842d6bb7 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -9,7 +9,7 @@ asflags-y := -ansi
 # Undefine sparc when processing vmlinux.lds - it is used
 # And teach CPP we are doing $(BITS) builds (for this case)
 CPPFLAGS_vmlinux.lds := -Usparc -m$(BITS)
-extra-y              += vmlinux.lds
+always-$(KBUILD_BUILTIN) += vmlinux.lds
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 4df1cd0d2017..821bf4027a23 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -12,7 +12,7 @@ CPPFLAGS_vmlinux.lds := -DSTART=$(LDS_START)		\
                         -DELF_ARCH=$(LDS_ELF_ARCH)	\
                         -DELF_FORMAT=$(LDS_ELF_FORMAT)	\
 			$(LDS_EXTRA)
-extra-y := vmlinux.lds
+always-$(KBUILD_BUILTIN) := vmlinux.lds
 
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 84cfa179802c..9a30c9816b16 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y	+= vmlinux.lds
+always-$(KBUILD_BUILTIN)	+= vmlinux.lds
 
 CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
 
diff --git a/arch/xtensa/kernel/Makefile b/arch/xtensa/kernel/Makefile
index f28b8e3d717e..d3ef0407401f 100644
--- a/arch/xtensa/kernel/Makefile
+++ b/arch/xtensa/kernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the Linux/Xtensa kernel.
 #
 
-extra-y := vmlinux.lds
+always-$(KBUILD_BUILTIN) := vmlinux.lds
 
 obj-y := head.o align.o coprocessor.o entry.o irq.o platform.o process.o \
 	 ptrace.o setup.o signal.o stacktrace.o syscall.o time.o traps.o \
-- 
2.43.0


