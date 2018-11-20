Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conuserg-11.nifty.com ([210.131.2.78])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gOuVE-0007bu-7f
 for linux-um@lists.infradead.org; Tue, 20 Nov 2018 01:06:59 +0000
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 2/9] kbuild: remove redundant 'set -e' from filechk_*
 defines
Date: Tue, 20 Nov 2018 10:05:23 +0900
Message-Id: <1542675930-21114-3-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Michal Marek <michal.lkml@markovi.net>, linux-um@lists.infradead.org, Jeff Dike <jdike@addtoit.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Richard Weinberger <richard@nod.at>, Sam Ravnborg <sam@ravnborg.org>

The filechk macro in scripts/Kbuild.include already sets 'set -e'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 arch/um/Makefile     | 2 +-
 scripts/Makefile.lib | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index ab1066c..71ff3d0 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -152,7 +152,7 @@ $(HOST_DIR)/um/user-offsets.s: __headers FORCE
 	$(Q)$(MAKE) $(build)=$(HOST_DIR)/um $@
 
 define filechk_gen-asm-offsets
-        (set -e; \
+        ( \
          echo "/*"; \
          echo " * DO NOT MODIFY."; \
          echo " *"; \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 8fe4468..ae3ae97 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -406,7 +406,7 @@ endef
 # Use filechk to avoid rebuilds when a header changes, but the resulting file
 # does not
 define filechk_offsets
-	(set -e; \
+	( \
 	 echo "#ifndef $2"; \
 	 echo "#define $2"; \
 	 echo "/*"; \
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

