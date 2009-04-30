Return-Path: <tabbott@mit.edu>
From: Tim Abbott <tabbott@MIT.EDU>
Subject: [PATCH 2/6] Add new NOSAVE_DATA linker script macro.
Date: Thu, 30 Apr 2009 15:32:32 -0400
Message-Id: <1241119956-31453-3-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241119956-31453-2-git-send-email-tabbott@mit.edu>
References: <1241119956-31453-1-git-send-email-tabbott@mit.edu>
 <1241119956-31453-2-git-send-email-tabbott@mit.edu>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bryan Wu <cooloney@kernel.org>, Chris Zankel <chris@zankel.net>, Cyrill Gorcunov <gorcunov@openvz.org>, David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, dev-etrax@axis.com, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@uclinux.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hirokazu Takata <takata@linux-m32r.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Kyle McMartin <kyle@mcmartin.ca>, Linus Torvalds <torvalds@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-am33-list@redhat.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org, linux-m68k@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, Mikael Starvik <starvik@axis.com>, Paul Mackerras <paulus@samba.org>, Paul Mundt <lethal@linux-sh.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, Roman Zippel <zippel@linux-m68k.org>, Russell King <rmk+kernel@arm.linux.org.uk>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, uclinux-dist-devel@blackfin.uclinux.org, user-mode-linux-devel@lists.sourceforge.net, Yoshinori Sato <ysato@users.sourceforge.jp>, Tim Abbott <tabbott@MIT.EDU>, Sam Ravnborg <sam@ravnborg.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This patch is preparation for replacing most ".data.nosave" in the
kernel with macros, so that the section name can later be changed
without having to touch a lot of the kernel.

The long-term goal here is to be able to change the kernel's magic
section names to those that are compatible with -ffunction-sections
-fdata-sections.  This requires renaming all magic sections with names
of the form ".data.foo".

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-generic/vmlinux.lds.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3d88c87..f5ebd2b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -124,6 +124,13 @@
 	. = ALIGN(PAGE_SIZE);						\
 	*(.bss.page_aligned)
 
+#define NOSAVE_DATA							\
+	. = ALIGN(PAGE_SIZE);						\
+	__nosave_begin = .;						\
+	*(.data.nosave)							\
+	. = ALIGN(PAGE_SIZE);						\
+	__nosave_end = .;
+
 #define RO_DATA(align)							\
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
-- 
1.6.2.1


