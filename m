Return-Path: <f.fainelli@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/2] arm64: Create asm/initrd.h
Date: Tue, 23 Oct 2018 16:40:43 -0700
Message-Id: <20181023234044.1138-3-f.fainelli@gmail.com>
In-Reply-To: <20181023234044.1138-1-f.fainelli@gmail.com>
References: <20181023234044.1138-1-f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, Florian Fainelli <f.fainelli@gmail.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Christoffer Dall <christoffer.dall@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Marc Zyngier <marc.zyngier@arm.com>, Greg Ungerer <gerg@linux-m68k.org>, Matt Redfearn <matt.redfearn@mips.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Jan Henrik Weinstock <jan.weinstock@ice.rwth-aachen.de>, Alan Kao <alankao@andestech.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Olof Johansson <olof@lixom.net>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, "open list:C6X ARCHITECTURE" <linux-c6x-dev@linux-c6x.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, "open list:QUALCOMM HEXAGON ARCHITECTURE" <linux-hexagon@vger.kernel.org>, "open list:IA64 Itanium PLATFORM" <linux-ia64@vger.kernel.org>, "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>, "open list:MIPS" <linux-mips@linux-mips.org>, "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>, "open list:OPENRISC ARCHITECTURE" <openrisc@lists.librecores.org>, "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>, "open list:LINUX FOR POWERPC 32-BIT AND 64-BIT" <linuxppc-dev@lists.ozlabs.org>, "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>, "open list:S390" <linux-s390@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:SPARC + UltraSPARC sparc/sparc64" <sparclinux@vger.kernel.org>, "open list:USER-MODE LINUX UML" <linux-um@lists.infradead.org>, "open list:TENSILICA XTENSA PORT xtensa" <linux-xtensa@linux-xtensa.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

ARM64 is the only architecture that requires a re-definition of
__early_init_dt_declare_initrd(). Now that we added the infrastructure
in asm-generic to provide an asm/initrd.h file, properly break up that
definition from asm/memory.h and make use of that header in
drivers/of/fdt.c where this is used.

This significantly cuts the number of objects that need to be rebuilt on
ARM64 due to the repercusions of including asm/memory.h in several
places.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/initrd.h | 13 +++++++++++++
 arch/arm64/include/asm/memory.h |  8 --------
 drivers/of/fdt.c                |  1 +
 3 files changed, 14 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/initrd.h

diff --git a/arch/arm64/include/asm/initrd.h b/arch/arm64/include/asm/initrd.h
new file mode 100644
index 000000000000..0c9572485810
--- /dev/null
+++ b/arch/arm64/include/asm/initrd.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_INITRD_H
+#define __ASM_INITRD_H
+
+#ifdef CONFIG_BLK_DEV_INITRD
+#define __early_init_dt_declare_initrd(__start, __end)			\
+	do {								\
+		initrd_start = (__start);				\
+		initrd_end = (__end);					\
+	} while (0)
+#endif
+
+#endif /* __ASM_INITRD_H */
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..dc3ca21ba240 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 800ad252cf9c..4e4711af907b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -28,6 +28,7 @@
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
+#include <asm/initrd.h>
 
 #include "of_private.h"
 
-- 
2.17.1


