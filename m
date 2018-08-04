Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conuserg-11.nifty.com ([210.131.2.78])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1floTn-0001xY-5O
 for linux-um@lists.infradead.org; Sat, 04 Aug 2018 04:47:54 +0000
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/3] um: clean up archheaders recipe
Date: Sat,  4 Aug 2018 13:47:03 +0900
Message-Id: <1533358023-5801-4-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
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
Cc: Michal Marek <michal.lkml@markovi.net>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Randy Dunlap <rdunlap@infradead.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>

Now that '%asm-generic' is added to no-dot-config-targets,
'make asm-generic' does not include the kernel configuration.

You can simply do 'make asm-generic' in the recursed top Makefile
without bothering syncconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/um/Makefile | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index de340e4..1a47f9c 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -116,13 +116,7 @@ endef
 KBUILD_KCONFIG := $(HOST_DIR)/um/Kconfig
 
 archheaders:
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
-	            kbuild-file=$(HOST_DIR)/include/asm/Kbuild \
-		    obj=$(HOST_DIR)/include/generated/asm
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
-	            kbuild-file=$(HOST_DIR)/include/uapi/asm/Kbuild \
-		    obj=$(HOST_DIR)/include/generated/uapi/asm
-	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) archheaders
+	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) asm-generic archheaders
 
 archprepare: include/generated/user_constants.h
 
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

