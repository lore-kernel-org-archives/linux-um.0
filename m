Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21FBFD45F1
	for <linux-um@archiver.kernel.org>; Wed, 25 Feb 2026 22:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X5Uei7J6wPTaufFZfJ1QY+msf1MQQfu8WvoFcRNTGHw=; b=0KUKYyt6yzj4i4tHvVnnb1DvBB
	IH+s1My4HpoVW1uC0Cu0ad5HFu0pLA+B1GPibwn4qK8HMki0lGO5x7fV6NJd6MFDqdUGhWaBaaeVK
	fC7hRhFgxE3/CRRE7QtaxsZ8DWZISo6gKyAfF5rnaNK/CDvE53U+YQCPkieQNGOrbSksTIT5f9YxK
	Dd+Atisih0VOON++pvKi5YKLtik+LiPBv/uhNz6nsgG2uHfrwTF/g1zwHYCqJdR36QfoGPYzLLQgW
	9nFsEnhG4KMLaqChBjpLIsHFsreEHduqa5oaOIUoy7sEDaeudHZD+bP1LZZyCfyxvCbaUXdhkPLQs
	IoZN2vNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvMyR-00000004y4R-3DCl;
	Wed, 25 Feb 2026 22:03:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvMyP-00000004y3x-1yeU;
	Wed, 25 Feb 2026 22:03:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B41C60053;
	Wed, 25 Feb 2026 22:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71333C116D0;
	Wed, 25 Feb 2026 22:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772056991;
	bh=gYzWYbqUVyUWAs9EGE5ShllXabtNZu/2sUv3FCUuj7w=;
	h=From:Date:Subject:To:Cc:From;
	b=Lh2Gp07eMCKl2XdNkedsqAZVkfBDWlOl2fsRxHEWE9tKv6jQh0edVVUsxDh6W5Xp/
	 cpuHLuvKro/8fpHAIcfb6xh/0YkDcRPPmsCi3vH9hoM2N/cp4Zu293fjw8x0Y3sBRt
	 xrryrjjtuF0G+GfHoJWSUPrL9Ub+h33d7ZDtN9xF5vWiBWN/Dqwh64X9F4ye8SQCek
	 kzV0xNeQjeGNvdSYha+gv6+Zs0BqrJ4PL5GFW9IS3v5kg8ppoQ0ELPzksn51X2e+bF
	 DsAPQYsTPAgDK9wa/O/d5HZiuyl/GUUOQtp0CrrKYMUtc7XQZ+nQdyI2fcEiQZeqbq
	 KLkKqVrgOPu2w==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 25 Feb 2026 15:02:51 -0700
Subject: [PATCH] kbuild: Split .modinfo out from ELF_DETAILS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-separate-modinfo-from-elf-details-v1-1-387ced6baf4b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQrCMAyA4VcZORvoOh3MVxEPcUk1srWj6UQYe
 3erHr/L/29gklUMzs0GWV5qmmJFe2hgfFC8CypXg3e+d94f0WShTEVwTqwxJAw5zShTQJZCOhl
 y1/aO6RS6YYDaWbIEff8el+vftt6eMpZvGPb9A+qYJnaFAAAA
X-Change-ID: 20260224-separate-modinfo-from-elf-details-d3160da5f399
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Vineet Gupta <vgupta@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Sam Creasey <sammy@sammy.net>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Masahiro Yamada <masahiroy@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org, 
 stable@vger.kernel.org, Ed W <lists@wildgooses.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11544; i=nathan@kernel.org;
 h=from:subject:message-id; bh=gYzWYbqUVyUWAs9EGE5ShllXabtNZu/2sUv3FCUuj7w=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJnzCyeriCZdaxI+5Sf0rTM57l6D0sWGw+sO7C6JuqWuV
 lv08cGpjhIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjAR9SKG75EsPLMZNsz8+2PX
 foVJdy5bdNqZ6l3jFRDMuD/jsMiKLoa/Andbtyi/Z/w0p6XQ5urDDXN8jKJenk+u2/pZubeWW6q
 QDwA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
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

Commit 3e86e4d74c04 ("kbuild: keep .modinfo section in
vmlinux.unstripped") added .modinfo to ELF_DETAILS while removing it
from DISCARDS, as it was needed in vmlinux.unstripped and ELF_DETAILS
was present in all architecture specific vmlinux linker scripts. While
this shuffle is fine for vmlinux, ELF_DETAILS and DISCARDS may be used
by other linker scripts, such as the s390 and x86 compressed boot
images, which may not expect to have a modinfo section. In certain
circumstances, this could result in a bootloader failing to load the
compressed kernel [1].

Commit ddc6cbef3ef1 ("s390/boot/vmlinux.lds.S: Ensure bzImage ends with
SecureBoot trailer") recently addressed this for the s390 bzImage but
the same bug remains for parisc and x86. The presence of .modinfo in the
x86 bzImage was the root cause of the issue workad around with
commit d50f21091358 ("kbuild: align modinfo section for Secureboot
Authenticode EDK2 compat"). misc.c in arch/x86/boot/compressed includes
lib/decompress_unzstd.c, which in turn includes lib/xxhash.c and its
MODULE_LICENSE / MODULE_DESCRIPTION macros due to the STATIC definition.

Split .modinfo out from ELF_DETAILS into its own macro and handle it in
all vmlinux linker scripts. Discard .modinfo in the places where it was
previously being discarded from being in DISCARDS, as it has never been
necessary in those uses.

Cc: stable@vger.kernel.org
Fixes: 3e86e4d74c04 ("kbuild: keep .modinfo section in vmlinux.unstripped")
Reported-by: Ed W <lists@wildgooses.com>
Closes: https://lore.kernel.org/587f25e0-a80e-46a5-9f01-87cb40cfa377@wildgooses.com/ [1]
Tested-by: Ed W <lists@wildgooses.com> # x86_64
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I intend to take this as a fix via the Kbuild tree for 7.0 after
sufficient testing in -next, please Ack accordingly.
---
 arch/alpha/kernel/vmlinux.lds.S           | 1 +
 arch/arc/kernel/vmlinux.lds.S             | 1 +
 arch/arm64/kernel/vmlinux.lds.S           | 1 +
 arch/csky/kernel/vmlinux.lds.S            | 1 +
 arch/hexagon/kernel/vmlinux.lds.S         | 1 +
 arch/loongarch/kernel/vmlinux.lds.S       | 1 +
 arch/m68k/kernel/vmlinux-nommu.lds        | 1 +
 arch/m68k/kernel/vmlinux-std.lds          | 1 +
 arch/m68k/kernel/vmlinux-sun3.lds         | 1 +
 arch/mips/kernel/vmlinux.lds.S            | 1 +
 arch/nios2/kernel/vmlinux.lds.S           | 1 +
 arch/openrisc/kernel/vmlinux.lds.S        | 1 +
 arch/parisc/boot/compressed/vmlinux.lds.S | 1 +
 arch/parisc/kernel/vmlinux.lds.S          | 1 +
 arch/powerpc/kernel/vmlinux.lds.S         | 1 +
 arch/riscv/kernel/vmlinux.lds.S           | 1 +
 arch/s390/kernel/vmlinux.lds.S            | 1 +
 arch/sh/kernel/vmlinux.lds.S              | 1 +
 arch/sparc/kernel/vmlinux.lds.S           | 1 +
 arch/um/kernel/dyn.lds.S                  | 1 +
 arch/um/kernel/uml.lds.S                  | 1 +
 arch/x86/boot/compressed/vmlinux.lds.S    | 2 +-
 arch/x86/kernel/vmlinux.lds.S             | 1 +
 include/asm-generic/vmlinux.lds.h         | 4 +++-
 24 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/vmlinux.lds.S b/arch/alpha/kernel/vmlinux.lds.S
index 2efa7dfc798a..2d136c63db16 100644
--- a/arch/alpha/kernel/vmlinux.lds.S
+++ b/arch/alpha/kernel/vmlinux.lds.S
@@ -71,6 +71,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	MODINFO
 	ELF_DETAILS
 
 	DISCARDS
diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
index 61a1b2b96e1d..6af63084ff28 100644
--- a/arch/arc/kernel/vmlinux.lds.S
+++ b/arch/arc/kernel/vmlinux.lds.S
@@ -123,6 +123,7 @@ SECTIONS
 	_end = . ;
 
 	STABS_DEBUG
+	MODINFO
 	ELF_DETAILS
 	DISCARDS
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index ad6133b89e7a..2964aad0362e 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -349,6 +349,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	MODINFO
 	ELF_DETAILS
 
 	HEAD_SYMBOLS
diff --git a/arch/csky/kernel/vmlinux.lds.S b/arch/csky/kernel/vmlinux.lds.S
index d718961786d2..81943981b3af 100644
--- a/arch/csky/kernel/vmlinux.lds.S
+++ b/arch/csky/kernel/vmlinux.lds.S
@@ -109,6 +109,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	MODINFO
 	ELF_DETAILS
 
 	DISCARDS
diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
index 1150b77fa281..aae22283b5e0 100644
--- a/arch/hexagon/kernel/vmlinux.lds.S
+++ b/arch/hexagon/kernel/vmlinux.lds.S
@@ -62,6 +62,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	MODINFO
 	ELF_DETAILS
 	.hexagon.attributes 0 : { *(.hexagon.attributes) }
 
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index 08ea921cdec1..d0e1377a041d 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -147,6 +147,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	MODINFO
 	ELF_DETAILS
 
 #ifdef CONFIG_EFI_STUB
diff --git a/arch/m68k/kernel/vmlinux-nommu.lds b/arch/m68k/kernel/vmlinux-nommu.lds
index 2624fc18c131..45d7f4b0177b 100644
--- a/arch/m68k/kernel/vmlinux-nommu.lds
+++ b/arch/m68k/kernel/vmlinux-nommu.lds
@@ -85,6 +85,7 @@ SECTIONS {
 	_end = .;
 
 	STABS_DEBUG
+	MODINFO
 	ELF_DETAILS
 
 	/* Sections to be discarded */
diff --git a/arch/m68k/kernel/vmlinux-std.lds b/arch/m68k/kernel/vmlinux-std.lds
index 1ccdd04ae462..7326586afe15 100644
--- a/arch/m68k/kernel/vmlinux-std.lds
+++ b/arch/m68k/kernel/vmlinux-std.lds
@@ -58,6 +58,7 @@ SECTIONS
   _end = . ;
 
   STABS_DEBUG
+  MODINFO
   ELF_DETAILS
 
   /* Sections to be discarded */
diff --git a/arch/m68k/kernel/vmlinux-sun3.lds b/arch/m68k/kernel/vmlinux-sun3.lds
index f13ddcc2af5c..1b19fef201fb 100644
--- a/arch/m68k/kernel/vmlinux-sun3.lds
+++ b/arch/m68k/kernel/vmlinux-sun3.lds
@@ -51,6 +51,7 @@ __init_begin = .;
   _end = . ;
 
   STABS_DEBUG
+  MODINFO
   ELF_DETAILS
 
   /* Sections to be discarded */
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 2b708fac8d2c..579b2cc1995a 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -217,6 +217,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	MODINFO
 	ELF_DETAILS
 
 	/* These must appear regardless of  .  */
diff --git a/arch/nios2/kernel/vmlinux.lds.S b/arch/nios2/kernel/vmlinux.lds.S
index 37b958055064..206f92445bfa 100644
--- a/arch/nios2/kernel/vmlinux.lds.S
+++ b/arch/nios2/kernel/vmlinux.lds.S
@@ -57,6 +57,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	MODINFO
 	ELF_DETAILS
 
 	DISCARDS
diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
index 049bff45f612..9b29c3211774 100644
--- a/arch/openrisc/kernel/vmlinux.lds.S
+++ b/arch/openrisc/kernel/vmlinux.lds.S
@@ -101,6 +101,7 @@ SECTIONS
 	/* Throw in the debugging sections */
 	STABS_DEBUG
 	DWARF_DEBUG
+	MODINFO
 	ELF_DETAILS
 
         /* Sections to be discarded -- must be last */
diff --git a/arch/parisc/boot/compressed/vmlinux.lds.S b/arch/parisc/boot/compressed/vmlinux.lds.S
index ab7b43990857..87d24cc824b6 100644
--- a/arch/parisc/boot/compressed/vmlinux.lds.S
+++ b/arch/parisc/boot/compressed/vmlinux.lds.S
@@ -90,6 +90,7 @@ SECTIONS
 	/* Sections to be discarded */
 	DISCARDS
 	/DISCARD/ : {
+		*(.modinfo)
 #ifdef CONFIG_64BIT
 		/* temporary hack until binutils is fixed to not emit these
 		 * for static binaries
diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlinux.lds.S
index b445e47903cf..0ca93d6d7235 100644
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -165,6 +165,7 @@ SECTIONS
 	_end = . ;
 
 	STABS_DEBUG
+	MODINFO
 	ELF_DETAILS
 	.note 0 : { *(.note) }
 
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 15850296c0a9..8fc11d6565bf 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -397,6 +397,7 @@ SECTIONS
 	_end = . ;
 
 	DWARF_DEBUG
+	MODINFO
 	ELF_DETAILS
 
 	DISCARDS
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 61bd5ba6680a..997f9eb3b22b 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -170,6 +170,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	MODINFO
 	ELF_DETAILS
 	.riscv.attributes 0 : { *(.riscv.attributes) }
 
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 53bcbb91bb9b..2b62395e35bf 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -221,6 +221,7 @@ SECTIONS
 	/* Debugging sections.	*/
 	STABS_DEBUG
 	DWARF_DEBUG
+	MODINFO
 	ELF_DETAILS
 
 	/*
diff --git a/arch/sh/kernel/vmlinux.lds.S b/arch/sh/kernel/vmlinux.lds.S
index 008c30289eaa..169c63fb3c1d 100644
--- a/arch/sh/kernel/vmlinux.lds.S
+++ b/arch/sh/kernel/vmlinux.lds.S
@@ -89,6 +89,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	MODINFO
 	ELF_DETAILS
 
 	DISCARDS
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index f1b86eb30340..7ea510d9b42f 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -191,6 +191,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	MODINFO
 	ELF_DETAILS
 
 	DISCARDS
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index a36b7918a011..ad3cefeff2ac 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -172,6 +172,7 @@ SECTIONS
 
   STABS_DEBUG
   DWARF_DEBUG
+  MODINFO
   ELF_DETAILS
 
   DISCARDS
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index a409d4b66114..30aa24348d60 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -113,6 +113,7 @@ SECTIONS
 
   STABS_DEBUG
   DWARF_DEBUG
+  MODINFO
   ELF_DETAILS
 
   DISCARDS
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 587ce3e7c504..e0b152715d9c 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -88,7 +88,7 @@ SECTIONS
 	/DISCARD/ : {
 		*(.dynamic) *(.dynsym) *(.dynstr) *(.dynbss)
 		*(.hash) *(.gnu.hash)
-		*(.note.*)
+		*(.note.*) *(.modinfo)
 	}
 
 	.got.plt (INFO) : {
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3a24a3fc55f5..4711a35e706c 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -427,6 +427,7 @@ SECTIONS
 	.llvm_bb_addr_map : { *(.llvm_bb_addr_map) }
 #endif
 
+	MODINFO
 	ELF_DETAILS
 
 	DISCARDS
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index eeb070f330bd..1e1580febe4b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -848,12 +848,14 @@
 
 /* Required sections not related to debugging. */
 #define ELF_DETAILS							\
-		.modinfo : { *(.modinfo) . = ALIGN(8); }		\
 		.comment 0 : { *(.comment) }				\
 		.symtab 0 : { *(.symtab) }				\
 		.strtab 0 : { *(.strtab) }				\
 		.shstrtab 0 : { *(.shstrtab) }
 
+#define MODINFO								\
+		.modinfo : { *(.modinfo) . = ALIGN(8); }
+
 #ifdef CONFIG_GENERIC_BUG
 #define BUG_TABLE							\
 	. = ALIGN(8);							\

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260224-separate-modinfo-from-elf-details-d3160da5f399

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


