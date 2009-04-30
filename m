Return-Path: <tabbott@mit.edu>
From: Tim Abbott <tabbott@MIT.EDU>
Subject: [PATCH v2 6/6] Add support for __read_mostly to linux/cache.h
Date: Thu, 30 Apr 2009 15:54:13 -0400
Message-Id: <1241121253-32341-7-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241121253-32341-6-git-send-email-tabbott@mit.edu>
References: <1241121253-32341-1-git-send-email-tabbott@mit.edu>
 <1241121253-32341-2-git-send-email-tabbott@mit.edu>
 <1241121253-32341-3-git-send-email-tabbott@mit.edu>
 <1241121253-32341-4-git-send-email-tabbott@mit.edu>
 <1241121253-32341-5-git-send-email-tabbott@mit.edu>
 <1241121253-32341-6-git-send-email-tabbott@mit.edu>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bryan Wu <cooloney@kernel.org>, Chris Zankel <chris@zankel.net>, Cyrill Gorcunov <gorcunov@openvz.org>, David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, dev-etrax@axis.com, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@uclinux.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hirokazu Takata <takata@linux-m32r.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Kyle McMartin <kyle@mcmartin.ca>, Linus Torvalds <torvalds@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, Mikael Starvik <starvik@axis.com>, Paul Mackerras <paulus@samba.org>, Paul Mundt <lethal@linux-sh.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, Roman Zippel <zippel@linux-m68k.org>, Russell King <rmk+kernel@arm.linux.org.uk>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, uclinux-dist-devel@blackfin.uclinux.org, user-mode-linux-devel@lists.sourceforge.net, Yoshinori Sato <ysato@users.sourceforge.jp>, Tim Abbott <tabbott@MIT.EDU>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Signed-off-by: Tim Abbott <tabbott@mit.edu>
---
 include/linux/cache.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 97e2488..99d8a6f 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -13,7 +13,13 @@
 #endif
 
 #ifndef __read_mostly
+#ifdef CONFIG_HAVE_READ_MOSTLY_DATA
+#define __read_mostly __attribute__((__section__(".data.read_mostly")))
+#define __READ_MOSTLY .section ".data.read_mostly", "aw"
+#else
 #define __read_mostly
+#define __READ_MOSTLY
+#endif /* CONFIG_HAVE_READ_MOSTLY_DATA */
 #endif
 
 #ifndef ____cacheline_aligned
-- 
1.6.2.1


