Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conuserg-11.nifty.com ([210.131.2.78])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gRC43-0001ii-Q3
 for linux-um@lists.infradead.org; Mon, 26 Nov 2018 08:16:21 +0000
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] pcmcia: remove per-arch PCMCIA config entry
Date: Mon, 26 Nov 2018 17:15:41 +0900
Message-Id: <1543220141-13744-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kbuild@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Richard Weinberger <richard@nod.at>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christoph Hellwig <hch@lst.de>

Now that all architectures include drivers/pcmcia/Kconfig where
the PCMCIA config is defined, the PCMCIA config entries in per-arch
Kconfig files are redundant.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I will queue this up to my kbuild tree
along with Christoph's clean-up patch set.


 arch/s390/Kconfig | 3 ---
 arch/um/Kconfig   | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 5173366..b212c59 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -837,9 +837,6 @@ source "kernel/power/Kconfig"
 
 endmenu
 
-config PCMCIA
-	def_bool n
-
 config CCW
 	def_bool y
 
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 6b99389..a7d09a7 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -34,9 +34,6 @@ config SBUS
 config PCI
 	bool
 
-config PCMCIA
-	bool
-
 config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

